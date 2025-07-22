#!/bin/bash

# Build and run Expo Go in Release mode without debugger

# Clean build folder
rm -rf ~/Library/Developer/Xcode/DerivedData/*

# Build the app in Release mode
xcodebuild -workspace Exponent.xcworkspace \
  -scheme "Expo Go" \
  -configuration Release \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro Max,OS=latest' \
  clean build | xcpretty

# Launch the app
xcrun simctl boot "iPhone 16 Pro Max" 2>/dev/null || true
xcrun simctl install booted "$(find ~/Library/Developer/Xcode/DerivedData -name "Expo Go.app" | grep Release-iphonesimulator | head -1)"
xcrun simctl launch booted host.exp.Exponent

echo "App launched in Release mode without debugger"