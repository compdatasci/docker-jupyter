# Builds a Docker image for Octave with Jupyter Notebook.
#
# It can be found at:
#   https://hub.docker.com/r/compdatasci/octave-notebook
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>

FROM compdatasci/base
LABEL maintainer "Xiangmin Jiao <xmjiao@gmail.com>"

USER root
WORKDIR /tmp

# Install octave from source. Also install octave_kernel
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential g++ make gawk gfortran \
        gnuplot-x11 \
        texi2html \
        icoutils \
        libxft-dev \
        gperf \
        flex \
        libbison-dev \
        libqhull-dev \
        libglpk-dev \
        libcurl4-gnutls-dev \
        libfltk-cairo1.3 \
        libfltk-forms1.3 \
        libfltk-images1.3 \
        libfltk1.3-dev \
        librsvg2-dev \
        libqrupdate-dev \
        libgl2ps-dev \
        libarpack2-dev \
        libreadline-dev \
        libncurses-dev \
        hdf5-helpers \
        libhdf5-cpp-11 \
        libhdf5-dev \
        llvm-dev \
        default-jdk \
        default-jdk-headless \
        javahelper \
        openjdk-8-jdk \
        openjdk-8-jdk-headless \
        texinfo \
        libfftw3-dev \
        libgraphicsmagick++1-dev \
        libgraphicsmagick1-dev \
        libjasper-dev \
        libfreeimage-dev \
        transfig \
        epstool \
        librsvg2-bin \
        libosmesa6-dev \
        libsndfile-dev \
        libsndfile1-dev \
        libportaudiocpp0 \
        portaudio19-dev \
        lzip \
        libqt5scintilla2-dev \
        qttools5-dev-tools \
        libopenblas-base libatlas3-base libatlas-dev liblapack-dev \
        ghostscript \
        pstoedit \
        libaec-dev \
        libblas-dev \
        libbtf1.2.1 \
        libcsparse3.1.4 \
        libexif-dev \
        libflac-dev \
        libftgl-dev \
        libftgl2 \
        libjack-dev \
        libklu1.3.3 \
        libldl2.2.1 \
        libogg-dev \
        libspqr2.0.2 \
        libsuitesparse-dev \
        libvorbis-dev \
        libwmf-dev \
        uuid-dev && \
    curl -s ftp://ftp.gnu.org/gnu/octave/octave-4.2.1.tar.gz | tar zx && \
    cd octave-4* && \
    ./configure --prefix=/usr/local && \
    make CFLAGS=-O CXXFLAGS=-O LDFLAGS= && \
    make install && \
    make check && \
    pip2 install -U \
         sympy && \
    pip3 install -U \
        octave_kernel && \
    python3 -m octave_kernel.install && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER $DOCKER_USER

# Install symbolic. odepkg fails to compile.
RUN octave --no-gui --eval "pkg install -forge symbolic"

USER root
WORKDIR $DOCKER_HOME
