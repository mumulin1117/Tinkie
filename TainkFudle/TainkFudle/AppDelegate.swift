
import UIKit
#if canImport(FBSDKCoreKit)
import FBSDKCoreKit
#endif

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if canImport(FBSDKCoreKit)
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        ApplicationDelegate.shared.initializeSDK()
        #endif
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: TinkieVerseCipherTrail.singBack("DMeZfYaKuglztS jCooFnCfnifgNuvrbantqiqoXnT"), sessionRole: connectingSceneSession.role)
    }


 
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        TinkieSongPulseBridge.shared.tinkieArchivePushCue(deviceToken)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        #if canImport(FBSDKCoreKit)
        ApplicationDelegate.shared.application(app, open: url, options: options)
        #else
        false
        #endif
    }

}
