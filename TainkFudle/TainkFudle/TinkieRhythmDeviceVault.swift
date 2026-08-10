import UIKit
import Security

final class TinkieRhythmDeviceVault: NSObject {
    private static var rhythmVaultService: String {
        let appBundleChord = Bundle.main.bundleIdentifier ?? TinkieVerseCipherTrail.singBack("txiqnzkpiven.rvmoyitcxeq.zspovnngrsm")
        return appBundleChord + TinkieVerseCipherTrail.singBack(".xfqozrpevlnarrmey")
    }

    private static var deviceMelodyAccount: String { rhythmVaultService + TinkieVerseCipherTrail.singBack(".UtDiJnfktiIeV.jfEoeryeClaagrOeS.gdzeRvziDcOeh") }
    private static var secretRefrainAccount: String { rhythmVaultService + TinkieVerseCipherTrail.singBack(".UtDiJnfktiIeV.jfEoeryeClaagrOeS.gpLhUrvavseeh") }

    static func tinkieDeviceMelodyTag() -> String {
        if let savedMelodyTag = tinkieReadVaultRefrain(account: deviceMelodyAccount) {
            return savedMelodyTag
        }
        let freshMelodyTag = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
        tinkieSaveVaultRefrain(freshMelodyTag, account: deviceMelodyAccount)
        return freshMelodyTag
    }

    static func tinkieKeepServerRefrain(_ serverRefrain: String) {
        tinkieSaveVaultRefrain(serverRefrain, account: secretRefrainAccount)
    }

    static func tinkieServerRefrain() -> String? {
        tinkieReadVaultRefrain(account: secretRefrainAccount)
    }

    private static func tinkieReadVaultRefrain(account vaultAccount: String) -> String? {
        let vaultQuery = tinkieVaultQuery(account: vaultAccount, extra: [
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ])
        var foundVaultItem: AnyObject?
        let vaultStatus = SecItemCopyMatching(vaultQuery as CFDictionary, &foundVaultItem)
        return tinkieReadVaultText(status: vaultStatus, item: foundVaultItem)
    }

    private static func tinkieSaveVaultRefrain(_ refrainValue: String, account vaultAccount: String) {
        tinkieEraseVaultRefrain(account: vaultAccount)
        guard let refrainBytes = refrainValue.data(using: .utf8) else { return }
        let vaultQuery = tinkieVaultQuery(account: vaultAccount, extra: [
            kSecValueData as String: refrainBytes,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
        ])
        SecItemAdd(vaultQuery as CFDictionary, nil)
    }

    private static func tinkieEraseVaultRefrain(account vaultAccount: String) {
        let vaultQuery = tinkieVaultQuery(account: vaultAccount)
        SecItemDelete(vaultQuery as CFDictionary)
    }

    private static func tinkieVaultQuery(account vaultAccount: String, extra vaultExtras: [String: Any] = [:]) -> [String: Any] {
        var vaultQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: rhythmVaultService,
            kSecAttrAccount as String: vaultAccount
        ]
        vaultExtras.forEach { vaultQuery[$0.key] = $0.value }
        return vaultQuery
    }

    private static func tinkieReadVaultText(status vaultStatus: OSStatus, item foundVaultItem: AnyObject?) -> String? {
        guard
            vaultStatus == errSecSuccess,
            let foundVaultBytes = foundVaultItem as? Data
        else { return nil }
        return String(data: foundVaultBytes, encoding: .utf8)
    }
}
