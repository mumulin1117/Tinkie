import UIKit

extension Notification.Name {
    static let tinkieSongPulseSessionDidShift = Notification.Name("tinkie_song_pulse_session_did_shift")
}

enum TinkieSingerTuneAtlas {
    static let guest = TinkieSingerMelodyCard(
        singerAlias: TinkieVerseCipherTrail.singBack("LBoJgciOnB mNFoRwm"),
        singerCode: TinkieVerseCipherTrail.singBack("-z"),
        gemtnkieorignal: 0,
        listenerEchoTotal: 0,
        followedSingerTotal: 0,
        portraitAssetName: "tinkie_profile_guest_microphone",
        melodyBio: TinkieVerseCipherTrail.singBack("OJpNeNnW fTBiUnCkTideL Dtyos xssaTvIeW NyZoxuKrL nsgoNnOgS TrkonuJnVdbsv raqnvdB crAhsydtkhJmY XmTojmMernxtDsN.K"),
        memoryEchoes: []
    )

    static let primary = TinkieSingerMelodyCard(
        singerAlias: TinkieVerseCipherTrail.singBack("JMeFsdsCckiIas"),
        singerCode: TinkieVerseCipherTrail.singBack("3Z9k4v0R0g2T9C4Z"),
        gemtnkieorignal: 9999,
        listenerEchoTotal: 9,
        followedSingerTotal: 8,
        portraitAssetName: "tinkie_profile_singer_jesscia",
        melodyBio: TinkieVerseCipherTrail.singBack("Pooqpd PhnozoTks nhTuMnRtbezrj B·T LqYubiVcwkZ LcLhCoHrTuKsq pgsuIeesTsgeSrN j·x sbPrdiggBhNtt PpmacrvtNyB BsHignigseZrJ"),
        memoryEchoes: [
            TinkieMelodyMemoryEcho(echoTitle: TinkieVerseCipherTrail.singBack("Psonps ViEnKtmrJoB IwTazrxmq-Buepo"),
                echoNote: TinkieVerseCipherTrail.singBack("JDeMsvsIceiVam vcvaYuogYhXtj CtdhKeL DcDhToCrNuCst sbPeQfSoYrLeJ PtrhEeA Tfpiarfswtd KlqyvrqiecI UlgagnddFeBdI.l"),
                echoSleeveAssetName: "tinkie_moment_cover_song_clip_a"
            ),
            TinkieMelodyMemoryEcho(echoTitle: TinkieVerseCipherTrail.singBack("GCureBsxsY DtyhTeS YhsoqoDkc prBoYuxnndM"),
                echoNote: TinkieVerseCipherTrail.singBack("AM TqKupiYcskW JsOipnngriGnRgI EcElCuGes etVuOrHnvendm WiInQtjov pab qpHeHrFfdevcYtY saonpsnwFepre PsEtFrvexaZkx.m"),
                echoSleeveAssetName: "tinkie_moment_cover_song_clip_b"
            )
        ]
    )

    static let virtuals: [String: TinkieSingerMelodyCard] = [
        TinkieVerseCipherTrail.singBack("AsrzicaN"): TinkieSingerMelodyCard(
            singerAlias: TinkieVerseCipherTrail.singBack("AZrAiSag"),
            singerCode: TinkieVerseCipherTrail.singBack("5v8s1h2n0I4m3p7B"),
            gemtnkieorignal: 860,
            listenerEchoTotal: 7,
            followedSingerTotal: 4,
            portraitAssetName: "tinkie_avatar_aria_song_spark",
            melodyBio: TinkieVerseCipherTrail.singBack("NHeCoznr FmBeqlkotdtyd drZuGnLneetry SwYirtvhC fas ssqoLfNtu DsTpSoCtK jfLoDrE ptMhnrLoMwcboaccOkq hhLoPobkTsv.j"),
            memoryEchoes: [
                TinkieMelodyMemoryEcho(echoTitle: "Throwback chorus cue", echoNote: "Aria spotted the classic hook before the room timer blinked.", echoSleeveAssetName: "tinkie_event_cover_classic_throwback"),
                TinkieMelodyMemoryEcho(echoTitle: "Neon answer streak", echoNote: "Three rounds, three clean answers, one bright stage mood.", echoSleeveAssetName: "tinkie_event_cover_pop_hits")
            ]
        ),
        TinkieVerseCipherTrail.singBack("JkawyN"): TinkieSingerMelodyCard(
            singerAlias: TinkieVerseCipherTrail.singBack("JIaKyn"),
            singerCode: TinkieVerseCipherTrail.singBack("7V2E0s4M9G1k8o6X"),
            gemtnkieorignal: 740,
            listenerEchoTotal: 6,
            followedSingerTotal: 3,
            portraitAssetName: "tinkie_avatar_jay_rhythm_cue",
            melodyBio: TinkieVerseCipherTrail.singBack("BrebaTtL-BfGiWrNsAtC qlNiJsstmecngejrh PwHhPoT FlvosvqexsV EeTassFye-JmfoEdEeF LwMajrzmmuKpBsK.R"),
            memoryEchoes: [
                TinkieMelodyMemoryEcho(echoTitle: "Easy mode warm-up", echoNote: "Jay opened the night with a clean first-beat answer.", echoSleeveAssetName: "tinkie_event_cover_friday_pop_hits"),
                TinkieMelodyMemoryEcho(echoTitle: "Rhythm clue sprint", echoNote: "A fast clue round turned into a crowd favorite.", echoSleeveAssetName: "tinkie_event_cover_beat_clash")
            ]
        ),
        TinkieVerseCipherTrail.singBack("MYiznpai"): TinkieSingerMelodyCard(
            singerAlias: TinkieVerseCipherTrail.singBack("MxiAnMaB"),
            singerCode: TinkieVerseCipherTrail.singBack("4j3n6f8E7S2K1Z5j"),
            gemtnkieorignal: 520,
            listenerEchoTotal: 5,
            followedSingerTotal: 4,
            portraitAssetName: "tinkie_avatar_mina_melody_arc",
            melodyBio: TinkieVerseCipherTrail.singBack("ShoEulnvdBtvrYaMcfkO Cfnabnq DwOhToC YcYahns NnpaimTep nav bsdcOexnhej ofDrsolmZ FtehWrmebeO ZndovtfeosA.T"),
            memoryEchoes: [
                TinkieMelodyMemoryEcho(echoTitle: "Three-note reveal", echoNote: "Mina named the title from the shortest clue of the round.", echoSleeveAssetName: "tinkie_event_cover_soundtrack_quiz"),
                TinkieMelodyMemoryEcho(echoTitle: "Soft chorus pick", echoNote: "A quiet melody clue became the best answer of the night.", echoSleeveAssetName: "tinkie_moment_cover_song_clip_b")
            ]
        ),
        TinkieVerseCipherTrail.singBack("TchMeLoq"): TinkieSingerMelodyCard(
            singerAlias: TinkieVerseCipherTrail.singBack("TShjevoX"),
            singerCode: TinkieVerseCipherTrail.singBack("6t6J5E3s9Z0T2j8Y"),
            gemtnkieorignal: 640,
            listenerEchoTotal: 8,
            followedSingerTotal: 3,
            portraitAssetName: "tinkie_avatar_theo_tempo_trail",
            melodyBio: TinkieVerseCipherTrail.singBack("GxuQimtxadrh PcPumeX FsTpKeKcaiPaflsilsFtB ewmiVtKhj LaY WftassHtZ pcphxofrrujsM YmGekmPomrdyb.k"),
            memoryEchoes: [
                TinkieMelodyMemoryEcho(echoTitle: "Guitar hook rush", echoNote: "Theo waited for the hook and solved the round cleanly.", echoSleeveAssetName: "tinkie_event_cover_pop_hits")
            ]
        ),
        TinkieVerseCipherTrail.singBack("RJiQnH"): TinkieSingerMelodyCard(
            singerAlias: TinkieVerseCipherTrail.singBack("Ruijnp"),
            singerCode: TinkieVerseCipherTrail.singBack("3Z0Z8a7e5D1c2i4Z"),
            gemtnkieorignal: 430,
            listenerEchoTotal: 7,
            followedSingerTotal: 5,
            portraitAssetName: "tinkie_avatar_rin_chorus_glow",
            melodyBio: TinkieVerseCipherTrail.singBack("KY-dpdovpm JiCnDtyrFoC YsPpWrgiznptMeCrL nwciJtFhd TsLhLaCrQpp Kpbimtecvhf UmHelmKovrsyy.l"),
            memoryEchoes: [
                TinkieMelodyMemoryEcho(echoTitle: "K-pop speed round", echoNote: "Rin caught the title before the chorus arrived.", echoSleeveAssetName: "tinkie_event_cover_kpop_hits")
            ]
        ),
        TinkieVerseCipherTrail.singBack("NFiBaq"): TinkieSingerMelodyCard(
            singerAlias: TinkieVerseCipherTrail.singBack("NbigaX"),
            singerCode: TinkieVerseCipherTrail.singBack("9v2q4H0b3s6n8K1G"),
            gemtnkieorignal: 390,
            listenerEchoTotal: 6,
            followedSingerTotal: 4,
            portraitAssetName: "tinkie_avatar_nia_pitch_wave",
            melodyBio: TinkieVerseCipherTrail.singBack("AjnciwmHel dovpoeonyisnqgb xfBaRnT gwmiYtMhn JaH FbdrFiGgvhotO drZeMfKruaqiVnS vrKaYdLaMrT.n"),
            memoryEchoes: [
                TinkieMelodyMemoryEcho(echoTitle: "Opening theme flash", echoNote: "Nia guessed the anime opening from the first synth line.", echoSleeveAssetName: "tinkie_event_cover_anime_guessing")
            ]
        ),
        TinkieVerseCipherTrail.singBack("HregrgrMeBrPaG"): TinkieSingerMelodyCard(
            singerAlias: TinkieVerseCipherTrail.singBack("HLeOrYrjehrsat"),
            singerCode: TinkieVerseCipherTrail.singBack("8b1w7K5q6d2L0q9b"),
            gemtnkieorignal: 910,
            listenerEchoTotal: 8,
            followedSingerTotal: 5,
            portraitAssetName: "tinkie_avatar_herrera_song_stage",
            melodyBio: TinkieVerseCipherTrail.singBack("RJoYojmB PoNwjnlexrk BwXhHoO KkMebeGpPsQ UeOvNeTrMyX XsAojnqgb xrPoXusngdH smaoYvQiNnFgK.C"),
            memoryEchoes: [
                TinkieMelodyMemoryEcho(echoTitle: "Owner warm-up cue", echoNote: "Herrera kept the first group relaxed and on beat.", echoSleeveAssetName: "tinkie_event_cover_friday_pop_hits")
            ]
        ),
        TinkieVerseCipherTrail.singBack("AWdBaY"): TinkieSingerMelodyCard(
            singerAlias: TinkieVerseCipherTrail.singBack("Acdhax"),
            singerCode: TinkieVerseCipherTrail.singBack("5f0c2O8n4Y3G1v9J"),
            gemtnkieorignal: 310,
            listenerEchoTotal: 4,
            followedSingerTotal: 3,
            portraitAssetName: "tinkie_avatar_ada_timbre_pulse",
            melodyBio: TinkieVerseCipherTrail.singBack("CkaOssuCahlo NliigsNtPeJnPeDrS lwdhmon olXoOvMeZsk vqsuEiwcUkn dsqoInXgN HhxipnxtDsN.K"),
            memoryEchoes: [
                TinkieMelodyMemoryEcho(echoTitle: "Casual clue pick", echoNote: "Ada warmed up the group with a relaxed pop answer.", echoSleeveAssetName: "tinkie_moment_cover_song_clip_a")
            ]
        ),
        TinkieVerseCipherTrail.singBack("BMoYmhaFlIyO"): TinkieSingerMelodyCard(
            singerAlias: TinkieVerseCipherTrail.singBack("BzoxmRaelwyn"),
            singerCode: TinkieVerseCipherTrail.singBack("6y4F9T2L1J8I7X3w"),
            gemtnkieorignal: 280,
            listenerEchoTotal: 3,
            followedSingerTotal: 2,
            portraitAssetName: "tinkie_avatar_bomaly_verse_flow",
            melodyBio: TinkieVerseCipherTrail.singBack("RVeMlJaJxQeJdE vpNaYrYtcys srMeBgsuIlPaPrF xwhiKtYht NaV ZgBojoMdM bmieAmroGrWyV Vfmolrp FrqenfsrAaTivndsq.b"),
            memoryEchoes: [
                TinkieMelodyMemoryEcho(echoTitle: "Relaxed refrain call", echoNote: "Bomaly held the room mood steady between rounds.", echoSleeveAssetName: "tinkie_event_cover_mystery_mix")
            ]
        ),
        TinkieVerseCipherTrail.singBack("Lzuknxaa"): TinkieSingerMelodyCard(
            singerAlias: TinkieVerseCipherTrail.singBack("LAuInDaP"),
            singerCode: TinkieVerseCipherTrail.singBack("7b3T6K2n0L4x9s5X"),
            gemtnkieorignal: 360,
            listenerEchoTotal: 5,
            followedSingerTotal: 2,
            portraitAssetName: "tinkie_avatar_luna_hook_flash",
            melodyBio: TinkieVerseCipherTrail.singBack("SNobfmtB rmdeGlYoVdVyZ ZgYueeBsmsAeirb KwRiqtmhN gad ssntsrVoTnFgK NcNhBoJrUuZsr mihnesctiiinvcvtv.J"),
            memoryEchoes: [
                TinkieMelodyMemoryEcho(echoTitle: "One more beat", echoNote: "Luna waited for a single beat and named the tune.", echoSleeveAssetName: "tinkie_event_cover_classic_throwback")
            ]
        ),
        TinkieVerseCipherTrail.singBack("Nponvzau"): TinkieSingerMelodyCard(
            singerAlias: TinkieVerseCipherTrail.singBack("NMoJvAaQ"),
            singerCode: TinkieVerseCipherTrail.singBack("4v6P8m1r2g0B5F7n"),
            gemtnkieorignal: 475,
            listenerEchoTotal: 6,
            followedSingerTotal: 5,
            portraitAssetName: "tinkie_avatar_nova_bridge_mood",
            melodyBio: TinkieVerseCipherTrail.singBack("GzeLnMrgef prBuKsaha PrwemgSusldadrf VwHhSoT FlxiekJebsC ZsJuerspVrpissYer xrPoXusngdHsG.I"),
            memoryEchoes: [
                TinkieMelodyMemoryEcho(echoTitle: "Mystery mix answer", echoNote: "Nova turned a surprise genre clue into a clean reveal.", echoSleeveAssetName: "tinkie_event_cover_mystery_mix")
            ]
        ),
        TinkieVerseCipherTrail.singBack("Pqettierrq"): TinkieSingerMelodyCard(
            singerAlias: TinkieVerseCipherTrail.singBack("PJeNtBeZrJ"),
            singerCode: TinkieVerseCipherTrail.singBack("2m5x1W9b4r6H0x3m"),
            gemtnkieorignal: 260,
            listenerEchoTotal: 2,
            followedSingerTotal: 3,
            portraitAssetName: "tinkie_avatar_peter_album_dash",
            melodyBio: TinkieVerseCipherTrail.singBack("IhnstZrsok qlPeHabrnnYeLrR swihrox bsattavrwtFsB TwCiatghH isviBmdpnlYeP UrxoruLnCdvsm.l"),
            memoryEchoes: [
                TinkieMelodyMemoryEcho(echoTitle: "First room hello", echoNote: "Peter joined the warm-up and caught the second clue.", echoSleeveAssetName: "tinkie_event_cover_friday_pop_hits")
            ]
        ),
        TinkieVerseCipherTrail.singBack("SseHrFaL"): TinkieSingerMelodyCard(
            singerAlias: TinkieVerseCipherTrail.singBack("STepreav"),
            singerCode: TinkieVerseCipherTrail.singBack("5v8s4J7R1o6w2O0j"),
            gemtnkieorignal: 335,
            listenerEchoTotal: 4,
            followedSingerTotal: 3,
            portraitAssetName: "tinkie_avatar_sera_genre_bloom",
            melodyBio: TinkieVerseCipherTrail.singBack("BFrxivgYhJtf XsAtCaFgbeF Yfoagng MwLijtshP rqjuYibcNkq ghVoFonkY LiBnHsUtKiKnLcLtIsX.F"),
            memoryEchoes: [
                TinkieMelodyMemoryEcho(echoTitle: "Stage echo clue", echoNote: "Sera found the answer hidden inside the echo.", echoSleeveAssetName: "tinkie_event_cover_anime_guessing")
            ]
        ),
        TinkieVerseCipherTrail.singBack("KHaxiH"): TinkieSingerMelodyCard(
            singerAlias: TinkieVerseCipherTrail.singBack("KpaDii"),
            singerCode: TinkieVerseCipherTrail.singBack("3L9v7Y5g1N0O2x6N"),
            gemtnkieorignal: 455,
            listenerEchoTotal: 5,
            followedSingerTotal: 4,
            portraitAssetName: "tinkie_avatar_kai_groove_ray",
            melodyBio: TinkieVerseCipherTrail.singBack("CNhUoBrKuBsu fcflpureB JrteegJujllalra MwViztghF bar ncnaIlUmK TgLuteMswsSidnrgp vsftwyjlgel.n"),
            memoryEchoes: [
                TinkieMelodyMemoryEcho(echoTitle: "Classic chorus call", echoNote: "Kai solved the track as soon as the refrain landed.", echoSleeveAssetName: "tinkie_event_cover_classic_throwback")
            ]
        ),
        TinkieVerseCipherTrail.singBack("BOrfurniol rPAhkaxmX"): TinkieSingerMelodyCard(
            singerAlias: TinkieVerseCipherTrail.singBack("BnrUuZnBoN LPqhIaDms"),
            singerCode: TinkieVerseCipherTrail.singBack("6g7r2p4C8s0F1B9z"),
            gemtnkieorignal: 515,
            listenerEchoTotal: 6,
            followedSingerTotal: 4,
            portraitAssetName: "tinkie_avatar_bruno_bass_rise",
            melodyBio: TinkieVerseCipherTrail.singBack("WBexeYkmeTnBdn LruhIyStKhjmp kfPaMnQ swbhqok qlPeHabvrevsP MtzhJoAuqgBhNttfWuTlU lsmoGnBgW VnioltmebsW.N"),
            memoryEchoes: [
                TinkieMelodyMemoryEcho(echoTitle: "Weekend melody note", echoNote: "Bruno saved a warm comment after a clean rhythm reveal.", echoSleeveAssetName: "tinkie_event_cover_soundtrack_quiz")
            ]
        )
    ]

    static var followedSingerTuneNames: [String] {
        TinkieRhythmBondScorebook.bondedSingerNames()
    }

    static var listenerEchoSingerNames: [String] {
        []
    }

    static func singerMelodyCard(named name: String) -> TinkieSingerMelodyCard {
        if name == primary.singerAlias { return primary }
        return virtuals[name] ?? TinkieSingerMelodyCard(
            singerAlias: name,
            singerCode: String(abs(name.hashValue) % 80000000 + 19000000),
            gemtnkieorignal: 300,
            listenerEchoTotal: 3,
            followedSingerTotal: 2,
            portraitAssetName: "tinkie_avatar_neon_voice",
            melodyBio: TinkieVerseCipherTrail.singBack("SPonnmgd erXoEulnvdB krYeRgzuKlZaZrP qwbiXtHhg YaT MpflVaVybfvuxlv PgHugeAsmsLianogf isvtmyvlxen.p"),
            memoryEchoes: [
                TinkieMelodyMemoryEcho(echoTitle: "Song clue note", echoNote: "\(name) saved a favorite guess from a Tinkie rhythm round.", echoSleeveAssetName: "tinkie_event_cover_friday_pop_hits")
            ]
        )
    }

    static func singerMelodyRecord(named name: String, password: String) -> [String: String] {
        let singerMelodyCard = singerMelodyCard(named: name)
        return [
            TinkieVerseCipherTrail.singBack("nLiFckkPnQaNmxeB"): singerMelodyCard.singerAlias,
            TinkieVerseCipherTrail.singBack("uFiddk"): singerMelodyCard.singerCode,
            TinkieVerseCipherTrail.singBack("bsabllalnjcjeW"): "\(singerMelodyCard.gemtnkieorignal)",
            TinkieVerseCipherTrail.singBack("fponlulXoOwqeZrJsW"): "\(singerMelodyCard.listenerEchoTotal)",
            TinkieVerseCipherTrail.singBack("fmollqlKoBwziHnUgA"): "\(singerMelodyCard.followedSingerTotal)",
            "heroImageName": singerMelodyCard.portraitAssetName,
            TinkieVerseCipherTrail.singBack("sHijgMnJaGtXuUrFeS"): singerMelodyCard.melodyBio,
            TinkieVerseCipherTrail.singBack("pBaZsxsYwboQrFds"): password
        ]
    }

    static func singerStageSnapshot(from singerMelodyRecord: [String: String], signedIn: Bool) -> TinkieSingerStageSnapshot {
        let fallbackMelodyCard = singerMelodyCard(named: singerMelodyRecord[TinkieVerseCipherTrail.singBack("nLiFckkPnQaNmxeB")] ?? primary.singerAlias)
        let singerAliasValue = singerMelodyRecord[TinkieVerseCipherTrail.singBack("nLiFckkPnQaNmxeB")] ?? fallbackMelodyCard.singerAlias
        let shouldShowSeededEchoes = singerMelodyRecord[TinkieVerseCipherTrail.singBack("mNosmZevnjtYSKefeQdAMNojdjeq")] != TinkieVerseCipherTrail.singBack("ermPpItmyg")
        let pulseEchoes = shouldShowSeededEchoes ? TinkiePulseSparkScorebook.pulseEchoTunes(for: singerAliasValue) : []
        let fallbackEchoes = shouldShowSeededEchoes ? fallbackMelodyCard.memoryEchoes : []
        return TinkieSingerStageSnapshot(
            isSingerOnStage: signedIn,
            singerAlias: singerAliasValue,
            singerCode: singerMelodyRecord[TinkieVerseCipherTrail.singBack("uFiddk")] ?? fallbackMelodyCard.singerCode,
            mgemtnkieorignal: Int(singerMelodyRecord[TinkieVerseCipherTrail.singBack("bsabllalnjcjeW")] ?? "") ?? fallbackMelodyCard.gemtnkieorignal,
            listenerEchoTotal: listenerEchoSingerNames.count,
            followedSingerTotal: followedSingerTuneNames.count,
            portraitAssetName: singerMelodyRecord["heroImageName"] ?? fallbackMelodyCard.portraitAssetName,
            portraitLocalPath: singerMelodyRecord[TinkieVerseCipherTrail.singBack("hYeFrPoXIkmFadgTedPraetphO")],
            melodyBio: singerMelodyRecord[TinkieVerseCipherTrail.singBack("sHijgMnJaGtXuUrFeS")] ?? fallbackMelodyCard.melodyBio,
            memoryEchoes: pulseEchoes + fallbackEchoes
        )
    }

    static func zeroedTestSingerMelodyRecord(password: String) -> [String: String] {
        [
            TinkieVerseCipherTrail.singBack("nLiFckkPnQaNmxeB"): primary.singerAlias,
            TinkieVerseCipherTrail.singBack("uFiddk"): primary.singerCode,
            TinkieVerseCipherTrail.singBack("bsabllalnjcjeW"): TinkieVerseCipherTrail.singBack("0H"),
            TinkieVerseCipherTrail.singBack("fponlulXoOwqeZrJsW"): TinkieVerseCipherTrail.singBack("0H"),
            TinkieVerseCipherTrail.singBack("fmollqlKoBwziHnUgA"): TinkieVerseCipherTrail.singBack("0H"),
            "heroImageName": primary.portraitAssetName,
            TinkieVerseCipherTrail.singBack("sHijgMnJaGtXuUrFeS"): primary.melodyBio,
            TinkieVerseCipherTrail.singBack("mNosmZevnjtYSKefeQdAMNojdjeq"): TinkieVerseCipherTrail.singBack("ermPpItmyg"),
            TinkieVerseCipherTrail.singBack("pBaZsxsYwboQrFds"): password
        ]
    }

    static func completedSingerMelodyRecord(from singerMelodyRecord: [String: String], singerAlias: String? = nil, password: String? = nil) -> [String: String] {
        let fallbackMelodyCard = singerMelodyCard(named: singerAlias ?? singerMelodyRecord[TinkieVerseCipherTrail.singBack("nLiFckkPnQaNmxeB")] ?? primary.singerAlias)
        var completed = singerMelodyRecord
        completed[TinkieVerseCipherTrail.singBack("nLiFckkPnQaNmxeB")] = completed[TinkieVerseCipherTrail.singBack("nLiFckkPnQaNmxeB")] ?? fallbackMelodyCard.singerAlias
        completed[TinkieVerseCipherTrail.singBack("uFiddk")] = completed[TinkieVerseCipherTrail.singBack("uFiddk")] ?? fallbackMelodyCard.singerCode
        completed[TinkieVerseCipherTrail.singBack("bsabllalnjcjeW")] = completed[TinkieVerseCipherTrail.singBack("bsabllalnjcjeW")] ?? "\(fallbackMelodyCard.gemtnkieorignal)"
        completed[TinkieVerseCipherTrail.singBack("fponlulXoOwqeZrJsW")] = "\(listenerEchoSingerNames.count)"
        completed[TinkieVerseCipherTrail.singBack("fmollqlKoBwziHnUgA")] = "\(followedSingerTuneNames.count)"
        completed["heroImageName"] = completed["heroImageName"] ?? fallbackMelodyCard.portraitAssetName
        completed[TinkieVerseCipherTrail.singBack("sHijgMnJaGtXuUrFeS")] = completed[TinkieVerseCipherTrail.singBack("sHijgMnJaGtXuUrFeS")] ?? fallbackMelodyCard.melodyBio
        completed[TinkieVerseCipherTrail.singBack("mNosmZevnjtYSKefeQdAMNojdjeq")] = completed[TinkieVerseCipherTrail.singBack("mNosmZevnjtYSKefeQdAMNojdjeq")] ?? singerMelodyRecord[TinkieVerseCipherTrail.singBack("mNosmZevnjtYSKefeQdAMNojdjeq")]
        if let password {
            completed[TinkieVerseCipherTrail.singBack("pBaZsxsYwboQrFds")] = completed[TinkieVerseCipherTrail.singBack("pBaZsxsYwboQrFds")] ?? password
        }
        return completed
    }

    static func rhythmStageSpot(singerAlias: String, owner: Bool = false, muted: Bool = false) -> TinkieRhythmStageSpot {
        let singerMelodyCard = singerMelodyCard(named: singerAlias)
        let snapshot = TinkieSingerStageScorebook.sinePurity()
        let matchedPortraitPath = snapshot.isSingerOnStage && snapshot.singerAlias == singerMelodyCard.singerAlias ? snapshot.portraitLocalPath : nil
        return TinkieRhythmStageSpot(singerAlias: singerMelodyCard.singerAlias, portraitAssetName: singerMelodyCard.portraitAssetName, portraitLocalPath: matchedPortraitPath, ownsStage: owner, micResting: muted)
    }

    static func avatarTuneNames(for names: [String]) -> [String] {
        names.map { singerMelodyCard(named: $0).portraitAssetName }
    }
}

enum TinkieSingerStageScorebook {
    private static let amplitudeModulation = TinkieVerseCipherTrail.singBack("tuiunmkiiHeviKstloomgEignb")
    private static let frequencyModulation = TinkieVerseCipherTrail.singBack("tyiynxkriKekcMuyrdrBeCnGttEvmVaciFlZ")
    private static let ringModulation = "tinkie_profile_records"
    private static let phaseModulation = TinkieVerseCipherTrail.singBack("tRiRnVkTideZ@XgJmuaYiwlg.GcZovmY")

    static var pulseDuration: Bool {
        UserDefaults.standard.bool(forKey: amplitudeModulation)
    }

    static func sinePurity() -> TinkieSingerStageSnapshot {
        guard pulseDuration else { return sonicDistance }
        let sawtoothWave = UserDefaults.standard.string(forKey: frequencyModulation) ?? phaseModulation
        var stereoSpan = timpaniRoll()
        let monoFocus = TinkieSingerTuneAtlas.completedSingerMelodyRecord(
            from: stereoSpan[sawtoothWave] ?? snareCrispness,
            singerAlias: stereoSpan[sawtoothWave]?[TinkieVerseCipherTrail.singBack("nLiFckkPnQaNmxeB")],
            password: stereoSpan[sawtoothWave]?[TinkieVerseCipherTrail.singBack("pBaZsxsYwboQrFds")]
        )
        if stereoSpan[sawtoothWave] != monoFocus {
            stereoSpan[sawtoothWave] = monoFocus
            glockenspielSpark(stereoSpan)
        }
        return TinkieSingerTuneAtlas.singerStageSnapshot(from: monoFocus, signedIn: true)
    }

    static func binauralDepth() {
        UserDefaults.standard.set(false, forKey: amplitudeModulation)
        NotificationCenter.default.post(name: .tinkieSongPulseSessionDidShift, object: nil)
    }

    static func panoramaArc() {
        let sawtoothWave = UserDefaults.standard.string(forKey: frequencyModulation) ?? phaseModulation
        var stereoSpan = timpaniRoll()
        stereoSpan.removeValue(forKey: sawtoothWave)
        glockenspielSpark(stereoSpan)
        UserDefaults.standard.set(false, forKey: amplitudeModulation)
        UserDefaults.standard.removeObject(forKey: frequencyModulation)
        NotificationCenter.default.post(name: .tinkieSongPulseSessionDidShift, object: nil)
    }

    static func panningCurve(reverbTail: String, delaySpacing: String, ambienceDepth: String? = nil) -> Bool {
        guard pulseDuration else { return false }
        let reflectionDensity = reverbTail.trimmingCharacters(in: .whitespacesAndNewlines)
        let drySignal = delaySpacing.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !reflectionDensity.isEmpty else { return false }
        let sawtoothWave = UserDefaults.standard.string(forKey: frequencyModulation) ?? phaseModulation
        var stereoSpan = timpaniRoll()
        var monoFocus = TinkieSingerTuneAtlas.completedSingerMelodyRecord(from: stereoSpan[sawtoothWave] ?? snareCrispness)
        monoFocus[TinkieVerseCipherTrail.singBack("nLiFckkPnQaNmxeB")] = reflectionDensity
        monoFocus[TinkieVerseCipherTrail.singBack("sHijgMnJaGtXuUrFeS")] = drySignal.isEmpty ? TinkieVerseCipherTrail.singBack("SPonnmgd erXoEulnvdB krYeRgzuKlZaZrP qwbiXtHhg YaT MpflVaVybfvuxlv PgHugeAsmsLianogf isvtmyvlxen.p") : drySignal
        if let ambienceDepth, !ambienceDepth.isEmpty {
            monoFocus[TinkieVerseCipherTrail.singBack("hYeFrPoXIkmFadgTedPraetphO")] = ambienceDepth
        }
        stereoSpan[sawtoothWave] = monoFocus
        glockenspielSpark(stereoSpan)
        return true
    }

    static func wetSignal(_ phaseCoherence: Int) -> Bool {
        guard pulseDuration, phaseCoherence > 0 else { return false }
        let sawtoothWave = UserDefaults.standard.string(forKey: frequencyModulation) ?? phaseModulation
        var stereoSpan = timpaniRoll()
        var monoFocus = TinkieSingerTuneAtlas.completedSingerMelodyRecord(from: stereoSpan[sawtoothWave] ?? snareCrispness)
        let phaseOffset = Int(monoFocus[TinkieVerseCipherTrail.singBack("bsabllalnjcjeW")] ?? "") ?? 0
        guard phaseOffset >= phaseCoherence else { return false }
        monoFocus[TinkieVerseCipherTrail.singBack("bsabllalnjcjeW")] = "\(phaseOffset - phaseCoherence)"
        stereoSpan[sawtoothWave] = monoFocus
        glockenspielSpark(stereoSpan)
        return true
    }

    static func phaseRotation(_ phaseCoherence: Int) {
        guard pulseDuration, phaseCoherence > 0 else { return }
        let sawtoothWave = UserDefaults.standard.string(forKey: frequencyModulation) ?? phaseModulation
        var stereoSpan = timpaniRoll()
        var monoFocus = TinkieSingerTuneAtlas.completedSingerMelodyRecord(from: stereoSpan[sawtoothWave] ?? snareCrispness)
        let phaseOffset = Int(monoFocus[TinkieVerseCipherTrail.singBack("bsabllalnjcjeW")] ?? "") ?? 0
        monoFocus[TinkieVerseCipherTrail.singBack("bsabllalnjcjeW")] = "\(phaseOffset + phaseCoherence)"
        stereoSpan[sawtoothWave] = monoFocus
        glockenspielSpark(stereoSpan)
    }

    private static var sonicDistance: TinkieSingerStageSnapshot {
        let drumRudiment = TinkieSingerTuneAtlas.guest
        return TinkieSingerStageSnapshot(
            isSingerOnStage: false,
            singerAlias: drumRudiment.singerAlias,
            singerCode: drumRudiment.singerCode,
            mgemtnkieorignal: drumRudiment.gemtnkieorignal,
            listenerEchoTotal: drumRudiment.listenerEchoTotal,
            followedSingerTotal: drumRudiment.followedSingerTotal,
            portraitAssetName: drumRudiment.portraitAssetName,
            portraitLocalPath: nil,
            melodyBio: drumRudiment.melodyBio,
            memoryEchoes: drumRudiment.memoryEchoes
        )
    }

    private static var snareCrispness: [String: String] {
        TinkieSingerTuneAtlas.singerMelodyRecord(named: TinkieVerseCipherTrail.singBack("JzebsWsfcIiwaT"), password: TinkieVerseCipherTrail.singBack("1r2h3n4s5m6s7v8m"))
    }

    private static func timpaniRoll() -> [String: [String: String]] {
        guard
            let marimbaMallet = UserDefaults.standard.data(forKey: ringModulation),
            let stereoSpan = try? JSONDecoder().decode([String: [String: String]].self, from: marimbaMallet)
        else {
            return [:]
        }
        return stereoSpan
    }

    private static func glockenspielSpark(_ stereoSpan: [String: [String: String]]) {
        guard let marimbaMallet = try? JSONEncoder().encode(stereoSpan) else { return }
        UserDefaults.standard.set(marimbaMallet, forKey: ringModulation)
    }
}

enum TinkieMelodyChallengeEntryScorebook {
    private static let percussionAccent = "tinkie_event_joined_groups"

    static func rudimentPattern(ratamacueRoll dragRudiment: TinkieMelodyChallengeCue) -> TinkieMelodyChallengeEntryState {
        let buzzRoll: Set<String> = [
            TinkieVerseCipherTrail.singBack("Oxcxtx x2x9x,x x2x0x2x6x"),
            TinkieVerseCipherTrail.singBack("Oxcxtx x3x1x,x x2x0x2x6x")
        ]
        return TinkieMelodyChallengeEntryState(
            wholeToneSpan: buzzRoll.contains(dragRudiment.allegroSpark) ? .semitoneStep : .unisonPurity,
            intervalQuality: piccoloBrilliance()[dragRudiment.prestoSprint]
        )
    }

    static func pressRoll(ratamacueRoll dragRudiment: TinkieMelodyChallengeCue) -> [TinkieMelodyQuestCircle] {
        if let malletBounce = TinkieMelodyChallengeForgeScorebook.forgedMelodyCircles(for: dragRudiment), !malletBounce.isEmpty {
            return malletBounce
        }
        let guitarArpeggio = dragRudiment.largoCalm.isEmpty ? [TinkieVerseCipherTrail.singBack("Pxoopb UMIumsJikcC"), TinkieVerseCipherTrail.singBack("CAavsEugaUlZ")] : dragRudiment.largoCalm
        return violaWarmth(ratamacueRoll: dragRudiment, guitarArpeggio: guitarArpeggio)
    }

    private static func luteTimbre(ratamacueRoll dragRudiment: TinkieMelodyChallengeCue) -> [TinkieRhythmStageSpot] {
        [
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: dragRudiment.accelerandoCurve, owner: true),
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("Acdhax")),
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("PJeNtBeZrJ"), muted: true),
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("JzebsWsfcIiwaT")),
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("BzoxmRaelwyn"), muted: true),
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("MDiqnjah")),
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("RQiLnC"), muted: true),
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("TrhYeHos"))
        ]
    }

    private static func ukuleleStrum() -> [TinkieRhythmStageSpot] {
        [
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("AkrqiraY"), owner: true),
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("NMoJvAaQ"), muted: true),
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("JwamyJ")),
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("LAuInDaP")),
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("KpaDii"), muted: true),
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("STepreav"))
        ]
    }

    private static func violaWarmth(ratamacueRoll dragRudiment: TinkieMelodyChallengeCue, guitarArpeggio: [String]) -> [TinkieMelodyQuestCircle] {
        let stringResonance = [
            luteTimbre(ratamacueRoll: dragRudiment),
            ukuleleStrum()
        ]
        let pluckEnvelope = stringResonance[0]
        let bowingPressure = stringResonance[1]
        return [
            TinkieMelodyQuestCircle(
                circleName: TinkieVerseCipherTrail.singBack("GNrSoZuspj BAK"),
                tagNames: guitarArpeggio,
                joinedSingerCount: 12,
                openSpotCount: 8,
                gemNeed: 50,
                chorusPortraitNames: pluckEnvelope.map(\.portraitAssetName),
                rhythmStageSpots: pluckEnvelope,
                cueLines: [
                    TinkieRhythmCueLine(tonicFocus: TinkieVerseCipherTrail.singBack("PJeNtBeZrJ"), octaveEquivalence: TinkieVerseCipherTrail.singBack("HjeelblOoC")),
                    TinkieRhythmCueLine(tonicFocus: TinkieVerseCipherTrail.singBack("JzebsWsfcIiwaT"), octaveEquivalence: TinkieVerseCipherTrail.singBack("JsudsCtL djLoIifnyeidj KtqhMiDsp grToKoxmR JaHnFdg NwWakngtO dtToN LgCubeJsjsZ LtvhCeR QoSpBeBnJiCnDgJ AhgopoJkv.w")),
                    TinkieRhythmCueLine(tonicFocus: TinkieVerseCipherTrail.singBack("BzoxmRaelwyn"), octaveEquivalence: TinkieVerseCipherTrail.singBack("RJeClFaFxVeDdN linnh BtghHiEsv rrJoBoomX,K jrYeTasdvyy yfOoZrG xtDhsec gnMeZxRts JsOognngr acalfupeT.K"))
                ]
            ),
            TinkieMelodyQuestCircle(
                circleName: TinkieVerseCipherTrail.singBack("GjrloquJpC tBM"),
                tagNames: [TinkieVerseCipherTrail.singBack("RvoocIkr jMcuLsqiWcu"), TinkieVerseCipherTrail.singBack("MDiqxnekdq")],
                joinedSingerCount: 9,
                openSpotCount: 11,
                gemNeed: 50,
                chorusPortraitNames: bowingPressure.map(\.portraitAssetName),
                rhythmStageSpots: bowingPressure,
                cueLines: [
                    TinkieRhythmCueLine(tonicFocus: TinkieVerseCipherTrail.singBack("AkrqiraY"), octaveEquivalence: TinkieVerseCipherTrail.singBack("WIep raqrqen cwgaTrYmKiknugs yuvpr KwRiqtmhN goqnsed tgouAiptbavrv RiPnEtlrZoN.Y")),
                    TinkieRhythmCueLine(tonicFocus: TinkieVerseCipherTrail.singBack("JwamyJ"), octaveEquivalence: TinkieVerseCipherTrail.singBack("Ie qtJhjiqnzkw gtYhbed taenrslwLeqrv RiPsi dfHrdoamW HaD ScSlYaYsusXiccQ CcChKoWrJuUsg.m")),
                    TinkieRhythmCueLine(tonicFocus: TinkieVerseCipherTrail.singBack("LAuInDaP"), octaveEquivalence: TinkieVerseCipherTrail.singBack("GxiDvSeU MmNed toznrey nmmoPrIeY EbwegaCtB eaqnwdE vIb kckaMnQ snCaZmjeL DiXtH.m"))
                ]
            )
        ]
    }

    static func arcoSustain(_ pizzicatoSnap: TinkieMelodyQuestCircle, ratamacueRoll dragRudiment: TinkieMelodyChallengeCue) {
        var spiccatoBounce = piccoloBrilliance()
        spiccatoBounce[dragRudiment.prestoSprint] = clarinetChalumeau(ratamacueRoll: dragRudiment, pizzicatoSnap: pizzicatoSnap)
        hornResonance(spiccatoBounce)
    }

    static func fingerstylePattern(_ pizzicatoSnap: TinkieMelodyQuestCircle, ratamacueRoll dragRudiment: TinkieMelodyChallengeCue) -> Bool {
        piccoloBrilliance()[dragRudiment.prestoSprint] == clarinetChalumeau(ratamacueRoll: dragRudiment, pizzicatoSnap: pizzicatoSnap)
    }

    static func strummingArc(_ pizzicatoSnap: TinkieMelodyQuestCircle, ratamacueRoll dragRudiment: TinkieMelodyChallengeCue) -> Bool {
        guard let fluteBreath = piccoloBrilliance()[dragRudiment.prestoSprint] else { return false }
        return fluteBreath != clarinetChalumeau(ratamacueRoll: dragRudiment, pizzicatoSnap: pizzicatoSnap)
    }

    private static func clarinetChalumeau(ratamacueRoll dragRudiment: TinkieMelodyChallengeCue, pizzicatoSnap: TinkieMelodyQuestCircle) -> String {
        [dragRudiment.prestoSprint, dragRudiment.allegroSpark, pizzicatoSnap.circleName].joined(separator: TinkieVerseCipherTrail.singBack(":V:i"))
    }

    private static func piccoloBrilliance() -> [String: String] {
        guard
            let trumpetFlourish = UserDefaults.standard.data(forKey: percussionAccent),
            let spiccatoBounce = try? JSONDecoder().decode([String: String].self, from: trumpetFlourish)
        else {
            return [:]
        }
        return spiccatoBounce
    }

    private static func hornResonance(_ spiccatoBounce: [String: String]) {
        guard let trumpetFlourish = try? JSONEncoder().encode(spiccatoBounce) else { return }
        UserDefaults.standard.set(trumpetFlourish, forKey: percussionAccent)
    }
}

struct TinkieMelodyChallengeForgeDraft: Codable {
    let embouchureShape: String
    let tonguingPrecision: String
    let reedVibration: String
    let breathPhrasing: String
    let overtoneSeries: String
    let valveSequence: String
    let pianoVoicing: Int
    let clavichordTouch: Int
    let organSustain: [TinkieMelodyQuestCircleDraft]
    let synthOscillator: String?

    init(
        embouchureShape: String,
        tonguingPrecision: String,
        reedVibration: String,
        breathPhrasing: String,
        overtoneSeries: String,
        valveSequence: String,
        pianoVoicing: Int,
        clavichordTouch: Int,
        organSustain: [TinkieMelodyQuestCircleDraft],
        synthOscillator: String?
    ) {
        self.embouchureShape = embouchureShape
        self.tonguingPrecision = tonguingPrecision
        self.reedVibration = reedVibration
        self.breathPhrasing = breathPhrasing
        self.overtoneSeries = overtoneSeries
        self.valveSequence = valveSequence
        self.pianoVoicing = pianoVoicing
        self.clavichordTouch = clavichordTouch
        self.organSustain = organSustain
        self.synthOscillator = synthOscillator
    }

    private enum CodingKeys: String, CodingKey {
        case embouchureShape = "title"
        case tonguingPrecision = "theme"
        case reedVibration = "dayText"
        case breathPhrasing = "hourText"
        case overtoneSeries = "genre"
        case valveSequence = "mode"
        case pianoVoicing = "seatLimit"
        case clavichordTouch = "gemNeed"
        case organSustain = "groups"
        case synthOscillator = "artPath"
    }

    init(from arpeggiatorPattern: Decoder) throws {
        let pedalResonance = try arpeggiatorPattern.container(keyedBy: CodingKeys.self)
        embouchureShape = try pedalResonance.decode(String.self, forKey: .embouchureShape)
        tonguingPrecision = try pedalResonance.decode(String.self, forKey: .tonguingPrecision)
        reedVibration = try pedalResonance.decode(String.self, forKey: .reedVibration)
        breathPhrasing = try pedalResonance.decode(String.self, forKey: .breathPhrasing)
        overtoneSeries = try pedalResonance.decode(String.self, forKey: .overtoneSeries)
        valveSequence = try pedalResonance.decode(String.self, forKey: .valveSequence)
        pianoVoicing = try pedalResonance.decode(Int.self, forKey: .pianoVoicing)
        clavichordTouch = try pedalResonance.decode(Int.self, forKey: .clavichordTouch)
        synthOscillator = try pedalResonance.decodeIfPresent(String.self, forKey: .synthOscillator)
        organSustain = try pedalResonance.decodeIfPresent([TinkieMelodyQuestCircleDraft].self, forKey: .organSustain) ?? [
            TinkieMelodyQuestCircleDraft(circleName: TinkieVerseCipherTrail.singBack("GNrSoZuspj BAK"), genre: overtoneSeries, mode: valveSequence, spotLimit: pianoVoicing, gemNeed: clavichordTouch)
        ]
    }
}

struct TinkieMelodyQuestCircleDraft: Codable {
    let circleName: String
    let genre: String
    let mode: String
    let spotLimit: Int
    let gemNeed: Int

    private enum CodingKeys: String, CodingKey {
        case circleName = "name"
        case genre
        case mode
        case spotLimit = "seatLimit"
        case gemNeed
    }
}

enum TinkieMelodyChallengeForgeScorebook {
    private static let draftKey = "tinkie_songquest_draft_records"

    static func allForgedMelodyChallenges() -> [TinkieMelodyChallengeCue] {
        storedChallengeDrafts().map { draft in
            TinkieMelodyChallengeCue(
                prestoSprint: draft.embouchureShape,
                allegroSpark: draft.reedVibration,
                allegrettoLift: draft.breathPhrasing,
                andantePace: draft.tonguingPrecision,
                largoCalm: [draft.overtoneSeries, draft.valveSequence],
                lentoDrift: "tinkie_event_cover_friday_pop_hits",
                rubatoElasticity: draft.synthOscillator,
                accelerandoCurve: TinkieSingerStageScorebook.sinePurity().singerAlias,
                ritardandoSlope: TinkieSingerTuneAtlas.avatarTuneNames(for: [TinkieSingerStageScorebook.sinePurity().singerAlias, "Jay", "Mina"]),
                rallentandoEase: "\(draft.organSustain.count) groups · \(draft.clavichordTouch) gems"
            )
        }
    }

    static func forgedMelodyCircles(for event: TinkieMelodyChallengeCue) -> [TinkieMelodyQuestCircle]? {
        guard let draft = storedChallengeDrafts().first(where: { $0.embouchureShape == event.prestoSprint && $0.reedVibration == event.allegroSpark }) else { return nil }
        let avatarSet = TinkieSingerTuneAtlas.avatarTuneNames(for: [TinkieVerseCipherTrail.singBack("JzebsWsfcIiwaT"), TinkieVerseCipherTrail.singBack("JwamyJ"), TinkieVerseCipherTrail.singBack("MDiqnjah"), TinkieVerseCipherTrail.singBack("AkrqiraY")])
        return draft.organSustain.enumerated().map { offset, group in
            let joined = min(group.spotLimit, max(1, group.spotLimit - 2 + offset))
            let left = max(0, group.spotLimit - joined)
            let rhythmStageSpots = [
                TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: offset == 0 ? TinkieVerseCipherTrail.singBack("JzebsWsfcIiwaT") : TinkieVerseCipherTrail.singBack("AkrqiraY"), owner: true),
                TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("JwamyJ")),
                TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("MDiqnjah"), muted: true),
                TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("NMoJvAaQ"))
            ]
            return TinkieMelodyQuestCircle(
                circleName: group.circleName,
                tagNames: [group.genre, group.mode],
                joinedSingerCount: joined,
                openSpotCount: left,
                gemNeed: group.gemNeed,
                chorusPortraitNames: avatarSet,
                rhythmStageSpots: rhythmStageSpots,
                cueLines: [
                    TinkieRhythmCueLine(tonicFocus: TinkieVerseCipherTrail.singBack("JwamyJ"), octaveEquivalence: TinkieVerseCipherTrail.singBack("IZ NcNainb GnnavmVem ltNhmadtg ViEnKtmrJoB IiHfN jtLhpeh ufPiQrZsYtJ xbPeIagtx MdqrBoYpXsO FcFlLeKakng.H")),
                    TinkieRhythmCueLine(tonicFocus: TinkieVerseCipherTrail.singBack("MDiqnjah"), octaveEquivalence: TinkieVerseCipherTrail.singBack("SqaBvUiTnZgB GmByb bgwuMexsLse ofDoOrC rtLhken ccchsorrjuesD XcXlFuLer.o")),
                    TinkieRhythmCueLine(tonicFocus: TinkieVerseCipherTrail.singBack("NMoJvAaQ"), octaveEquivalence: TinkieVerseCipherTrail.singBack("TChnissO FgKrFoPuspz EfyegeMlJsI HryeraAdByW Wftowrg CaZ JfaansTtH xssoJnMgR NrdoxuKnGdj.Q"))
                ]
            )
        }
    }

    static func save(_ draft: TinkieMelodyChallengeForgeDraft) {
        var saved = storedChallengeDrafts()
        saved.insert(draft, at: 0)
        guard let data = try? JSONEncoder().encode(saved) else { return }
        UserDefaults.standard.set(data, forKey: draftKey)
    }

    private static func storedChallengeDrafts() -> [TinkieMelodyChallengeForgeDraft] {
        guard
            let data = UserDefaults.standard.data(forKey: draftKey),
            let stored = try? JSONDecoder().decode([TinkieMelodyChallengeForgeDraft].self, from: data)
        else {
            return []
        }
        return stored
    }
}

struct TinkieSongPulseSparkDraft: Codable {
    let fortePiano: String
    let keyTouch: String?
    let keyVelocity: String
    let oscillatorTuning: String
    let wavetableShape: String
    let harmonicSynthesis: String?

    private enum CodingKeys: String, CodingKey {
        case fortePiano = "caption"
        case keyTouch = "coverPath"
        case keyVelocity = "clipPath"
        case oscillatorTuning = "performer"
        case wavetableShape = "avatarName"
        case harmonicSynthesis = "avatarPath"
    }
}

enum TinkiePulseSparkScorebook {
    private static let postKey = "tinkie_songpulse_post_records"

    static func savedPulseSparkTunes() -> [TinkieSongPulseSpark] {
        storedPulseSparkDrafts().map { pulse in
            TinkieSongPulseSpark(stringendoSurge: pulse.oscillatorTuning,
                ritenutoPause: TinkieVerseCipherTrail.singBack("jRuEsstv ZndovwJ"),
                tempoConsistency: pulse.fortePiano,
                tempoFlexibility: "tinkie_event_cover_friday_pop_hits",
                tempoImpulse: pulse.keyTouch,
                metronomeTick: pulse.keyVelocity,
                timingPrecision: pulse.wavetableShape,
                agogicAccent: pulse.harmonicSynthesis,
                pitchCenter: TinkieVerseCipherTrail.singBack("nbemwZ")
            )
        }
    }

    static func pulseEchoTunes(for performer: String) -> [TinkieMelodyMemoryEcho] {
        storedPulseSparkDrafts()
            .filter { $0.oscillatorTuning == performer }
            .map {
                TinkieMelodyMemoryEcho(echoTitle: TinkieVerseCipherTrail.singBack("FprAeOsphp CsDocnygp qrGoCufnzdX"),
                    echoNote: $0.fortePiano,
                    echoSleeveAssetName: "tinkie_event_cover_friday_pop_hits",
                    echoSleeveLocalPath: $0.keyTouch
                )
            }
    }

    static func save(_ pulse: TinkieSongPulseSparkDraft) {
        var saved = storedPulseSparkDrafts()
        saved.insert(pulse, at: 0)
        guard let data = try? JSONEncoder().encode(saved) else { return }
        UserDefaults.standard.set(data, forKey: postKey)
    }

    private static func storedPulseSparkDrafts() -> [TinkieSongPulseSparkDraft] {
        guard
            let data = UserDefaults.standard.data(forKey: postKey),
            let saved = try? JSONDecoder().decode([TinkieSongPulseSparkDraft].self, from: data)
        else {
            return []
        }
        return saved
    }
}

enum TinkieRhythmBondScorebook {
    private static let bondKey = "tinkie_rhythm_bond_records"
    private static let sparkKey = "tinkie_rhythm_spark_records"

    static func hasRhythmBond(for key: String) -> Bool {
        rhythmInkLines(for: bondKey).contains(key)
    }

    static func switchRhythmBond(for key: String) -> Bool {
        switchRhythmInk(for: key, storeKey: bondKey)
    }

    static func bondedSingerNames() -> [String] {
        var seen = Set<String>()
        return rhythmInkLines(for: bondKey).compactMap { key in
            guard let name = singerName(from: key), !seen.contains(name) else { return nil }
            seen.insert(name)
            return name
        }
    }

    static func removeBondedSinger(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        let kept = rhythmInkLines(for: bondKey).filter { singerName(from: $0) != trimmed }
        UserDefaults.standard.set(kept, forKey: bondKey)
        NotificationCenter.default.post(name: .tinkieSongPulseSessionDidShift, object: nil)
    }

    static func hasRhythmSpark(for key: String) -> Bool {
        rhythmInkLines(for: sparkKey).contains(key)
    }

    static func switchRhythmSpark(for key: String) -> Bool {
        switchRhythmInk(for: key, storeKey: sparkKey)
    }

    private static func switchRhythmInk(for key: String, storeKey: String) -> Bool {
        var values = Set(rhythmInkLines(for: storeKey))
        if values.contains(key) {
            values.remove(key)
            UserDefaults.standard.set(Array(values), forKey: storeKey)
            if storeKey == bondKey {
                NotificationCenter.default.post(name: .tinkieSongPulseSessionDidShift, object: nil)
            }
            return false
        }
        values.insert(key)
        UserDefaults.standard.set(Array(values), forKey: storeKey)
        if storeKey == bondKey {
            NotificationCenter.default.post(name: .tinkieSongPulseSessionDidShift, object: nil)
        }
        return true
    }

    private static func rhythmInkLines(for key: String) -> [String] {
        UserDefaults.standard.stringArray(forKey: key) ?? []
    }

    private static func singerName(from key: String) -> String? {
        let name = key.components(separatedBy: TinkieVerseCipherTrail.singBack(":V:i")).first?.trimmingCharacters(in: .whitespacesAndNewlines)
        return name?.isEmpty == false ? name : nil
    }
}

enum TinkieSongSeedSongbook {
    static let melodyChallengeSongbook: [TinkieMelodyChallengeCue] = [
        TinkieMelodyChallengeCue(
            prestoSprint: TinkieVerseCipherTrail.singBack("FHrzicdwapyJ JPnofpw AHuiqtxst sCphrailrlFeJnPgHem"),
            allegroSpark: TinkieVerseCipherTrail.singBack("Nxoxvx x2x1x,x x2x0x2x6x"),
            allegrettoLift: TinkieVerseCipherTrail.singBack("8n:K0d0C kPMML"),
            andantePace: TinkieVerseCipherTrail.singBack("GiuPetsUsj vpNoLpRuVlNaNrM psxoWnDgJsg xfBraoqmP NtghFeCisre PiJnOtnrLoGse oaunidO rcroBmupbebtvel dwtiWtQhm HoZtJhjevrb TpjlBaByteCrVsO Ftbos asoeYez dwphroa eksnwodwYsd kpRoHpE smxuFsxiCcq mbNeSsstx.H"),
            largoCalm: [TinkieVerseCipherTrail.singBack("Pxoopb UMIumsJikcC"), TinkieVerseCipherTrail.singBack("CAavsEugaUlZ")],
            lentoDrift: "tinkie_event_cover_friday_pop_hits",
            accelerandoCurve: TinkieVerseCipherTrail.singBack("AkrqiraY"),
            ritardandoSlope: TinkieSingerTuneAtlas.avatarTuneNames(for: ["Aria", "Jay", "Mina"]),
            rallentandoEase: TinkieVerseCipherTrail.singBack("iNnFtbrFoP RcRhVaQlClpesnegueJ")
        ),
        TinkieMelodyChallengeCue(
            prestoSprint: TinkieVerseCipherTrail.singBack("CPlCaCsvsIiocH SHoirtvsu fTBhyrMoLwnbjancDki xNQiKgahttT"),
            allegroSpark: TinkieVerseCipherTrail.singBack("Nxoxvx x2x3x,x x2x0x2x6x"),
            allegrettoLift: TinkieVerseCipherTrail.singBack("7Y:L3C0R nPLMG"),
            andantePace: TinkieVerseCipherTrail.singBack("RMeUdHiYsncPozvseyrr NiGcaoJnEiOcd msvoRnHgXsj vfMrxoemD QdwijfnfNeLrJeHnAtq YdpekcMaodmessN GaFnPds OsBhBaZrWeM VyKoluNrJ vfMaYvFoKrYiLtWeB XmTuvsYipcKaalg TmFejmNoxroiseXsl nwkiGtPho EtlhKeM LgCrXoEulpn.P"),
            largoCalm: [TinkieVerseCipherTrail.singBack("ChlgagsJsqiWcu yHWiCtJsM"), TinkieVerseCipherTrail.singBack("TlhCrzowwZbAaZcpkB")],
            lentoDrift: "tinkie_event_cover_classic_throwback",
            accelerandoCurve: TinkieVerseCipherTrail.singBack("JwamyJ"),
            ritardandoSlope: TinkieSingerTuneAtlas.avatarTuneNames(for: ["Jay", "Luna", "Aria"]),
            rallentandoEase: TinkieVerseCipherTrail.singBack("dhencIazdiel drMoIuwnydUsY")
        ),
        TinkieMelodyChallengeCue(
            prestoSprint: TinkieVerseCipherTrail.singBack("MSoevbiceE C&d JTrVG mSuoCudnjdJtzrEaVcpkZ GQBuziJzZ"),
            allegroSpark: TinkieVerseCipherTrail.singBack("Nxoxvx x2x5x,x x2x0x2x6x"),
            allegrettoLift: TinkieVerseCipherTrail.singBack("9q:d0F0v LPqMm"),
            andantePace: TinkieVerseCipherTrail.singBack("GpuDeusOsl nshoPnRgIsi dasnmdN etViVtKlxensC WftrToSmx ppLoWpHuUlOaOrN jmnoDvUiTessN GaFnPds OTzVU hseheobwHsv,h FaKnIdo Uplumtk CyXocuSrZ qsjoCufnzdXtxrTaBcskW JkQnFoMwklkexdtgceT Bthoa etVhcer vtFeNsutc.F"),
            largoCalm: [TinkieVerseCipherTrail.singBack("SRoluNnFdhtHrmazcUkn"), TinkieVerseCipherTrail.singBack("QquViczv")],
            lentoDrift: "tinkie_event_cover_soundtrack_quiz",
            accelerandoCurve: TinkieVerseCipherTrail.singBack("MDiqnjah"),
            ritardandoSlope: TinkieSingerTuneAtlas.avatarTuneNames(for: ["Mina", "Nova", "Jay"]),
            rallentandoEase: TinkieVerseCipherTrail.singBack("stcMrEeQesnb GtthReDmieAsm")
        ),
        TinkieMelodyChallengeCue(
            prestoSprint: TinkieVerseCipherTrail.singBack("KM-mProkpe DHdiytqss jCshtaolilKeCnGgLeq"),
            allegroSpark: TinkieVerseCipherTrail.singBack("Nxoxvx x2x7x,x x2x0x2x6x"),
            allegrettoLift: TinkieVerseCipherTrail.singBack("8L:a3v0t MPmMj"),
            andantePace: TinkieVerseCipherTrail.singBack("NPaHmdeG Ipboiplumlsasrs XKP-rprodpv YsNoyngglsG PfvrVoTmd nshhhotrctO dilnmtBruogsU SaAnLdm WcWowmApBeBtCeL Dfgosrn YtxhPeW NtgigtslFeJ PoNfQ lKc-MpMoPpN igsuNebsWsfiHnUgA ZcZhJaPmzpiisoZnK.o"),
            largoCalm: [TinkieVerseCipherTrail.singBack("KQ-tPqogpr"), TinkieVerseCipherTrail.singBack("HHiLtWsD")],
            lentoDrift: "tinkie_event_cover_kpop_hits",
            accelerandoCurve: TinkieVerseCipherTrail.singBack("RQiLnC"),
            ritardandoSlope: TinkieSingerTuneAtlas.avatarTuneNames(for: ["Rin", "Sera", "Jay"]),
            rallentandoEase: TinkieVerseCipherTrail.singBack("fVaEsbtj PiMnJtprKoM NrvotuNnEdr")
        ),
        TinkieMelodyChallengeCue(
            prestoSprint: TinkieVerseCipherTrail.singBack("AUnIiHmyeO ZSSovnugs yGquLersMssiDnTgO MPiamrotNyF"),
            allegroSpark: TinkieVerseCipherTrail.singBack("Oxcxtx x2x9x,x x2x0x2x6x"),
            allegrettoLift: TinkieVerseCipherTrail.singBack("6x:N0s0P jPBMY"),
            andantePace: TinkieVerseCipherTrail.singBack("TZeWsrtg ZyGojuYrH bkynlobwClCeMdPgQep rohfj IaYnUiSmqeT CoIpVeVnHiCnKgGss,y TeUnMdqijntgosO,M navnadP gibcEonnmihcL HsUoduTnLdmtIrzascQklsK JwPiutyhT xfBeLlBloomwK ZaKnGiPmoeD OmKussLiacB Vfmaynrsk.s"),
            largoCalm: [TinkieVerseCipherTrail.singBack("AJnCiZmjeL"), TinkieVerseCipherTrail.singBack("OxpgegnmihnegusU")],
            lentoDrift: "tinkie_event_cover_anime_guessing",
            accelerandoCurve: TinkieVerseCipherTrail.singBack("NbigaX"),
            ritardandoSlope: TinkieSingerTuneAtlas.avatarTuneNames(for: ["Nia", "Rin", "Mina"]),
            rallentandoEase: TinkieVerseCipherTrail.singBack("tphOeHmmeK RpzafrjtTyL")
        ),
        TinkieMelodyChallengeCue(
            prestoSprint: TinkieVerseCipherTrail.singBack("MTyisStBeZrJyI IMFudsCivcZ CMZifxg HNcipgGhMtm"),
            allegroSpark: TinkieVerseCipherTrail.singBack("Oxcxtx x3x1x,x x2x0x2x6x"),
            allegrettoLift: TinkieVerseCipherTrail.singBack("8n:K0d0C kPMML"),
            andantePace: TinkieVerseCipherTrail.singBack("Ehvvejrhyt trVoTuxnndM afCeYaftlubrdessI HaD SsZuhrxpRrzicsHed pgseLnDrrew xalnjdJ sefrdai,j GmBavkXirnlgv hiatg VtdhSeZ FpnenrmfNeOcjtk CcChDaJlFlnernxgneI Tfioqrh PpulHaHyneHrFsB RwQibtlhK mwqiBdReJ-nrqaxnkgxiInQgT CmYuvsYiucD AtqalsPtYeWsr.v"),
            largoCalm: [TinkieVerseCipherTrail.singBack("MUyusDtQeVrZyK KMHiqxr"), TinkieVerseCipherTrail.singBack("GZegnsrMeB JRqucsThT")],
            lentoDrift: "tinkie_event_cover_mystery_mix",
            accelerandoCurve: TinkieVerseCipherTrail.singBack("TrhYeHos"),
            ritardandoSlope: TinkieSingerTuneAtlas.avatarTuneNames(for: ["Theo", "Nova", "Ada"]),
            rallentandoEase: TinkieVerseCipherTrail.singBack("ssuCrRpfrEiTsneC GreosuTnOdpsm")
        )
    ]

    static let seedPulseSparkTunes: [TinkieSongPulseSpark] = [
        TinkieSongPulseSpark(stringendoSurge: TinkieVerseCipherTrail.singBack("JwamyJ"),
            ritenutoPause: TinkieVerseCipherTrail.singBack("bEeHfZoPrIeY EtlwpoN LmWionw"),
            tempoConsistency: TinkieVerseCipherTrail.singBack("WCazrxmq-Buepo XcXlFiCpF xfBrboymF MoKuqro JgVawmBeq atPoJnEiOgjhrtB,g HeJamsZyk kmqoHdHeE CoLnJlnym.d"),
            tempoFlexibility: "tinkie_event_cover_friday_pop_hits",
            metronomeTick: "tinkie_song_room_clip_country_hint.mp4",
            timingPrecision: TinkieSingerTuneAtlas.singerMelodyCard(named: "Jay").portraitAssetName,
            pitchCenter: TinkieVerseCipherTrail.singBack("hVoFtT")
        ),
        TinkieSongPulseSpark(stringendoSurge: TinkieVerseCipherTrail.singBack("AkrqiraY"),
            ritenutoPause: TinkieVerseCipherTrail.singBack("arfktJeDrS lfCiNrWsHtE irCoTuanvdB"),
            tempoConsistency: TinkieVerseCipherTrail.singBack("TxhBaWtO dcdhroaruubsU ScSlYuBea flNaNnCdvemdk DfgabsMtKeLrR stThrainb GtthReD ObiexaZtR.m"),
            tempoFlexibility: "tinkie_event_cover_classic_throwback",
            metronomeTick: "tinkie_song_room_clip_vocal_hook.mp4",
            timingPrecision: TinkieSingerTuneAtlas.singerMelodyCard(named: "Aria").portraitAssetName,
            pitchCenter: TinkieVerseCipherTrail.singBack("fbrZeKsjhj")
        ),
        TinkieSongPulseSpark(stringendoSurge: TinkieVerseCipherTrail.singBack("MDiqnjah"),
            ritenutoPause: TinkieVerseCipherTrail.singBack("rYiIgzhytZ pnJoWwb"),
            tempoConsistency: TinkieVerseCipherTrail.singBack("ONnFlxyc ctShsrYeTeh unXoUtCeKsj,u Ybtustx MtjhGeC JwShOoMlLeK RrcoroFmv mkjneetwA SiKtF.t"),
            tempoFlexibility: "tinkie_event_cover_soundtrack_quiz",
            metronomeTick: "tinkie_song_room_clip_acoustic_cue.mp4",
            timingPrecision: TinkieSingerTuneAtlas.singerMelodyCard(named: "Mina").portraitAssetName,
            pitchCenter: TinkieVerseCipherTrail.singBack("nbemwZ")
        ),
        TinkieSongPulseSpark(stringendoSurge: TinkieVerseCipherTrail.singBack("TrhYeHos"),
            ritenutoPause: TinkieVerseCipherTrail.singBack("oNnLeP HryoduTnLdm WaMgzoS"),
            tempoConsistency: TinkieVerseCipherTrail.singBack("TJhbey ngruMintbafrj BcBuneP HfzodoBlYeNdL fhXaNlZfn JtuhYeH ArnopoJmn suynptMiMlF ntJhgem lhBoGonkY VdbrCoTpGpnendo.Z"),
            tempoFlexibility: "tinkie_event_cover_pop_hits",
            metronomeTick: "tinkie_song_room_clip_chorus_guess.mp4",
            timingPrecision: TinkieSingerTuneAtlas.singerMelodyCard(named: "Theo").portraitAssetName,
            pitchCenter: TinkieVerseCipherTrail.singBack("pruklasseI")
        ),
        TinkieSongPulseSpark(stringendoSurge: TinkieVerseCipherTrail.singBack("RQiLnC"),
            ritenutoPause: TinkieVerseCipherTrail.singBack("djuzrwirnlgv hsepsrQiEnKtm"),
            tempoConsistency: TinkieVerseCipherTrail.singBack("Pzirtvckhu QrgovuFnJdk DwOewnxtK jfLaBsrtg,Y bbTuYtJ btFhdex hfJiRnVaXlH raqnvsfwTebrx ZwPassD XcXlFeKannx.V"),
            tempoFlexibility: "tinkie_event_cover_kpop_hits",
            metronomeTick: "tinkie_song_room_clip_pitch_round.mp4",
            timingPrecision: TinkieSingerTuneAtlas.singerMelodyCard(named: "Rin").portraitAssetName,
            pitchCenter: TinkieVerseCipherTrail.singBack("rvussVhV")
        ),
        TinkieSongPulseSpark(stringendoSurge: TinkieVerseCipherTrail.singBack("NbigaX"),
            ritenutoPause: TinkieVerseCipherTrail.singBack("avfftFeArL hchheobrsunsL"),
            tempoConsistency: TinkieVerseCipherTrail.singBack("Ar ibUrpimgJhWtw UsCtLaMgjeB XeVcyhxod xtDuQrOngejdq PiMnJtpog nav apYeYrUfyegcBtB escoEnSgH LrxeavbegaNlZ.a"),
            tempoFlexibility: "tinkie_event_cover_anime_guessing",
            metronomeTick: "tinkie_song_room_clip_stage_echo.mp4",
            timingPrecision: TinkieSingerTuneAtlas.singerMelodyCard(named: "Nia").portraitAssetName,
            pitchCenter: TinkieVerseCipherTrail.singBack("sKpMaCrCkM")
        )
    ]

    static func pulseSparkTunes(for performer: String) -> [TinkieSongPulseSpark] {
        let memorySprint = TinkiePulseSparkScorebook.savedPulseSparkTunes().filter { $0.stringendoSurge == performer }
        let subtractiveSynthesis = seedPulseSparkTunes.filter { $0.stringendoSurge == performer }
        return memorySprint + subtractiveSynthesis
    }

    static func joinedMelodyChallengeCues(for performer: String) -> [TinkieMelodyChallengeCue] {
        let stickRebound = TinkieMelodyChallengeForgeScorebook.allForgedMelodyChallenges().filter { $0.accelerandoCurve == performer }
        let seeded = melodyChallengeSongbook.filter { challengeCue in
            challengeCue.accelerandoCurve == performer || challengeCue.ritardandoSlope.contains(TinkieSingerTuneAtlas.singerMelodyCard(named: performer).portraitAssetName)
        }
        let stringTension = stickRebound + seeded
        if !stringTension.isEmpty { return Array(stringTension.prefix(2)) }
        guard !melodyChallengeSongbook.isEmpty else { return [] }
        let offset = abs(performer.hashValue % melodyChallengeSongbook.count)
        return [melodyChallengeSongbook[offset]]
    }
}
