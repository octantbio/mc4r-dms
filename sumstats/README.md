### Post-Processing Summary Statistics

#### Coefficient Contrasts of DMS5 and DMS8

```
Rscript sumstats-contrast.R \
    -i MC4R_new/dms5-combined.sumstats.tsv \
    -c Forsk_2.5e-05 \
    -o MC4R-DMS5-Gs.tsv

Rscript sumstats-contrast.R \
    -i MC4R_new/dms5-combined.sumstats.tsv \
    -c NA \
    -o MC4R-DMS5-Gs-unnormalized.tsv

Rscript sumstats-contrast.R \
    -i MC4R_new/dms8-combined.sumstats.tsv \
    -c None_0 \
    -o MC4R-DMS8-Gq.tsv

Rscript sumstats-contrast.R \
    -i MC4R_new/dms8-combined.sumstats.tsv \
    -c NA \
    -o MC4R-DMS8-Gq-unnormalized.tsv
```

#### Marginal Contrasts of DMS11

```
Rscript contrast-marginal-chaperone.R \
    -i MC4R_new/dms11-combined-marginals.sumstats.tsv \
    --defect MC4R-DMS11-DefectSumstats.tsv \
    --rescue MC4R-DMS11-RescueSumstats.tsv
```
