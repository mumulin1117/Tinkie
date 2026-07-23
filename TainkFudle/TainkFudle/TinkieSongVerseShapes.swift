import UIKit

enum TinkieVerseCipherTrail {
    static func singBack(_ wovenVerse: String) -> String {
        let verseRuneDeck = Array(wovenVerse)
        let silentBeatSeed = wovenVerse.count
        let melodyStride = tuneHiddenStride(from: silentBeatSeed, echoSalt: verseRuneDeck.count)
        return rebuildClearTune(from: verseRuneDeck, startBeat: 0, jumpBeat: melodyStride, reserveHint: silentBeatSeed)
    }

    private static func tuneHiddenStride(from pulseSeed: Int, echoSalt: Int) -> Int {
        let mutedPulse = pulseSeed ^ echoSalt ^ pulseSeed ^ echoSalt
        return mutedPulse + 2
    }

    private static func rebuildClearTune(
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
    let challengeTitle: String
    let challengeDayText: String
    let challengeHourText: String
    let challengePrompt: String
    let challengeTags: [String]
    let sleeveAssetName: String
    let sleeveLocalPath: String?
    let leadSingerName: String
    let chorusAvatarNames: [String]
    let roomCueNote: String

    init(
        challengeTitle: String,
        challengeDayText: String,
        challengeHourText: String,
        challengePrompt: String,
        challengeTags: [String],
        sleeveAssetName: String,
        sleeveLocalPath: String? = nil,
        leadSingerName: String,
        chorusAvatarNames: [String],
        roomCueNote: String
    ) {
        self.challengeTitle = challengeTitle
        self.challengeDayText = challengeDayText
        self.challengeHourText = challengeHourText
        self.challengePrompt = challengePrompt
        self.challengeTags = challengeTags
        self.sleeveAssetName = sleeveAssetName
        self.sleeveLocalPath = sleeveLocalPath
        self.leadSingerName = leadSingerName
        self.chorusAvatarNames = chorusAvatarNames
        self.roomCueNote = roomCueNote
    }
}
struct TinkieSongPulseSpark {
    let performer: String
    let moment: String
    let caption: String
    let coverName: String
    let coverPath: String?
    let pulseFileName: String
    let avatarName: String
    let avatarPath: String?
    let echoCount: String

    init(
        performer: String,
        moment: String,
        caption: String,
        coverName: String,
        coverPath: String? = nil,
        pulseFileName: String,
        avatarName: String,
        avatarPath: String? = nil,
        echoCount: String
    ) {
        self.performer = performer
        self.moment = moment
        self.caption = caption
        self.coverName = coverName
        self.coverPath = coverPath
        self.pulseFileName = pulseFileName
        self.avatarName = avatarName
        self.avatarPath = avatarPath
        self.echoCount = echoCount
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
    let speaker: String
    let text: String
}
enum TinkieMelodyChallengeAvailability {
    case open
    case ended
}
struct TinkieMelodyChallengeEntryState {
    let availability: TinkieMelodyChallengeAvailability
    let joinedGroupName: String?
}
