FROM nvidia/cuda:11.7.1-cudnn8-devel-centos7

LABEL maintainer Lincoln Bryant <lincolnb@uchicago.edu>

#################
#### curl/wget/software-properties-common
#################
RUN yum install epel-release -y
RUN yum install -y \ 
    curl \
    wget \
    unzip \
    zip \
    vim \
    jq \
    rsync

###################
#### CUDA stuff
###################

# make sure we have a way to bind host provided libraries
# see https://github.com/singularityware/singularity/issues/611
RUN mkdir -p /host-libs && \
    echo "/host-libs/" >/etc/ld.so.conf.d/000-host-libs.conf

####################
# xvfb, python-opengl, python3-tk, swig, ffmpeg - this is needed for visualizations in OpenAI 

RUN yum install -y \
    git \
    freetype-devel \
    libpng-devel \
    libXpm-devel \
    czmq-devel \
    kmod \
    pkgconfig \
    python3-pip \
    python3-devel \
    zlib-devel \
    java-1.8.0-openjdk \ 
    java-1.8.0-openjdk-headless \
    xorg-x11-server-Xvfb \ 
    PyOpenGL \
    hdf5-devel \ 
    && \
    yum clean all 
    
RUN python3.6 -m pip install --upgrade pip setuptools wheel

# Install Python 3.8 from Software Colections
RUN yum install centos-release-scl -y
RUN yum install rh-python38 -y
RUN source scl_source enable rh-python38; python3.8 -m pip install --upgrade pip setuptools wheel
