import UIKit

final class TinkieSongQuestRootscore: NSObject {
    static let shared = TinkieSongQuestRootscore()

    private override init() {
        super.init()
    }

    var tinkieSongQuestDebugBeat = false

    private var releaseSongGate = TinkieSongGateReleaseDomain()
    private let debugSongGate = TinkieSongGateDebugDomain()
    private var artSongGate = TinkieSongGateArtDomain()
    private var routeSongGate = TinkieSongGateRouteDomain()
    private var fieldSongGate = TinkieSongGateFieldDomain()
    private let ribbonSongGate = TinkieSongGateRibbonDomain()

    var tinkieSongQuestReleaseBase: String {
        get { releaseSongGate.baseTune }
        set { releaseSongGate.baseTune = newValue }
    }

    var tinkieSongQuestReleaseMark: String {
        get { releaseSongGate.appTuneMark }
        set { releaseSongGate.appTuneMark = newValue }
    }

    var tinkieSongQuestReleaseKey: String {
        get { releaseSongGate.cipherTuneKey }
        set { releaseSongGate.cipherTuneKey = newValue }
    }

    var tinkieSongQuestReleaseVector: String {
        get { releaseSongGate.cipherTuneVector }
        set { releaseSongGate.cipherTuneVector = newValue }
    }

    var tinkieSongQuestLaunchMoment: TimeInterval = 0

    var tinkieMelodyAttributionMark: String? {
        get { UserDefaults.standard.string(forKey: TinkieVerseCipherTrail.singBack("tmisnOkcireE.SfnoNrhellJaPrxeB.PafdzjWuysNtf.eiCdO")) }
        set { UserDefaults.standard.set(newValue, forKey: TinkieVerseCipherTrail.singBack("tmisnOkcireE.SfnoNrhellJaPrxeB.PafdzjWuysNtf.eiCdO")) }
    }

    var tinkieRhythmAttributionPaper: String? {
        get { UserDefaults.standard.string(forKey: TinkieVerseCipherTrail.singBack("tmisnOkcireE.SfnoNrhellJaPrxeB.PafdzjWuysNtf.ejDsdoqnG")) }
        set { UserDefaults.standard.set(newValue, forKey: TinkieVerseCipherTrail.singBack("tmisnOkcireE.SfnoNrhellJaPrxeB.PafdzjWuysNtf.ejDsdoqnG")) }
    }


    var tinkieSongQuestLaunchArtName: String {
        get { artSongGate.launchArtName }
        set { artSongGate.launchArtName = newValue }
    }

    var tinkieMelodyCueEntryArtName: String {
        get { artSongGate.entryArtName }
        set { artSongGate.entryArtName = newValue }
    }

    var tinkieMelodyCueButtonArtName: String {
        get { artSongGate.buttonArtName }
        set { artSongGate.buttonArtName = newValue }
    }

    var tinkieMelodyCueSmallArtName: String {
        get { artSongGate.smallArtName }
        set { artSongGate.smallArtName = newValue }
    }

    var tinkieMelodyCueButtonWidth: CGFloat {
        get { artSongGate.buttonWidth }
        set { artSongGate.buttonWidth = newValue }
    }

    var tinkieMelodyCueButtonHeight: CGFloat {
        get { artSongGate.buttonHeight }
        set { artSongGate.buttonHeight = newValue }
    }

    var tinkieMelodyCueButtonTextColor: UIColor {
        get { artSongGate.buttonTextColor }
        set { artSongGate.buttonTextColor = newValue }
    }

    var tinkieMelodyCueSmallArtWidth: CGFloat {
        get { artSongGate.smallArtWidth }
        set { artSongGate.smallArtWidth = newValue }
    }

    var tinkieMelodyCueSmallArtHeight: CGFloat {
        get { artSongGate.smallArtHeight }
        set { artSongGate.smallArtHeight = newValue }
    }

    var tinkieSongQuestLaunchPath: String {
        get { routeSongGate.launchTunePath }
        set { routeSongGate.launchTunePath = newValue }
    }

    var tinkieMelodyCueEntryPath: String {
        get { routeSongGate.entryTunePath }
        set { routeSongGate.entryTunePath = newValue }
    }

    var tinkieSongStageDurationPath: String {
        get { routeSongGate.stageDurationPath }
        set { routeSongGate.stageDurationPath = newValue }
    }

    var tinkieSongSparkProofPath: String {
        get { routeSongGate.sparkProofPath }
        set { routeSongGate.sparkProofPath = newValue }
    }

    var tinkieMelodyCueFieldDeck: TinkieSongCueFieldDeck {
        get { fieldSongGate.cueFieldDeck }
        set { fieldSongGate.cueFieldDeck = newValue }
    }

    var tinkieSongStageDurationKey: String {
        get { fieldSongGate.stageDurationKey }
        set { fieldSongGate.stageDurationKey = newValue }
    }

    var tinkieSongSparkFieldDeck: TinkieSongSparkFieldDeck {
        get { fieldSongGate.sparkFieldDeck }
        set { fieldSongGate.sparkFieldDeck = newValue }
    }

    var tinkieGemRibbonBatchDeck: [String: String] {
        tinkieSongQuestDebugBeat ? ribbonSongGate.debugBatchDeck : ribbonSongGate.releaseBatchDeck
    }

    var tinkieSongHomeReturnBeat: ((UIWindow?) -> Void)?

    func tinkieReturnToSongHomeStage() {
        tinkieSongHomeReturnBeat?(TinkieSongQuestBeginStage.tinkieKeyWindow)
    }

    var tinkieSongQuestBaseURL: String { releaseSongGate.baseTune }
    var tinkieSongQuestAppMark: String { tinkieSongQuestDebugBeat ? debugSongGate.appTuneMark : releaseSongGate.appTuneMark }
    var tinkieMelodyCipherKey: String { tinkieSongQuestDebugBeat ? debugSongGate.cipherTuneKey : releaseSongGate.cipherTuneKey }
    var tinkieMelodyCipherVector: String { tinkieSongQuestDebugBeat ? debugSongGate.cipherTuneVector : releaseSongGate.cipherTuneVector }
}

private struct TinkieSongGateReleaseDomain {
    var baseTune = TinkieVerseCipherTrail.singBack("hxtqtzpp:v/n/rompxiq.zzp8vin6r0m0x3quz.plvinnrkm")
    var appTuneMark = TinkieVerseCipherTrail.singBack("5x1q8z5p0v1n9r3m")
    var cipherTuneKey = TinkieVerseCipherTrail.singBack("ex2q3z7pbvmn6rcm4xtqez5pxvjn9rum")
    var cipherTuneVector = TinkieVerseCipherTrail.singBack("txmqazdpbvlnzrymyx8qbzvpqvdnyrgm")
}

private struct TinkieSongGateDebugDomain {
    let appTuneMark = TinkieVerseCipherTrail.singBack("4x4q3z3p2v2n1r1m")
    let cipherTuneKey = TinkieVerseCipherTrail.singBack("5x1q8z4p8v6nhrem8xpqzzgpbvjnsrkm")
    let cipherTuneVector = TinkieVerseCipherTrail.singBack("6x1q4z4p3v6npr2m8xqqzzhpkvjnsrlm")
}

private struct TinkieSongGateArtDomain {
    var launchArtName = "TainkieLaunch"
    var entryArtName = "TainkieLauioe"
    var buttonArtName = "TainkieLhuliin"
    var smallArtName = "TainkieLer"
    var buttonWidth: CGFloat = 335
    var buttonHeight: CGFloat = 52
    var buttonTextColor: UIColor = .black
    var smallArtWidth: CGFloat = 324
    var smallArtHeight: CGFloat = 112
}

private struct TinkieSongGateRouteDomain {
    var launchTunePath = TinkieVerseCipherTrail.singBack("/xoqpzip/vvn1r/mtxiqnzkpivenLramuxnqczhpTvunnremPxaqtzhpov")
    var entryTunePath = TinkieVerseCipherTrail.singBack("/xoqpzip/vvn1r/mtxiqnzkpivenErnmtxrqyzTpuvnnerPmaxtqhzlp")
    var stageDurationPath = TinkieVerseCipherTrail.singBack("/xoqpzip/vvn1r/mtxiqnzkpivenPramgxeqRzhpyvtnhrmmPxaqtzhptv")
    var sparkProofPath = TinkieVerseCipherTrail.singBack("/xoqpzip/vvn1r/mtxiqnzkpivenRremcxeqizpptvRnhrymtxhqmzPpavtnhrpm")
}

private struct TinkieSongGateFieldDomain {
    var cueFieldDeck = TinkieSongCueFieldDeck(
        deviceCueKey: TinkieVerseCipherTrail.singBack("txiqnzkpivenMremlxoqdzypnv"),
        adjustCueKey: TinkieVerseCipherTrail.singBack("txiqnzkpivenMremlxoqdzypav"),
        secretRefrainKey: TinkieVerseCipherTrail.singBack("txiqnzkpivenMremlxoqdzypdv")
    )
    var stageDurationKey = TinkieVerseCipherTrail.singBack("SxoqnzgpSvtnargmexoq")
    var sparkFieldDeck = TinkieSongSparkFieldDeck(
        sparkProofText: TinkieVerseCipherTrail.singBack("sxpqazrpkvPnrromoxfqTzepxvtnpr"),
        sparkTransactionMark: TinkieVerseCipherTrail.singBack("sxpqazrpkvTnrramnxsqazcptvinornmMxaqrzkptv"),
        callbackChordText: TinkieVerseCipherTrail.singBack("cxaqlzlpbvancrkmCxhqozrpdvTnerxmtxcq")
    )
}

private struct TinkieSongGateRibbonDomain {
    var debugBatchDeck: [String: String] {
        [
            TinkieVerseCipherTrail.singBack("lxvqbzspvvhnxrcmgxcqrzvpevsnorrm"): TinkieVerseCipherTrail.singBack("0x.q9z9p"),
            TinkieVerseCipherTrail.singBack("dxxqizspmvgncrwmexwqhzrptvenzrom"): TinkieVerseCipherTrail.singBack("4x.q9z9p"),
            TinkieVerseCipherTrail.singBack("kxhqtzxplvcnerjmaxxqmzqpcvsnrram"): TinkieVerseCipherTrail.singBack("9x.q9z9p"),
            TinkieVerseCipherTrail.singBack("yxaqdzwpwvvnxrsmpxgqxzwplvnndrbm"): TinkieVerseCipherTrail.singBack("1x9q.z9p9v"),
            TinkieVerseCipherTrail.singBack("qxnqrzcpuvenlrbmtxiquzfplvynkrym"): TinkieVerseCipherTrail.singBack("4x9q.z9p9v"),
            TinkieVerseCipherTrail.singBack("yxmqozhpxvnnvrpmkxqqxzuptvvnarbm"): TinkieVerseCipherTrail.singBack("9x9q.z9p9v")
        ]
    }

    var releaseBatchDeck: [String: String] {
        [
            TinkieVerseCipherTrail.singBack("yxqqfzuptvpnqrjmmxjqszdplvsnsrhm"): TinkieVerseCipherTrail.singBack("0x.q9z9p"),
            TinkieVerseCipherTrail.singBack("sxmqvzlpuvpnsrwmuxiqzzcppvrnsrpm"): TinkieVerseCipherTrail.singBack("1x.q9z9p"),
            TinkieVerseCipherTrail.singBack("qxiqizppwvmntrzmuxvqbzipzvinersm"): TinkieVerseCipherTrail.singBack("4x.q9z9p"),
            TinkieVerseCipherTrail.singBack("dxyqhztpjvsnyrmmwxaqyzsptvfnzrzm"): TinkieVerseCipherTrail.singBack("9x.q9z9p"),
            TinkieVerseCipherTrail.singBack("qxmqbzapavwnbrsmgxmqizppavonyrbm"): TinkieVerseCipherTrail.singBack("1x9q.z9p9v"),
            TinkieVerseCipherTrail.singBack("oxrqzzvpcvbnorumbxaqtzapxvrndrkm"): TinkieVerseCipherTrail.singBack("4x9q.z9p9v"),
            TinkieVerseCipherTrail.singBack("wxoquzdpsvinnrjmqxyqdzfpvvpndrcm"): TinkieVerseCipherTrail.singBack("9x9q.z9p9v")
        ]
    }
}

final class TinkieSongCueFieldDeck: NSObject {
    let deviceCueKey: String
    let adjustCueKey: String
    let secretRefrainKey: String

    init(deviceCueKey: String, adjustCueKey: String, secretRefrainKey: String) {
        self.deviceCueKey = deviceCueKey
        self.adjustCueKey = adjustCueKey
        self.secretRefrainKey = secretRefrainKey
    }
}

final class TinkieSongSparkFieldDeck: NSObject {
    let sparkProofText: String
    let sparkTransactionMark: String
    let callbackChordText: String

    init(sparkProofText: String, sparkTransactionMark: String, callbackChordText: String) {
        self.sparkProofText = sparkProofText
        self.sparkTransactionMark = sparkTransactionMark
        self.callbackChordText = callbackChordText
    }
}
