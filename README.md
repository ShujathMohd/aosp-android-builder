# Android Build Environment Docker

This repository contains a Dockerfile to set up an Ubuntu-based environment for building Android 15. The image comes pre-installed with all necessary packages and tools required for the Android build process.

## Getting Started

### Prerequisites
- Ensure you have [Docker](https://docs.docker.com/get-docker/) installed on your host system.
- A directory named `android` on your host machine that will be used to sync the Android source code.

### Building the Docker Image
1. Clone this repository:
   ```bash
   git clone https://github.com/ShujathMohd/aosp-android-builder.git
   cd aosp-android-builder
   ```

2. Build the Docker image:
   ```bash
   docker build -t android-build-env .
   ```

### Running the Docker Container
To start a container with the `android` folder from your host mapped to `/android` in the container:
Create a folder in the root directory 
```bash
mkdir ~/android
```
```bash
docker run -it --rm -v ~/android:/android android-build-env
```

## Setting Up the Android Source

Once inside the container, follow these steps:

1. Initialize the repo:
   ```bash
   repo init -u https://android.googlesource.com/platform/manifest -b <android branch/tag>
   ```

2. Clone the local manifests:
   ```bash
   cd .repo
   git clone https://github.com/ShujathMohd/local_manifests.git
   ```

3. Sync the repository:
   ```bash
   repo sync -c --force-sync --no-tags --no-clone-bundle --optimized-fetch --prune
   ```

## Building Android

1. Set up the environment and choose a build target:
   ```bash
   source build/envsetup.sh
   lunch <device_name>-userdebug
   ```

2. Start the build:
   ```bash
   make -j$(nproc)
   ```
