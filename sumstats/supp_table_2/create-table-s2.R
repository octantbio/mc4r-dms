library(tidyverse)

clin_vars <- read_tsv("../../data/annotations/mc4r-clinical-vars.tsv") %>%
    mutate(VariantID = gsub("^.", "", Variant))

sumstats_gs <- read_tsv("../MC4R-DMS5-Gs.tsv") %>%
    group_by(pos, aa) %>%
    summarize("Gs-GOF" = if_else(sum(p.adj <= 0.01 & log2ContrastEstimate > 0) > 0, "significant", "NS"),
        "Gs-LOF" = if_else(sum(p.adj <= 0.01 & log2ContrastEstimate < 0) > 0, "significant", "NS"))

sumstats_gq <- read_tsv("../MC4R-DMS8-Gq-unnormalized.tsv") %>%
    group_by(contrast) %>%
    mutate(p.adj = p.adjust(p.value, method = "BH")) %>%
    ungroup() %>%
    group_by(pos, aa) %>%
    summarize("Gq-GOF" = if_else(sum(p.adj <= 0.01 & log2FoldChange > 0) > 0, "significant", "NS"),
        "Gq-LOF" = if_else(sum(p.adj <= 0.01 & log2FoldChange < 0) > 0, "significant", "NS"))

classifications <- inner_join(sumstats_gs, sumstats_gq, by = c("pos", "aa")) %>%
    mutate(VariantID = str_c(pos, aa)) %>%
    rename("Position" = "pos",
           "AA" = "aa") %>%
    inner_join(clin_vars) %>%
    select(-AA, -VariantID) %>%
    relocate(Variant, .before = Position)

write_tsv(classifications,
          "Supplementary-Table-S2-variant-classifications.tsv")