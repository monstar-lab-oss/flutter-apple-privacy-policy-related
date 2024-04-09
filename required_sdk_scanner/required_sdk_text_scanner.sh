#!/bin/bash

# https://developer.apple.com/support/third-party-SDK-requirements/
searchTerms=(
    "Abseil"
    "AFNetworking"
    "Alamofire"
    "AppAuth"
    "BoringSSL"
    "openssl_grpc"
    "Capacitor"
    "Charts"
    "connectivity_plus"
    "Cordova"
    "device_info_plus"
    "DKImagePickerController"
    "DKPhotoGallery"
    "FBAEMKit"
    "FBLPromises"
    "FBSDKCoreKit"
    "FBSDKCoreKit_Basics"
    "FBSDKLoginKit"
    "FBSDKShareKit"
    "file_picker"
    "FirebaseABTesting"
    "FirebaseAuth"
    "FirebaseCore"
    "FirebaseCoreDiagnostics"
    "FirebaseCoreExtension"
    "FirebaseCoreInternal"
    "FirebaseCrashlytics"
    "FirebaseDynamicLinks"
    "FirebaseFirestore"
    "FirebaseInstallations"
    "FirebaseMessaging"
    "FirebaseRemoteConfig"
    "Flutter"
    "flutter_inappwebview"
    "flutter_local_notifications"
    "fluttertoast"
    "FMDB"
    "geolocator_apple"
    "GoogleDataTransport"
    "GoogleSignIn"
    "GoogleToolboxForMac"
    "GoogleUtilities"
    "grpcpp"
    "GTMAppAuth"
    "GTMSessionFetcher"
    "hermes"
    "image_picker_ios"
    "IQKeyboardManager"
    "IQKeyboardManagerSwift"
    "Kingfisher"
    "leveldb"
    "Lottie"
    "MBProgressHUD"
    "nanopb"
    "OneSignal"
    "OneSignalCore"
    "OneSignalExtension"
    "OneSignalOutcomes"
    "OpenSSL"
    "OrderedSet"
    "package_info"
    "package_info_plus"
    "path_provider"
    "path_provider_ios"
    "path_provider_foundation"
    "Promises"
    "Protobuf"
    "Reachability"
    "RealmSwift"
    "RxCocoa"
    "RxRelay"
    "RxSwift"
    "SDWebImage"
    "share_plus"
    "shared_preferences_ios"
    "shared_preferences_foundation"
    "SnapKit"
    "sqflite"
    "Starscream"
    "SVProgressHUD"
    "SwiftyGif"
    "SwiftyJSON"
    "Toast"
    "UnityFramework"
    "url_launcher"
    "url_launcher_ios"
    "video_player_avfoundation"
    "wakelock"
    "webview_flutter_wkwebview"
)
search_dir="$1"

if [ -z "$search_dir" ]; then
    echo "Usage: $0 <search_dir>"
    exit 1
fi

foundSDKs=()

for pattern in "${searchTerms[@]}"; do
    files=$(find "$search_dir" -type f \( -name "*.lock" -o -name "*.resolved" -o -name "Package.swift" \
    -o -name "*.xcworkspace" -o -name "*.xcframework" -o -name "*.framework" -o -name "*.xcodeproj" \) \
    -exec grep -H -Fw "$pattern" {} +)
    if [[ -n "$files" ]]; then
        foundSDKs+=("$pattern")
        echo "SDK found: $pattern"
        echo -e "$files\n"
    fi
done

echo "List of found SDKs:"
for sdk in "${foundSDKs[@]}"; do
    echo "- $sdk"
done
