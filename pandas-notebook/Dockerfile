# Builds a Docker image for Pandas with Jupyter Notebook.
#
# It can be found at:
#   https://quay.io/repository/datacomputing/pandas-notebook
#
# Authors:
# Xiangmin Jiao <xiangmin.jiao@stonybrook.edu>

FROM quay.io/datacomputing/base
LABEL maintainer "Xiangmin Jiao <xiangmin.jiao@stonybrook.edu>"

# Install pandas
USER root
RUN apt-get update && \
    apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get install -y python3-pandas && \
    rm -rf /var/lib/apt/lists/*

# Clean Up
RUN rm -rf /tmp/* /var/tmp/*

USER $DCUSER

# Print something nice on entry.
COPY WELCOME $DCHOME/WELCOME

USER root
