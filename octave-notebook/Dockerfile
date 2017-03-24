# Builds a Docker image for Octave with Jupyter Notebook.
#
# It can be found at:
#   https://hub.docker.com/r/compdatasci/octave-notebook
#
# Authors:
# Xiangmin Jiao <xiangmin.jiao@stonybrook.edu>

FROM compdatasci/base
LABEL maintainer "Xiangmin Jiao <xiangmin.jiao@stonybrook.edu>"

# Install octave and octave_kernel (liboctave-dev is not installed to save space.)
USER root
RUN apt-get update && \
    apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get install -y --no-install-recommends \
        octave \
        octave-symbolic \
        octave-odepkg \
        ghostscript \
        gnuplot && \
    pip3 install -U \
        octave_kernel && \
    python3 -m octave_kernel.install && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
