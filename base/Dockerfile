# Builds a base Docker image that all other DataComputing images are
# built off of (FROM). In this image we control the end user
# experience, namely; creating the user compdatasci, setting up the
# users environment and the default entry point and cmds.
#
# Although this image is not used directly by end-users, it can be
# found at:
#
#   https://hub.docker.com/r/compdatasci/base
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>

FROM phusion/baseimage:0.9.20
LABEL maintainer "Xiangmin Jiao <xmjiao@gmail.com>"

# Get Ubuntu updates, pip, etc.
# Install jupyter, ipywidgets 
# jupyter_latex_envs version 1.3.8.4 for Jupyter Notebook
# Install spell checker for Jupyter Notebook
USER root
WORKDIR /tmp

RUN apt-get update && \
    apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get install -y --no-install-recommends \
            locales \
            sudo \
            build-essential \
            python3-pip \
            python3-dev \
            pandoc \
            ttf-dejavu && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install -U pip \
         setuptools && \
    pip3 install -U \
         jupyter \
         ipywidgets && \
    jupyter nbextension install --py --system \
         widgetsnbextension && \
    jupyter nbextension enable --py --system \
         widgetsnbextension && \
    pip3 install -U \
        jupyter_latex_envs==1.3.8.4 && \
    jupyter nbextension install --py --system \
        latex_envs && \
    jupyter nbextension enable --py --system \
        latex_envs && \
    jupyter nbextension install --system \
        https://bitbucket.org/ipre/calico/downloads/calico-spell-check-1.0.zip && \
    jupyter nbextension install --system \
        https://bitbucket.org/ipre/calico/downloads/calico-document-tools-1.0.zip && \
    jupyter nbextension install --system \
        https://bitbucket.org/ipre/calico/downloads/calico-cell-tools-1.0.zip && \
    jupyter nbextension enable --system \
        calico-spell-check && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD image /

########################################################
# Customization for user and location
########################################################

ENV DOCKER_USER=compdatasci
ENV DOCKER_GROUP=$DOCKER_USER \
    DOCKER_HOME=/home/$DOCKER_USER \
    HOME=/home/$DOCKER_USER

# Change the default timezone to America/New_York

# Set up user so that we do not run as root
# See https://github.com/phusion/baseimage-docker/issues/186
# Disable forward logging
# Add script to set up permissions of home directory on myinit
# Run ldconfig so that /usr/local/lib is in the default search
# path for the dynamic linker.
RUN echo "America/New_York" > /etc/timezone && \
    ln -s -f /usr/share/zoneinfo/America/New_York /etc/localtime && \
    useradd -m -s /bin/bash -G sudo,docker_env $DOCKER_USER && \
    echo "$DOCKER_USER:docker" | chpasswd && \
    echo "$DOCKER_USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    touch /etc/service/syslog-forwarder/down && \
    ldconfig && \
    touch $DOCKER_HOME/.sudo_as_admin_successful && \
    mkdir $DOCKER_HOME/shared && \
    mkdir $DOCKER_HOME/.log && touch $DOCKER_HOME/.log/jupyter.log && \
    chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME

WORKDIR $DOCKER_HOME

USER root
ENTRYPOINT ["/sbin/my_init","--quiet","--","/sbin/setuser","compdatasci","/bin/bash","-l","-c"]
CMD ["/bin/bash","-l","-i"]
