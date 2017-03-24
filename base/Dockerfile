# Builds a base Docker image that all other DataComputing images are
# built off of (FROM). In this image we control the end user
# experience, namely; creating the user compdatasci, setting up the users
# environment and the default entry point and cmds.
#
# Although this image is not used directly by end-users, it can be
# found at:
#
#   https://hub.docker.com/r/compdatasci/base
#
# Authors:
# Xiangmin Jiao <xiangmin.jiao@stonybrook.edu>

FROM phusion/baseimage:0.9.20
LABEL maintainer "Xiangmin Jiao <xiangmin.jiao@stonybrook.edu>"

# Get Ubuntu updates
USER root
RUN apt-get update && \
    apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get install -y --no-install-recommends \
            locales \
            sudo && \
    echo "C.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Set locale environment
ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    LANGUAGE=C.UTF-8

# Install pip for python3
RUN apt-get install -y --no-install-recommends \
            build-essential \
            python-pip \
            python3-pip \
            pandoc \
            ttf-dejavu && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install jupyter and ipywidgets
RUN pip3 install -U pip setuptools

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

ADD image /

########################################################
# Customization for user and location
########################################################

# Change the default timezone to America/New_York
RUN ln -s -f /usr/share/zoneinfo/America/New_York /etc/localtime && \
    echo "America/New_York" > /etc/timezone

ENV DOCKER_USER=compdatasci
ENV DOCKER_GROUP=$DOCKER_USER
ENV DOCKER_HOME=/home/$DOCKER_USER
ENV HOME=$DOCKER_HOME
ENV SHELL=/bin/bash

# Set up user so that we do not run as root
# See https://github.com/phusion/baseimage-docker/issues/186
# Disable forward logging
# Add script to set up permissions of home directory on myinit
# Run ldconfig so that /usr/local/lib is in the default search
# path for the dynamic linker.
RUN useradd -m -s /bin/bash -G sudo,docker_env $DOCKER_USER && \
    echo "$DOCKER_USER:docker" | chpasswd && \
    echo "$DOCKER_USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    touch /etc/service/syslog-forwarder/down && \
    echo "cat $DOCKER_HOME/WELCOME" >> /$DOCKER_HOME/.bashrc && \
    ldconfig

USER $DOCKER_USER
RUN touch $DOCKER_HOME/.sudo_as_admin_successful && \
    mkdir $DOCKER_HOME/shared


# Customize font for output area
RUN mkdir -p $DOCKER_HOME/.jupyter/custom && \
    echo "div.output_area pre {" > $DOCKER_HOME/.jupyter/custom && \
    echo "  font-family: DejaVu Sans Mono;" >> $DOCKER_HOME/.jupyter/custom && \
    echo "  font-size: small;" >> $DOCKER_HOME/.jupyter/custom && \
    echo "}" >> $DOCKER_HOME/.jupyter/custom

VOLUME $DOCKER_HOME/shared

# Print something nice on entry.
COPY WELCOME $DOCKER_HOME/WELCOME

WORKDIR $DOCKER_HOME
USER root
ENTRYPOINT ["/sbin/my_init","--quiet","--","/sbin/setuser","compdatasci","/bin/bash","-c"]
CMD ["/bin/bash","-l","-i"]
