# Rocker/tidyverse base image
FROM rocker/verse:4.3

#===============================================================================
# Install *nix utils
#===============================================================================
RUN apt-get update && \
    apt-get install -y \
        wget \
        curl \
        vim \
        less \
        git

#===============================================================================
# R packages
#===============================================================================
RUN install2.r --error --skipinstalled --ncpus -1 \
	argparse \
        emmeans \
	bench \
        broom \
        broom.mixed \
        janitor \
        scico \
        ggbeeswarm \
        ggrepel \
        scales \
        patchwork \
        factoextra \
	drc \
        brms

RUN R -q -e 'install.packages("glmmTMB", repos = "https://cran.r-project.org/src/contrib/Archive/glmmTMB/glmmTMB_1.1.8.tar.gz")'
RUN R -q -e 'install.packages("TMB", repos = "https://cran.r-project.org/src/contrib/Archive/TMB/TMB_1.9.6.tar.gz")'
RUN R -q -e 'install.packages("Matrix", repos = "https://cran.r-project.org/src/contrib/Archive/Matrix/Matrix_1.6.0.tar.gz")'

# special install for cmdstanr
# https://github.com/Chuan-Peng-Lab/Rstudio_docker/blob/57ded5a1e40b73d711aebd119a78d9cb2bc0cc7b/arm64.Dockerfile#L38-L41
RUN R -q -e 'install.packages("cmdstanr", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))'
RUN mkdir -p /home/rstudio/.cmdstanr
ENV PATH="/home/rstudio/.cmdstanr:${PATH}"
RUN R -q -e "cmdstanr::install_cmdstan(dir = '/home/rstudio/.cmdstanr', cores = 4)"
