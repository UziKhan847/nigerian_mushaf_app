# nigerian_mushaf_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# nigerian_mushaf_app

## Build for iOS

1. get started: https://docs.flutter.dev/get-started/quick
2. integration setup: https://docs.flutter.dev/platform-integration/ios/setup
3. ios build and relese: https://docs.flutter.dev/deployment/ios

ensure these are installed:
- xcode
- cocoapods

### build for xcode:
run `flutter build ios`

### troubleshoot: clean build / pods and update dependencies

```
flutter clean
rm -rf ios/Pods ios/Podfile.lock
pod repo update
pod install
flutter pub get
flutter precache --ios
flutter build ios --config-only
```

- after running this, head over to xcode and select "Product" -> "Clean build folder". 
- then select "Product" -> "Archive" 


### troubleshoot: just recreate pods

```
cd ios
rm -rf Pods Podfile.lock
pod repo update
pod install
cd ..
```

### open xcode 

`open ios/Runner.xcworkspace`

### Troubleshooting: Make sure iOS is enabled in Flutter
flutter config --enable-ios
flutter doctor -v   # verify Xcode + CocoaPods are detected
