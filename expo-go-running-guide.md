# Expo Go Running Guide (iOS)

This guide documents the steps taken to run the Expo Go application on an iOS simulator or device from the source code in this monorepo.

## 1. Install Dependencies

First, install the necessary dependencies for the entire project by running `yarn` from the root directory:

```bash
yarn
```

## 2. Build the `expo` Package

Next, build the `expo` package located in the `packages` directory. This is a required step before running the Expo Go app.

```bash
cd packages/expo
yarn build
cd ../..
```

## 3. Start the Metro Bundler

The Metro bundler needs to be running on port 80 before building the iOS application. Run the following command from the `apps/expo-go` directory. You may need to use `sudo` to grant permissions for using a privileged port.

```bash
cd apps/expo-go
sudo yarn start
```

Leave this process running in a separate terminal window.

## 4. Configure the iOS Project

Before building the project in Xcode, you need to configure it for local development.

### a. Create the Build Constants File

The project uses a `plist` file for build constants. A template is provided, which needs to be copied.

```bash
cp apps/expo-go/ios/Exponent/Supporting/EXBuildConstants.plist.example apps/expo-go/ios/Exponent/Supporting/EXBuildConstants.plist
```

### b. Set the Development Kernel Source

Modify the newly created `EXBuildConstants.plist` file to point to the local development kernel. This can be done using the `PlistBuddy` command-line tool.

```bash
/usr/libexec/PlistBuddy -c "Set :DEV_KERNEL_SOURCE LOCAL" apps/expo-go/ios/Exponent/Supporting/EXBuildConstants.plist
```

## 5. Build and Run in Xcode

With all the setup complete, you can now build and run the application.

1.  Open the Xcode workspace file located at `apps/expo-go/ios/Exponent.xcworkspace`.
2.  Select an iOS simulator or a connected physical device as the build target.
3.  Click the **Run** button (the play icon) to build and launch the Expo Go app.
