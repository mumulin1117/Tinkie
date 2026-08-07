
import UIKit

import FBSDKCoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

        TinkieMelodyGemRibbonLedger.tinkieSealOpenGemTransactions()
       
        return true
    }

  
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: TinkieVerseCipherTrail.singBack("DMeZfYaKuglztS jCooFnCfnifgNuvrbantqiqoXnT"), sessionRole: connectingSceneSession.role)
    }


 
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        TinkieSongPulseBridge.shared.tinkieArchivePushCue(deviceToken)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      
        ApplicationDelegate.shared.application(app, open: url, options: options)
       
    }

}
