# Dockerfile VERSION = v0.6
# docker login registry.cmbi.umcn.nl
# docker build --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') -t registry.cmbi.umcn.nl/x-omics-action-dataset/action_nextflow/r-base-phenotypes:$VERSION . 
# docker push registry.cmbi.umcn.nl/x-omics-action-dataset/action_nextflow/r-base-phenotypes:$VERSION
# docker pull registry.cmbi.umcn.nl/x-omics-action-dataset/action_nextflow/r-base-phenotypes:$VERSION
# docker images # to get IMAGE_ID
# docker save $IMAGE_ID -o r-base-phenotypes.tar
# sudo singularity build r-base-phenotypes.sif docker-archive://r-base-phenotypes.tar

FROM r-base:4.1.2

ARG BUILD_DATE

LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.vendor="Radboudumc, Medical Biosciences department"
LABEL maintainer="casper.devisser@radboudumc.nl"

RUN apt-get -y update && apt-get install -y \
    build-essential \
    cmake \
    pandoc

# Install R packages
ENV RENV_VERSION 0.15.2-2
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))" \
    && R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

COPY renv.lock renv.lock
RUN R -e 'renv::restore()'

# Installations for Nextflow metrics, 'ps' command
RUN apt-get update && apt-get install -y procps && rm -rf /var/lib/apt/lists/*