
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let firstSipCanvas = scene as? UIWindowScene else { return }
        tinkieMelodyCue(firstSipCanvas)
    }

    func tinkieMelodyCue(_ firstSipCanvas: UIWindowScene) {
        guard window == nil else { return }
        let firstSipScroll = UIWindow(windowScene: firstSipCanvas)
        window = firstSipScroll
        ListenerEchoTotal.quaverFlow.tactusStability(pulseRegularity: firstSipScroll) {
            TinkieRhythmMainStageViewController()
        }
        firstSipScroll.makeKeyAndVisible()
    }




}
