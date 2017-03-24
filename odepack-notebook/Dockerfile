# Builds a Docker image for Octave with odepkg and Jupyter Notebook.
#
# It can be found at:
#   https://hub.docker.com/r/compdatasci/odepack-notebook
#
# Authors:
# Xiangmin Jiao <xiangmin.jiao@stonybrook.edu>

FROM compdatasci/octave-notebook
LABEL maintainer "Xiangmin Jiao <xiangmin.jiao@stonybrook.edu>"

# Install octave-sybolic and octave-odepkg
USER root
RUN apt-get update && \
    apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get install -y --no-install-recommends octave-symbolic octave-odepkg && \
    rm -rf /var/lib/apt/lists/*

# Clean Up
RUN rm -rf /tmp/* /var/tmp/*

USER $DOCKER_USER

# Print something nice on entry.
COPY WELCOME $DOCKER_HOME/WELCOME

USER root
