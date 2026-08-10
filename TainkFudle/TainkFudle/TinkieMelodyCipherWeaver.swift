import Foundation
import CommonCrypto

struct TinkieMelodyCipherWeaver {
    private let melodyKeyData: Data
    private let melodyVectorData: Data

    init?() {
        guard let melodyCipherPair = Self.tinkieMelodyCipherPair() else { return nil }
        melodyKeyData = melodyCipherPair.key
        melodyVectorData = melodyCipherPair.vector
    }

    func tinkieWeaveMelody(_ plainTune: String) -> String? {
        guard let openSongBytes = plainTune.data(using: .utf8) else { return nil }
        return tinkieRunMelodyCipher(openSongBytes, action: kCCEncrypt)?.tinkieMelodyHexTrail()
    }

    func tinkieUnweaveMelody(hexTune: String) -> String? {
        guard let sealedSongBytes = Data(tinkieMelodyHexTrail: hexTune) else { return nil }
        return tinkieRunMelodyCipher(sealedSongBytes, action: kCCDecrypt)?.tinkieMelodyPlainText()
    }

    private func tinkieRunMelodyCipher(_ tuneBytes: Data, action: Int) -> Data? {
        let chorusBufferLimit = tuneBytes.count + kCCBlockSizeAES128
        var chorusBuffer = Data(count: chorusBufferLimit)
        var sungByteCount: size_t = 0
        let cipherBeatStatus = tinkieCipherStatus(
            sourceBytes: tuneBytes,
            action: action,
            outputBytes: &chorusBuffer,
            outputLimit: chorusBufferLimit,
            sungByteCount: &sungByteCount
        )
        guard cipherBeatStatus == kCCSuccess else { return nil }
        return tinkieMelodyCipherResult(chorusBuffer, count: sungByteCount)
    }

    private static func tinkieMelodyCipherPair() -> (key: Data, vector: Data)? {
        guard
            let chordKeyBytes = TinkieSongQuestRootscore.shared.tinkieMelodyCipherKey.data(using: .utf8),
            let chordVectorBytes = TinkieSongQuestRootscore.shared.tinkieMelodyCipherVector.data(using: .utf8)
        else { return nil }
        return (chordKeyBytes, chordVectorBytes)
    }

    private func tinkieCipherStatus(
        sourceBytes tuneBytes: Data,
        action: Int,
        outputBytes chorusBuffer: inout Data,
        outputLimit chorusBufferLimit: Int,
        sungByteCount: inout size_t
    ) -> CCCryptorStatus {
        chorusBuffer.withUnsafeMutableBytes { chorusBytes in
            tuneBytes.withUnsafeBytes { sourceBytes in
                melodyVectorData.withUnsafeBytes { vectorCueBytes in
                    melodyKeyData.withUnsafeBytes { keyCueBytes in
                        CCCrypt(
                            CCOperation(action),
                            CCAlgorithm(kCCAlgorithmAES),
                            CCOptions(kCCOptionPKCS7Padding),
                            keyCueBytes.baseAddress,
                            melodyKeyData.count,
                            vectorCueBytes.baseAddress,
                            sourceBytes.baseAddress,
                            tuneBytes.count,
                            chorusBytes.baseAddress,
                            chorusBufferLimit,
                            &sungByteCount
                        )
                    }
                }
            }
        }
    }

    private func tinkieMelodyCipherResult(_ chorusBuffer: Data, count sungByteCount: size_t) -> Data {
        var melodyResult = chorusBuffer
        melodyResult.removeSubrange(sungByteCount..<melodyResult.count)
        return melodyResult
    }
}

extension Data {
    func tinkieMelodyHexTrail() -> String {
        map { String(format: TinkieVerseCipherTrail.singBack("%L0n2GhZhqxX"), $0) }.joined()
    }

    init?(tinkieMelodyHexTrail source: String) {
        guard source.count.isMultiple(of: 2) else { return nil }
        var melodyBytes = Data()
        melodyBytes.reserveCapacity(source.count / 2)
        var runeCursor = source.startIndex
        guard Self.tinkieCollectMelodyHex(source, into: &melodyBytes, cursor: &runeCursor) else { return nil }
        self = melodyBytes
    }

    func tinkieMelodyPlainText() -> String? {
        String(data: self, encoding: .utf8)
    }

    private static func tinkieCollectMelodyHex(_ source: String, into melodyBytes: inout Data, cursor runeCursor: inout String.Index) -> Bool {
        while runeCursor < source.endIndex {
            let nextRune = source.index(runeCursor, offsetBy: 2)
            guard let melodyByte = UInt8(source[runeCursor..<nextRune], radix: 16) else { return false }
            melodyBytes.append(melodyByte)
            runeCursor = nextRune
        }
        return true
    }
}
