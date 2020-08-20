# Dockerfile to an image for creating test container
# used with the GoogleTest and GoogleMock framework

# Set base image for susequenet instructions
FROM debian:buster-slim

# Add meta data ad key-value pairs to the image
LABEL maintainer = "Volker Weber <volker.weber@swarco.de>"

# Set environment variables
ENV DEBIAN_FRONTEND noninteractive

# RUN at shell, debian needed packages
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    gnupg \
    wget \
    --no-install-recommends

# Install dependencies
RUN apt-get update && apt-get install -y  \
    build-essential \
    clang clang-format \
    pkg-config \
    cmake \
    libgtest-dev \
    valgrind \
    xsltproc \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Build GTest library
RUN cd /usr/src/googletest && \
    cmake . && \
    cmake --build . --target install

# Set environment variables
ENV GTEST_OUTPUT="xml:/tmp/gtest.xml"

# Set entrypoint instruction
CMD ["/bin/bash"]
