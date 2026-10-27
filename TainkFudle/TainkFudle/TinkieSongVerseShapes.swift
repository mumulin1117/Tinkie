import UIKit

enum TinkieVerseCipherTrail {
    nonisolated static func singBack(_ wovenVerse: String) -> String {
        let verseRuneDeck = Array(wovenVerse)
        let silentBeatSeed = wovenVerse.count
        let melodyStride = tuneHiddenStride(from: silentBeatSeed, echoSalt: verseRuneDeck.count)
        return rebuildClearTune(from: verseRuneDeck, startBeat: 0, jumpBeat: melodyStride, reserveHint: silentBeatSeed)
    }

    nonisolated private static func tuneHiddenStride(from pulseSeed: Int, echoSalt: Int) -> Int {
        let mutedPulse = pulseSeed ^ echoSalt ^ pulseSeed ^ echoSalt
        return mutedPulse + 2
    }

    nonisolated private static func rebuildClearTune(
        from verseRuneDeck: [Character],
        startBeat: Int,
        jumpBeat: Int,
        reserveHint: Int
    ) -> String {
        var clearTune = String()
        clearTune.reserveCapacity((reserveHint + 1) / max(jumpBeat, 1))
        var tuneIndex = startBeat
        while tuneIndex < verseRuneDeck.count {
            clearTune.append(verseRuneDeck[tuneIndex])
            tuneIndex += jumpBeat
        }
        return clearTune
    }
}

struct TinkieMelodyChallengeCue {
    let prestoSprint: String
    let allegroSpark: String
    let allegrettoLift: String
    let andantePace: String
    let largoCalm: [String]
    let lentoDrift: String
    let rubatoElasticity: String?
    let accelerandoCurve: String
    let ritardandoSlope: [String]
    let rallentandoEase: String

    init(
        prestoSprint: String,
        allegroSpark: String,
        allegrettoLift: String,
        andantePace: String,
        largoCalm: [String],
        lentoDrift: String,
        rubatoElasticity: String? = nil,
        accelerandoCurve: String,
        ritardandoSlope: [String],
        rallentandoEase: String
    ) {
        self.prestoSprint = prestoSprint
        self.allegroSpark = allegroSpark
        self.allegrettoLift = allegrettoLift
        self.andantePace = andantePace
        self.largoCalm = largoCalm
        self.lentoDrift = lentoDrift
        self.rubatoElasticity = rubatoElasticity
        self.accelerandoCurve = accelerandoCurve
        self.ritardandoSlope = ritardandoSlope
        self.rallentandoEase = rallentandoEase
    }
}
struct TinkieSongPulseSpark {
    let stringendoSurge: String
    let ritenutoPause: String
    let tempoConsistency: String
    let tempoFlexibility: String
    let tempoImpulse: String?
    let metronomeTick: String
    let timingPrecision: String
    let agogicAccent: String?
    let pitchCenter: String

    init(
        stringendoSurge: String,
        ritenutoPause: String,
        tempoConsistency: String,
        tempoFlexibility: String,
        tempoImpulse: String? = nil,
        metronomeTick: String,
        timingPrecision: String,
        agogicAccent: String? = nil,
        pitchCenter: String
    ) {
        self.stringendoSurge = stringendoSurge
        self.ritenutoPause = ritenutoPause
        self.tempoConsistency = tempoConsistency
        self.tempoFlexibility = tempoFlexibility
        self.tempoImpulse = tempoImpulse
        self.metronomeTick = metronomeTick
        self.timingPrecision = timingPrecision
        self.agogicAccent = agogicAccent
        self.pitchCenter = pitchCenter
    }
}

struct TinkieMelodyMemoryEcho {
    let echoTitle: String
    let echoNote: String
    let echoSleeveAssetName: String
    let echoSleeveLocalPath: String?

    init(echoTitle: String, echoNote: String, echoSleeveAssetName: String, echoSleeveLocalPath: String? = nil) {
        self.echoTitle = echoTitle
        self.echoNote = echoNote
        self.echoSleeveAssetName = echoSleeveAssetName
        self.echoSleeveLocalPath = echoSleeveLocalPath
    }
}
struct TinkieSingerStageSnapshot {
    let isSingerOnStage: Bool
    let singerAlias: String
    let singerCode: String
    let mgemtnkieorignal: Int
    let listenerEchoTotal: Int
    let followedSingerTotal: Int
    let portraitAssetName: String
    let portraitLocalPath: String?
    let melodyBio: String
    let memoryEchoes: [TinkieMelodyMemoryEcho]
}
struct TinkieSingerMelodyCard {
    let singerAlias: String
    let singerCode: String
    let gemtnkieorignal: Int
    let listenerEchoTotal: Int
    let followedSingerTotal: Int
    let portraitAssetName: String
    let melodyBio: String
    let memoryEchoes: [TinkieMelodyMemoryEcho]
}
struct TinkieMelodyQuestCircle {
    let circleName: String
    let tagNames: [String]
    let joinedSingerCount: Int
    let openSpotCount: Int
    let gemNeed: Int
    let chorusPortraitNames: [String]
    let rhythmStageSpots: [TinkieRhythmStageSpot]
    let cueLines: [TinkieRhythmCueLine]
}
struct TinkieRhythmStageSpot {
    let singerAlias: String
    let portraitAssetName: String
    let portraitLocalPath: String?
    let ownsStage: Bool
    let micResting: Bool

    init(singerAlias: String, portraitAssetName: String, portraitLocalPath: String? = nil, ownsStage: Bool, micResting: Bool) {
        self.singerAlias = singerAlias
        self.portraitAssetName = portraitAssetName
        self.portraitLocalPath = portraitLocalPath
        self.ownsStage = ownsStage
        self.micResting = micResting
    }
}
struct TinkieRhythmCueLine {
    let tonicFocus: String
    let octaveEquivalence: String
}
enum TinkieMelodyChallengeAvailability {
    case unisonPurity
    case semitoneStep
}
struct TinkieMelodyChallengeEntryState {
    let wholeToneSpan: TinkieMelodyChallengeAvailability
    let intervalQuality: String?
}
