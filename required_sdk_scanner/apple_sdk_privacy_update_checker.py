from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from webdriver_manager.chrome import ChromeDriverManager
import time

chrome_options = Options()
chrome_options.add_argument("--headless")

service = Service(ChromeDriverManager().install())
driver = webdriver.Chrome(service=service, options=chrome_options)

driver.get('https://developer.apple.com/support/third-party-SDK-requirements/')

time.sleep(5)

list_sdk_online = []

article = driver.find_element(By.TAG_NAME, 'article')

section = article.find_element(By.TAG_NAME, 'section')

ul = section.find_element(By.TAG_NAME, 'ul')

li_elements = ul.find_elements(By.TAG_NAME, 'li')

for li in li_elements:
  list_sdk_online.append(li.text)

driver.quit()

old_list_sdk = [
  "Abseil", "BoringSSL / openssl_grpc", "FirebaseABTesting", "FirebaseAuth",
  "FirebaseCore", "FirebaseCoreDiagnostics", "FirebaseCoreExtension",
  "FirebaseCoreInternal", "FirebaseCrashlytics", "FirebaseDynamicLinks",
  "FirebaseFirestore", "FirebaseInstallations", "FirebaseMessaging",
  "FirebaseRemoteConfig", "GoogleDataTransport", "GoogleUtilities",
  "GoogleSignIn", "GoogleToolboxForMac", "GTMAppAuth", "GTMSessionFetcher",
  "leveldb", "Promises", "FBLPromises", "Protobuf", "Flutter",
  "image_picker_ios", "shared_preferences_ios", "path_provider",
  "path_provider_ios", "url_launcher", "url_launcher_ios",
  "video_player_avfoundation", "webview_flutter_wkwebview", "file_picker",
  "flutter_inappwebview", "flutter_local_notifications", "fluttertoast",
  "OrderedSet", "connectivity_plus", "device_info_plus", "package_info",
  "package_info_plus", "share_plus", "geolocator_apple", "sqflite", "wakelock",
  "FBAEMKit", "FBSDKCoreKit", "FBSDKCoreKit_Basics", "FBSDKLoginKit",
  "FBSDKShareKit", "hermes", "OneSignal", "OneSignalCore", "OneSignalExtension",
  "OneSignalOutcomes", "AFNetworking", "Alamofire", "AppAuth", "Capacitor",
  "Charts", "Cordova", "DKImagePickerController", "DKPhotoGallery", "FMDB",
  "grpcpp", "IQKeyboardManager", "IQKeyboardManagerSwift", "Kingfisher", "Lottie",
  "MBProgressHUD", "nanopb", "OpenSSL", "Reachability", "RealmSwift", "RxCocoa",
  "RxRelay", "RxSwift", "SDWebImage", "SnapKit", "Starscream", "SVProgressHUD",
  "SwiftyGif", "SwiftyJSON", "Toast", "UnityFramework"
]

# Convert lists to sets for easier comparison
set_old_list_sdk = set(old_list_sdk)
set_list_sdk_online = set(list_sdk_online)

# Find differences between the two sets
only_in_old_list_sdk = set_old_list_sdk - set_list_sdk_online
only_in_list_sdk_online = set_list_sdk_online - set_old_list_sdk

# Print out the differences
if len(only_in_old_list_sdk) == 0 and len(only_in_list_sdk_online) == 0:
  print("- Not differences 🤷‍♂️")
else:
  print("Only in old list SDK:")
  for item in only_in_old_list_sdk:
    print("- " + item)

  print("\nOnly in list SDK online:")
  for item in only_in_list_sdk_online:
    print("- " + item)
