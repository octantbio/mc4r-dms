## Model Execution

This subdirectory contains four R scripts for processing raw barcode counts and barcode maps through to final variant effect summary statistics.

The following commands join raw barcode counts to an oligo-barcode map, one command for each dataset. Paths are assumed to be relative to the main level of `mc4r-dms`, e.g. the script path below is `src/preprocess.R`:

```
Rscript src/preprocess.R \
    -d data/barcode_counts/MC4R-DMS5-Gs \
    -o data/mapped_counts/MC4R-DMS5-Gs.mapped-counts.tsv \
    -m data/barcode_maps/mc4r-cre.bcmap-final.tsv \
    -s data/MC4R-DMS5-Gs-sample-properties.tsv

Rscript src/preprocess.R \
    -d data/barcode_counts/MC4R-DMS8-Gq \
    -o data/mapped_counts/MC4R-DMS8-Gq.mapped-counts.tsv \
    -m data/barcode_maps/mc4r-uas.bcmap-final.tsv \
    -s data/MC4R-DMS8-Gq-sample-properties.tsv

Rscript src/preprocess.R \
    -d data/barcode_counts/MC4R-DMS11-Gs \
    -o data/mapped_counts/MC4R-DMS11-Gs.mapped-counts.tsv \
    -m data/barcode_maps/mc4r-cre.bcmap-final.tsv \
    -s data/MC4R-DMS11-Gs-sample-properties.tsv
```

After executing the above, the resulting `mapped-counts.tsv` files are input to `model.R` as follows to compute raw summary statistics:

```
Rscript src/model.R \
    -f data/mapped_counts/MC4R-DMS5-Gs.mapped-counts.tsv \
    -o sumstats/MC4R-DMS5-Gs-unnormalized.tsv \
    -n 60

Rscript src/model.R \
    -f data/mapped_counts/MC4R-DMS8-Gq.mapped-counts.tsv \
    -o sumstats/MC4R-DMS8-Gq-unnormalized.tsv \
    -n 60

Rscript src/model.R \
    -f data/mapped_counts/MC4R-DMS11-Gs.mapped-counts.tsv \
    -o sumstats/MC4R-DMS11-Gs-unnormalized.tsv \
    -n 60
```

**NOTE: models are fit using glmmTMB, whose output is sensitive to the local Matrix>TMB>glmmTMB installation (see [glmmTMB/TMB/Matrix mismatches](https://glmmtmb.github.io/glmmTMB/index.html) for more details)**

Finally, raw summary statistics are processed to compute either control-normalized (Forskolin or Untreated) or chaperone-specific (Defect and Rescue) summary statistics using the following commands:

```
Rscript src/contrast.R \
    -i sumstats/MC4R-DMS5-Gs-unnormalized.tsv \
    -o sumstats/MC4R-DMS5-Gs.tsv \
    -c Forsk_2.5e-05

Rscript src/contrast.R \
    -i sumstats/MC4R-DMS8-Gq-unnormalized.tsv \
    -o sumstats/MC4R-DMS8-Gq.tsv \
    -c None_0

Rscript src/contrast-chaperone.R \
    -i sumstats/MC4R-DMS11-Gs-unnormalized.marginals.tsv \
    --defect sumstats/MC4R-DMS11-DefectSumstats.tsv \
    --rescue sumstats/MC4R-DMS11-RescueSumstats.tsv 
```
