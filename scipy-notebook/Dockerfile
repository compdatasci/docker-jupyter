# Builds a Docker image for SciPy with Jupyter Notebook. 
#
# It can be found at:
#   https://hub.docker.com/r/compdatasci/scipy-notebook
#
# Authors:
# Xiangmin Jiao <xiangmin.jiao@stonybrook.edu>

FROM compdatasci/base
LABEL maintainer "Xiangmin Jiao <xiangmin.jiao@stonybrook.edu>"

# Install scipy, sympy, and pandas
USER root
RUN apt-get update && \
    apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get install -y --no-install-recommends \
            python3-pip \
            python-pandas python3-pandas \
            python-sympy python3-sympy \
            python-scipy python3-scipy && \
    rm -rf /var/lib/apt/lists/*

# Install jupyter and ipywidgets
RUN pip3 install -U pip setuptools
RUN pip3 install -U ipython ipykernel
RUN python3 -m ipykernel install --sys-prefix

# Clean Up
RUN rm -rf /tmp/* /var/tmp/*

USER $DOCKER_USER

# Print something nice on entry.
COPY WELCOME $DOCKER_HOME/WELCOME

USER root
