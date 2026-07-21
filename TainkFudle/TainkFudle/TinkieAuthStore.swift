import Foundation

enum TinkieAuthStore {
    private static let statusKey = "tinkieislogin"
    private static let accountKey = "tinkiecurrentEmail"
    private static let profileKey = "tinkie_profile_records"
    private static let eulaKey = "tinkie_auth_eula_agreed"
    private static let testEmail = "tinkie@gmail.com"
    private static let testPassword = "12345678"

    static var hasAcceptedEula: Bool {
        get { UserDefaults.standard.bool(forKey: eulaKey) }
        set { UserDefaults.standard.set(newValue, forKey: eulaKey) }
    }

    static func signIn(email rawEmail: String, password: String) -> TinkieAuthResult {
        let email = normalized(rawEmail)
        guard !email.isEmpty else { return .failure("Enter your email address") }
        guard isValidEmail(email) else { return .failure("Enter a valid email address") }
        guard !password.isEmpty else { return .failure("Choose a password") }

        if email == testEmail {
            guard password == testPassword else { return .failure("Wrong password") }
            var records = storedRecords()
            records[testEmail] = defaultRecord(nickname: "Jesscia")
            save(records)
            saveSession(email: testEmail)
            return .success
        }

        let records = storedRecords()
        guard let record = records[email] else { return .failure("Account does not exist") }
        guard record["password"] == password else { return .failure("Wrong password") }
        saveSession(email: email)
        return .success
    }

    static func register(name rawName: String, email rawEmail: String, password: String, heroImagePath: String? = nil) -> TinkieAuthResult {
        let name = rawName.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = normalized(rawEmail)
        guard !name.isEmpty else { return .failure("Enter your name") }
        guard !email.isEmpty else { return .failure("Enter your email address") }
        guard isValidEmail(email) else { return .failure("Enter a valid email address") }
        guard password.count >= 6 else { return .failure("Password must be at least 6 characters") }

        var records = storedRecords()
        guard records[email] == nil else { return .failure("This account already exists") }
        var record = defaultRecord(nickname: name, password: password)
        if let heroImagePath, !heroImagePath.isEmpty {
            record["heroImagePath"] = heroImagePath
        }
        records[email] = record
        save(records)
        saveSession(email: email)
        return .success
    }

    private static func saveSession(email: String) {
        UserDefaults.standard.set(true, forKey: statusKey)
        UserDefaults.standard.set(email, forKey: accountKey)
    }

    private static func normalized(_ email: String) -> String {
        email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }

    private static func isValidEmail(_ email: String) -> Bool {
        let parts = email.split(separator: "@")
        guard parts.count == 2, let domain = parts.last else { return false }
        return domain.contains(".") && email.count >= 6
    }

    private static func defaultRecord(nickname: String, password: String = testPassword) -> [String: String] {
        TinkiePersonaDirectory.record(named: nickname, password: password)
    }

    private static func storedRecords() -> [String: [String: String]] {
        guard
            let data = UserDefaults.standard.data(forKey: profileKey),
            let records = try? JSONDecoder().decode([String: [String: String]].self, from: data)
        else {
            return [:]
        }
        return records
    }

    private static func save(_ records: [String: [String: String]]) {
        guard let data = try? JSONEncoder().encode(records) else { return }
        UserDefaults.standard.set(data, forKey: profileKey)
    }
}
