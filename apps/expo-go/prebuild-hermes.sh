#!/bin/bash

# Prebuild Hermes to avoid CMake architecture issues
cd Pods/hermes-engine || exit 1

# Clean previous builds
rm -rf build

# Create build directory
mkdir -p build/iphonesimulator

# Configure Hermes with single architecture
cmake -S . -B build/iphonesimulator \
  -DHERMES_APPLE_TARGET_PLATFORM:STRING=iphonesimulator \
  -DCMAKE_OSX_ARCHITECTURES:STRING=arm64 \
  -DCMAKE_OSX_DEPLOYMENT_TARGET:STRING=15.1 \
  -DHERMES_ENABLE_DEBUGGER:BOOLEAN=true \
  -DHERMES_ENABLE_INTL:BOOLEAN=true \
  -DHERMES_BUILD_APPLE_FRAMEWORK:BOOLEAN=true \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX:PATH=./destroot \
  -DHERMES_ENABLE_BITCODE:BOOLEAN=false

echo "Hermes pre-configuration complete"