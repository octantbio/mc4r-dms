# High resolution deep mutational scanning of the melanocortin-4 receptor

Welcome! This repository contains summary statistics and downstream analysis results for MC4R DMS datasets at Octant. The following directories are enclosed:

  -  `data` contains small auxiliary annotation files
  -  `docker` contains a single `Dockerfile` describing the analysis environment
  -  `paper` contains main figures, additional plots, and analysis code in Rmarkdown format
  -  `sumstats` contains tab-delimited mutant-vs-wild-type variant effects for all datasets, described below

#### CRE System

| Run ID | Type | Conditions | Link |
| ------- | ---- | ----------- | --- |
| DMS5 | Full | <ul><li>Forskolin 25 uM</li><li>Untreated</li><li>aMSH 0.5 nM</li><li>aMSH 5 nM</li><li>aMSH 20 nM</li><li>THIQ 0.4 nM</li><li>THIQ 4 nM</li><li>THIQ 120 nM</li></ul> | [Sumstats](./sumstats/MC4R-DMS5-Gs.tsv) |
| DMS11 | Full | <ul><li>Forskolin 25 uM</li><li>Forskolin 25 uM + Ipsen</li><li>Untreated</li><li>Untreated + Ipsen</li><li>aMSH 1 uM</li><li>aMSH 1 uM + Ipsen</li></ul> | [Defect Sumstats](./sumstats/MC4R-DMS11-DefectSumstats.tsv), [Rescue Sumstats](./sumstats/MC4R-DMS11-RescueSumstats.tsv) |

#### UAS System

| Run ID | Type | Conditions | Link |
| ------- | ---- | ----------- | --- |
| DMS8 | Full | <ul><li>Untreated</li><li>aMSH 20 nM</li><li>aMSH 50 nM</li><li>aMSH 1 uM</li><li>THIQ 3 nM</li><li>THIQ 9 nM</li><li>THIQ 100 nM</li></ul> | [Sumstats](./MC4R-DMS8-Gq.tsv) |

