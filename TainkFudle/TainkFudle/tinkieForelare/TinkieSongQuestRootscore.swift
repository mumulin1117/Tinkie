import UIKit

final class TinkieSongQuestRootscore: NSObject {
    static let shared = TinkieSongQuestRootscore()

    private override init() {
        super.init()
    }

    var tinkieSongQuestDebugBeat = false

    var tinkieSongQuestReleaseBase = "http://opi.z8i6003u.link"
    var tinkieSongQuestReleaseMark = "51850193"
    var tinkieSongQuestReleaseKey = "e237bm6c4te5xj9u"
    var tinkieSongQuestReleaseVector = "tmadblzyy8bvqdyg"

    var tinkieSongQuestLaunchMoment: TimeInterval = 0

    var tinkieMelodyAttributionMark: String? {
        get { UserDefaults.standard.string(forKey: TinkieVerseCipherTrail.singBack("tmisnOkcireE.SfnoNrhellJaPrxeB.PafdzjWuysNtf.eiCdO")) }
        set { UserDefaults.standard.set(newValue, forKey: TinkieVerseCipherTrail.singBack("tmisnOkcireE.SfnoNrhellJaPrxeB.PafdzjWuysNtf.eiCdO")) }
    }

    var tinkieRhythmAttributionPaper: String? {
        get { UserDefaults.standard.string(forKey: TinkieVerseCipherTrail.singBack("tmisnOkcireE.SfnoNrhellJaPrxeB.PafdzjWuysNtf.ejDsdoqnG")) }
        set { UserDefaults.standard.set(newValue, forKey: TinkieVerseCipherTrail.singBack("tmisnOkcireE.SfnoNrhellJaPrxeB.PafdzjWuysNtf.ejDsdoqnG")) }
    }


    var tinkieSongQuestLaunchArtName = "TainkieLaunch"
    var tinkieMelodyCueEntryArtName = "TainkieLauioe"
    var tinkieMelodyCueButtonArtName = "TainkieLhuliin"
    var tinkieMelodyCueSmallArtName = "TainkieLer"

    var tinkieMelodyCueButtonWidth: CGFloat = 335
    var tinkieMelodyCueButtonHeight: CGFloat = 52
    var tinkieMelodyCueButtonTextColor: UIColor = .black
    var tinkieMelodyCueSmallArtWidth: CGFloat = 324
    var tinkieMelodyCueSmallArtHeight: CGFloat = 112

    var tinkieSongQuestLaunchPath = "/opi/v1/tinkieLaunchTunePatho"
    var tinkieMelodyCueEntryPath = "/opi/v1/tinkieEntryTunePathl"
    var tinkieSongStageDurationPath = "/opi/v1/tinkiePageRhythmPatht"
    var tinkieSongSparkProofPath = "/opi/v1/tinkieReceiptRhythmPathp"

    var tinkieMelodyCueFieldDeck = TinkieSongCueFieldDeck(
        deviceCueKey: "....n",
        adjustCueKey: "....a",
        secretRefrainKey: "....d"
    )

    var tinkieSongStageDurationKey = "....o"

    var tinkieSongSparkFieldDeck = TinkieSongSparkFieldDeck(
        sparkProofText: "....p",
        sparkTransactionMark: "....t",
        callbackChordText: "....c"
    )

    var tinkieGemRibbonBatchDeck: [String: String] {
        tinkieSongQuestDebugBeat
            ? [
                "lvbsvhxcgcrvesor": "0.99",
                "dxismgcwewhrtezo": "4.99",
                "khtxlcejaxmqcsra": "9.99",
                "yadwwvxspgxwlndb": "19.99",
                "qnrcuelbtiuflyky": "49.99",
                "ymohxnvpkqxutvab": "99.99"
            ]
            : ["a": "0.99", "b": "1.99", "c": "4.99"]
    }

    var tinkieSongHomeReturnBeat: ((UIWindow?) -> Void)?

    func tinkieReturnToSongHomeStage() {
        tinkieSongHomeReturnBeat?(TinkieSongQuestLaunchStage.tinkieKeyWindow)
    }

    var tinkieSongQuestBaseURL: String { tinkieSongQuestReleaseBase }
    var tinkieSongQuestAppMark: String { tinkieSongQuestDebugBeat ? "44332211" : tinkieSongQuestReleaseMark }
    var tinkieMelodyCipherKey: String { tinkieSongQuestDebugBeat ? "518486he8pzgbjsk" : tinkieSongQuestReleaseKey }
    var tinkieMelodyCipherVector: String { tinkieSongQuestDebugBeat ? "614436p28qzhkjsl" : tinkieSongQuestReleaseVector }
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
