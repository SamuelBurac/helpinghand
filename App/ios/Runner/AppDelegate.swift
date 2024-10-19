import Flutter
import UIKit
import Firebase

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    // Initialize Firebase
    FirebaseApp.configure()
    
    // Ensure the APNS token is available before making any FCM plugin API calls
    FirebaseMessaging.instance.getAPNSToken { apnsToken in
      if let apnsToken = apnsToken {
        // APNS token is available, make FCM plugin API requests...
      }
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}