# Stage 1: unpack toolchain
FROM debian:bullseye-slim as tools-image

ARG GCC_DIR=arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi

RUN apt-get update && \
    apt-get install -y --no-install-recommends xz-utils && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /opt
COPY ${GCC_DIR}.tar.xz .
RUN tar -xf ${GCC_DIR}.tar.xz && rm ${GCC_DIR}.tar.xz

# Stage 2: final dev-container image
FROM debian:bullseye-slim as dev-image

ENV GCC_DIR=arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi

# Install development tools and utilities
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        bash \
        cmake \
        make \
        ninja-build \
        clang \
        clang-format \
        clang-tidy \
        cppcheck \
        git \
        ruby \
        ruby-dev \
        build-essential \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install ceedling
RUN gem install ceedling --no-document

# Copy extracted/installed tools from Stage 1 image
COPY --from=tools-image /opt/${GCC_DIR} /opt/${GCC_DIR}

# Add tools to PATH
ENV PATH="/opt/${GCC_DIR}/bin:${PATH}"

# Setup workspace
RUN mkdir -p /workspace
WORKDIR /workspace

# Change shell to bash
SHELL ["/bin/bash", "-c"]

# Default command
CMD ["bash"]
