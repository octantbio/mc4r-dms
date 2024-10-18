#!/usr/bin/env Rscript
# Usage: Rscript src/contrast-chaperone.R -i input_sumstats.tsv -d defect_sumstats.tsv -r rescue_sumstats.tsv

library(argparse)
library(tidyverse)

# Command line arguments setup
parser <- ArgumentParser()
parser$add_argument("-i", "--input", type = "character", help = "Input Summary Statistics TSV File", metavar = "input", required = TRUE)
parser$add_argument("-d", "--defect", type = "character", help = "Defect Summary Statistics TSV file", metavar = "defect", required = TRUE)
parser$add_argument("-r", "--rescue", type = "character", help = "Rescue Summary Statistics TSV file", metavar = "rescue", required = TRUE)
args <- parser$parse_args()

# Execution
marginals <- read_tsv(args$input) %>%
    rename("aa" = "mut_aa") %>%
    separate(condition, c("treatment", "concentration"), "_") %>%
    separate(treatment, c("drug", "chaperone"), "-") %>%
    mutate(chaperone = if_else(is.na(chaperone), "NoIpsen", "Ipsen"))

norm_marginals <- marginals %>%
    filter(drug != "None") %>%
    select(-statistic, -p.value, -concentration) %>%
    pivot_wider(names_from = drug, values_from = log2Marginal:log2MarginalError) %>%
    mutate(log2MarginalNorm = log2Marginal_aMSH - log2Marginal_Forsk,
           log2MarginalNormError = sqrt(log2MarginalError_aMSH^2 + log2MarginalError_Forsk^2)) %>%
    select(chunk, pos, aa, chaperone, log2MarginalNorm, log2MarginalNormError)

wt_noipsen <- norm_marginals %>%
    filter(chaperone == "NoIpsen", aa == "WT") %>%
    select(chunk, pos, log2MarginalNorm, log2MarginalNormError) %>%
    rename("log2MarginalNorm_WT" = "log2MarginalNorm",
           "log2MarginalNormError_WT" = "log2MarginalNormError")

defect_sumstats <- norm_marginals %>%
    left_join(wt_noipsen) %>%
    ungroup() %>%
    mutate(log2FoldChange = log2MarginalNorm - log2MarginalNorm_WT,
           std.error = sqrt(log2MarginalNormError^2 + log2MarginalNormError_WT^2),
           statistic = log2FoldChange/std.error,
           p.value = pnorm(statistic, mean = 0, sd = 1),
           p.adj = p.adjust(p.value, method = "BH")) %>%
    select(-log2MarginalNorm:-log2MarginalNormError_WT)

rescue_sumstats <- norm_marginals %>%
    group_by(chunk, pos, aa) %>%
    pivot_wider(names_from = chaperone,
                values_from = log2MarginalNorm:log2MarginalNormError) %>%
    ungroup() %>%
    mutate(log2FoldChange = log2MarginalNorm_Ipsen - log2MarginalNorm_NoIpsen,
           std.error = sqrt(log2MarginalNormError_Ipsen^2 + log2MarginalNormError_NoIpsen^2),
           statistic = log2FoldChange/std.error,
           p.value = 1-pnorm(statistic, mean = 0, sd = 1),
           p.adj = p.adjust(p.value, method = "BH")) %>%
    select(-log2MarginalNorm_NoIpsen:-log2MarginalNormError_Ipsen)

write_tsv(defect_sumstats, args$defect)
write_tsv(rescue_sumstats, args$rescue)
