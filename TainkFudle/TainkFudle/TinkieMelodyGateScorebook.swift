import Foundation

enum TinkieMelodyGateScorebook {
    private static let statusKey = TinkieVerseCipherTrail.singBack("tQiQnHkBipeFiqsNlEoHgliYnP")
    private static let accountKey = TinkieVerseCipherTrail.singBack("tCiCnKkLiqeIczuCrTrhednttNEFmdaSiblk")
    private static let profileKey = "tinkie_profile_records"
    private static let eulaKey = "tinkie_auth_eula_agreed"
    private static let testMail = TinkieVerseCipherTrail.singBack("tbibndkxiTes@sgumQamiKlY.tckoHmm")
    private static let testSecret = TinkieVerseCipherTrail.singBack("1L2R3J4T5H6Z7F8B")

    static var hasSignedMelodyRules: Bool {
        get { UserDefaults.standard.bool(forKey: eulaKey) }
        set { UserDefaults.standard.set(newValue, forKey: eulaKey) }
    }

    static func stepIntoSingerMelody(mailText rawMailText: String, secretText: String) -> TinkieMelodyGateResult {
        let mailKey = cleanSingerMailTune(rawMailText)
        guard !mailKey.isEmpty else { return .melodyBlocked(TinkieVerseCipherTrail.singBack("EknltNeYrW oyioOunrp FeGmuaYiwlg ZaMdFdvrNeVsxsY")) }
        guard mailTuneLooksReady(mailKey) else { return .melodyBlocked(TinkieVerseCipherTrail.singBack("EBnNtgesrm GaF Pvyacljindb BeMmcaXidlq FaKdBdorAeOspsJ")) }
        guard !secretText.isEmpty else { return .melodyBlocked(TinkieVerseCipherTrail.singBack("CghooroFsreM LaJ HpramsZsdwMoerzdH")) }

        if mailKey == testMail {
            guard secretText == testSecret else { return .melodyBlocked(TinkieVerseCipherTrail.singBack("WZrDoVnUgA ZphassDsmwFojrbdZ")) }
            var singerMelodyRecords = loadSingerMelodyRecords()
            singerMelodyRecords[testMail] = TinkieSingerTuneAtlas.zeroedTestSingerMelodyRecord(password: testSecret)
            tuckSingerMelodyRecordsAway(singerMelodyRecords)
            keepSingerOnStage(mailKey: testMail)
            return .melodyOpened
        }

        var singerMelodyRecords = loadSingerMelodyRecords()
        guard let singerMelodyRecord = singerMelodyRecords[mailKey] else { return .melodyBlocked(TinkieVerseCipherTrail.singBack("AocTchoPurnitB rdToBensQ Unjortk CeBxTiQsxtp")) }
        guard singerMelodyRecord[TinkieVerseCipherTrail.singBack("pRaMsysHwboLrPdk")] == secretText else { return .melodyBlocked(TinkieVerseCipherTrail.singBack("WZrDoVnUgA ZphassDsmwFojrbdZ")) }
        singerMelodyRecords[mailKey] = TinkieSingerTuneAtlas.completedSingerMelodyRecord(from: singerMelodyRecord, singerAlias: singerMelodyRecord[TinkieVerseCipherTrail.singBack("niidcKksnvaxmXeb")], password: secretText)
        tuckSingerMelodyRecordsAway(singerMelodyRecords)
        keepSingerOnStage(mailKey: mailKey)
        return .melodyOpened
    }

    static func makeFreshSingerCard(singerName rawSingerName: String, mailText rawMailText: String, secretText: String, facePath: String? = nil) -> TinkieMelodyGateResult {
        let singerName = rawSingerName.trimmingCharacters(in: .whitespacesAndNewlines)
        let mailKey = cleanSingerMailTune(rawMailText)
        guard !singerName.isEmpty else { return .melodyBlocked(TinkieVerseCipherTrail.singBack("EZnEtlegrd LyHoguOrH vnLaYmqeR")) }
        guard !mailKey.isEmpty else { return .melodyBlocked(TinkieVerseCipherTrail.singBack("EknltNeYrW oyioOunrp FeGmuaYiwlg ZaMdFdvrNeVsxsY")) }
        guard mailTuneLooksReady(mailKey) else { return .melodyBlocked(TinkieVerseCipherTrail.singBack("EBnNtgesrm GaF Pvyacljindb BeMmcaXidlq FaKdBdorAeOspsJ")) }
        guard secretText.count >= 6 else { return .melodyBlocked(TinkieVerseCipherTrail.singBack("PzaxsCsuwNowrgdS pmjuIszty Abpev jahtz NliesaKsatt P6l OcOhBaZrWaCcotdeprpsk")) }

        var singerMelodyRecords = loadSingerMelodyRecords()
        guard singerMelodyRecords[mailKey] == nil else { return .melodyBlocked(TinkieVerseCipherTrail.singBack("TMhiilsF LaJcecHoduTnLtv WaMlNrgedaZdLyD DeHxZiHsstxst")) }
        var singerMelodyRecord = TinkieSingerTuneAtlas.completedSingerMelodyRecord(
            from: makeStarterSingerMelodyRecord(singerAlias: singerName, password: secretText),
            singerAlias: singerName,
            password: secretText
        )
        if let facePath, !facePath.isEmpty {
            singerMelodyRecord[TinkieVerseCipherTrail.singBack("hDeVrZoZIwmPaagPecPoadtjhG")] = facePath
        }
        singerMelodyRecords[mailKey] = singerMelodyRecord
        tuckSingerMelodyRecordsAway(singerMelodyRecords)
        keepSingerOnStage(mailKey: mailKey)
        return .melodyOpened
    }

    private static func keepSingerOnStage(mailKey: String) {
        UserDefaults.standard.set(true, forKey: statusKey)
        UserDefaults.standard.set(mailKey, forKey: accountKey)
        NotificationCenter.default.post(name: .tinkieSongPulseSessionDidShift, object: nil)
    }

    private static func cleanSingerMailTune(_ rawMailText: String) -> String {
        rawMailText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }

    private static func mailTuneLooksReady(_ mailKey: String) -> Bool {
        let mailPieces = mailKey.components(separatedBy: TinkieVerseCipherTrail.singBack("@T"))
        guard mailPieces.count == 2, let mailTail = mailPieces.last else { return false }
        return mailTail.contains(TinkieVerseCipherTrail.singBack(".L")) && mailKey.count >= 6
    }

    private static func makeStarterSingerMelodyRecord(singerAlias: String, password: String = testSecret) -> [String: String] {
        TinkieSingerTuneAtlas.singerMelodyRecord(named: singerAlias, password: password)
    }

    private static func loadSingerMelodyRecords() -> [String: [String: String]] {
        guard
            let packedMelodyCards = UserDefaults.standard.data(forKey: profileKey),
            let singerMelodyRecords = try? JSONDecoder().decode([String: [String: String]].self, from: packedMelodyCards)
        else {
            return [:]
        }
        return singerMelodyRecords
    }

    private static func tuckSingerMelodyRecordsAway(_ singerMelodyRecords: [String: [String: String]]) {
        guard let packedMelodyCards = try? JSONEncoder().encode(singerMelodyRecords) else { return }
        UserDefaults.standard.set(packedMelodyCards, forKey: profileKey)
    }
}
