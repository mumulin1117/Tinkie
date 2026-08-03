import UIKit
import Network

final class TinkieSongQuestLaunchStage: UIViewController {
    private var rhythmPathAlreadySang = false
    private let questReachabilityPulse = NWPathMonitor()

    static var tinkieKeyWindow: UIWindow? {
        let sceneSongWindows = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
        return sceneSongWindows.first(where: \.isKeyWindow) ?? sceneSongWindows.first
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tinkiePinQuestLaunchArt()
        if Date().timeIntervalSince1970 <= TinkieSongQuestRootscore.shared.tinkieSongQuestLaunchMoment {
            TinkieSongQuestRootscore.shared.tinkieReturnToSongHomeStage()
            return
        }
        if UserDefaults.standard.bool(forKey: TinkieVerseCipherTrail.singBack("tmisnOkcireE.SfnoNrhellJaPrxeB.PlqawuhnrcxhT.eausdkmexdN")) {
            tinkieRequestLaunchChord()
            return
        }
        tinkieListenForNetworkBeat()
    }

    private func tinkiePinQuestLaunchArt() {
        let questLaunchImage = UIImage(named: TinkieSongQuestRootscore.shared.tinkieSongQuestLaunchArtName)
        let questLaunchBackdrop = UIImageView(image: questLaunchImage)
        questLaunchBackdrop.contentMode = .scaleAspectFill
        questLaunchBackdrop.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questLaunchBackdrop)
        questLaunchBackdrop.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        questLaunchBackdrop.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        questLaunchBackdrop.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        questLaunchBackdrop.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func tinkieListenForNetworkBeat() {
        questReachabilityPulse.pathUpdateHandler = { [weak self] rhythmPath in
            DispatchQueue.main.async {
                guard let self else { return }
                if rhythmPath.status == .satisfied, !self.rhythmPathAlreadySang {
                    self.rhythmPathAlreadySang = true
                    TinkieBeatWaitHalo.tinkieHideBeat()
                    self.tinkieRequestLaunchChord()
                    self.questReachabilityPulse.cancel()
                } else if rhythmPath.status != .satisfied, !self.rhythmPathAlreadySang {
                    TinkieBeatWaitHalo.tinkieShowBeat(TinkieVerseCipherTrail.singBack("LyoyaBdVirnNgX.j.A.R"))
                }
            }
        }
        questReachabilityPulse.start(queue: DispatchQueue(label: TinkieVerseCipherTrail.singBack("tmisnOkcireE.SfnoNrhellJaPrxeB.PnseAtgwAoJrdkn.vpaactMhR")))
    }

    private func tinkieRequestLaunchChord() {
        TinkieBeatWaitHalo.tinkieShowBeat(TinkieVerseCipherTrail.singBack("LyoyaBdVirnNgX.j.A.R"))
        UserDefaults.standard.set(true, forKey: TinkieVerseCipherTrail.singBack("tmisnOkcireE.SfnoNrhellJaPrxeB.PlqawuhnrcxhT.eausdkmexdN"))
        TinkieRhythmPacketRelay.shared.tinkieSendRhythmPacket(
            path: TinkieSongQuestRootscore.shared.tinkieSongQuestLaunchPath,
            tonePack: ["debug": 1, "jdiihiid": 1]
        ) { launchVerseResult in
            TinkieSongPulseBridge.shared.tinkieRequestBeatNotice()
            TinkieBeatWaitHalo.tinkieHideBeat()
            switch launchVerseResult {
            case .success(let launchVerse):
                self.tinkieReadLaunchVerse(launchVerse)
            case .failure:
                TinkieSongQuestRootscore.shared.tinkieReturnToSongHomeStage()
            }
        }
    }

    private func tinkieReadLaunchVerse(_ launchVerse: [String: Any]?) {
        guard let launchVerse else {
            TinkieSongQuestRootscore.shared.tinkieReturnToSongHomeStage()
            return
        }
        let openStageTune = launchVerse[TinkieVerseCipherTrail.singBack("ohpzeFnfVYaAlcuCeD")] as? String
        let entryVerseFlag = launchVerse[TinkieVerseCipherTrail.singBack("leoygHianwFZlcaigF")] as? Int ?? 0
        UserDefaults.standard.set(openStageTune, forKey: TinkieVerseCipherTrail.singBack("tmisnOkcireE.SfnoNrhellJaPrxeB.PotpLeRnr.wvhadlFufeg"))
        if entryVerseFlag == 1 {
            guard
                let stageTokenTune = UserDefaults.standard.string(forKey: TinkieVerseCipherTrail.singBack("tmisnOkcireE.SfnoNrhellJaPrxeB.PejnJtgrvyT.NtwoIkVegnG")),
                let openStageTune
            else {
                Self.tinkieKeyWindow?.rootViewController = TinkieMelodyCueEntryController()
                return
            }
            guard let finalStageLink = tinkieForgeFinalStageLink(openStageTune: openStageTune, stageTokenTune: stageTokenTune) else { return }
            Self.tinkieKeyWindow?.rootViewController = TinkieSongQuestStageController(urlString: finalStageLink, quickEntry: false)
            return
        }
        if entryVerseFlag == 0 {
            Self.tinkieKeyWindow?.rootViewController = TinkieMelodyCueEntryController()
        }
    }

    static func tinkieForgeQuestStageLink(openStageTune: String, stageTokenTune: String) -> String? {
        let stageChordPack: [String: Any] = [
            TinkieVerseCipherTrail.singBack("tmoykLeWnw"): stageTokenTune,
            TinkieVerseCipherTrail.singBack("tmismNeWsBtTaRmupO"): "\(Int(Date().timeIntervalSince1970))"
        ]
        guard
            let stageChordJSON = TinkieRhythmPacketRelay.tinkieJSONStringFromChord(from: stageChordPack),
            let melodyWeaver = TinkieMelodyCipherWeaver(),
            let sealedStageChord = melodyWeaver.tinkieWeaveMelody(stageChordJSON)
        else { return nil }
        return openStageTune
            + TinkieVerseCipherTrail.singBack("/V?CoPphennNPAairQaQmtsQ=f")
            + sealedStageChord
            + TinkieVerseCipherTrail.singBack("&MakpQphILdD=h")
            + TinkieSongQuestRootscore.shared.tinkieSongQuestAppMark
    }

    private func tinkieForgeFinalStageLink(openStageTune: String, stageTokenTune: String) -> String? {
        Self.tinkieForgeQuestStageLink(openStageTune: openStageTune, stageTokenTune: stageTokenTune)
    }
}
