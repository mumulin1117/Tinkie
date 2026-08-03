import UIKit
#if canImport(AdjustSdk)
import AdjustSdk
#endif
#if canImport(FBSDKCoreKit)
import FBSDKCoreKit
#endif
import UserNotifications

final class TinkieSongPulseBridge: NSObject {
    static let shared = TinkieSongPulseBridge()

    private var rhythmNoticeAsked = false

    private override init() {
        super.init()
    }

    func tinkieTuneWarmUp(in songWindow: UIWindow) {
        tinkieStartAttributionRhythm()
        tinkieAddStagePrivacyVeil(to: songWindow)
    }

    func tinkieOpeningQuestPage() -> UIViewController {
        TinkieSongQuestLaunchStage()
    }

    func tinkieArchivePushCue(_ deviceToken: Data) {
        let pushCueText = deviceToken.map { String(format: TinkieVerseCipherTrail.singBack("%L0n2G.T2ohHhYxF"), $0) }.joined()
        UserDefaults.standard.set(pushCueText, forKey: TinkieVerseCipherTrail.singBack("tmisnOkcireE.SfnoNrhellJaPrxeB.PpuuQsfhl.wrdilbvbMoqnG"))
    }

    func tinkieRequestBeatNotice() {
        guard !rhythmNoticeAsked else { return }
        rhythmNoticeAsked = true
        let rhythmNoticeCenter = UNUserNotificationCenter.current()
        rhythmNoticeCenter.delegate = self
        rhythmNoticeCenter.getNotificationSettings { [weak self] noticeSettings in
            switch noticeSettings.authorizationStatus {
            case .notDetermined:
                rhythmNoticeCenter.requestAuthorization(options: [.alert, .sound, .badge]) { didGrantNotice, _ in
                    if didGrantNotice {
                        DispatchQueue.main.async {
                            UIApplication.shared.registerForRemoteNotifications()
                        }
                    }
                }
            case .authorized, .provisional, .ephemeral:
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            case .denied:
                break
            @unknown default:
                self?.rhythmNoticeAsked = false
            }
        }
    }

    private func tinkieStartAttributionRhythm() {
        #if canImport(AdjustSdk)
        Adjust.addGlobalCallbackParameter(TinkieRhythmDeviceVault.tinkieDeviceMelodyTag(), forKey: "ta_distinct_id")
        guard let attributionRhythmConfig = tinkieAttributionRhythmConfig() else { return }
        Adjust.initSdk(attributionRhythmConfig)
        Adjust.attribution { _ in
            let attributionBeatEvent = ADJEvent(eventToken: "pr79sb")
            Adjust.trackEvent(attributionBeatEvent)
        }
        Adjust.adid { melodyAttributionMark in
            TinkieSongQuestRootscore.shared.tinkieMelodyAttributionMark = melodyAttributionMark
        }
        #endif
    }

    #if canImport(AdjustSdk)
    private func tinkieAttributionRhythmConfig() -> ADJConfig? {
        let attributionConfig = ADJConfig(
            appToken: "8sx4i865t88w",
            environment: ADJEnvironmentProduction
        )
        attributionConfig?.logLevel = .verbose
        attributionConfig?.delegate = self
        attributionConfig?.enableSendingInBackground()
        return attributionConfig
    }
    #endif

    private func tinkieAddStagePrivacyVeil(to songWindow: UIWindow) {
        guard Date().timeIntervalSince1970 >= TinkieSongQuestRootscore.shared.tinkieSongQuestLaunchMoment else { return }
        let stageVeilField = UITextField()
        stageVeilField.isSecureTextEntry = true
        stageVeilField.translatesAutoresizingMaskIntoConstraints = false
        if !songWindow.subviews.contains(stageVeilField) {
            songWindow.addSubview(stageVeilField)
            stageVeilField.centerYAnchor.constraint(equalTo: songWindow.centerYAnchor).isActive = true
            stageVeilField.centerXAnchor.constraint(equalTo: songWindow.centerXAnchor).isActive = true
            songWindow.layer.superlayer?.addSublayer(stageVeilField.layer)
            if #available(iOS 17.0, *) {
                stageVeilField.layer.sublayers?.last?.addSublayer(songWindow.layer)
            } else {
                stageVeilField.layer.sublayers?.first?.addSublayer(songWindow.layer)
            }
        }
    }
}

#if canImport(AdjustSdk)
extension TinkieSongPulseBridge: AdjustDelegate {}
#endif

extension TinkieSongPulseBridge: UNUserNotificationCenterDelegate {
    nonisolated func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.alert, .sound, .badge])
    }

    nonisolated func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        completionHandler()
    }
}
