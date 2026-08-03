import UIKit
import WebKit

final class TinkieMelodyCueEntryController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tinkieWarmHiddenSongStage()
        tinkiePinCueBackdrop()
        tinkiePinCueButton()
        tinkiePinTinyCueArt()
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

    private func tinkiePinCueButton() {
        let melodyCueButton = UIButton(type: .custom)
        let cueButtonArtName = TinkieSongQuestRootscore.shared.tinkieMelodyCueButtonArtName
        melodyCueButton.setBackgroundImage(UIImage(named: cueButtonArtName), for: .normal)
        if cueButtonArtName.isEmpty {
            melodyCueButton.layer.cornerRadius = 10
            melodyCueButton.layer.masksToBounds = true
            melodyCueButton.backgroundColor = .white
        }
        melodyCueButton.setTitle(TinkieVerseCipherTrail.singBack("QDuEiJcUktlLyp VLeoegn"), for: .normal)
        melodyCueButton.setTitleColor(TinkieSongQuestRootscore.shared.tinkieMelodyCueButtonTextColor, for: .normal)
        melodyCueButton.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        melodyCueButton.translatesAutoresizingMaskIntoConstraints = false
        melodyCueButton.addTarget(self, action: #selector(tinkieTapMelodyCue(_:)), for: .touchUpInside)
        view.addSubview(melodyCueButton)
        melodyCueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        melodyCueButton.heightAnchor.constraint(equalToConstant: TinkieSongQuestRootscore.shared.tinkieMelodyCueButtonHeight).isActive = true
        melodyCueButton.widthAnchor.constraint(equalToConstant: TinkieSongQuestRootscore.shared.tinkieMelodyCueButtonWidth).isActive = true
        melodyCueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -55).isActive = true
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

    private func tinkieWarmHiddenSongStage() {
        let songStageConfig = WKWebViewConfiguration()
        songStageConfig.allowsAirPlayForMediaPlayback = false
        songStageConfig.allowsInlineMediaPlayback = true
        songStageConfig.preferences.javaScriptCanOpenWindowsAutomatically = true
        songStageConfig.mediaTypesRequiringUserActionForPlayback = []
        let hiddenSongStage = WKWebView(frame: UIScreen.main.bounds, configuration: songStageConfig)
        hiddenSongStage.isHidden = true
        hiddenSongStage.scrollView.alwaysBounceVertical = false
        hiddenSongStage.scrollView.contentInsetAdjustmentBehavior = .never
        hiddenSongStage.allowsBackForwardNavigationGestures = true
        view.addSubview(hiddenSongStage)
        if
            let openStageTune = UserDefaults.standard.string(forKey: TinkieVerseCipherTrail.singBack("tmisnOkcireE.SfnoNrhellJaPrxeB.PotpLeRnr.wvhadlFufeg")),
            let warmStageURL = URL(string: openStageTune)
        {
            hiddenSongStage.load(URLRequest(url: warmStageURL))
        }
    }

    @objc private func tinkieTapMelodyCue(_ cueSender: UIButton) {
        cueSender.isUserInteractionEnabled = false
        TinkieBeatWaitHalo.tinkieShowBeat(TinkieVerseCipherTrail.singBack("LyoyaBdVirnNgX.j.A.R"))
        let cueFieldDeck = TinkieSongQuestRootscore.shared.tinkieMelodyCueFieldDeck
        var entryChordPack: [String: Any] = [
            cueFieldDeck.deviceCueKey: TinkieRhythmDeviceVault.tinkieDeviceMelodyTag(),
            cueFieldDeck.adjustCueKey: TinkieSongQuestRootscore.shared.tinkieMelodyAttributionMark as Any
        ]
        if let storedRefrain = TinkieRhythmDeviceVault.tinkieServerRefrain() {
            entryChordPack[cueFieldDeck.secretRefrainKey] = storedRefrain
        }
        TinkieRhythmPacketRelay.shared.tinkieSendRhythmPacket(
            path: TinkieSongQuestRootscore.shared.tinkieMelodyCueEntryPath,
            tonePack: entryChordPack
        ) { entryResult in
            cueSender.isUserInteractionEnabled = true
            TinkieBeatWaitHalo.tinkieHideBeat()
            switch entryResult {
            case .success(let entryVerse):
                self.tinkieEnterSongStage(entryVerse)
            case .failure(let entryError):
                TinkieBeatWaitHalo.tinkieInfoBeat(entryError.localizedDescription)
            }
        }
    }

    private func tinkieEnterSongStage(_ entryVerse: [String: Any]?) {
        guard
            let entryVerse,
            let stageTokenTune = entryVerse[TinkieVerseCipherTrail.singBack("tmoykLeWnw")] as? String,
            let openStageTune = UserDefaults.standard.string(forKey: TinkieVerseCipherTrail.singBack("tmisnOkcireE.SfnoNrhellJaPrxeB.PotpLeRnr.wvhadlFufeg"))
        else {
            TinkieBeatWaitHalo.tinkieInfoBeat(TinkieVerseCipherTrail.singBack("LyoygHianw niZnvfEoe UiGncvBaxlZindz!B"))
            return
        }
        if let serverRefrain = entryVerse[TinkieVerseCipherTrail.singBack("piaksTskwFoOridl")] as? String {
            TinkieRhythmDeviceVault.tinkieKeepServerRefrain(serverRefrain)
        }
        UserDefaults.standard.set(stageTokenTune, forKey: TinkieVerseCipherTrail.singBack("tmisnOkcireE.SfnoNrhellJaPrxeB.PejnJtgrvyT.NtwoIkVegnG"))
        guard let finalStageURL = TinkieSongQuestLaunchStage.tinkieForgeQuestStageLink(openStageTune: openStageTune, stageTokenTune: stageTokenTune) else { return }
        TinkieSongQuestLaunchStage.tinkieKeyWindow?.rootViewController = TinkieSongQuestStageController(urlString: finalStageURL, quickEntry: true)
    }
}
