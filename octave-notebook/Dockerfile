# Builds a Docker image for Octave with Jupyter Notebook.
#
# It can be found at:
#   https://hub.docker.com/r/compdatasci/octave-notebook
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>

FROM quay.io/compdatasci/base
LABEL maintainer "Xiangmin Jiao <xmjiao@gmail.com>"

# Install octave and octave_kernel (liboctave-dev is not installed to save space.)
USER root
WORKDIR /tmp

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

WORKDIR $DOCKER_HOME
