#!/bin/bash

# Simple build script for Expo Go

cd /Users/saul_sharma/projects/sideproject/expo/apps/expo-go/ios

# Clean previous builds
xcodebuild clean -workspace Exponent.xcworkspace -scheme "Expo Go" -quiet

# Build the app
xcodebuild \
  -workspace Exponent.xcworkspace \
  -scheme "Expo Go" \
  -configuration Debug \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro Max' \
  -derivedDataPath ./build \
  CODE_SIGN_IDENTITY="" \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGNING_ALLOWED=NO \
  ONLY_ACTIVE_ARCH=YES \
  build

echo "Build completed"