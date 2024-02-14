# Rocker/tidyverse base image
FROM rocker/verse:4.1.1

#===============================================================================
# Install *nix utils
#===============================================================================
RUN apt-get update && \
    apt-get install -y \
        parallel \
        wget \
        curl \
        pigz \
        vim \
        less \
        tre-agrep \
        bzip2 \
        ca-certificates \
        cargo \
        curl \
        zlibc \
        libc6 \
        gcc \
        g++ \
        git && \
    apt-get clean && \
    apt-get remove -y cmake

#===============================================================================
# Bcl2fastq installation from source
#===============================================================================
WORKDIR /opt/bcl2fastq
RUN mkdir -p /usr/include/sys && \
    ln -s /usr/include/x86_64-linux-gnu/sys/stat.h /usr/include/sys/stat.h

RUN wget ftp://webdata2:webdata2@ussd-ftp.illumina.com/downloads/software/bcl2fastq/bcl2fastq2-v2-20-0-tar.zip && \
    unzip bcl2fastq2-v2-20-0-tar.zip && \
    gunzip bcl2fastq2-v2.20.0.422-Source.tar.gz && \
    tar xvf bcl2fastq2-v2.20.0.422-Source.tar

RUN cd bcl2fastq && \
    ./src/configure && \
    make && \
    make install

#===============================================================================
# General package installation with micromamba
#===============================================================================
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV MAMBA_ROOT_PREFIX /opt/conda
ENV PATH /opt/conda/bin:$PATH

WORKDIR /opt/conda
RUN curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
RUN eval "$(/opt/conda/bin/micromamba shell hook -s posix)"

RUN /opt/conda/bin/micromamba self-update -c conda-forge && \
    /opt/conda/bin/micromamba install -y \
        -n base \
        -c conda-forge \
        -c bioconda \
        -c r \
        gcc \
        numpy \
        scikit-learn \
        ipython \
        jupyter \
        pandas=1.5.0 \
        STAR=2.7.10a \
        umi_tools=1.1.2 \
        samtools=1.6 \
        flash2=2.2.00 \
        cutadapt=4.1 \
        papermill=2.4.0 \
        nbconvert=7.2.9 \
        r-matrix=1.6.0 \
        r-tmb=1.9.6 \
        r-glmmtmb=1.1.8 \
        r-scico \
        r-emmeans \
        r-tidyverse \
        r-furrr \
        r-tidymodels \
        r-hexbin \
        r-gridextra \
        r-ggextra \
        r-ggbeeswarm \
        r-ggpointdensity \
        r-ggrepel \
        r-ggpubr \
        r-scales \
        r-doFuture \
        r-patchwork \
        r-broom \
        r-broom.mixed \
        r-cowplot \
        r-data.table \
        r-irkernel \
        r-argparse \
        r-future.callr

#===============================================================================
# Work environment
#===============================================================================
WORKDIR /home/rstudio/
RUN echo "alias ll='ls -Alrth'" >> /home/rstudio/.bashrc
CMD ["/bin/bash"]
