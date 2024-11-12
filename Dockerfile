# Use the Ubuntu 22.04 image as the base.
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages for building Android 15
RUN apt-get update && \
    apt-get install -y \
    bc \
    git-core \
    gnupg \
    flex \
    bison \
    gperf \
    build-essential \
    zip \
    curl \
    zlib1g-dev \
    gcc-multilib \
    g++-multilib \
    libc6-dev-i386 \
    lib32ncurses5-dev \
    x11proto-core-dev \
    libx11-dev \
    lib32z1-dev \
    libgl1-mesa-dev \
    libssl-dev \
    libxml2-utils \
    xsltproc \
    unzip \
    fontconfig \
    ccache \
    openjdk-17-jdk \
    python3 \
    python3-pip \
    repo \
    libncurses5 \
    libncurses5-dev \
    vim \
    rsync \
    sudo && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create and set permissions for a user to avoid running as root
RUN useradd -m builder && echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER builder
WORKDIR /home/builder

# Create ~/bin directory, download 'repo', and make it executable
RUN mkdir ~/bin && \
    curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo && \
    chmod a+x ~/bin/repo

# Update the PATH in ~/.bashrc
RUN echo "export PATH=~/bin:\$PATH" >> ~/.bashrc

# Map a volume from the host to the root directory of the container
VOLUME ["/android"]

# Set /android as the working directory
WORKDIR /android

# Default command
CMD ["/bin/bash"]
