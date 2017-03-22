# Builds a Docker image for Octave with odepkg and Jupyter Notebook.
#
# It can be found at:
#   https://quay.io/repository/compdatasci/odepack-notebook
#
# Authors:
# Xiangmin Jiao <xiangmin.jiao@stonybrook.edu>

FROM quay.io/compdatasci/octave-notebook
LABEL maintainer "Xiangmin Jiao <xiangmin.jiao@stonybrook.edu>"

# Install octave-sybolic and octave-odepkg
USER root
RUN apt-get update && \
    apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get install -y octave-symbolic octave-odepkg && \
    rm -rf /var/lib/apt/lists/*

# Clean Up
RUN rm -rf /tmp/* /var/tmp/*

USER $CDSUSER

# Print something nice on entry.
COPY WELCOME $CDSHOME/WELCOME

USER root
