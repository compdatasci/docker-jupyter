# Builds a Docker image for SciPy with Jupyter Notebook. 
#
# It can be found at:
#   https://quay.io/repository/compdatasci/scipy-notebook
#
# Authors:
# Xiangmin Jiao <xiangmin.jiao@stonybrook.edu>

FROM quay.io/compdatasci/base
LABEL maintainer "Xiangmin Jiao <xiangmin.jiao@stonybrook.edu>"

# Install scipy
USER root
RUN apt-get update && \
    apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get install -y python3-scipy && \
    rm -rf /var/lib/apt/lists/*

# Clean Up
RUN rm -rf /tmp/* /var/tmp/*

USER $CDSUSER

# Print something nice on entry.
COPY WELCOME $CDSHOME/WELCOME

USER root
