### Post-Processing Summary Statistics

#### Coefficient Contrasts of DMS5 and DMS8

```
Rscript src/sumstats-contrast.R \
    -i mc4r-dms/sumstats/MC4R_new/dms5-combined.sumstats.tsv \
    -c Forsk_2.5e-05 \
    -o mc4r-dms/sumstats/MC4R_new/MC4R-DMS5-Gs.tsv

Rscript src/sumstats-contrast.R \
    -i mc4r-dms/sumstats/MC4R_new/dms5-combined.sumstats.tsv \
    -c NA \
    -o mc4r-dms/sumstats/MC4R_new/MC4R-DMS5-Gs-unnormalized.tsv

Rscript src/sumstats-contrast.R \
    -i mc4r-dms/sumstats/MC4R_new/dms8-combined.sumstats.tsv \
    -c None_0 \
    -o mc4r-dms/sumstats/MC4R_new/MC4R-DMS8-Gq.tsv

Rscript src/sumstats-contrast.R \
    -i mc4r-dms/sumstats/MC4R_new/dms8-combined.sumstats.tsv \
    -c NA \
    -o mc4r-dms/sumstats/MC4R_new/MC4R-DMS8-Gq-unnormalized.tsv
```

#### Marginal Contrasts of DMS11

NOTE: `contrast-marginal-chaperone.R` accepts only one concentration per treatment, and requires each treatment have a corresponding `-Ipsen` condition, e.g. `aMSH` and `aMSH-Ipsen`.

```
Rscript src/contrast-marginal-chaperone.R \
    -i mc4r-dms/sumstats/MC4R_new/dms11-combined-marginals.sumstats.tsv \
    -w aMSH \
    -c Forsk \
    -o mc4r-dms/sumstats/MC4R-DMS11-DefectSumstats.tsv \
    -t aMSH

Rscript src/marginal-contrast.R \
    -i mc4r-dms/sumstats/MC4R_new/dms11-combined-marginals.sumstats.tsv \
    -w aMSH \
    -c Forsk \
    -o mc4r-dms/sumstats/MC4R-DMS11-RescueSumstats.tsv \
    -t aMSH
```
