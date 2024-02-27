#!/usr/bin/env Rscript
# Example usage:
# Rscript src/contrast-marginal-chaperone.R -i combined.sumstats.tsv -w None_0 -o contrast.tsv -t condition1,condition2

library(argparse)
library(tidyverse)

# Command line arguments setup
parser <- ArgumentParser()
parser$add_argument("-i", "--input", type = "character", help = "Path to the input summary statistics TSV file", metavar = "input")
parser$add_argument("-w", "--wt", type = "character", help = "Condition to use as WT reference", metavar = "wt")
parser$add_argument("-o", "--output", type = "character", help = "Path to the output TSV file", metavar = "output")
parser$add_argument("-t", "--targets", type = "character", help = "Comma delimited string specifying the conditions to be compared against the control", metavar = "targets")
args <- parser$parse_args()

# Execution
data <- read_tsv(args$input) %>%
    rename("aa" = "mut_aa") %>%
    separate(condition, c("treatment", "concentration"), "_") %>%
    separate(treatment, c("drug", "chaperone"), "-") %>%
    mutate(chaperone = if_else(is.na(chaperone), "NoIpsen", "Ipsen"))

if (!is.null(args$targets)) {
    target_drugs <- str_split(args$targets, ",")[[1]]
    data <- data %>%
        filter(drug %in% c(target_drugs, args$control))
}

wt_reference <- data %>%
    filter(drug == args$wt, aa == "WT") %>%
    select(chunk, pos, aa, log2Marginal,log2MarginalError) %>%
    rename("log2Marginal" = "log2Marginal_WT",
        "log2MarginalError" = "log2MarginalError_WT")

if (args$control == "NA") {
    sumstats_contrast <- data %>%
        left_join(wt_reference,
            by = c("chunk", "pos", "aa")) %>%
        mutate(log2ContrastEstimate = log2Marginal - log2Marginal_WT,
            log2ContrastError = sqrt(log2MarginalError^2 + log2Marginal_WT^2),
            statistic = log2ContrastEstimate / log2ContrastError,
            p.value = (1 - pnorm(abs(statistic))) * 2,
            p.adj = p.adjust(p.value, method = "BH")) %>%
        select(chunk, pos, aa, log2ContrastEstimate,log2ContrastError,
            statistic, p.value, p.adj)
} else {

    data_reduced <- data %>% select(chunk, pos, condition, aa, log2Marginal, log2MarginalError)
    condition_data <- data_reduced %>% filter(drug != args$control)
    control_data <- data_reduced %>% filter(drug == args$control)

    sumstats_norm <- condition_data %>%
        inner_join(control_data,
            by = c("chunk", "pos", "aa", "chaperone"),
            suffix = c("_cond", "_control")) %>%
        mutate(log2NormEstimate = log2Marginal_cond - log2Marginal_control,
            log2NormError = sqrt(log2MarginalError_cond^2 + log2MarginalError_control^2)) %>%
        select(chunk, pos, aa, log2NormEstimate,log2NormError)

    sumstats_contrast <- sumstats_norm %>%
        left_join(wt_reference,
            by = c("chunk", "pos", "aa")) %>%
        mutate(log2ContrastEstimate = log2Marginal - log2Marginal_WT,
            log2ContrastError = sqrt(log2MarginalError^2 + log2Marginal_WT^2),
            statistic = log2ContrastEstimate / log2ContrastError,
            p.value = (1 - pnorm(abs(statistic))) * 2,
            p.adj = p.adjust(p.value, method = "BH")) %>%
        select(chunk, pos, aa, log2ContrastEstimate,log2ContrastError,
            statistic, p.value, p.adj)
}

write_tsv(sumstats_contrast, args$output)
