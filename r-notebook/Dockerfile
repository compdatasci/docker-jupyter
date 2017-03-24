# Builds a Docker image for R with Jupyter Notebook.
#
# It can be found at:
#   https://hub.docker.com/r/compdatasci/r-notebook
#
# Authors:
# Xiangmin Jiao <xiangmin.jiao@stonybrook.edu>

FROM compdatasci/base
LABEL maintainer "Xiangmin Jiao <xiangmin.jiao@stonybrook.edu>"

# Install R
USER root
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
    add-apt-repository 'deb [arch=amd64,i386] https://cran.rstudio.com/bin/linux/ubuntu xenial/' && \
    apt-get update && \
    apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get install -y --no-install-recommends r-base \
            libssl-dev \
            libcairo2-dev \
            libcurl4-openssl-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
COPY install_irkernel.R /tmp/install_irkernel.R 

# Install latex_envs for Jupyter Notebook
RUN R --no-save < install_irkernel.R

# Clean Up
RUN rm -rf /tmp/* /var/tmp/*

USER $DOCKER_USER

# Print something nice on entry.
COPY WELCOME $DOCKER_HOME/WELCOME

USER root
