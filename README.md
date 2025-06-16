# ARM Embedded Development Container

This project provides a lightweight Docker-based development environment for bare-metal ARM projects. It includes the `arm-none-eabi-gcc` toolchain, along with essential build tools like `cmake`, `make`, and `ninja`.

## Features

- `arm-none-eabi-gcc` (from a local `.tar.bz2` file)
- `cmake`, `make`, `ninja`, `bash`
- Based on `debian:bullseye-slim`
- Suitable for STM32 and other Cortex-M development
- Offline and reproducible builds

## Why?

The goal of this project is to create a simple embedded development environment image, that can be used in VS Code to have a reproducible easy to use dev environment without having to install any tools locally.

## Usage

To run the container interactively and mount the current working directory into the container, use the following command in PowerShell:

```powershell
docker run -it -v "${PWD}:/workspace" arm-dev:14.2
```

## Building and Publishing the Docker Image

### 1. Build the Docker Image

To build the Docker image from the current directory:

```bash
docker build -t your-dockerhub-username/arm-dev:14.2 .
```

### 2. Push the Docker Image

To push the Docker image to Dockerhub:

```bash
docker push adabasi/arm-dev:14.2
```

### 3. Use the Docker Image

To use the Docker image from anywhere:

```bash
docker pull your-dockerhub-username/arm-dev:14.2
docker run -it -v "${PWD}:/workspace" your-dockerhub-username/arm-dev:14.2
```
