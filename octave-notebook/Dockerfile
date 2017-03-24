# Builds a Docker image for Octave with Jupyter Notebook.
#
# It can be found at:
#   https://hub.docker.com/r/compdatasci/octave-notebook
#
# Authors:
# Xiangmin Jiao <xiangmin.jiao@stonybrook.edu>

FROM compdatasci/base
LABEL maintainer "Xiangmin Jiao <xiangmin.jiao@stonybrook.edu>"

# Install octave (liboctave-dev is not installed to save space.)
USER root
RUN apt-get update && \
    apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get install -y --no-install-recommends octave gnuplot && \
    rm -rf /var/lib/apt/lists/*

# Install latex_envs for Jupyter Notebook
RUN pip install -U octave_kernel && \
    python -m octave_kernel.install

# Clean Up
RUN rm -rf /tmp/* /var/tmp/*

USER $DOCKER_USER

# Print something nice on entry.
COPY WELCOME $DOCKER_HOME/WELCOME

USER root
