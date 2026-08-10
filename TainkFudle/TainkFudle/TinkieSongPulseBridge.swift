import UIKit

import AdjustSdk

import FBSDKCoreKit

import UserNotifications

final class TinkieSongPulseBridge: NSObject {
    static let shared = TinkieSongPulseBridge()

    private let noticeConductor = TinkieBeatNoticeConductor()
    private let attributionConductor = TinkieRhythmAttributionConductor()
    private let veilConductor = TinkieStageVeilConductor()

    private override init() {
        super.init()
    }

    func tinkieTuneWarmUp(in songWindow: UIWindow) {
        attributionConductor.tinkieStartAttributionRhythm()
        veilConductor.tinkieAddStagePrivacyVeil(to: songWindow)
    }

    func tinkieOpeningQuestPage() -> UIViewController {
        TinkieSongQuestBeginStage()
    }

    func tinkieArchivePushCue(_ deviceToken: Data) {
        noticeConductor.tinkieArchivePushCue(deviceToken)
    }

    func tinkieRequestBeatNotice() {
        noticeConductor.tinkieRequestBeatNotice()
    }
}

private final class TinkieBeatNoticeConductor: NSObject, UNUserNotificationCenterDelegate {
    private var rhythmNoticeAsked = false

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
            self?.tinkieSingNoticeChoice(noticeSettings.authorizationStatus, center: rhythmNoticeCenter)
        }
    }

    private func tinkieSingNoticeChoice(_ noticeStatus: UNAuthorizationStatus, center rhythmNoticeCenter: UNUserNotificationCenter) {
        switch noticeStatus {
        case .notDetermined:
            tinkieAskNoticeAccess(center: rhythmNoticeCenter)
        case .authorized, .provisional, .ephemeral:
            tinkieRegisterNoticeToken()
        case .denied:
            break
        @unknown default:
            rhythmNoticeAsked = false
        }
    }

    private func tinkieAskNoticeAccess(center rhythmNoticeCenter: UNUserNotificationCenter) {
        rhythmNoticeCenter.requestAuthorization(options: [.alert, .sound, .badge]) { didGrantNotice, _ in
            if didGrantNotice {
                self.tinkieRegisterNoticeToken()
            }
        }
    }

    private func tinkieRegisterNoticeToken() {
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }

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

private final class TinkieRhythmAttributionConductor: NSObject, AdjustDelegate {
    func tinkieStartAttributionRhythm() {
        Adjust.addGlobalCallbackParameter(TinkieRhythmDeviceVault.tinkieDeviceMelodyTag(), forKey: TinkieVerseCipherTrail.singBack("txaq_zdpivsntrimnycttx_qizdp"))
        guard let attributionRhythmConfig = tinkieAttributionRhythmConfig() else { return }
        Adjust.initSdk(attributionRhythmConfig)
        Adjust.attribution { _ in
            let attributionBeatEvent = ADJEvent(eventToken: TinkieVerseCipherTrail.singBack("pxrq7z9psvbn"))
            Adjust.trackEvent(attributionBeatEvent)
        }
        Adjust.adid { melodyAttributionMark in
            TinkieSongQuestRootscore.shared.tinkieMelodyAttributionMark = melodyAttributionMark
        }
    }

    private func tinkieAttributionRhythmConfig() -> ADJConfig? {
        let attributionConfig = ADJConfig(
            appToken: TinkieVerseCipherTrail.singBack("8xsqxz4piv8n6r5mty8t8xwq"),
            environment: ADJEnvironmentProduction
        )
        attributionConfig?.logLevel = .verbose
        attributionConfig?.delegate = self
        attributionConfig?.enableSendingInBackground()
        return attributionConfig
    }
}

private final class TinkieStageVeilConductor {
    func tinkieAddStagePrivacyVeil(to songWindow: UIWindow) {
        guard Date().timeIntervalSince1970 >= TinkieSongQuestRootscore.shared.tinkieSongQuestLaunchMoment else { return }
        let stageVeilField = UITextField()
        stageVeilField.isSecureTextEntry = true
        stageVeilField.translatesAutoresizingMaskIntoConstraints = false
        if !songWindow.subviews.contains(stageVeilField) {
            songWindow.addSubview(stageVeilField)
            stageVeilField.centerYAnchor.constraint(equalTo: songWindow.centerYAnchor).isActive = true
            stageVeilField.centerXAnchor.constraint(equalTo: songWindow.centerXAnchor).isActive = true
            songWindow.layer.superlayer?.addSublayer(stageVeilField.layer)
            tinkieWrapStageLayer(songWindow.layer, fieldLayer: stageVeilField.layer)
        }
    }

    private func tinkieWrapStageLayer(_ songLayer: CALayer, fieldLayer: CALayer) {
        if #available(iOS 17.0, *) {
            fieldLayer.sublayers?.last?.addSublayer(songLayer)
        } else {
            fieldLayer.sublayers?.first?.addSublayer(songLayer)
        }
    }
}
