# Builds a base Docker image that all other DataComputing images are
# built off of (FROM). In this image we control the end user
# experience, namely; creating the user datacomputing, setting up the users
# environment and the default entry point and cmds.
#
# Although this image is not used directly by end-users, it can be
# found at:
#
#   https://quay.io/organization/datacomputing/base
#
# Authors:
# Xiangmin Jiao <xiangmin.jiao@stonybrook.edu>

FROM phusion/baseimage:latest
LABEL maintainer "Xiangmin Jiao <xiangmin.jiao@stonybrook.edu>"

# Get Ubuntu updates
USER root
RUN apt-get update && \
    apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get -y install \
            locales \
            sudo && \
    echo "C.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Set locale environment
ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    LANGUAGE=C.UTF-8

# Install python3 and update pip
RUN apt-get -y install \
            python3 \
            python3-pip && \
    pip3 install -U pip && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install latex_envs for Jupyter Notebook
RUN pip3 install -U jupyter_latex_envs && \
    jupyter nbextension install --system --py latex_envs && \
    jupyter nbextension enable --system --py latex_envs

# Install spell checker for Jupyter Notebook
RUN jupyter nbextension install --system https://bitbucket.org/ipre/calico/downloads/calico-spell-check-1.0.zip && \
    jupyter nbextension install --system https://bitbucket.org/ipre/calico/downloads/calico-document-tools-1.0.zip && \
    jupyter nbextension install --system https://bitbucket.org/ipre/calico/downloads/calico-cell-tools-1.0.zip && \
    jupyter nbextension enable --system calico-spell-check && \
    rm -rf /tmp/* /var/tmp/*

ENV DCUSER=datacomputing
ENV DCHOME=/home/$DCUSER

COPY set-home-permissions.sh /etc/my_init.d/set-home-permissions.sh

# Set up user so that we do not run as root
# See https://github.com/phusion/baseimage-docker/issues/186
# Disable forward logging
# Add script to set up permissions of home directory on myinit
# Run ldconfig so that /usr/local/lib is in the default search
# path for the dynamic linker.
RUN useradd -m -s /bin/bash -G sudo,docker_env $DCUSER && \
    echo "$DCUSER:docker" | chpasswd && \
    echo "$DCUSER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    touch /etc/service/syslog-forwarder/down && \
    echo "cat $DCHOME/WELCOME" >> /$DCHOME/.bashrc && \
    chmod +x /etc/my_init.d/set-home-permissions.sh && \
    ldconfig

USER $DCUSER
RUN touch $DCHOME/.sudo_as_admin_successful && \
    mkdir $DCHOME/shared
VOLUME $DCHOME/shared

# Print something nice on entry.
COPY WELCOME $DCHOME/WELCOME

WORKDIR $DCHOME
USER root
ENTRYPOINT ["/sbin/my_init","--quiet","--","/sbin/setuser","datacomputing","/bin/bash","-l","-c"]
CMD ["/bin/bash","-i"]
