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
        let snapshot = TinkieSingerStageScorebook.currentSingerStage()
        let matchedPortraitPath = snapshot.isSingerOnStage && snapshot.singerAlias == singerMelodyCard.singerAlias ? snapshot.portraitLocalPath : nil
        return TinkieRhythmStageSpot(singerAlias: singerMelodyCard.singerAlias, portraitAssetName: singerMelodyCard.portraitAssetName, portraitLocalPath: matchedPortraitPath, ownsStage: owner, micResting: muted)
    }

    static func avatarTuneNames(for names: [String]) -> [String] {
        names.map { singerMelodyCard(named: $0).portraitAssetName }
    }
}

enum TinkieSingerStageScorebook {
    private static let statusKey = TinkieVerseCipherTrail.singBack("tuiunmkiiHeviKstloomgEignb")
    private static let accountKey = TinkieVerseCipherTrail.singBack("tyiynxkriKekcMuyrdrBeCnGttEvmVaciFlZ")
    private static let profileKey = "tinkie_profile_records"
    private static let testAccount = TinkieVerseCipherTrail.singBack("tRiRnVkTideZ@XgJmuaYiwlg.GcZovmY")

    static var isSingerOnStage: Bool {
        UserDefaults.standard.bool(forKey: statusKey)
    }

    static func currentSingerStage() -> TinkieSingerStageSnapshot {
        guard isSingerOnStage else { return guestSnapshot }
        let account = UserDefaults.standard.string(forKey: accountKey) ?? testAccount
        var records = loadSingerMelodyRecords()
        let record = TinkieSingerTuneAtlas.completedSingerMelodyRecord(
            from: records[account] ?? defaultSingerMelodyRecord,
            singerAlias: records[account]?[TinkieVerseCipherTrail.singBack("nLiFckkPnQaNmxeB")],
            password: records[account]?[TinkieVerseCipherTrail.singBack("pBaZsxsYwboQrFds")]
        )
        if records[account] != record {
            records[account] = record
            saveSingerMelodyRecords(records)
        }
        return TinkieSingerTuneAtlas.singerStageSnapshot(from: record, signedIn: true)
    }

    static func dimSingerStageOnly() {
        UserDefaults.standard.set(false, forKey: statusKey)
        NotificationCenter.default.post(name: .tinkieSongPulseSessionDidShift, object: nil)
    }

    static func eraseCurrentSingerAndDimStage() {
        let account = UserDefaults.standard.string(forKey: accountKey) ?? testAccount
        var records = loadSingerMelodyRecords()
        records.removeValue(forKey: account)
        saveSingerMelodyRecords(records)
        UserDefaults.standard.set(false, forKey: statusKey)
        UserDefaults.standard.removeObject(forKey: accountKey)
        NotificationCenter.default.post(name: .tinkieSongPulseSessionDidShift, object: nil)
    }

    static func retuneCurrentSinger(singerAlias: String, melodyBio: String, portraitLocalPath: String? = nil) -> Bool {
        guard isSingerOnStage else { return false }
        let trimmedName = singerAlias.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedSignature = melodyBio.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return false }
        let account = UserDefaults.standard.string(forKey: accountKey) ?? testAccount
        var records = loadSingerMelodyRecords()
        var record = TinkieSingerTuneAtlas.completedSingerMelodyRecord(from: records[account] ?? defaultSingerMelodyRecord)
        record[TinkieVerseCipherTrail.singBack("nLiFckkPnQaNmxeB")] = trimmedName
        record[TinkieVerseCipherTrail.singBack("sHijgMnJaGtXuUrFeS")] = trimmedSignature.isEmpty ? TinkieVerseCipherTrail.singBack("SPonnmgd erXoEulnvdB krYeRgzuKlZaZrP qwbiXtHhg YaT MpflVaVybfvuxlv PgHugeAsmsLianogf isvtmyvlxen.p") : trimmedSignature
        if let portraitLocalPath, !portraitLocalPath.isEmpty {
            record[TinkieVerseCipherTrail.singBack("hYeFrPoXIkmFadgTedPraetphO")] = portraitLocalPath
        }
        records[account] = record
        saveSingerMelodyRecords(records)
        return true
    }

    static func spendGemRhythm(_ amount: Int) -> Bool {
        guard isSingerOnStage, amount > 0 else { return false }
        let account = UserDefaults.standard.string(forKey: accountKey) ?? testAccount
        var records = loadSingerMelodyRecords()
        var record = TinkieSingerTuneAtlas.completedSingerMelodyRecord(from: records[account] ?? defaultSingerMelodyRecord)
        let current = Int(record[TinkieVerseCipherTrail.singBack("bsabllalnjcjeW")] ?? "") ?? 0
        guard current >= amount else { return false }
        record[TinkieVerseCipherTrail.singBack("bsabllalnjcjeW")] = "\(current - amount)"
        records[account] = record
        saveSingerMelodyRecords(records)
        return true
    }

    static func addGemRhythm(_ amount: Int) {
        guard isSingerOnStage, amount > 0 else { return }
        let account = UserDefaults.standard.string(forKey: accountKey) ?? testAccount
        var records = loadSingerMelodyRecords()
        var record = TinkieSingerTuneAtlas.completedSingerMelodyRecord(from: records[account] ?? defaultSingerMelodyRecord)
        let current = Int(record[TinkieVerseCipherTrail.singBack("bsabllalnjcjeW")] ?? "") ?? 0
        record[TinkieVerseCipherTrail.singBack("bsabllalnjcjeW")] = "\(current + amount)"
        records[account] = record
        saveSingerMelodyRecords(records)
    }

    private static var guestSnapshot: TinkieSingerStageSnapshot {
        let guest = TinkieSingerTuneAtlas.guest
        return TinkieSingerStageSnapshot(
            isSingerOnStage: false,
            singerAlias: guest.singerAlias,
            singerCode: guest.singerCode,
            mgemtnkieorignal: guest.gemtnkieorignal,
            listenerEchoTotal: guest.listenerEchoTotal,
            followedSingerTotal: guest.followedSingerTotal,
            portraitAssetName: guest.portraitAssetName,
            portraitLocalPath: nil,
            melodyBio: guest.melodyBio,
            memoryEchoes: guest.memoryEchoes
        )
    }

    private static var defaultSingerMelodyRecord: [String: String] {
        TinkieSingerTuneAtlas.singerMelodyRecord(named: TinkieVerseCipherTrail.singBack("JzebsWsfcIiwaT"), password: TinkieVerseCipherTrail.singBack("1r2h3n4s5m6s7v8m"))
    }

    private static func loadSingerMelodyRecords() -> [String: [String: String]] {
        guard
            let data = UserDefaults.standard.data(forKey: profileKey),
            let records = try? JSONDecoder().decode([String: [String: String]].self, from: data)
        else {
            return [:]
        }
        return records
    }

    private static func saveSingerMelodyRecords(_ records: [String: [String: String]]) {
        guard let data = try? JSONEncoder().encode(records) else { return }
        UserDefaults.standard.set(data, forKey: profileKey)
    }
}

enum TinkieMelodyChallengeEntryScorebook {
    private static let joinedKey = "tinkie_event_joined_groups"

    static func entryState(for event: TinkieMelodyChallengeCue) -> TinkieMelodyChallengeEntryState {
        let closedTitles: Set<String> = [TinkieVerseCipherTrail.singBack("AUnIiHmyeO ZSSovnugs yGquLersMssiDnTgO MPiamrotNyF")]
        return TinkieMelodyChallengeEntryState(
            availability: closedTitles.contains(event.challengeTitle) ? .ended : .open,
            joinedGroupName: joinedMelodyCircleMap()[event.challengeTitle]
        )
    }

    static func detailMelodyCircles(for event: TinkieMelodyChallengeCue) -> [TinkieMelodyQuestCircle] {
        if let createdGroups = TinkieMelodyChallengeForgeScorebook.forgedMelodyCircles(for: event), !createdGroups.isEmpty {
            return createdGroups
        }
        let firstTags = event.challengeTags.isEmpty ? [TinkieVerseCipherTrail.singBack("Pxoopb UMIumsJikcC"), TinkieVerseCipherTrail.singBack("CAavsEugaUlZ")] : event.challengeTags
        return makeDefaultMelodyCircles(for: event, firstTags: firstTags)
    }

    private static func makeFirstRhythmSeats(for event: TinkieMelodyChallengeCue) -> [TinkieRhythmStageSpot] {
        [
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: event.leadSingerName, owner: true),
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("Acdhax")),
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("PJeNtBeZrJ"), muted: true),
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("JzebsWsfcIiwaT")),
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("BzoxmRaelwyn"), muted: true),
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("MDiqnjah")),
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("RQiLnC"), muted: true),
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("TrhYeHos"))
        ]
    }

    private static func makeSecondRhythmSeats() -> [TinkieRhythmStageSpot] {
        [
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("AkrqiraY"), owner: true),
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("NMoJvAaQ"), muted: true),
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("JwamyJ")),
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("LAuInDaP")),
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("KpaDii"), muted: true),
            TinkieSingerTuneAtlas.rhythmStageSpot(singerAlias: TinkieVerseCipherTrail.singBack("STepreav"))
        ]
    }

    private static func makeDefaultMelodyCircles(for event: TinkieMelodyChallengeCue, firstTags: [String]) -> [TinkieMelodyQuestCircle] {
        let rhythmSeatDecks = [
            makeFirstRhythmSeats(for: event),
            makeSecondRhythmSeats()
        ]
        let firstRhythmSeats = rhythmSeatDecks[0]
        let secondRhythmSeats = rhythmSeatDecks[1]
        return [
            TinkieMelodyQuestCircle(
                circleName: TinkieVerseCipherTrail.singBack("GNrSoZuspj BAK"),
                tagNames: firstTags,
                joinedSingerCount: 12,
                openSpotCount: 8,
                gemNeed: 50,
                chorusPortraitNames: firstRhythmSeats.map(\.portraitAssetName),
                rhythmStageSpots: firstRhythmSeats,
                cueLines: [
                    TinkieRhythmCueLine(speaker: TinkieVerseCipherTrail.singBack("PJeNtBeZrJ"), text: TinkieVerseCipherTrail.singBack("HjeelblOoC")),
                    TinkieRhythmCueLine(speaker: TinkieVerseCipherTrail.singBack("JzebsWsfcIiwaT"), text: TinkieVerseCipherTrail.singBack("JsudsCtL djLoIifnyeidj KtqhMiDsp grToKoxmR JaHnFdg NwWakngtO dtToN LgCubeJsjsZ LtvhCeR QoSpBeBnJiCnDgJ AhgopoJkv.w")),
                    TinkieRhythmCueLine(speaker: TinkieVerseCipherTrail.singBack("BzoxmRaelwyn"), text: TinkieVerseCipherTrail.singBack("RJeClFaFxVeDdN linnh BtghHiEsv rrJoBoomX,K jrYeTasdvyy yfOoZrG xtDhsec gnMeZxRts JsOognngr acalfupeT.K"))
                ]
            ),
            TinkieMelodyQuestCircle(
                circleName: TinkieVerseCipherTrail.singBack("GjrloquJpC tBM"),
                tagNames: [TinkieVerseCipherTrail.singBack("RvoocIkr jMcuLsqiWcu"), TinkieVerseCipherTrail.singBack("MDiqxnekdq")],
                joinedSingerCount: 9,
                openSpotCount: 11,
                gemNeed: 50,
                chorusPortraitNames: secondRhythmSeats.map(\.portraitAssetName),
                rhythmStageSpots: secondRhythmSeats,
                cueLines: [
                    TinkieRhythmCueLine(speaker: TinkieVerseCipherTrail.singBack("AkrqiraY"), text: TinkieVerseCipherTrail.singBack("WIep raqrqen cwgaTrYmKiknugs yuvpr KwRiqtmhN goqnsed tgouAiptbavrv RiPnEtlrZoN.Y")),
                    TinkieRhythmCueLine(speaker: TinkieVerseCipherTrail.singBack("JwamyJ"), text: TinkieVerseCipherTrail.singBack("Ie qtJhjiqnzkw gtYhbed taenrslwLeqrv RiPsi dfHrdoamW HaD ScSlYaYsusXiccQ CcChKoWrJuUsg.m")),
                    TinkieRhythmCueLine(speaker: TinkieVerseCipherTrail.singBack("LAuInDaP"), text: TinkieVerseCipherTrail.singBack("GxiDvSeU MmNed toznrey nmmoPrIeY EbwegaCtB eaqnwdE vIb kckaMnQ snCaZmjeL DiXtH.m"))
                ]
            )
        ]
    }

    static func joinMelodyCircle(_ group: TinkieMelodyQuestCircle, for event: TinkieMelodyChallengeCue) {
        var groups = joinedMelodyCircleMap()
        groups[event.challengeTitle] = melodyCircleKey(for: event, group: group)
        saveJoinedMelodyCircleMap(groups)
    }

    static func isMelodyCircleJoined(_ group: TinkieMelodyQuestCircle, for event: TinkieMelodyChallengeCue) -> Bool {
        joinedMelodyCircleMap()[event.challengeTitle] == melodyCircleKey(for: event, group: group)
    }

    static func hasJoinedDifferentMelodyCircle(_ group: TinkieMelodyQuestCircle, for event: TinkieMelodyChallengeCue) -> Bool {
        guard let joined = joinedMelodyCircleMap()[event.challengeTitle] else { return false }
        return joined != melodyCircleKey(for: event, group: group)
    }

    private static func melodyCircleKey(for event: TinkieMelodyChallengeCue, group: TinkieMelodyQuestCircle) -> String {
        [event.challengeTitle, event.challengeDayText, group.circleName].joined(separator: TinkieVerseCipherTrail.singBack(":V:i"))
    }

    private static func joinedMelodyCircleMap() -> [String: String] {
        guard
            let data = UserDefaults.standard.data(forKey: joinedKey),
            let groups = try? JSONDecoder().decode([String: String].self, from: data)
        else {
            return [:]
        }
        return groups
    }

    private static func saveJoinedMelodyCircleMap(_ groups: [String: String]) {
        guard let data = try? JSONEncoder().encode(groups) else { return }
        UserDefaults.standard.set(data, forKey: joinedKey)
    }
}

struct TinkieMelodyChallengeForgeDraft: Codable {
    let challengeTitle: String
    let challengeTheme: String
    let challengeDayText: String
    let challengeHourText: String
    let challengeGenre: String
    let challengeMood: String
    let seatLimit: Int
    let gemNeed: Int
    let melodyCircleDrafts: [TinkieMelodyQuestCircleDraft]
    let sleeveLocalPath: String?

    init(
        challengeTitle: String,
        challengeTheme: String,
        challengeDayText: String,
        challengeHourText: String,
        challengeGenre: String,
        challengeMood: String,
        seatLimit: Int,
        gemNeed: Int,
        melodyCircleDrafts: [TinkieMelodyQuestCircleDraft],
        sleeveLocalPath: String?
    ) {
        self.challengeTitle = challengeTitle
        self.challengeTheme = challengeTheme
        self.challengeDayText = challengeDayText
        self.challengeHourText = challengeHourText
        self.challengeGenre = challengeGenre
        self.challengeMood = challengeMood
        self.seatLimit = seatLimit
        self.gemNeed = gemNeed
        self.melodyCircleDrafts = melodyCircleDrafts
        self.sleeveLocalPath = sleeveLocalPath
    }

    private enum CodingKeys: String, CodingKey {
        case challengeTitle = "title"
        case challengeTheme = "theme"
        case challengeDayText = "dayText"
        case challengeHourText = "hourText"
        case challengeGenre = "genre"
        case challengeMood = "mode"
        case seatLimit
        case gemNeed
        case melodyCircleDrafts = "groups"
        case sleeveLocalPath = "artPath"
    }

    init(from decoder: Decoder) throws {
        let box = try decoder.container(keyedBy: CodingKeys.self)
        challengeTitle = try box.decode(String.self, forKey: .challengeTitle)
        challengeTheme = try box.decode(String.self, forKey: .challengeTheme)
        challengeDayText = try box.decode(String.self, forKey: .challengeDayText)
        challengeHourText = try box.decode(String.self, forKey: .challengeHourText)
        challengeGenre = try box.decode(String.self, forKey: .challengeGenre)
        challengeMood = try box.decode(String.self, forKey: .challengeMood)
        seatLimit = try box.decode(Int.self, forKey: .seatLimit)
        gemNeed = try box.decode(Int.self, forKey: .gemNeed)
        sleeveLocalPath = try box.decodeIfPresent(String.self, forKey: .sleeveLocalPath)
        melodyCircleDrafts = try box.decodeIfPresent([TinkieMelodyQuestCircleDraft].self, forKey: .melodyCircleDrafts) ?? [
            TinkieMelodyQuestCircleDraft(circleName: TinkieVerseCipherTrail.singBack("GNrSoZuspj BAK"), genre: challengeGenre, mode: challengeMood, spotLimit: seatLimit, gemNeed: gemNeed)
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
                challengeTitle: draft.challengeTitle,
                challengeDayText: draft.challengeDayText,
                challengeHourText: draft.challengeHourText,
                challengePrompt: draft.challengeTheme,
                challengeTags: [draft.challengeGenre, draft.challengeMood],
                sleeveAssetName: "tinkie_event_cover_friday_pop_hits",
                sleeveLocalPath: draft.sleeveLocalPath,
                leadSingerName: TinkieSingerStageScorebook.currentSingerStage().singerAlias,
                chorusAvatarNames: TinkieSingerTuneAtlas.avatarTuneNames(for: [TinkieSingerStageScorebook.currentSingerStage().singerAlias, "Jay", "Mina"]),
                roomCueNote: "\(draft.melodyCircleDrafts.count) groups · \(draft.gemNeed) gems"
            )
        }
    }

    static func forgedMelodyCircles(for event: TinkieMelodyChallengeCue) -> [TinkieMelodyQuestCircle]? {
        guard let draft = storedChallengeDrafts().first(where: { $0.challengeTitle == event.challengeTitle && $0.challengeDayText == event.challengeDayText }) else { return nil }
        let avatarSet = TinkieSingerTuneAtlas.avatarTuneNames(for: [TinkieVerseCipherTrail.singBack("JzebsWsfcIiwaT"), TinkieVerseCipherTrail.singBack("JwamyJ"), TinkieVerseCipherTrail.singBack("MDiqnjah"), TinkieVerseCipherTrail.singBack("AkrqiraY")])
        return draft.melodyCircleDrafts.enumerated().map { offset, group in
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
                    TinkieRhythmCueLine(speaker: TinkieVerseCipherTrail.singBack("JwamyJ"), text: TinkieVerseCipherTrail.singBack("IZ NcNainb GnnavmVem ltNhmadtg ViEnKtmrJoB IiHfN jtLhpeh ufPiQrZsYtJ xbPeIagtx MdqrBoYpXsO FcFlLeKakng.H")),
                    TinkieRhythmCueLine(speaker: TinkieVerseCipherTrail.singBack("MDiqnjah"), text: TinkieVerseCipherTrail.singBack("SqaBvUiTnZgB GmByb bgwuMexsLse ofDoOrC rtLhken ccchsorrjuesD XcXlFuLer.o")),
                    TinkieRhythmCueLine(speaker: TinkieVerseCipherTrail.singBack("NMoJvAaQ"), text: TinkieVerseCipherTrail.singBack("TChnissO FgKrFoPuspz EfyegeMlJsI HryeraAdByW Wftowrg CaZ JfaansTtH xssoJnMgR NrdoxuKnGdj.Q"))
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
    let caption: String
    let coverPath: String?
    let clipPath: String
    let performer: String
    let avatarName: String
    let avatarPath: String?
}

enum TinkiePulseSparkScorebook {
    private static let postKey = "tinkie_songpulse_post_records"

    static func savedPulseSparkTunes() -> [TinkieSongPulseSpark] {
        storedPulseSparkDrafts().map { pulse in
            TinkieSongPulseSpark(performer: pulse.performer,
                moment: TinkieVerseCipherTrail.singBack("jRuEsstv ZndovwJ"),
                caption: pulse.caption,
                coverName: "tinkie_event_cover_friday_pop_hits",
                coverPath: pulse.coverPath,
                pulseFileName: pulse.clipPath,
                avatarName: pulse.avatarName,
                avatarPath: pulse.avatarPath,
                echoCount: TinkieVerseCipherTrail.singBack("nbemwZ")
            )
        }
    }

    static func pulseEchoTunes(for performer: String) -> [TinkieMelodyMemoryEcho] {
        storedPulseSparkDrafts()
            .filter { $0.performer == performer }
            .map {
                TinkieMelodyMemoryEcho(echoTitle: TinkieVerseCipherTrail.singBack("FprAeOsphp CsDocnygp qrGoCufnzdX"),
                    echoNote: $0.caption,
                    echoSleeveAssetName: "tinkie_event_cover_friday_pop_hits",
                    echoSleeveLocalPath: $0.coverPath
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
            challengeTitle: TinkieVerseCipherTrail.singBack("FHrzicdwapyJ JPnofpw AHuiqtxst sCphrailrlFeJnPgHem"),
            challengeDayText: TinkieVerseCipherTrail.singBack("Jxunlq F1H8O,i U2m0J2e6X"),
            challengeHourText: TinkieVerseCipherTrail.singBack("8n:K0d0C kPMML"),
            challengePrompt: TinkieVerseCipherTrail.singBack("GiuPetsUsj vpNoLpRuVlNaNrM psxoWnDgJsg xfBraoqmP NtghFeCisre PiJnOtnrLoGse oaunidO rcroBmupbebtvel dwtiWtQhm HoZtJhjevrb TpjlBaByteCrVsO Ftbos asoeYez dwphroa eksnwodwYsd kpRoHpE smxuFsxiCcq mbNeSsstx.H"),
            challengeTags: [TinkieVerseCipherTrail.singBack("Pxoopb UMIumsJikcC"), TinkieVerseCipherTrail.singBack("CAavsEugaUlZ")],
            sleeveAssetName: "tinkie_event_cover_friday_pop_hits",
            leadSingerName: TinkieVerseCipherTrail.singBack("AkrqiraY"),
            chorusAvatarNames: TinkieSingerTuneAtlas.avatarTuneNames(for: ["Aria", "Jay", "Mina"]),
            roomCueNote: TinkieVerseCipherTrail.singBack("iNnFtbrFoP RcRhVaQlClpesnegueJ")
        ),
        TinkieMelodyChallengeCue(
            challengeTitle: TinkieVerseCipherTrail.singBack("CPlCaCsvsIiocH SHoirtvsu fTBhyrMoLwnbjancDki xNQiKgahttT"),
            challengeDayText: TinkieVerseCipherTrail.singBack("Jqublp L1V9g,d S2h0C2o6Q"),
            challengeHourText: TinkieVerseCipherTrail.singBack("7Y:L3C0R nPLMG"),
            challengePrompt: TinkieVerseCipherTrail.singBack("RMeUdHiYsncPozvseyrr NiGcaoJnEiOcd msvoRnHgXsj vfMrxoemD QdwijfnfNeLrJeHnAtq YdpekcMaodmessN GaFnPds OsBhBaZrWeM VyKoluNrJ vfMaYvFoKrYiLtWeB XmTuvsYipcKaalg TmFejmNoxroiseXsl nwkiGtPho EtlhKeM LgCrXoEulpn.P"),
            challengeTags: [TinkieVerseCipherTrail.singBack("ChlgagsJsqiWcu yHWiCtJsM"), TinkieVerseCipherTrail.singBack("TlhCrzowwZbAaZcpkB")],
            sleeveAssetName: "tinkie_event_cover_classic_throwback",
            leadSingerName: TinkieVerseCipherTrail.singBack("JwamyJ"),
            chorusAvatarNames: TinkieSingerTuneAtlas.avatarTuneNames(for: ["Jay", "Luna", "Aria"]),
            roomCueNote: TinkieVerseCipherTrail.singBack("dhencIazdiel drMoIuwnydUsY")
        ),
        TinkieMelodyChallengeCue(
            challengeTitle: TinkieVerseCipherTrail.singBack("MSoevbiceE C&d JTrVG mSuoCudnjdJtzrEaVcpkZ GQBuziJzZ"),
            challengeDayText: TinkieVerseCipherTrail.singBack("JSuDlH r2Y1G,P a2N0i2Z6m"),
            challengeHourText: TinkieVerseCipherTrail.singBack("9q:d0F0v LPqMm"),
            challengePrompt: TinkieVerseCipherTrail.singBack("GpuDeusOsl nshoPnRgIsi dasnmdN etViVtKlxensC WftrToSmx ppLoWpHuUlOaOrN jmnoDvUiTessN GaFnPds OTzVU hseheobwHsv,h FaKnIdo Uplumtk CyXocuSrZ qsjoCufnzdXtxrTaBcskW JkQnFoMwklkexdtgceT Bthoa etVhcer vtFeNsutc.F"),
            challengeTags: [TinkieVerseCipherTrail.singBack("SRoluNnFdhtHrmazcUkn"), TinkieVerseCipherTrail.singBack("QquViczv")],
            sleeveAssetName: "tinkie_event_cover_soundtrack_quiz",
            leadSingerName: TinkieVerseCipherTrail.singBack("MDiqnjah"),
            chorusAvatarNames: TinkieSingerTuneAtlas.avatarTuneNames(for: ["Mina", "Nova", "Jay"]),
            roomCueNote: TinkieVerseCipherTrail.singBack("stcMrEeQesnb GtthReDmieAsm")
        ),
        TinkieMelodyChallengeCue(
            challengeTitle: TinkieVerseCipherTrail.singBack("KM-mProkpe DHdiytqss jCshtaolilKeCnGgLeq"),
            challengeDayText: TinkieVerseCipherTrail.singBack("JBuQlE g2J3W,Y t2A0l2Y6a"),
            challengeHourText: TinkieVerseCipherTrail.singBack("8L:a3v0t MPmMj"),
            challengePrompt: TinkieVerseCipherTrail.singBack("NPaHmdeG Ipboiplumlsasrs XKP-rprodpv YsNoyngglsG PfvrVoTmd nshhhotrctO dilnmtBruogsU SaAnLdm WcWowmApBeBtCeL Dfgosrn YtxhPeW NtgigtslFeJ PoNfQ lKc-MpMoPpN igsuNebsWsfiHnUgA ZcZhJaPmzpiisoZnK.o"),
            challengeTags: [TinkieVerseCipherTrail.singBack("KQ-tPqogpr"), TinkieVerseCipherTrail.singBack("HHiLtWsD")],
            sleeveAssetName: "tinkie_event_cover_kpop_hits",
            leadSingerName: TinkieVerseCipherTrail.singBack("RQiLnC"),
            chorusAvatarNames: TinkieSingerTuneAtlas.avatarTuneNames(for: ["Rin", "Sera", "Jay"]),
            roomCueNote: TinkieVerseCipherTrail.singBack("fVaEsbtj PiMnJtprKoM NrvotuNnEdr")
        ),
        TinkieMelodyChallengeCue(
            challengeTitle: TinkieVerseCipherTrail.singBack("AUnIiHmyeO ZSSovnugs yGquLersMssiDnTgO MPiamrotNyF"),
            challengeDayText: TinkieVerseCipherTrail.singBack("JNuSlF q2W5J,X z2C0b2J6t"),
            challengeHourText: TinkieVerseCipherTrail.singBack("6x:N0s0P jPBMY"),
            challengePrompt: TinkieVerseCipherTrail.singBack("TZeWsrtg ZyGojuYrH bkynlobwClCeMdPgQep rohfj IaYnUiSmqeT CoIpVeVnHiCnKgGss,y TeUnMdqijntgosO,M navnadP gibcEonnmihcL HsUoduTnLdmtIrzascQklsK JwPiutyhT xfBeLlBloomwK ZaKnGiPmoeD OmKussLiacB Vfmaynrsk.s"),
            challengeTags: [TinkieVerseCipherTrail.singBack("AJnCiZmjeL"), TinkieVerseCipherTrail.singBack("OxpgegnmihnegusU")],
            sleeveAssetName: "tinkie_event_cover_anime_guessing",
            leadSingerName: TinkieVerseCipherTrail.singBack("NbigaX"),
            chorusAvatarNames: TinkieSingerTuneAtlas.avatarTuneNames(for: ["Nia", "Rin", "Mina"]),
            roomCueNote: TinkieVerseCipherTrail.singBack("tphOeHmmeK RpzafrjtTyL")
        ),
        TinkieMelodyChallengeCue(
            challengeTitle: TinkieVerseCipherTrail.singBack("MTyisStBeZrJyI IMFudsCivcZ CMZifxg HNcipgGhMtm"),
            challengeDayText: TinkieVerseCipherTrail.singBack("JPuBlM d2H7U,U y2L0j2W6z"),
            challengeHourText: TinkieVerseCipherTrail.singBack("8n:K0d0C kPMML"),
            challengePrompt: TinkieVerseCipherTrail.singBack("Ehvvejrhyt trVoTuxnndM afCeYaftlubrdessI HaD SsZuhrxpRrzicsHed pgseLnDrrew xalnjdJ sefrdai,j GmBavkXirnlgv hiatg VtdhSeZ FpnenrmfNeOcjtk CcChDaJlFlnernxgneI Tfioqrh PpulHaHyneHrFsB RwQibtlhK mwqiBdReJ-nrqaxnkgxiInQgT CmYuvsYiucD AtqalsPtYeWsr.v"),
            challengeTags: [TinkieVerseCipherTrail.singBack("MUyusDtQeVrZyK KMHiqxr"), TinkieVerseCipherTrail.singBack("GZegnsrMeB JRqucsThT")],
            sleeveAssetName: "tinkie_event_cover_mystery_mix",
            leadSingerName: TinkieVerseCipherTrail.singBack("TrhYeHos"),
            chorusAvatarNames: TinkieSingerTuneAtlas.avatarTuneNames(for: ["Theo", "Nova", "Ada"]),
            roomCueNote: TinkieVerseCipherTrail.singBack("ssuCrRpfrEiTsneC GreosuTnOdpsm")
        )
    ]

    static let seedPulseSparkTunes: [TinkieSongPulseSpark] = [
        TinkieSongPulseSpark(performer: TinkieVerseCipherTrail.singBack("JwamyJ"),
            moment: TinkieVerseCipherTrail.singBack("bEeHfZoPrIeY EtlwpoN LmWionw"),
            caption: TinkieVerseCipherTrail.singBack("WCazrxmq-Buepo XcXlFiCpF xfBrboymF MoKuqro JgVawmBeq atPoJnEiOgjhrtB,g HeJamsZyk kmqoHdHeE CoLnJlnym.d"),
            coverName: "tinkie_event_cover_friday_pop_hits",
            pulseFileName: "tinkie_song_room_clip_country_hint.mp4",
            avatarName: TinkieSingerTuneAtlas.singerMelodyCard(named: "Jay").portraitAssetName,
            echoCount: TinkieVerseCipherTrail.singBack("hVoFtT")
        ),
        TinkieSongPulseSpark(performer: TinkieVerseCipherTrail.singBack("AkrqiraY"),
            moment: TinkieVerseCipherTrail.singBack("arfktJeDrS lfCiNrWsHtE irCoTuanvdB"),
            caption: TinkieVerseCipherTrail.singBack("TxhBaWtO dcdhroaruubsU ScSlYuBea flNaNnCdvemdk DfgabsMtKeLrR stThrainb GtthReD ObiexaZtR.m"),
            coverName: "tinkie_event_cover_classic_throwback",
            pulseFileName: "tinkie_song_room_clip_vocal_hook.mp4",
            avatarName: TinkieSingerTuneAtlas.singerMelodyCard(named: "Aria").portraitAssetName,
            echoCount: TinkieVerseCipherTrail.singBack("fbrZeKsjhj")
        ),
        TinkieSongPulseSpark(performer: TinkieVerseCipherTrail.singBack("MDiqnjah"),
            moment: TinkieVerseCipherTrail.singBack("rYiIgzhytZ pnJoWwb"),
            caption: TinkieVerseCipherTrail.singBack("ONnFlxyc ctShsrYeTeh unXoUtCeKsj,u Ybtustx MtjhGeC JwShOoMlLeK RrcoroFmv mkjneetwA SiKtF.t"),
            coverName: "tinkie_event_cover_soundtrack_quiz",
            pulseFileName: "tinkie_song_room_clip_acoustic_cue.mp4",
            avatarName: TinkieSingerTuneAtlas.singerMelodyCard(named: "Mina").portraitAssetName,
            echoCount: TinkieVerseCipherTrail.singBack("nbemwZ")
        ),
        TinkieSongPulseSpark(performer: TinkieVerseCipherTrail.singBack("TrhYeHos"),
            moment: TinkieVerseCipherTrail.singBack("oNnLeP HryoduTnLdm WaMgzoS"),
            caption: TinkieVerseCipherTrail.singBack("TJhbey ngruMintbafrj BcBuneP HfzodoBlYeNdL fhXaNlZfn JtuhYeH ArnopoJmn suynptMiMlF ntJhgem lhBoGonkY VdbrCoTpGpnendo.Z"),
            coverName: "tinkie_event_cover_pop_hits",
            pulseFileName: "tinkie_song_room_clip_chorus_guess.mp4",
            avatarName: TinkieSingerTuneAtlas.singerMelodyCard(named: "Theo").portraitAssetName,
            echoCount: TinkieVerseCipherTrail.singBack("pruklasseI")
        ),
        TinkieSongPulseSpark(performer: TinkieVerseCipherTrail.singBack("RQiLnC"),
            moment: TinkieVerseCipherTrail.singBack("djuzrwirnlgv hsepsrQiEnKtm"),
            caption: TinkieVerseCipherTrail.singBack("Pzirtvckhu QrgovuFnJdk DwOewnxtK jfLaBsrtg,Y bbTuYtJ btFhdex hfJiRnVaXlH raqnvsfwTebrx ZwPassD XcXlFeKannx.V"),
            coverName: "tinkie_event_cover_kpop_hits",
            pulseFileName: "tinkie_song_room_clip_pitch_round.mp4",
            avatarName: TinkieSingerTuneAtlas.singerMelodyCard(named: "Rin").portraitAssetName,
            echoCount: TinkieVerseCipherTrail.singBack("rvussVhV")
        ),
        TinkieSongPulseSpark(performer: TinkieVerseCipherTrail.singBack("NbigaX"),
            moment: TinkieVerseCipherTrail.singBack("avfftFeArL hchheobrsunsL"),
            caption: TinkieVerseCipherTrail.singBack("Ar ibUrpimgJhWtw UsCtLaMgjeB XeVcyhxod xtDuQrOngejdq PiMnJtpog nav apYeYrUfyegcBtB escoEnSgH LrxeavbegaNlZ.a"),
            coverName: "tinkie_event_cover_anime_guessing",
            pulseFileName: "tinkie_song_room_clip_stage_echo.mp4",
            avatarName: TinkieSingerTuneAtlas.singerMelodyCard(named: "Nia").portraitAssetName,
            echoCount: TinkieVerseCipherTrail.singBack("sKpMaCrCkM")
        )
    ]

    static func pulseSparkTunes(for performer: String) -> [TinkieSongPulseSpark] {
        let local = TinkiePulseSparkScorebook.savedPulseSparkTunes().filter { $0.performer == performer }
        let seeded = seedPulseSparkTunes.filter { $0.performer == performer }
        return local + seeded
    }

    static func joinedMelodyChallengeCues(for performer: String) -> [TinkieMelodyChallengeCue] {
        let authored = TinkieMelodyChallengeForgeScorebook.allForgedMelodyChallenges().filter { $0.leadSingerName == performer }
        let seeded = melodyChallengeSongbook.filter { challengeCue in
            challengeCue.leadSingerName == performer || challengeCue.chorusAvatarNames.contains(TinkieSingerTuneAtlas.singerMelodyCard(named: performer).portraitAssetName)
        }
        let linked = authored + seeded
        if !linked.isEmpty { return Array(linked.prefix(2)) }
        guard !melodyChallengeSongbook.isEmpty else { return [] }
        let offset = abs(performer.hashValue % melodyChallengeSongbook.count)
        return [melodyChallengeSongbook[offset]]
    }
}
