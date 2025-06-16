FROM debian:bullseye-slim

ENV GCC_DIR=arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi

# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        bash \
        cmake \
        make \
        ninja-build \
        xz-utils \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /opt

# Copy and extract toolchain archive
# Replace the filename below with your actual archive name
COPY ${GCC_DIR}.tar.xz .

RUN tar -xf ${GCC_DIR}.tar.xz && \
    rm ${GCC_DIR}.tar.xz

# Add toolchain to PATH
ENV PATH="/opt/${GCC_DIR}/bin:${PATH}"

# Create and switch to workspace
RUN mkdir -p /workspace
WORKDIR /workspace

# Set default shell
SHELL ["/bin/bash", "-c"]

# Default to bash
CMD ["bash"]
