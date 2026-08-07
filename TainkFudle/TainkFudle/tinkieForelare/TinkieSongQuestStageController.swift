import UIKit
import WebKit

import AdjustSdk

import FBSDKCoreKit


final class TinkieSongQuestStageController: UIViewController, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
    private var songStage: WKWebView?
   
    init(sonspath stageURLText: String, songeinit keepsCueEntry: Bool) {
        openingStageURLText = stageURLText
        keepsMelodyCueEntry = keepsCueEntry
        super.init(nibName: nil, bundle: nil)
    }
    private var loadStartBeat = TinkieStageLoadMeter()

    required init?(coder: NSCoder) {
        fatalError("")
    }
    private var keepsMelodyCueEntry = false
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tinkieStageOpeningScore()
    }
    private let openingStageURLText: String

    private func tinkieStageOpeningScore() {
        tinkiePinCueBackdrop()
        tinkiePinTinyCueArt()
        if keepsMelodyCueEntry {
            tinkiePinQuietCueButton()
        }
        tinkiePinSongStage()
        TinkieTuneNoticeBridge.tinkieSpinCue(TinkieVerseCipherTrail.singBack("LyoyaBdVirnNgX.j.A.R"))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        tinkieAddScriptCueDeck()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        tinkieClearScriptCueDeck()
    }

    deinit {
        tinkieClearScriptCueDeck()
    }

    private func tinkieAddScriptCueDeck() {
        let scriptCueDeck = songStage?.configuration.userContentController
        tinkieScriptCueNames().forEach { scriptCueDeck?.add(self, name: $0) }
    }

    private func tinkieClearScriptCueDeck() {
        songStage?.configuration.userContentController.removeAllScriptMessageHandlers()
    }

    private func tinkieScriptCueNames() -> [String] {
        TinkieStageCueKind.allCases.map(\.rawName)
    }

    private func tinkiePinCueBackdrop() {
        let cueBackdropImage = UIImage(named: TinkieSongQuestRootscore.shared.tinkieMelodyCueEntryArtName)
        let cueBackdropView = UIImageView(image: cueBackdropImage)
        cueBackdropView.contentMode = .scaleAspectFill
        cueBackdropView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cueBackdropView)
        tinkiePinFullStageView(cueBackdropView)
    }

    private func tinkiePinFullStageView(_ stageView: UIView) {
        stageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func tinkiePinSongStageFrame(_ questSongStage: WKWebView) {
        tinkiePinFullStageView(questSongStage)
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
        let questSongStage = tinkieMakeSongStage()
        view.addSubview(questSongStage)
        tinkiePinSongStageFrame(questSongStage)
        songStage = questSongStage
        tinkieLoadOpeningStage(questSongStage)
    }

    private func tinkieMakeSongStageConfig() -> WKWebViewConfiguration {
        let songStageConfig = WKWebViewConfiguration()
        songStageConfig.allowsAirPlayForMediaPlayback = false
        songStageConfig.allowsInlineMediaPlayback = true
        songStageConfig.preferences.javaScriptCanOpenWindowsAutomatically = true
        songStageConfig.mediaTypesRequiringUserActionForPlayback = []
        return songStageConfig
    }

    private func tinkieMakeSongStage() -> WKWebView {
        let questSongStage = WKWebView(frame: UIScreen.main.bounds, configuration: tinkieMakeSongStageConfig())
        questSongStage.isHidden = true
        questSongStage.translatesAutoresizingMaskIntoConstraints = false
        questSongStage.scrollView.alwaysBounceVertical = false
        questSongStage.scrollView.contentInsetAdjustmentBehavior = .never
        questSongStage.navigationDelegate = self
        questSongStage.uiDelegate = self
        questSongStage.allowsBackForwardNavigationGestures = true
        return questSongStage
    }

    private func tinkieLoadOpeningStage(_ questSongStage: WKWebView) {
        if let stageURL = URL(string: openingStageURLText) {
            questSongStage.load(URLRequest(url: stageURL))
            loadStartBeat = TinkieStageLoadMeter()
        }
    }

    func webView(_ rhythmStage: WKWebView, createWebViewWith stageConfig: WKWebViewConfiguration, for stageWindow: WKWindowFeatures, completionHandler: @escaping (WKWebView?) -> Void) {
        completionHandler(nil)
    }

    func webView(_ rhythmStage: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let stageURL = TinkieOuterStageRoute.tinkieOuterStageURL(from: navigationAction) {
            tinkieOpenOuterStage(stageURL, stage: rhythmStage)
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }

    func webView(_ rhythmStage: WKWebView, createWebViewWith stageConfig: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if TinkieOuterStageRoute.tinkieShouldOpenNewStageOutside(navigationAction), let stageURL = navigationAction.request.url {
            UIApplication.shared.open(stageURL, options: [:])
        }
        return nil
    }

    func webView(_ rhythmStage: WKWebView, requestMediaCapturePermissionFor origin: WKSecurityOrigin, initiatedByFrame frame: WKFrameInfo, type: WKMediaCaptureType, decisionHandler: @escaping @MainActor (WKPermissionDecision) -> Void) {
        decisionHandler(.grant)
    }

    func webView(_ rhythmStage: WKWebView, didFinish navigation: WKNavigation!) {
        songStage?.isHidden = false
        TinkieTuneNoticeBridge.tinkieRestCue()
        TinkieSongPulseBridge.shared.tinkieRequestBeatNotice()
        keepsMelodyCueEntry = false
        tinkieReportStageLoadBeat()
    }

    private func tinkieReportStageLoadBeat() {
        let stageLoadBeatLength = tinkieStageLoadBeatLength()
        TinkieRhythmPacketRelay.shared.tinkieSendRhythmPacket(
            path: TinkieSongQuestRootscore.shared.tinkieSongStageDurationPath,
            tonePack: [TinkieSongQuestRootscore.shared.tinkieSongStageDurationKey: stageLoadBeatLength]
        )
    }

    private func tinkieStageLoadBeatLength() -> String {
        loadStartBeat.tinkieStageLoadBeatLength()
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive scriptCue: WKScriptMessage) {
        guard let cueKind = TinkieStageCueKind.tinkieKind(for: scriptCue.name) else { return }
        tinkiePlayStageCue(cueKind, scriptCue: scriptCue)
    }

    private func tinkiePlayStageCue(_ cueKind: TinkieStageCueKind, scriptCue: WKScriptMessage) {
        switch cueKind {
        case .spark:
            tinkieHandleSparkScriptCue(scriptCue)
        case .close:
            tinkieHandleCloseScriptCue()
        case .ready:
            tinkieHandleReadyScriptCue()
        case .outer:
            tinkieHandleOuterScriptCue(scriptCue)
        }
    }

    private func tinkieHandleSparkScriptCue(_ scriptCue: WKScriptMessage) {
        if let scriptPack = scriptCue.body as? [String: Any] {
            tinkieHandleGemRibbonBeat(scriptPack)
        }
    }

    private func tinkieHandleCloseScriptCue() {
        UserDefaults.standard.set(nil, forKey: TinkieVerseCipherTrail.singBack("tmisnOkcireE.SfnoNrhellJaPrxeB.PejnJtgrvyT.NtwoIkVegnG"))
        TinkieSongQuestBeginStage.tinkieKeyWindow?.rootViewController = TinkieMelodyCueEntryController()
    }

    private func tinkieHandleReadyScriptCue() {
        songStage?.isHidden = false
        TinkieTuneNoticeBridge.tinkieRestCue()
    }

    private func tinkieHandleOuterScriptCue(_ scriptCue: WKScriptMessage) {
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
        let orderCode = gemScriptPack[TinkieVerseCipherTrail.singBack("ohrBdEeWrPCQosdJeD")] as? String ?? ""
        view.isUserInteractionEnabled = false
        TinkieTuneNoticeBridge.tinkieSpinCue(TinkieVerseCipherTrail.singBack("Pxaqyzipnvgn"))
        TinkieMelodyGemRibbonLedger.shared.tinkieStartGemRibbonBeat(batchChord: batchChord) { gemBeatResult in
            self.tinkieFinishGemRibbonStart(gemBeatResult, orderCode: orderCode, batchChord: batchChord)
        }
    }

    private func tinkieFinishGemRibbonStart(_ gemBeatResult: Result<Void, Error>, orderCode: String, batchChord: String) {
        TinkieTuneNoticeBridge.tinkieRestCue()
        view.isUserInteractionEnabled = true
        switch gemBeatResult {
        case .success:
            tinkieVerifyGemRibbonBeat(orderCode: orderCode, batchChord: batchChord)
        case .failure(let gemBeatError):
            TinkieTuneNoticeBridge.tinkieSoftCue(gemBeatError.localizedDescription)
        }
    }

    private func tinkieVerifyGemRibbonBeat(orderCode: String, batchChord: String) {
        guard let sparkTune = tinkieSparkProofPack(orderCode: orderCode) else {
            TinkieTuneNoticeBridge.tinkieSoftCue(TinkieVerseCipherTrail.singBack("AncmtUiaoxnN EfnaziYlseCdS"))
            return
        }
        let keys = TinkieSongQuestRootscore.shared.tinkieSongSparkFieldDeck
        TinkieRhythmPacketRelay.shared.tinkieSendRhythmPacket(
            path: TinkieSongQuestRootscore.shared.tinkieSongSparkProofPath,
            tonePack: [
                keys.sparkProofText: sparkTune.proofData.base64EncodedString(),
                keys.sparkTransactionMark: sparkTune.transactionMark,
                keys.callbackChordText: sparkTune.callbackText
            ],
            skipsSealedRefrain: true
        ) { sparkProofResult in
            self.tinkieFinishSparkProof(sparkProofResult, sparkTransactionMark: sparkTune.transactionMark, batchChord: batchChord)
        }
    }

    private func tinkieSparkProofPack(orderCode: String) -> TinkieSparkProofTune? {
        guard
            let sparkProofData = TinkieMelodyGemRibbonLedger.shared.tinkieLocalSparkProofData(),
            let sparkTransactionMark = TinkieMelodyGemRibbonLedger.shared.tinkieSparkTransactionMark,
            let orderCodeText = tinkieOrderCodeText(orderCode)
        else { return nil }
        return TinkieSparkProofTune(proofData: sparkProofData, transactionMark: sparkTransactionMark, callbackText: orderCodeText)
    }

    private func tinkieOrderCodeText(_ orderCode: String) -> String? {
        guard
            let orderCodeData = try? JSONSerialization.data(withJSONObject: [TinkieVerseCipherTrail.singBack("ohrBdEeWrPCQosdJeD"): orderCode], options: [.prettyPrinted])
        else { return nil }
        return String(data: orderCodeData, encoding: .utf8)
    }

    private func tinkieFinishSparkProof(_ sparkProofResult: Result<[String: Any]?, Error>, sparkTransactionMark: String, batchChord: String) {
        view.isUserInteractionEnabled = true
        switch sparkProofResult {
        case .success:
            tinkieTrackGemRibbonBeat(sparkTransactionMark: sparkTransactionMark, batchChord: batchChord)
            TinkieTuneNoticeBridge.tinkieBrightCue(TinkieVerseCipherTrail.singBack("Pxaqyz psvuncrcmexsqszfpuvln"))
        case .failure:
            TinkieTuneNoticeBridge.tinkieSoftCue(TinkieVerseCipherTrail.singBack("AncmtUiaoxnN EfnaziYlseCdS"))
        }
    }

    private func tinkieTrackGemRibbonBeat(sparkTransactionMark: String, batchChord: String) {
        guard
            let gemValueText = TinkieSongQuestRootscore.shared.tinkieGemRibbonBatchDeck.first(where: { $0.key == batchChord })?.value,
            let gemRibbonAmount = Double(gemValueText)
        else { return }
       
        AppEvents.shared.logPurchase(
            amount: gemRibbonAmount,
            currency: TinkieVerseCipherTrail.singBack("UHSWDY"),
            parameters: [.init(TinkieVerseCipherTrail.singBack("fYbl_zmeoxbBiZlteD_OpwuSrgcihEaOsxeA")): TinkieVerseCipherTrail.singBack("tmrBuVeW")]
        )
       
        let event = ADJEvent(eventToken: TinkieVerseCipherTrail.singBack("exjqmz2p3vkn"))
        event?.setProductId(batchChord)
        event?.setTransactionId(sparkTransactionMark)
        event?.setRevenue(gemRibbonAmount, currency: TinkieVerseCipherTrail.singBack("UHSWDY"))
        Adjust.trackEvent(event)
       
    }

    private func tinkieOpenOuterStage(_ outerStageURL: URL, stage rhythmStage: WKWebView?) {
        UIApplication.shared.open(outerStageURL, options: [:]) { openedBeat in
            let outerStageState = openedBeat ? TinkieVerseCipherTrail.singBack("sxuqczcpevsnsr") : TinkieVerseCipherTrail.singBack("fxaqizlpevdn")
            let stageCallbackScript = TinkieVerseCipherTrail.singBack("wxiqnzdpovwn.rdmiystpxaqtzcphvEnvremnytt(xnqezwp vCnursmtyotmxEqvzepnvtn(r'mnyattxiqvzepOvpnernmSyttaxtqez'p,v n{r\nm y t x qdzeptvanirlm:y t{x qsztpavtner:m y't")
                + outerStageState
                + TinkieVerseCipherTrail.singBack("'x,q zuprvln:r m'y")
                + outerStageURL.absoluteString
                + TinkieVerseCipherTrail.singBack("'x q}z\np}v)n)r;m")
            DispatchQueue.main.async {
                rhythmStage?.evaluateJavaScript(stageCallbackScript, completionHandler: nil)
            }
        }
    }
}

private enum TinkieStageCueKind: CaseIterable {
    case spark
    case close
    case ready
    case outer

    var rawName: String {
        switch self {
        case .spark:
            return TinkieVerseCipherTrail.singBack("rkeocDhZajrRgXemPiaQyF")
        case .close:
            return TinkieVerseCipherTrail.singBack("CplvoPsken")
        case .ready:
            return TinkieVerseCipherTrail.singBack("piakgHeWLOoOaRdleDdT")
        case .outer:
            return TinkieVerseCipherTrail.singBack("ohpzeFnfBErRofwEsReUry")
        }
    }

    static func tinkieKind(for scriptCueName: String) -> TinkieStageCueKind? {
        allCases.first { $0.rawName == scriptCueName }
    }
}

private struct TinkieStageLoadMeter {
    private let openingBeat = Date().timeIntervalSince1970

    func tinkieStageLoadBeatLength() -> String {
        "\(Int(Date().timeIntervalSince1970 * 1000 - openingBeat * 1000))"
    }
}

private struct TinkieSparkProofTune {
    let proofData: Data
    let transactionMark: String
    let callbackText: String
}

private enum TinkieOuterStageRoute {
    static func tinkieOuterStageURL(from navigationAction: WKNavigationAction) -> URL? {
        guard
            let stageURL = navigationAction.request.url,
            let stageScheme = stageURL.scheme?.lowercased(),
            !tinkieStageAllowedSchemes().contains(stageScheme)
        else { return nil }
        return stageURL
    }

    static func tinkieShouldOpenNewStageOutside(_ navigationAction: WKNavigationAction) -> Bool {
        navigationAction.targetFrame == nil || navigationAction.targetFrame?.isMainFrame != nil
    }

    private static func tinkieStageAllowedSchemes() -> [String] {
        [
            TinkieVerseCipherTrail.singBack("hxtqtzpp"),
            TinkieVerseCipherTrail.singBack("hxtqtzppsv"),
            TinkieVerseCipherTrail.singBack("fxiqlzep"),
            TinkieVerseCipherTrail.singBack("axbqozuptv")
        ]
    }
}
