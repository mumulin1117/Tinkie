import Foundation

enum TinkieMelodyGateScorebook {
    private static let statusKey = "tinkieislogin"
    private static let accountKey = "tinkiecurrentEmail"
    private static let profileKey = "tinkie_profile_records"
    private static let eulaKey = "tinkie_auth_eula_agreed"
    private static let testMail = "tinkie@gmail.com"
    private static let testSecret = "12345678"

    static var hasSignedMelodyRules: Bool {
        get { UserDefaults.standard.bool(forKey: eulaKey) }
        set { UserDefaults.standard.set(newValue, forKey: eulaKey) }
    }

    static func stepIntoSingerMelody(mailText rawMailText: String, secretText: String) -> TinkieMelodyGateResult {
        let mailKey = cleanSingerMailTune(rawMailText)
        guard !mailKey.isEmpty else { return .melodyBlocked("Enter your email address") }
        guard mailTuneLooksReady(mailKey) else { return .melodyBlocked("Enter a valid email address") }
        guard !secretText.isEmpty else { return .melodyBlocked("Choose a password") }

        if mailKey == testMail {
            guard secretText == testSecret else { return .melodyBlocked("Wrong password") }
            var singerTuneRecords = loadSingerTuneCards()
            singerTuneRecords[testMail] = TinkieSingerTuneAtlas.zeroedTestSingerTuneCard(password: testSecret)
            tuckSingerTuneCardsAway(singerTuneRecords)
            keepSingerOnStage(mailKey: testMail)
            return .melodyOpened
        }

        var singerTuneRecords = loadSingerTuneCards()
        guard let singerTuneRecord = singerTuneRecords[mailKey] else { return .melodyBlocked("Account does not exist") }
        guard singerTuneRecord["password"] == secretText else { return .melodyBlocked("Wrong password") }
        singerTuneRecords[mailKey] = TinkieSingerTuneAtlas.completedSingerTuneCard(from: singerTuneRecord, nickname: singerTuneRecord["nickname"], password: secretText)
        tuckSingerTuneCardsAway(singerTuneRecords)
        keepSingerOnStage(mailKey: mailKey)
        return .melodyOpened
    }

    static func makeFreshSingerCard(singerName rawSingerName: String, mailText rawMailText: String, secretText: String, facePath: String? = nil) -> TinkieMelodyGateResult {
        let singerName = rawSingerName.trimmingCharacters(in: .whitespacesAndNewlines)
        let mailKey = cleanSingerMailTune(rawMailText)
        guard !singerName.isEmpty else { return .melodyBlocked("Enter your name") }
        guard !mailKey.isEmpty else { return .melodyBlocked("Enter your email address") }
        guard mailTuneLooksReady(mailKey) else { return .melodyBlocked("Enter a valid email address") }
        guard secretText.count >= 6 else { return .melodyBlocked("Password must be at least 6 characters") }

        var singerTuneRecords = loadSingerTuneCards()
        guard singerTuneRecords[mailKey] == nil else { return .melodyBlocked("This account already exists") }
        var singerTuneRecord = TinkieSingerTuneAtlas.completedSingerTuneCard(
            from: makeStarterSingerTuneCard(nickname: singerName, password: secretText),
            nickname: singerName,
            password: secretText
        )
        if let facePath, !facePath.isEmpty {
            singerTuneRecord["heroImagePath"] = facePath
        }
        singerTuneRecords[mailKey] = singerTuneRecord
        tuckSingerTuneCardsAway(singerTuneRecords)
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
        let mailPieces = mailKey.split(separator: "@")
        guard mailPieces.count == 2, let mailTail = mailPieces.last else { return false }
        return mailTail.contains(".") && mailKey.count >= 6
    }

    private static func makeStarterSingerTuneCard(nickname: String, password: String = testSecret) -> [String: String] {
        TinkieSingerTuneAtlas.singerTuneRecord(named: nickname, password: password)
    }

    private static func loadSingerTuneCards() -> [String: [String: String]] {
        guard
            let packedCards = UserDefaults.standard.data(forKey: profileKey),
            let singerTuneRecords = try? JSONDecoder().decode([String: [String: String]].self, from: packedCards)
        else {
            return [:]
        }
        return singerTuneRecords
    }

    private static func tuckSingerTuneCardsAway(_ singerTuneRecords: [String: [String: String]]) {
        guard let packedCards = try? JSONEncoder().encode(singerTuneRecords) else { return }
        UserDefaults.standard.set(packedCards, forKey: profileKey)
    }
}
