#!/usr/bin/env Rscript
# Negative Binomial Mixed Modeling of DMS Variant Effects

library(argparse)
library(tidyverse)
source("src/model_utils.R")

RNGkind("L'Ecuyer-CMRG")
set.seed(1)

# Command line arguments
parser <- ArgumentParser()
parser$add_argument("-f", "--file", type = "character",
    help = "Mapped Counts File", metavar = "file")
parser$add_argument("-o", "--outpfx", type = "character",
    help = "Output Prefix", metavar = "outpfx")
parser$add_argument("-m", "--model", type = "character",
    help = "Model Type", metavar = "model")
parser$add_argument("-s", "--stops", type = "character",
    help = "Stop Handling: agg or nonagg", metavar = "stops")
parser$add_argument("-n", "--nworkers", type = "numeric", default = 35,
    help = "Number of workers to use for model fitting", metavar = "nworkers")

# Argument parsing and I/O
args <- parser$parse_args()
mapped_counts_file <- args$file
model_type <- args$model
stops <- args$stops
nworkers <- args$nworkers

coefs_outfile <- str_c(args$outpfx, ".sumstats.tsv")
marginals_outfile <- str_c(args$outpfx, ".marginals.tsv")
model_output_path <- str_c(args$outpfx, "_model_objects/")

dir.create(model_output_path)
stop_aliases <-  c("*", "X", "Stop", "stop", "x")

# Read and format mapped counts file
mapped_counts <- read_tsv(mapped_counts_file) %>%
    mutate(mut_aa = relevel(as.factor(mut_aa), ref = "WT"))

# Set up formula and run model
form <- as.formula(count ~ -1 + condition + condition:mut_aa + (1 | barcode) + offset(stop_counts))
nested_sumstats <- rand_effect_wrap(mapped_counts, form, model_output_path, nworkers)

# Extract and format coefficients and marginals
nested_coef <- nested_sumstats %>% select(-marginals) %>% unnest(coefs)
nested_marginals <- nested_sumstats %>% select(-coefs) %>% unnest(marginals)

# Write summary statistics
write_tsv(nested_coef, coefs_outfile)
write_tsv(nested_marginals, marginals_outfile)
