MC4R Figure Generation
================
Nathan Abell and Nathan Lubock
February 27, 2024

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

![](./fig-1/barcode-downsample-1.pdf)<!-- -->

### Correlation to Computational Predictions

![](./fig-1/predictors-1.pdf)<!-- -->

# Figure 2

## Main Figures

### aMSH Heatmap

Let’s split the protein up in two and use patchwork to smash it together

![](./fig-2/cre-amsh-heatmap-1.pdf)<!-- -->

### ClinVar

![](./fig-2/clinvar-dists-1.pdf)<!-- -->

### gnomAD

![](./fig-2/gnomad-1.pdf)<!-- -->

### Literature Mutants

![](./fig-2/huang-mutants-1.pdf)<!-- -->

### Delta EC50s from Literature

![](./fig-2/amsh-experimental-pec50s-1.pdf)<!-- -->

### Variant Classification

![](./fig-2/class-proportions-1.pdf)<!-- -->

## Extended Figures

### aMSH Heatmap (Log2FC)

![](./fig-2/cre-amsh-zoom-log2fc-1.pdf)<!-- -->

### Show of Force (Z’s)

![](./fig-2/show-of-force-1.pdf)<!-- -->

### Show of Force (Log2FC)

![](./fig-2/show-of-force-log2fc-1.pdf)<!-- -->

# Figure 3

## Main Figures

### PCA for Bias

![](./fig-3/amsh-bias-no-contrasts-1.pdf)<!-- -->

### Specific Mutants

![](./fig-3/bias-inset-1-1.pdf)<!-- -->

![](./fig-3/bias-inset-2-1.pdf)<!-- -->

### Patchwork

![](./fig-3/fig-3-1.pdf)<!-- -->

## Extended Figures

### Bias PCA with Stops

![](./fig-3/bias_pca_stops-1.pdf)<!-- -->

### Bias PCA with Loadings

![](./fig-3/bias_pca_loadings-1.pdf)<!-- -->

### Write TSV out for Structure

We’ll also write out the PC’s for projecting onto the structure

### More Biased Residue Zooms

![](./fig-3/bias-inset-3-1.pdf)<!-- -->

### 79 Zoom

![](./fig-3/79-zoom-1.pdf)<!-- -->

# Figure 4

## Main Figures

### Scaled (0-1) Rescue Effects Across All Variants

![](./fig-4/scaled-rescue-scatter-1.pdf)<!-- -->

### Custom Variant Set

![](./fig-4/chap-custom-varset-barplot-1.pdf)<!-- -->

### Wang 2014 Variants

![](./fig-4/rescue-wang2014-barplot-1.pdf)<!-- -->

![](./fig-4/rescue-wang2014-scatter-1.pdf)<!-- -->

### Huang 2017 Variants

![](./fig-4/rescue-huanh2017-barplot-1.pdf)<!-- -->

![](./fig-4/rescue-huang2017-scatter-1.pdf)<!-- -->

## Extended Figures

### Rescue/Defect Effects Across All Variants

![](./fig-4/rescue-defect-effects-scatter-1.pdf)<!-- -->

### Rescue/Defect Z-Statistics Across All Variants

![](./fig-4/rescue-defect-z-scatter-1.pdf)<!-- -->

# Figure 5

## Main Figures

### THIQ vs aMSH meta-regression

    ## process    real 
    ##   8.16s   2.52m

![](./fig-5/amsh-vs-thiq-meta-1.pdf)<!-- -->

As a table, here’s the 5% FDR’s

| pos | aa  | est_aMSH | est_THIQ | residual_z | residual_fdr |
|----:|:----|---------:|---------:|-----------:|-------------:|
|  43 | V   |    -0.45 |     0.27 |      -3.65 |         1.40 |
|  46 | R   |    -0.67 |     0.10 |      -4.95 |         3.43 |
|  48 | R   |    -1.08 |    -0.25 |      -4.87 |         3.31 |
|  48 | D   |     0.34 |    -0.49 |       3.80 |         1.58 |
|  50 | P   |    -0.61 |     0.08 |      -3.96 |         1.74 |
|  51 | S   |    -1.11 |    -0.21 |      -5.73 |         4.79 |
|  51 | L   |    -1.01 |    -0.30 |      -3.91 |         1.72 |
|  52 | S   |    -0.90 |    -0.09 |      -5.70 |         4.79 |
|  52 | G   |    -0.73 |     0.05 |      -4.82 |         3.26 |
|  52 | A   |    -0.71 |     0.10 |      -3.92 |         1.72 |
|  52 | T   |    -0.93 |    -0.10 |      -3.87 |         1.66 |
|  96 | L   |    -1.01 |     0.06 |      -3.73 |         1.49 |
| 101 | R   |    -0.86 |     0.35 |      -5.04 |         3.58 |
| 101 | I   |    -1.12 |     0.32 |      -4.10 |         1.91 |
| 104 | V   |    -1.40 |     0.13 |      -5.04 |         3.58 |
| 104 | R   |    -1.48 |    -0.27 |      -4.05 |         1.84 |
| 104 | G   |    -1.27 |     0.03 |      -4.02 |         1.81 |
| 104 | S   |    -1.12 |     0.35 |      -3.61 |         1.34 |
| 106 | R   |    -1.25 |    -0.26 |      -3.85 |         1.64 |
| 107 | G   |    -1.27 |    -0.13 |      -4.82 |         3.26 |
| 107 | A   |    -0.95 |    -0.07 |      -3.78 |         1.57 |
| 107 | R   |    -0.91 |    -0.12 |      -3.67 |         1.40 |
| 121 | P   |    -1.69 |     0.24 |      -5.86 |         4.81 |
| 123 | V   |    -1.92 |    -0.03 |      -5.09 |         3.62 |
| 123 | P   |    -1.44 |     0.01 |      -3.83 |         1.63 |
| 127 | G   |    -1.25 |     0.19 |      -4.05 |         1.84 |
| 127 | L   |    -1.65 |    -0.39 |      -4.01 |         1.81 |
| 129 | V   |    -1.35 |     0.02 |      -3.91 |         1.72 |
| 129 | T   |     0.41 |    -0.65 |       3.65 |         1.40 |
| 129 | H   |    -0.07 |    -1.43 |       3.65 |         1.40 |
| 129 | S   |    -0.12 |    -1.33 |       5.76 |         4.79 |
| 130 | S   |    -1.64 |     0.12 |      -5.57 |         4.55 |
| 185 | M   |    -1.47 |     0.12 |      -4.33 |         2.29 |
| 188 | R   |    -1.44 |     0.20 |      -4.26 |         2.16 |
| 188 | M   |    -1.66 |    -0.04 |      -3.92 |         1.72 |
| 189 | P   |    -1.37 |     0.41 |      -4.87 |         3.31 |
| 193 | F   |    -1.10 |     0.46 |      -4.18 |         2.04 |
| 194 | F   |    -1.61 |     0.25 |      -5.19 |         3.81 |
| 194 | Y   |    -1.29 |     0.18 |      -3.96 |         1.74 |
| 272 | R   |    -1.10 |    -0.03 |      -5.39 |         4.17 |
| 281 | R   |    -0.83 |     0.07 |      -5.24 |         3.88 |
| 282 | L   |    -0.63 |     0.03 |      -3.77 |         1.55 |
| 284 | L   |    -1.02 |     0.27 |      -7.85 |        10.55 |
| 285 | R   |    -0.74 |     0.10 |      -4.71 |         3.03 |
| 292 | E   |    -1.01 |     0.14 |      -3.83 |         1.63 |

### aMSH vs THIQ – Position 129

![](./fig-5/pos129-amsh-vs-thiq-1.pdf)<!-- -->

### aMSH vs THIQ – Position 284

![](./fig-5/pos284-amsh-vs-thiq-1.pdf)<!-- -->

## Extended Figures

### PCA for ligand selectivity

![](./fig-5/ligand-pca-1.pdf)<!-- -->

### aMSH vs THIQ – Position 48

![](./fig-5/pos48-amsh-vs-thiq-1.pdf)<!-- -->

### DRC aMSH vs Thiq – Position 48

![](./fig-5/48-drc-1.pdf)<!-- -->

### aMSH vs THIQ – Position 52

![](./fig-5/pos52-amsh-vs-thiq-1.pdf)<!-- -->

### DRC aMSH vs THIQ – Position 52

![](./fig-5/52-drc-1.pdf)<!-- -->

### aMSH vs THIQ – Position 101

![](./fig-5/pos101-amsh-vs-thiq-1.pdf)<!-- -->

### DRC aMSH vs THIQ – Position 101

![](./fig-5/101-drc-1.pdf)<!-- -->

### aMSH vs THIQ – Position 104

![](./fig-5/pos104-amsh-vs-thiq-1.pdf)<!-- -->

### DRC aMSH vs THIQ – Position 104

![](./fig-5/104-drc-1.pdf)<!-- -->

### DRC aMSH vs THIQ – Position 129

![](./fig-5/129-drc-1.pdf)<!-- -->

### DRC aMSH vs THIQ – Position 284

![](./fig-5/284-drc-1.pdf)<!-- -->
