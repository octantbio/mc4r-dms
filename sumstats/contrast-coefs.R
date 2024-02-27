#!/usr/bin/env Rscript
# Example usage:
# Rscript src/sumstats-contrast.R -i combined.sumstats.tsv -c None_0 -o contrast.tsv -t condition1,condition2

library(argparse)
library(tidyverse)

# Command line arguments setup
parser <- ArgumentParser()
parser$add_argument("-i", "--input", type = "character", help = "Path to the input summary statistics TSV file", metavar = "input")
parser$add_argument("-c", "--control", type = "character", help = "String Identifier for control condition or NA for no normalization", metavar = "control")
parser$add_argument("-o", "--output", type = "character", help = "Path to the output TSV file", metavar = "output")
parser$add_argument("-t", "--targets", type = "character", help = "Comma delimited string specifying the conditions to be compared against the control", metavar = "targets")
args <- parser$parse_args()

# Execution
data <- read_tsv(args$input) %>%
    filter(grepl("mut_aa", term)) %>%
    separate(term, into = c("condition", "aa"), sep = ":") %>%
    mutate(condition = gsub("condition", "", condition),
        aa = gsub("mut_aa", "", aa))

if (!is.null(args$targets)) {
    target_conditions <- str_split(args$targets, ",")[[1]]
    data <- data %>%
        filter(condition %in% c(target_conditions, args$control))
}

if (args$control == "NA") {
    sumstats_contrast <- data %>%
        group_by(condition) %>%
        mutate(contrast = str_c(condition, "_unnormalized"),
            p.adj = p.adjust(p.value, method = "BH")) %>%
        ungroup() %>%
        select(chunk, pos, aa, log2FoldChange,log2StdError,
            statistic, p.value, contrast)
} else {

    data_reduced <- data %>% select(chunk, pos, condition, aa, log2FoldChange, log2StdError)
    condition_data <- data_reduced %>% filter(condition != args$control)
    control_data <- data_reduced %>% filter(condition == args$control)

    sumstats_contrast <- condition_data %>%
        inner_join(control_data,
            by = c("chunk", "pos", "aa"),
            suffix = c("_cond", "_control")) %>%
        group_by(condition_cond) %>%
        mutate(log2ContrastEstimate = log2FoldChange_cond - log2FoldChange_control,
            log2ContrastError = sqrt(log2StdError_cond^2 + log2StdError_control^2),
            contrast = str_c(condition_cond, "_minus_", condition_control),
            statistic = log2ContrastEstimate / log2ContrastError,
            p.value = (1 - pnorm(abs(statistic))) * 2,
            p.adj = p.adjust(p.value, method = "BH")) %>%
        ungroup() %>%
        select(chunk, pos, aa, log2ContrastEstimate,log2ContrastError,
            statistic, p.value, p.adj, contrast)
}

write_tsv(sumstats_contrast, args$output)
