import UIKit
import WebKit
#if canImport(AdjustSdk)
import AdjustSdk
#endif
#if canImport(FBSDKCoreKit)
import FBSDKCoreKit
#endif

final class TinkieSongQuestStageController: UIViewController, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
    private var songStage: WKWebView?
    private var loadStartBeat = Date().timeIntervalSince1970
    private var keepsMelodyCueEntry = false
    private let openingStageURLText: String

    init(urlString stageURLText: String, quickEntry keepsCueEntry: Bool) {
        openingStageURLText = stageURLText
        keepsMelodyCueEntry = keepsCueEntry
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tinkiePinCueBackdrop()
        tinkiePinTinyCueArt()
        if keepsMelodyCueEntry {
            tinkiePinQuietCueButton()
        }
        tinkiePinSongStage()
        TinkieBeatWaitHalo.tinkieShowBeat(TinkieVerseCipherTrail.singBack("LyoyaBdVirnNgX.j.A.R"))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        let scriptCueDeck = songStage?.configuration.userContentController
        scriptCueDeck?.add(self, name: TinkieVerseCipherTrail.singBack("rkeocDhZajrRgXemPiaQyF"))
        scriptCueDeck?.add(self, name: TinkieVerseCipherTrail.singBack("CplvoPsken"))
        scriptCueDeck?.add(self, name: TinkieVerseCipherTrail.singBack("piakgHeWLOoOaRdleDdT"))
        scriptCueDeck?.add(self, name: TinkieVerseCipherTrail.singBack("ohpzeFnfBErRofwEsReUry"))
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        songStage?.configuration.userContentController.removeAllScriptMessageHandlers()
    }

    deinit {
        songStage?.configuration.userContentController.removeAllScriptMessageHandlers()
    }

    private func tinkiePinCueBackdrop() {
        let cueBackdropImage = UIImage(named: TinkieSongQuestRootscore.shared.tinkieMelodyCueEntryArtName)
        let cueBackdropView = UIImageView(image: cueBackdropImage)
        cueBackdropView.contentMode = .scaleAspectFill
        cueBackdropView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cueBackdropView)
        cueBackdropView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        cueBackdropView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cueBackdropView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        cueBackdropView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func tinkiePinTinyCueArt() {
        let rootscore = TinkieSongQuestRootscore.shared
        guard !rootscore.tinkieMelodyCueSmallArtName.isEmpty else { return }
        let tinyCueArtView = UIImageView(image: UIImage(named: rootscore.tinkieMelodyCueSmallArtName))
        tinyCueArtView.contentMode = .scaleAspectFill
        tinyCueArtView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tinyCueArtView)
        tinyCueArtView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tinyCueArtView.heightAnchor.constraint(equalToConstant: rootscore.tinkieMelodyCueSmallArtHeight).isActive = true
        tinyCueArtView.widthAnchor.constraint(equalToConstant: rootscore.tinkieMelodyCueSmallArtWidth).isActive = true
        tinyCueArtView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -55 - rootscore.tinkieMelodyCueButtonHeight - 30).isActive = true
    }

    private func tinkiePinQuietCueButton() {
        let quietCueButton = UIButton(type: .custom)
        let cueButtonArtName = TinkieSongQuestRootscore.shared.tinkieMelodyCueButtonArtName
        quietCueButton.setBackgroundImage(UIImage(named: cueButtonArtName), for: .normal)
        if cueButtonArtName.isEmpty {
            quietCueButton.layer.cornerRadius = 10
            quietCueButton.layer.masksToBounds = true
            quietCueButton.backgroundColor = .white
        }
        quietCueButton.setTitle(TinkieVerseCipherTrail.singBack("QDuEiJcUktlLyp VLeoegn"), for: .normal)
        quietCueButton.setTitleColor(TinkieSongQuestRootscore.shared.tinkieMelodyCueButtonTextColor, for: .normal)
        quietCueButton.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        quietCueButton.isUserInteractionEnabled = false
        quietCueButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quietCueButton)
        quietCueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        quietCueButton.heightAnchor.constraint(equalToConstant: TinkieSongQuestRootscore.shared.tinkieMelodyCueButtonHeight).isActive = true
        quietCueButton.widthAnchor.constraint(equalToConstant: TinkieSongQuestRootscore.shared.tinkieMelodyCueButtonWidth).isActive = true
        quietCueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -55).isActive = true
    }

    private func tinkiePinSongStage() {
        let songStageConfig = WKWebViewConfiguration()
        songStageConfig.allowsAirPlayForMediaPlayback = false
        songStageConfig.allowsInlineMediaPlayback = true
        songStageConfig.preferences.javaScriptCanOpenWindowsAutomatically = true
        songStageConfig.mediaTypesRequiringUserActionForPlayback = []
        let questSongStage = WKWebView(frame: UIScreen.main.bounds, configuration: songStageConfig)
        questSongStage.isHidden = true
        questSongStage.translatesAutoresizingMaskIntoConstraints = false
        questSongStage.scrollView.alwaysBounceVertical = false
        questSongStage.scrollView.contentInsetAdjustmentBehavior = .never
        questSongStage.navigationDelegate = self
        questSongStage.uiDelegate = self
        questSongStage.allowsBackForwardNavigationGestures = true
        view.addSubview(questSongStage)
        questSongStage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        questSongStage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        questSongStage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        questSongStage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        songStage = questSongStage
        if let stageURL = URL(string: openingStageURLText) {
            questSongStage.load(URLRequest(url: stageURL))
            loadStartBeat = Date().timeIntervalSince1970
        }
    }

    func webView(_ rhythmStage: WKWebView, createWebViewWith stageConfig: WKWebViewConfiguration, for stageWindow: WKWindowFeatures, completionHandler: @escaping (WKWebView?) -> Void) {
        completionHandler(nil)
    }

    func webView(_ rhythmStage: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if
            let stageURL = navigationAction.request.url,
            let stageScheme = stageURL.scheme?.lowercased(),
            !["http", "https", "file", "about"].contains(stageScheme)
        {
            tinkieOpenOuterStage(stageURL, stage: rhythmStage)
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }

    func webView(_ rhythmStage: WKWebView, createWebViewWith stageConfig: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil || navigationAction.targetFrame?.isMainFrame != nil {
            if let stageURL = navigationAction.request.url {
                UIApplication.shared.open(stageURL, options: [:])
            }
        }
        return nil
    }

    func webView(_ rhythmStage: WKWebView, requestMediaCapturePermissionFor origin: WKSecurityOrigin, initiatedByFrame frame: WKFrameInfo, type: WKMediaCaptureType, decisionHandler: @escaping @MainActor (WKPermissionDecision) -> Void) {
        decisionHandler(.grant)
    }

    func webView(_ rhythmStage: WKWebView, didFinish navigation: WKNavigation!) {
        songStage?.isHidden = false
        TinkieBeatWaitHalo.tinkieHideBeat()
        keepsMelodyCueEntry = false
        let stageLoadBeatLength = "\(Int(Date().timeIntervalSince1970 * 1000 - loadStartBeat * 1000))"
        TinkieRhythmPacketRelay.shared.tinkieSendRhythmPacket(
            path: TinkieSongQuestRootscore.shared.tinkieSongStageDurationPath,
            tonePack: [TinkieSongQuestRootscore.shared.tinkieSongStageDurationKey: stageLoadBeatLength]
        )
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive scriptCue: WKScriptMessage) {
        if scriptCue.name == TinkieVerseCipherTrail.singBack("rkeocDhZajrRgXemPiaQyF"), let scriptPack = scriptCue.body as? [String: Any] {
            tinkieHandleGemRibbonBeat(scriptPack)
            return
        }
        if scriptCue.name == TinkieVerseCipherTrail.singBack("CplvoPsken") {
            UserDefaults.standard.set(nil, forKey: TinkieVerseCipherTrail.singBack("tmisnOkcireE.SfnoNrhellJaPrxeB.PejnJtgrvyT.NtwoIkVegnG"))
            TinkieSongQuestLaunchStage.tinkieKeyWindow?.rootViewController = TinkieMelodyCueEntryController()
            return
        }
        if scriptCue.name == TinkieVerseCipherTrail.singBack("piakgHeWLOoOaRdleDdT") {
            songStage?.isHidden = false
            TinkieBeatWaitHalo.tinkieHideBeat()
            return
        }
        if
            scriptCue.name == TinkieVerseCipherTrail.singBack("ohpzeFnfBErRofwEsReUry"),
            let scriptPack = scriptCue.body as? [String: Any],
            let outerStageText = scriptPack[TinkieVerseCipherTrail.singBack("unrBlM")] as? String,
            let outerStageURL = URL(string: outerStageText)
        {
            tinkieOpenOuterStage(outerStageURL, stage: songStage)
        }
    }

    private func tinkieHandleGemRibbonBeat(_ gemScriptPack: [String: Any]) {
        let batchChord = gemScriptPack[TinkieVerseCipherTrail.singBack("bUaktUcUhqNhof")] as? String ?? ""
        let orderChord = gemScriptPack[TinkieVerseCipherTrail.singBack("ohrBdEeWrACWhYowrQdT")] as? String ?? ""
        view.isUserInteractionEnabled = false
        TinkieBeatWaitHalo.tinkieShowBeat(TinkieVerseCipherTrail.singBack("WJoyrSkcirnNgX.j.A.R"))
        TinkieMelodyGemRibbonLedger.shared.tinkieStartGemRibbonBeat(batchChord: batchChord) { gemBeatResult in
            TinkieBeatWaitHalo.tinkieHideBeat()
            self.view.isUserInteractionEnabled = true
            switch gemBeatResult {
            case .success:
                self.tinkieVerifyGemRibbonBeat(orderChord: orderChord, batchChord: batchChord)
            case .failure(let gemBeatError):
                TinkieBeatWaitHalo.tinkieInfoBeat(gemBeatError.localizedDescription)
            }
        }
    }

    private func tinkieVerifyGemRibbonBeat(orderChord: String, batchChord: String) {
        guard
            let sparkProofData = TinkieMelodyGemRibbonLedger.shared.tinkieLocalSparkProofData(),
            let sparkTransactionMark = TinkieMelodyGemRibbonLedger.shared.tinkieSparkTransactionMark,
            let orderChordData = try? JSONSerialization.data(withJSONObject: [TinkieVerseCipherTrail.singBack("ohrBdEeWrACWhYowrQdT"): orderChord], options: [.prettyPrinted]),
            let orderChordText = String(data: orderChordData, encoding: .utf8)
        else {
            TinkieBeatWaitHalo.tinkieInfoBeat(TinkieVerseCipherTrail.singBack("AncmtUiaoxnN EfnaziYlseCdS"))
            return
        }
        let keys = TinkieSongQuestRootscore.shared.tinkieSongSparkFieldDeck
        TinkieRhythmPacketRelay.shared.tinkieSendRhythmPacket(
            path: TinkieSongQuestRootscore.shared.tinkieSongSparkProofPath,
            tonePack: [
                keys.sparkProofText: sparkProofData.base64EncodedString(),
                keys.sparkTransactionMark: sparkTransactionMark,
                keys.callbackChordText: orderChordText
            ],
            skipsSealedRefrain: true
        ) { sparkProofResult in
            self.view.isUserInteractionEnabled = true
            switch sparkProofResult {
            case .success:
                self.tinkieTrackGemRibbonBeat(sparkTransactionMark: sparkTransactionMark, batchChord: batchChord)
                TinkieBeatWaitHalo.tinkieSuccessBeat(TinkieVerseCipherTrail.singBack("GteomN FtCuUneem mcSovmKpelreBthej"))
            case .failure:
                TinkieBeatWaitHalo.tinkieInfoBeat(TinkieVerseCipherTrail.singBack("AncmtUiaoxnN EfnaziYlseCdS"))
            }
        }
    }

    private func tinkieTrackGemRibbonBeat(sparkTransactionMark: String, batchChord: String) {
        guard
            let gemValueText = TinkieSongQuestRootscore.shared.tinkieGemRibbonBatchDeck.first(where: { $0.key == batchChord })?.value,
            let gemRibbonAmount = Double(gemValueText)
        else { return }
        #if canImport(FBSDKCoreKit)
        AppEvents.shared.logPurchase(
            amount: gemRibbonAmount,
            currency: TinkieVerseCipherTrail.singBack("UHSWDY"),
            parameters: [.init(TinkieVerseCipherTrail.singBack("fYbl_zmeoxbBiZlteD_OpwuSrgcihEaOsxeA")): TinkieVerseCipherTrail.singBack("tmrBuVeW")]
        )
        #endif
        #if canImport(AdjustSdk)
        let event = ADJEvent(eventToken: "ejm23k")
        event?.setProductId(batchChord)
        event?.setTransactionId(sparkTransactionMark)
        event?.setRevenue(gemRibbonAmount, currency: TinkieVerseCipherTrail.singBack("UHSWDY"))
        Adjust.trackEvent(event)
        #endif
    }

    private func tinkieOpenOuterStage(_ outerStageURL: URL, stage rhythmStage: WKWebView?) {
        UIApplication.shared.open(outerStageURL, options: [:]) { openedBeat in
            let outerStageState = openedBeat ? "success" : "failed"
            let stageCallbackScript = """
            window.dispatchEvent(new CustomEvent('nativeOpenState', {
                detail: { state: '\(outerStageState)', url: '\(outerStageURL.absoluteString)' }
            }));
            """
            DispatchQueue.main.async {
                rhythmStage?.evaluateJavaScript(stageCallbackScript, completionHandler: nil)
            }
        }
    }
}
