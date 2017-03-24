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

RUN pip3 install -U \
    sympy \
    scipy \
    pandas && \
    rm -rf /tmp/* /var/tmp/*
