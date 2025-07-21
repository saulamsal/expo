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

## Troubleshooting

If you encounter issues while building or running Expo Go, here are some common problems and their solutions.

### Build fails with "Command PhaseScriptExecution failed"

This is a generic Xcode error. You need to inspect the build logs in Xcode's Report Navigator to find the specific error message.

#### Issue: Script path with spaces

- **Symptom:** The build log shows an error like `No such file or directory` pointing to a partial path that was split at a space.
- **Cause:** A script (`bin/et`) does not correctly handle file paths containing spaces, which is common for Node.js installations managed by tools like `nvm` or `Herd`.
- **Solution:** Edit the `bin/et` file in the root of the repository. Wrap the `$NODE_BINARY` variable in double quotes:
  ```diff
  - $NODE_BINARY "${expotools_dir}/bin/expotools.js" "$@"
  + "$NODE_BINARY" "${expotools_dir}/bin/expotools.js" "$@"
  ```

#### Issue: Missing patch files or protocols

- **Symptom:** The build fails with errors about missing protocols (e.g., `RNSDismissibleModalProtocol`) or other code that should be applied via patches.
- **Cause:** The `postinstall` script, which applies necessary patches to dependencies, may have failed to run correctly.
- **Solution:**
  1.  From the root directory of the repository, run the `postinstall` script manually:
      ```bash
      yarn postinstall
      ```
  2.  If the script fails with a `command not found` error (e.g., for `yarn-deduplicate`), you may need to install the missing dependency to the workspace root:
      ```bash
      yarn add yarn-deduplicate -W
      ```
  3.  Run `yarn postinstall` again.

### General Build Cleaning

Xcode and its related tools can have sticky caches. If you're facing persistent or strange build issues, performing a full clean can often help.

1.  **Clean Xcode Build Folder:** In Xcode, go to `Product > Clean Build Folder`.
2.  **Reinstall Pods:**
    ```bash
    cd apps/expo-go/ios
    rm -rf Pods Podfile.lock
    pod install
    cd ../../..
    ```
3.  **Clear C++ Build Artifacts:** From the root directory:
    ```bash
    find . -name ".cxx" -type d -prune -exec rm -rf '{}' +
    ```
4.  **Clear Metro Cache:**
    ```bash
    rm -rf $TMPDIR/metro-cache
    ```
