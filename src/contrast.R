#!/usr/bin/env Rscript
# Usage: Rscript src/contrast-coefs.R -i input_sumstats.tsv -c DMSO -o output_sumstats.tsv

library(argparse)
library(tidyverse)

# Command line arguments setup
parser <- ArgumentParser()
parser$add_argument("-i", "--input", type = "character", help = "Input Summary Statistics TSV File", metavar = "input")
parser$add_argument("-c", "--control", type = "character", help = "Control Condition", metavar = "control")
parser$add_argument("-o", "--output", type = "character", help = "Output Summary Statistics TSV file", metavar = "output")
args <- parser$parse_args()

# Execution
data <- read_tsv(args$input) %>%
    mutate(condition = gsub("_unnormalized", "", contrast))

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

write_tsv(sumstats_contrast, args$output)
