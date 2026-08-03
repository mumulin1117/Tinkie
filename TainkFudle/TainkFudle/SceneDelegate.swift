
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let songWindow = UIWindow(windowScene: windowScene)
        TinkieSongQuestRootscore.shared.tinkieSongHomeReturnBeat = { window in
            window?.rootViewController = TinkieRhythmMainStageViewController()
            window?.makeKeyAndVisible()
        }
        window = songWindow
        TinkieSongPulseBridge.shared.tinkieTuneWarmUp(in: songWindow)
        songWindow.rootViewController = TinkieSongPulseBridge.shared.tinkieOpeningQuestPage()
        songWindow.makeKeyAndVisible()
    }

   


}
