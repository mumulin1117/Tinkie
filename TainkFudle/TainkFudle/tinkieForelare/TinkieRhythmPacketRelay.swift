import UIKit

final class TinkieRhythmPacketRelay: NSObject {
    static let shared = TinkieRhythmPacketRelay()

    private override init() {
        super.init()
    }

    func tinkieSendRhythmPacket(
        path tunePath: String,
        tonePack rhythmPack: [String: Any],
        skipsSealedRefrain keepsPlainServerEcho: Bool = false,
        afterBeat finishBeat: @escaping (Result<[String: Any]?, Error>) -> Void = { _ in }
    ) {
        let rootscore = TinkieSongQuestRootscore.shared
        guard let rhythmURL = URL(string: rootscore.tinkieSongQuestBaseURL + tunePath) else {
            finishBeat(.failure(NSError(domain: TinkieVerseCipherTrail.singBack("UHRVLg FEHrRriowrQ"), code: 400)))
            return
        }
        guard
            let rhythmJSON = Self.tinkieJSONStringFromChord(from: rhythmPack),
            let melodyWeaver = TinkieMelodyCipherWeaver(),
            let sealedRhythmText = melodyWeaver.tinkieWeaveMelody(rhythmJSON),
            let sealedRhythmBytes = sealedRhythmText.data(using: .utf8)
        else { return }

        var rhythmRequest = URLRequest(url: rhythmURL)
        rhythmRequest.httpMethod = TinkieVerseCipherTrail.singBack("PCOSSnTF")
        rhythmRequest.httpBody = sealedRhythmBytes
        rhythmRequest.timeoutInterval = 15
        rhythmRequest.setValue(TinkieVerseCipherTrail.singBack("aTpzpQldircCaRtBiHoenu/AjYsyoLnb"), forHTTPHeaderField: TinkieVerseCipherTrail.singBack("CpoynOtlennNtk-iTmyopweC"))
        rhythmRequest.setValue(rootscore.tinkieSongQuestAppMark, forHTTPHeaderField: TinkieVerseCipherTrail.singBack("aTpzpQIudm"))
        rhythmRequest.setValue(Bundle.main.tinkieSongQuestBuildName, forHTTPHeaderField: TinkieVerseCipherTrail.singBack("aTpzpQVHenrRsjiqoNnd"))
        rhythmRequest.setValue(TinkieRhythmDeviceVault.tinkieDeviceMelodyTag(), forHTTPHeaderField: TinkieVerseCipherTrail.singBack("dWeovWiacleENyow"))
        rhythmRequest.setValue(Locale.current.languageCode ?? "", forHTTPHeaderField: TinkieVerseCipherTrail.singBack("leaknOgYuDaAgXem"))
        rhythmRequest.setValue(UserDefaults.standard.string(forKey: TinkieVerseCipherTrail.singBack("tmisnOkcireE.SfnoNrhellJaPrxeB.PejnJtgrvyT.NtwoIkVegnG")) ?? "", forHTTPHeaderField: TinkieVerseCipherTrail.singBack("leoygHianwTnofkseDnd"))
        rhythmRequest.setValue(UserDefaults.standard.string(forKey: TinkieVerseCipherTrail.singBack("tmisnOkcireE.SfnoNrhellJaPrxeB.PpuuQsfhl.wrdilbvbMoqnG")) ?? "", forHTTPHeaderField: TinkieVerseCipherTrail.singBack("piuEsThZTWoOkbemnM"))

        URLSession.shared.dataTask(with: rhythmRequest) { echoBytes, _, echoError in
            if let echoError {
                DispatchQueue.main.async { finishBeat(.failure(echoError)) }
                return
            }
            guard let echoBytes else {
                DispatchQueue.main.async {
                    finishBeat(.failure(NSError(domain: TinkieVerseCipherTrail.singBack("NAoy oDpajtTaR"), code: 1000)))
                }
                return
            }
            self.tinkieUnpackServerRefrain(
                rawData: echoBytes,
                skipsSealedRefrain: keepsPlainServerEcho,
                afterBeat: finishBeat
            )
        }.resume()
    }

    private func tinkieUnpackServerRefrain(
        rawData serverEchoBytes: Data,
        skipsSealedRefrain keepsPlainServerEcho: Bool,
        afterBeat finishBeat: @escaping (Result<[String: Any]?, Error>) -> Void
    ) {
        do {
            guard let serverChord = try JSONSerialization.jsonObject(with: serverEchoBytes) as? [String: Any] else {
                throw NSError(domain: TinkieVerseCipherTrail.singBack("IvnxvWaSluiIdU VJcSCOPNf"), code: 1001)
            }
            if keepsPlainServerEcho {
                guard
                    let serverCode = serverChord[TinkieVerseCipherTrail.singBack("cVoydEeW")] as? String,
                    serverCode == TinkieVerseCipherTrail.singBack("0W0n0E0V")
                else {
                    DispatchQueue.main.async {
                        finishBeat(.failure(NSError(domain: TinkieVerseCipherTrail.singBack("GteomN FtCuUneem meUryrPodrx"), code: 1001)))
                    }
                    return
                }
                DispatchQueue.main.async { finishBeat(.success([:])) }
                return
            }
            guard
                let serverCode = serverChord[TinkieVerseCipherTrail.singBack("cVoydEeW")] as? String,
                serverCode == TinkieVerseCipherTrail.singBack("0W0n0E0V"),
                let sealedRefrain = serverChord[TinkieVerseCipherTrail.singBack("rkeosTumlutT")] as? String
            else {
                throw NSError(
                    domain: serverChord[TinkieVerseCipherTrail.singBack("mfeosTskajgGeV")] as? String ?? TinkieVerseCipherTrail.singBack("DqaktUaS WBVaRckkJ DEFrPrgourO"),
                    code: 1002
                )
            }
            guard
                let melodyWeaver = TinkieMelodyCipherWeaver(),
                let refrainText = melodyWeaver.tinkieUnweaveMelody(hexTune: sealedRefrain),
                let refrainBytes = refrainText.data(using: .utf8),
                let refrainPack = try JSONSerialization.jsonObject(with: refrainBytes) as? [String: Any]
            else {
                throw NSError(domain: TinkieVerseCipherTrail.singBack("DqeocDrjyHpPtkiqoNnd UEWrgrxoLrf"), code: 1003)
            }
            DispatchQueue.main.async { finishBeat(.success(refrainPack)) }
        } catch {
            DispatchQueue.main.async { finishBeat(.failure(error)) }
        }
    }

    static func tinkieJSONStringFromChord(from chordPack: [String: Any]) -> String? {
        guard let chordBytes = try? JSONSerialization.data(withJSONObject: chordPack) else { return nil }
        return String(data: chordBytes, encoding: .utf8)
    }
}

private extension Bundle {
    var tinkieSongQuestBuildName: String {
        object(forInfoDictionaryKey: TinkieVerseCipherTrail.singBack("CpFJBWumnwdDlcemSlhXovrPtiVVeBrfsxiEobnrShtfruiCnYgi")) as? String ?? ""
    }
}
