MC4R Figure Generation
================
Nathan Abell and Nathan Lubock
February 18, 2024

# Introduction

This document will recreate all of the figures for the manuscript.
Extended figures are included in the same directory as their
corresponding main figures for clarity.

But first, a little data munging to get everything annotated an
consistent.

# Figure 1

## Main Figures

## Extended Figures

### Effect of Barcodes

![](./fig-1/barcode-downsample-1.png)<!-- -->

### Correlation to Computational Predictions

![](./fig-1/predictors-1.png)<!-- -->

# Figure 2

## Main Figures

### aMSH Heatmap

Let’s split the protein up in two and use patchwork to smash it together

![](./fig-2/cre-amsh-heatmap-1.png)<!-- -->

### ClinVar

![](./fig-2/clinvar-dists-1.png)<!-- -->

### gnomAD

![](./fig-2/gnomad-1.png)<!-- -->

### Literature Mutants

![](./fig-2/huang-mutants-1.png)<!-- -->

### Delta EC50s from Literature

![](./fig-2/amsh-experimental-pec50s-1.png)<!-- -->

### Variant Classification

![](./fig-2/class-proportions-1.png)<!-- -->

## Extended Figures

### aMSH Heatmap (Log2FC)

![](./fig-2/cre-amsh-zoom-log2fc-1.png)<!-- -->

### Show of Force (Z’s)

![](./fig-2/show-of-force-1.png)<!-- -->

### Show of Force (Log2FC)

![](./fig-2/show-of-force-log2fc-1.png)<!-- -->

# Figure 3

## Main Figures

### PCA for Bias

![](./fig-3/amsh-bias-no-contrasts-1.png)<!-- -->

### Specific Mutants

![](./fig-3/bias-inset-1-1.png)<!-- -->

![](./fig-3/bias-inset-2-1.png)<!-- -->

## Extended Figures

### Bias PCA with Stops

![](./fig-3/bias_pca_stops-1.png)<!-- -->

### Bias PCA with Loadings

![](./fig-3/bias_pca_loadings-1.png)<!-- -->

### Write TSV out for Structure

We’ll also write out the PC’s for projecting onto the structure

### More Biased Residue Zooms

![](./fig-3/bias-inset-3-1.png)<!-- -->

### 79 Zoom

![](./fig-3/79-zoom-1.png)<!-- -->

# Figure 4

## Main Figures

### Scaled (0-1) Rescue Effects Across All Variants

![](./fig-4/scaled-rescue-scatter-1.png)<!-- -->

### Wang 2014 Variants

![](./fig-4/rescue-wang2014-barplot-1.png)<!-- -->

![](./fig-4/rescue-wang2014-scatter-1.png)<!-- -->

### Huang 2017 Variants

![](./fig-4/rescue-huanh2017-barplot-1.png)<!-- -->

![](./fig-4/rescue-huang2017-scatter-1.png)<!-- -->

## Extended Figures

### Rescue/Defect Effects Across All Variants

![](./fig-4/rescue-defect-effects-scatter-1.png)<!-- -->

### Rescue/Defect Z-Statistics Across All Variants

![](./fig-4/rescue-defect-z-scatter-1.png)<!-- -->

# Figure 5

## Main Figures

### THIQ vs aMSH meta-regression

    ## process    real 
    ##  15.24s   4.33m

![](./fig-5/amsh-vs-thiq-meta-1.png)<!-- -->

As a table, here’s the 5% FDR’s

| pos | aa  | est_aMSH | est_THIQ | residual_z | residual_fdr |
|----:|:----|---------:|---------:|-----------:|-------------:|
|  43 | V   |    -0.44 |     0.27 |      -3.64 |         1.38 |
|  46 | R   |    -0.67 |     0.11 |      -4.93 |         3.34 |
|  48 | R   |    -1.06 |    -0.25 |      -4.80 |         3.15 |
|  48 | D   |     0.34 |    -0.49 |       3.91 |         1.67 |
|  50 | P   |    -0.62 |     0.07 |      -4.00 |         1.81 |
|  51 | S   |    -1.06 |    -0.24 |      -4.84 |         3.21 |
|  51 | L   |    -0.98 |    -0.30 |      -3.77 |         1.52 |
|  52 | S   |    -0.87 |    -0.10 |      -5.37 |         4.06 |
|  52 | G   |    -0.72 |     0.05 |      -4.59 |         2.79 |
|  52 | A   |    -0.70 |     0.10 |      -3.81 |         1.55 |
|  52 | T   |    -0.92 |    -0.09 |      -3.77 |         1.52 |
|  96 | L   |    -1.03 |     0.02 |      -3.64 |         1.38 |
| 101 | R   |    -0.88 |     0.36 |      -5.13 |         3.66 |
| 101 | I   |    -1.10 |     0.33 |      -4.10 |         1.90 |
| 104 | V   |    -1.35 |     0.14 |      -4.84 |         3.21 |
| 104 | G   |    -1.25 |     0.03 |      -4.01 |         1.81 |
| 104 | R   |    -1.46 |    -0.26 |      -3.87 |         1.64 |
| 104 | S   |    -1.13 |     0.35 |      -3.64 |         1.38 |
| 106 | R   |    -1.25 |    -0.25 |      -3.84 |         1.59 |
| 107 | G   |    -1.26 |    -0.13 |      -4.96 |         3.36 |
| 107 | A   |    -0.94 |    -0.07 |      -3.76 |         1.52 |
| 107 | R   |    -0.91 |    -0.12 |      -3.66 |         1.38 |
| 121 | P   |    -1.68 |     0.19 |      -5.79 |         4.82 |
| 123 | V   |    -1.94 |    -0.03 |      -5.15 |         3.67 |
| 123 | P   |    -1.43 |     0.02 |      -3.76 |         1.52 |
| 127 | G   |    -1.26 |     0.18 |      -4.13 |         1.94 |
| 127 | L   |    -1.62 |    -0.42 |      -3.78 |         1.52 |
| 129 | V   |    -1.36 |     0.01 |      -3.87 |         1.64 |
| 129 | T   |     0.39 |    -0.67 |       3.64 |         1.38 |
| 129 | H   |    -0.12 |    -1.47 |       3.67 |         1.38 |
| 129 | S   |    -0.11 |    -1.35 |       5.93 |         4.99 |
| 130 | S   |    -1.63 |     0.11 |      -5.50 |         4.29 |
| 185 | M   |    -1.55 |     0.11 |      -4.57 |         2.77 |
| 188 | R   |    -1.44 |     0.21 |      -4.31 |         2.27 |
| 188 | M   |    -1.66 |    -0.04 |      -3.92 |         1.68 |
| 189 | P   |    -1.36 |     0.39 |      -4.63 |         2.85 |
| 193 | F   |    -1.10 |     0.44 |      -4.06 |         1.86 |
| 194 | F   |    -1.62 |     0.24 |      -5.20 |         3.71 |
| 194 | Y   |    -1.28 |     0.17 |      -4.05 |         1.86 |
| 272 | R   |    -1.14 |    -0.02 |      -5.56 |         4.36 |
| 281 | R   |    -0.81 |     0.05 |      -5.09 |         3.63 |
| 282 | L   |    -0.62 |     0.03 |      -3.60 |         1.32 |
| 284 | L   |    -1.03 |     0.25 |      -7.80 |        10.38 |
| 285 | R   |    -0.74 |     0.08 |      -4.65 |         2.86 |
| 292 | E   |    -1.05 |     0.12 |      -4.09 |         1.90 |

### aMSH vs THIQ – Position 129

![](./fig-5/pos129-amsh-vs-thiq-1.png)<!-- -->

### aMSH vs THIQ – Position 284

![](./fig-5/pos284-amsh-vs-thiq-1.png)<!-- -->

## Extended Figures

### PCA for ligand selectivity

![](./fig-5/ligand-pca-1.png)<!-- -->

### aMSH vs THIQ – Position 48

![](./fig-5/pos48-amsh-vs-thiq-1.png)<!-- -->

### DRC aMSH vs Thiq – Position 48

![](./fig-5/48-drc-1.png)<!-- -->

### aMSH vs THIQ – Position 52

![](./fig-5/pos52-amsh-vs-thiq-1.png)<!-- -->

### DRC aMSH vs THIQ – Position 52

![](./fig-5/52-drc-1.png)<!-- -->

### aMSH vs THIQ – Position 101

![](./fig-5/pos101-amsh-vs-thiq-1.png)<!-- -->

### DRC aMSH vs THIQ – Position 101

![](./fig-5/101-drc-1.png)<!-- -->

### DRC aMSH vs THIQ – Position 129

![](./fig-5/129-drc-1.png)<!-- -->

### DRC aMSH vs THIQ – Position 284

![](./fig-5/284-drc-1.png)<!-- -->
