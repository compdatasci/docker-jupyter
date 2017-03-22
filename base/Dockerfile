# Builds a base Docker image that all other DataComputing images are
# built off of (FROM). In this image we control the end user
# experience, namely; creating the user compdatasci, setting up the users
# environment and the default entry point and cmds.
#
# Although this image is not used directly by end-users, it can be
# found at:
#
#   https://quay.io/organization/compdatasci/base
#
# Authors:
# Xiangmin Jiao <xiangmin.jiao@stonybrook.edu>

FROM phusion/baseimage:0.9.20
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
            python3-pip \
            pandoc && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install jupyter and ipywidgets
RUN pip3 install -U jupyter ipywidgets && \
    jupyter nbextension install --py --system widgetsnbextension && \
    jupyter nbextension enable --py --system widgetsnbextension

# Install jupyter_latex_envs version 1.3.7.2 for Jupyter Notebook
RUN pip3 install -U jupyter_latex_envs==1.3.7.2 && \
    jupyter nbextension install --py --system latex_envs && \
    jupyter nbextension enable --py --system latex_envs

# Install spell checker for Jupyter Notebook
RUN jupyter nbextension install --system https://bitbucket.org/ipre/calico/downloads/calico-spell-check-1.0.zip && \
    jupyter nbextension install --system https://bitbucket.org/ipre/calico/downloads/calico-document-tools-1.0.zip && \
    jupyter nbextension install --system https://bitbucket.org/ipre/calico/downloads/calico-cell-tools-1.0.zip && \
    jupyter nbextension enable --system calico-spell-check && \
    rm -rf /tmp/* /var/tmp/*

ENV CDSUSER=compdatasci
ENV CDSHOME=/home/$CDSUSER

COPY set-home-permissions.sh /etc/my_init.d/set-home-permissions.sh

# Set up user so that we do not run as root
# See https://github.com/phusion/baseimage-docker/issues/186
# Disable forward logging
# Add script to set up permissions of home directory on myinit
# Run ldconfig so that /usr/local/lib is in the default search
# path for the dynamic linker.
RUN useradd -m -s /bin/bash -G sudo,docker_env $CDSUSER && \
    echo "$CDSUSER:docker" | chpasswd && \
    echo "$CDSUSER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    touch /etc/service/syslog-forwarder/down && \
    echo "cat $CDSHOME/WELCOME" >> /$CDSHOME/.bashrc && \
    chmod +x /etc/my_init.d/set-home-permissions.sh && \
    ldconfig

USER $CDSUSER
RUN touch $CDSHOME/.sudo_as_admin_successful && \
    mkdir $CDSHOME/shared
VOLUME $CDSHOME/shared

# Print something nice on entry.
COPY WELCOME $CDSHOME/WELCOME

WORKDIR $CDSHOME
USER root
ENTRYPOINT ["/sbin/my_init","--quiet","--","/sbin/setuser","compdatasci","/bin/bash","-l","-c"]
CMD ["/bin/bash","-i"]
