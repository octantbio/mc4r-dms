#!/usr/bin/env Rscript

# Negative Binomial Mixed Modeling of DMS Variant Effects
# Usage: Rscript src/model.R -o output_file -m map_file -s samp_prop_file -d bc_dir

# Libraries
library(argparse)
library(data.table)
library(future)
library(furrr)
library(broom)
library(broom.mixed)
library(glmmTMB)
library(emmeans)
library(future.callr)
library(tidyverse)

RNGkind("L'Ecuyer-CMRG")
set.seed(1)

# Functions
rand_effect <- function(data, mod_path, formula) {

    to_return <- tryCatch({

        mod <- glmmTMB(formula = formula,
            start = -1,
            REML = FALSE,
            control = glmmTMBControl(optimizer = optim,
                profile = TRUE,
                optArgs = list(method = "L-BFGS-B",
                    pgtol = 0,
                    rel.tol = 0.1)),
            data = data,
            sparseX = c(cond = TRUE),
            family = nbinom2)

        saveRDS(mod, file = str_c(mod_path, ".RDS"))

        coefs <- broom.mixed::tidy(mod) %>%
            unnest_longer(term) %>%
            mutate(dispersion = sigma(mod),
                estimate = estimate / log(2),
                std.error = std.error / log(2)) %>%
            rename("log2FoldChange" = "estimate",
                "log2StdError" = "std.error")

        marginals <- broom::tidy(emmeans(mod, as.formula(~ mut_aa + condition))) %>%
            mutate(estimate = estimate / log(2),
                std.error = std.error / log(2)) %>%
            rename("log2Marginal" = "estimate",
                "log2MarginalError" = "std.error")

        list("coefs" = coefs, "marginals" = marginals)

        }, error = function(e) {

            message("Error fitting model")
            NULL

        }
    )

    return(to_return)
}

rand_effect_wrap <- function(mapped_counts, form, model_output_path, nworkers) {

    plan(callr, workers = nworkers)

    wt_df <- mapped_counts %>%
        filter(mut_aa == "WT") %>%
        select(-pos) %>%
        nest(wt = -chunk)

    nested_counts <- mapped_counts %>%
        filter(mut_aa != "WT") %>%
        nest(data = c(-pos, -chunk))

    joined_counts <- inner_join(nested_counts, wt_df, by = "chunk") %>%
        mutate(
            df = map2(data, wt, bind_rows),
            name = str_c("chunk", chunk, "pos", pos, sep = "_"),
            full_path = str_c(model_output_path, name, sep = "")
        )

    fit_df <- joined_counts %>%
        mutate(sumstats = future_map2(df, full_path, rand_effect, formula = form,
            .options = furrr_options(seed = .Random.seed)))

    sumstats_wide <- fit_df %>%
        select(chunk, pos, sumstats) %>%
        unnest_wider(sumstats)

  return(sumstats_wide)
}

# Command line arguments
parser <- ArgumentParser()
parser$add_argument("-f", "--file", type = "character",
    help = "Mapped Counts File", metavar = "file")
parser$add_argument("-o", "--outfile", type = "character",
    help = "Output Prefix", metavar = "outfile")
parser$add_argument("-n", "--nworkers", type = "numeric", default = 35,
    help = "Number of workers to use for model fitting", metavar = "nworkers")

# Argument parsing and I/O
args <- parser$parse_args()
mapped_counts_file <- args$file
nworkers <- args$nworkers

coefs_outfile <- args$outfile
marginals_outfile <- gsub(".tsv", ".marginals.tsv", args$outfile)
model_output_path <- gsub(".tsv", "_model_objects/", args$outfile)

dir.create(model_output_path)
stop_aliases <-  c("*", "X", "Stop", "stop", "x")

# Read and format mapped counts file
mapped_counts <- read_tsv(mapped_counts_file) %>%
    mutate(mut_aa = relevel(as.factor(mut_aa), ref = "WT"))

# Set up formula and run model
form <- as.formula(count ~ -1 + condition + condition:mut_aa + (1 | barcode) + offset(stop_counts))
nested_sumstats <- rand_effect_wrap(mapped_counts, form, model_output_path, nworkers)

# Extract and format coefficients and marginals
nested_coef <- nested_sumstats %>%
    select(-marginals) %>%
    unnest(coefs) %>%
    filter(grepl("mut_aa", term)) %>%
    separate(term, c("condition", "aa"), ":") %>%
    mutate(condition = gsub("condition", "", condition),
        aa = gsub("mut_aa", "", aa) %>%
        contrast = str_c(condition, "_unnormalized")) %>%
    select(chunk, pos, aa, log2FoldChange, log2StdError, statistic, p.value, contrast) 

nested_marginals <- nested_sumstats %>%
    select(-coefs) %>%
    unnest(marginals) %>%
    select(chunk, pos, mut_aa, condition, log2Marginal, log2MarginalError)

# Write summary statistics
write_tsv(nested_coef, coefs_outfile)
write_tsv(nested_marginals, marginals_outfile)
