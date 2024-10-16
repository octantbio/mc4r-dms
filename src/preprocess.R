#!/usr/bin/env Rscript

# Join barcode counts to oligo-barcode map
# Usage: Rscript src/preprocess.R -o output_file -m map_file -s samp_prop_file -d bc_dir

# Libraries
library(data.table)
library(argparse)
library(tidyverse)

# Argument parsing
parser <- ArgumentParser()
parser$add_argument("-o", "--output", help = "Output File Name", required = TRUE)
parser$add_argument("-m", "--map", help = "Oligo-Barcode Map File", required = TRUE)
parser$add_argument("-s", "--samp_prop", help = "Barcode Sample Properties TSV File", required = TRUE)
parser$add_argument("-d", "--bc_dir", help = "Barcode Counts Directory", required = TRUE)
args <- parser$parse_args()

out_file <- args$output
oligo_map <- fread(args$map, col.names = c("barcode", "oligo"))
samp_prop <- read_tsv(args$samp_prop, col_names = TRUE) %>% select(-bclen)
bc_file_dir <- args$bc_dir

bc_files <- list.files(str_c("pipeline/", bc_file_dir, "/rna_bcs"),pattern = ".rna-bcs.tsv", full.names = TRUE)
names(bc_files) <- gsub(str_c("pipeline/", bc_file_dir, "/rna_bcs/", "|.rna-bcs.tsv"), "", bc_files, perl = TRUE)

## Read in barcode counts
bcs <- bc_files %>%
    map_dfr(fread, .id = "sample",
    col.names = c("count", "barcode"))

# Remove barcodes represented more than once
setkey(oligo_map, barcode)
oligo_map <- oligo_map[, if (.N == 1) .SD, by = key(oligo_map)]

# Join map to counts
setkey(bcs, barcode)
bc_oligo_join <- data.table::merge.data.table(bcs,
    oligo_map,
    by = "barcode",
    all.x = TRUE)
bc_oligo_join <- data.table::merge.data.table(bc_oligo_join,
    samp_prop,
    by = "sample",
    all.x = TRUE)

# Format and write to out_file
mapped_counts <- bc_oligo_join %>%
    separate(oligo,
        c("lib", "chunk", "wt_aa", "pos",
          "mut_aa", "wt_codon", "mut_codon"),
        sep = "_") %>%
    mutate(condition_conc = as.factor(condition_conc),
        condition = as.factor(str_c(condition, "_", condition_conc))) %>%
    group_by(sample, chunk) %>%
    mutate(stop_counts = log(sum(count[which(mut_aa %in% stop_aliases)])),
        mut_aa = if_else(wt_aa == mut_aa | is.na(mut_aa), "WT", mut_aa),
        mut_aa = relevel(as.factor(mut_aa), ref = "WT"))

fwrite(mapped_counts, out_file, quote = F, sep = "\t", na = "NA")
