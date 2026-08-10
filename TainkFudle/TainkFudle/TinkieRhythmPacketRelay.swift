import UIKit

final class TinkieRhythmPacketRelay: NSObject {
    static let shared = TinkieRhythmPacketRelay()

    private let packetForge = TinkieRhythmPacketForge()
    private let packetSeal = TinkieRhythmPacketSeal()
    private let packetTrace = TinkieRhythmPacketTrace()
    private let packetEcho = TinkieRhythmPacketEcho()

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
        guard let rhythmURL = packetForge.tinkieRhythmURL(path: tunePath, rootscore: rootscore) else {
            finishBeat(.failure(NSError(domain: TinkieVerseCipherTrail.singBack("UHRVLg FEHrRriowrQ"), code: 400)))
            return
        }
        guard let sealedBeat = packetSeal.tinkieSealedBeat(from: rhythmPack) else { return }
        let rhythmRequest = packetForge.tinkieRhythmRequest(
            rhythmURL: rhythmURL,
            rootscore: rootscore,
            sealedRhythmBytes: sealedBeat.bytes
        )
        packetTrace.tinkieTraceSendCue(path: tunePath, link: rhythmURL.absoluteString, chordPack: rhythmPack, sealedText: sealedBeat.text)
        tinkieSendPreparedRhythmRequest(rhythmRequest, keepsPlainServerEcho: keepsPlainServerEcho, finishBeat: finishBeat)
    }

    private func tinkieSendPreparedRhythmRequest(
        _ rhythmRequest: URLRequest,
        keepsPlainServerEcho: Bool,
        finishBeat: @escaping (Result<[String: Any]?, Error>) -> Void
    ) {
        URLSession.shared.dataTask(with: rhythmRequest) { echoBytes, _, echoError in
            guard let echoBytes = self.packetEcho.tinkieEchoBytes(echoBytes, echoError: echoError, finishBeat: finishBeat) else { return }
            self.packetTrace.tinkieTraceRawEcho(echoBytes)
            self.packetEcho.tinkieUnpackServerRefrain(
                rawData: echoBytes,
                skipsSealedRefrain: keepsPlainServerEcho,
                traceDeck: self.packetTrace,
                afterBeat: finishBeat
            )
        }.resume()
    }

    static func tinkieJSONStringFromChord(from chordPack: [String: Any]) -> String? {
        guard let chordBytes = try? JSONSerialization.data(withJSONObject: chordPack) else { return nil }
        return String(data: chordBytes, encoding: .utf8)
    }
}

private final class TinkieRhythmPacketForge {
    func tinkieRhythmURL(path tunePath: String, rootscore: TinkieSongQuestRootscore) -> URL? {
        URL(string: rootscore.tinkieSongQuestBaseURL + tunePath)
    }

    func tinkieRhythmRequest(
        rhythmURL: URL,
        rootscore: TinkieSongQuestRootscore,
        sealedRhythmBytes: Data
    ) -> URLRequest {
        var rhythmRequest = URLRequest(url: rhythmURL)
        rhythmRequest.httpMethod = TinkieVerseCipherTrail.singBack("PCOSSnTF")
        rhythmRequest.httpBody = sealedRhythmBytes
        rhythmRequest.timeoutInterval = 15
        tinkieFillRhythmHeaders(&rhythmRequest, rootscore: rootscore)
        return rhythmRequest
    }

    private func tinkieFillRhythmHeaders(_ rhythmRequest: inout URLRequest, rootscore: TinkieSongQuestRootscore) {
        rhythmRequest.setValue(TinkieVerseCipherTrail.singBack("aTpzpQldircCaRtBiHoenu/AjYsyoLnb"), forHTTPHeaderField: TinkieVerseCipherTrail.singBack("CpoynOtlennNtk-iTmyopweC"))
        rhythmRequest.setValue(rootscore.tinkieSongQuestAppMark, forHTTPHeaderField: TinkieVerseCipherTrail.singBack("aTpzpQIudm"))
        rhythmRequest.setValue(Bundle.main.tinkieSongQuestBuildName, forHTTPHeaderField: TinkieVerseCipherTrail.singBack("aTpzpQVHenrRsjiqoNnd"))
        rhythmRequest.setValue(TinkieRhythmDeviceVault.tinkieDeviceMelodyTag(), forHTTPHeaderField: TinkieVerseCipherTrail.singBack("dWeovWiacleENyow"))
        rhythmRequest.setValue(Locale.current.languageCode ?? "", forHTTPHeaderField: TinkieVerseCipherTrail.singBack("leaknOgYuDaAgXem"))
        rhythmRequest.setValue(UserDefaults.standard.string(forKey: TinkieVerseCipherTrail.singBack("tmisnOkcireE.SfnoNrhellJaPrxeB.PejnJtgrvyT.NtwoIkVegnG")) ?? "", forHTTPHeaderField: TinkieVerseCipherTrail.singBack("leoygHianwTnofkseDnd"))
        rhythmRequest.setValue(UserDefaults.standard.string(forKey: TinkieVerseCipherTrail.singBack("tmisnOkcireE.SfnoNrhellJaPrxeB.PpuuQsfhl.wrdilbvbMoqnG")) ?? "", forHTTPHeaderField: TinkieVerseCipherTrail.singBack("piuEsThZTWoOkbemnM"))
    }
}

private final class TinkieRhythmPacketSeal {
    func tinkieSealedBeat(from rhythmPack: [String: Any]) -> TinkieRhythmSealedBeat? {
        guard
            let rhythmJSON = TinkieRhythmPacketRelay.tinkieJSONStringFromChord(from: rhythmPack),
            let melodyWeaver = TinkieMelodyCipherWeaver(),
            let sealedRhythmText = melodyWeaver.tinkieWeaveMelody(rhythmJSON),
            let sealedRhythmBytes = sealedRhythmText.data(using: .utf8)
        else { return nil }
        return TinkieRhythmSealedBeat(text: sealedRhythmText, bytes: sealedRhythmBytes)
    }
}

private struct TinkieRhythmSealedBeat {
    let text: String
    let bytes: Data
}

private final class TinkieRhythmPacketEcho {
    func tinkieEchoBytes(
        _ echoBytes: Data?,
        echoError: Error?,
        finishBeat: @escaping (Result<[String: Any]?, Error>) -> Void
    ) -> Data? {
        if let echoError {
            TinkieRhythmPacketTrace().tinkieTraceErrorCue(echoError)
            DispatchQueue.main.async { finishBeat(.failure(echoError)) }
            return nil
        }
        guard let echoBytes else {
            DispatchQueue.main.async {
                finishBeat(.failure(NSError(domain: TinkieVerseCipherTrail.singBack("NAoy oDpajtTaR"), code: 1000)))
            }
            return nil
        }
        return echoBytes
    }

    func tinkieUnpackServerRefrain(
        rawData serverEchoBytes: Data,
        skipsSealedRefrain keepsPlainServerEcho: Bool,
        traceDeck packetTrace: TinkieRhythmPacketTrace,
        afterBeat finishBeat: @escaping (Result<[String: Any]?, Error>) -> Void
    ) {
        do {
            let serverChord = try tinkieServerChord(from: serverEchoBytes)
            packetTrace.tinkieTraceOpenEcho(serverChord)
            if keepsPlainServerEcho {
                tinkieFinishPlainServerEcho(serverChord, finishBeat: finishBeat)
                return
            }
            let sealedRefrain = try tinkieSealedRefrain(from: serverChord)
            let refrainPack = try tinkieOpenRefrainPack(sealedRefrain)
            packetTrace.tinkieTraceDecodedEcho(refrainPack)
            DispatchQueue.main.async { finishBeat(.success(refrainPack)) }
        } catch {
            packetTrace.tinkieTraceErrorCue(error)
            DispatchQueue.main.async { finishBeat(.failure(error)) }
        }
    }

    private func tinkieServerChord(from serverEchoBytes: Data) throws -> [String: Any] {
        guard let serverChord = try JSONSerialization.jsonObject(with: serverEchoBytes) as? [String: Any] else {
            throw NSError(domain: TinkieVerseCipherTrail.singBack("IvnxvWaSluiIdU VJcSCOPNf"), code: 1001)
        }
        return serverChord
    }

    private func tinkieFinishPlainServerEcho(
        _ serverChord: [String: Any],
        finishBeat: @escaping (Result<[String: Any]?, Error>) -> Void
    ) {
        guard tinkieServerCodeSings(serverChord) else {
            DispatchQueue.main.async {
                finishBeat(.failure(NSError(domain: TinkieVerseCipherTrail.singBack("GteomN FtCuUneem meUryrPodrx"), code: 1001)))
            }
            return
        }
        DispatchQueue.main.async { finishBeat(.success([:])) }
    }

    private func tinkieSealedRefrain(from serverChord: [String: Any]) throws -> String {
        guard
            tinkieServerCodeSings(serverChord),
            let sealedRefrain = serverChord[TinkieVerseCipherTrail.singBack("rkeosTumlutT")] as? String
        else {
            throw NSError(
                domain: serverChord[TinkieVerseCipherTrail.singBack("mfeosTskajgGeV")] as? String ?? TinkieVerseCipherTrail.singBack("DqaktUaS WBVaRckkJ DEFrPrgourO"),
                code: 1002
            )
        }
        return sealedRefrain
    }

    private func tinkieOpenRefrainPack(_ sealedRefrain: String) throws -> [String: Any] {
        guard
            let melodyWeaver = TinkieMelodyCipherWeaver(),
            let refrainText = melodyWeaver.tinkieUnweaveMelody(hexTune: sealedRefrain),
            let refrainBytes = refrainText.data(using: .utf8),
            let refrainPack = try JSONSerialization.jsonObject(with: refrainBytes) as? [String: Any]
        else {
            throw NSError(domain: TinkieVerseCipherTrail.singBack("DqeocDrjyHpPtkiqoNnd UEWrgrxoLrf"), code: 1003)
        }
        return refrainPack
    }

    private func tinkieServerCodeSings(_ serverChord: [String: Any]) -> Bool {
        guard let serverCode = serverChord[TinkieVerseCipherTrail.singBack("cVoydEeW")] as? String else { return false }
        return serverCode == TinkieVerseCipherTrail.singBack("0W0n0E0V")
    }
}

private final class TinkieRhythmPacketTrace {
    func tinkieTraceSendCue(path tunePath: String, link tuneLink: String, chordPack: [String: Any], sealedText: String) {
        print(TinkieVerseCipherTrail.singBack("[xTqiznpkvinerFmoyrtexlqazrpev]n rrmeyqtuxeqsztp vpnartmhy:t"), tunePath)
        print(TinkieVerseCipherTrail.singBack("[xTqiznpkvinerFmoyrtexlqazrpev]n rrmeyqtuxeqsztp vunrrlm:y"), tuneLink)
        print(TinkieVerseCipherTrail.singBack("[xTqiznpkvinerFmoyrtexlqazrpev]n rrmeyqtuxeqsztp vpnarrmaymtsx:q"), chordPack)
        print(TinkieVerseCipherTrail.singBack("[xTqiznpkvinerFmoyrtexlqazrpev]n rrmeyqtuxeqsztp vsneramlyetdx:q"), sealedText)
    }

    func tinkieTraceRawEcho(_ echoBytes: Data) {
        let rawEchoText = String(data: echoBytes, encoding: .utf8) ?? TinkieVerseCipherTrail.singBack("<xnqoznp-vuntrfm8y>t")
        print(TinkieVerseCipherTrail.singBack("[xTqiznpkvinerFmoyrtexlqazrpev]n rrmeyttuxrqnz prvanwr:m"), rawEchoText)
    }

    func tinkieTraceOpenEcho(_ echoPack: [String: Any]) {
        print(TinkieVerseCipherTrail.singBack("[xTqiznpkvinerFmoyrtexlqazrpev]n rrmeyttuxrqnz pevnnvremlyotpxeq:z"), echoPack)
    }

    func tinkieTraceDecodedEcho(_ echoPack: [String: Any]) {
        print(TinkieVerseCipherTrail.singBack("[xTqiznpkvinerFmoyrtexlqazrpev]n rrmeyttuxrqnz pdvencromdyetdx:q"), echoPack)
    }

    func tinkieTraceErrorCue(_ tuneError: Error) {
        print(TinkieVerseCipherTrail.singBack("[xTqiznpkvinerFmoyrtexlqazrpev]n remryrtoxrq:z"), tuneError.localizedDescription)
    }
}

private extension Bundle {
    var tinkieSongQuestBuildName: String {
        object(forInfoDictionaryKey: TinkieVerseCipherTrail.singBack("CpFJBWumnwdDlcemSlhXovrPtiVVeBrfsxiEobnrShtfruiCnYgi")) as? String ?? ""
    }
}
