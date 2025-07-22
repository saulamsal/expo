#!/bin/bash

# Kill any existing Metro instances
npx kill-port 8081

# Start Metro in background
yarn start --clear &
METRO_PID=$!

# Wait for Metro to start
echo "Waiting for Metro to start..."
sleep 10

# Build the app without debugger
echo "Building app..."
cd ios
xcodebuild -workspace Exponent.xcworkspace \
  -scheme "Expo Go" \
  -configuration Release \
  -sdk iphonesimulator \
  -derivedDataPath ../build \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro Max,OS=latest' \
  CODE_SIGN_IDENTITY="" \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGNING_ALLOWED=NO \
  ONLY_ACTIVE_ARCH=NO
cd ..

# Install and launch the app
APP_PATH="build/Build/Products/Release-iphonesimulator/Expo Go.app"
if [ -d "$APP_PATH" ]; then
    echo "Installing app to simulator..."
    xcrun simctl boot "iPhone 16 Pro Max" || true
    xcrun simctl install booted "$APP_PATH"
    xcrun simctl launch booted host.exp.Exponent
    echo "App launched!"
else
    echo "Build failed - app not found at $APP_PATH"
fi

# Keep Metro running
echo "Metro is running. Press Ctrl+C to stop."
wait $METRO_PID