#!/usr/bin/env Rscript

## Libraries
library(magrittr)
library(data.table)
library(future)
library(furrr)
library(broom)
library(broom.mixed)
library(glmmTMB)
library(future.callr)
library(tidyverse)

## Setup
RNGkind("L'Ecuyer-CMRG")
set.seed(1)
stop_aliases <-  c("*", "X", "Stop", "stop", "x")

## Forskolin Model
compositional_model <- function(data) {

    to_return <- tryCatch({

        mod <- glmmTMB(formula = as.formula(count ~ 1 + (1 | barcode) + offset(total_counts)),
            start = -1,
            REML = FALSE,
            control = glmmTMBControl(optimizer = optim,
                parallel = 40,
                profile = TRUE,
                optArgs = list(method = "L-BFGS-B",
                    pgtol = 0,
                    rel.tol = 0.1)),
            data = data,
            sparseX = c(cond=TRUE),
            family = nbinom2)

        barcode_effects <- as_tibble(ranef(mod, condVar = TRUE)) %>%
            rename("barcode" = "grp",
                   "forsk" = "condval") %>%
            select(barcode, forsk)

        }, error = function(e) {

            message("Error fitting model")
            NULL

        }
    )

    return(to_return)
}

## Execution
mapped_counts <- read_tsv("data/mapped_counts/mc4r-cre-forskolin.mapped-counts-formatted.tsv", show_col_types = FALSE)
nested_counts <- mapped_counts %>% nest(data = -chunk)
barcode_effects <- map_dfr(nested_counts$data, ~compositional_model(data = .))
write_tsv(barcode_effects, "sumstats/pipeline-outputs-forsk-offset/mc4r-cre.barcode-effects.tsv")
