import UIKit

struct TinkieLyricFlow {
    let title: String
    let dateText: String
    let timeText: String
    let subtitle: String
    let tags: [String]
    let coverName: String
    let coverPath: String?
    let hostName: String
    let avatarNames: [String]
    let listenerNote: String

    init(
        title: String,
        dateText: String,
        timeText: String,
        subtitle: String,
        tags: [String],
        coverName: String,
        coverPath: String? = nil,
        hostName: String,
        avatarNames: [String],
        listenerNote: String
    ) {
        self.title = title
        self.dateText = dateText
        self.timeText = timeText
        self.subtitle = subtitle
        self.tags = tags
        self.coverName = coverName
        self.coverPath = coverPath
        self.hostName = hostName
        self.avatarNames = avatarNames
        self.listenerNote = listenerNote
    }
}

typealias TinkieSongEvent = TinkieLyricFlow

struct TinkieReelClip {
    let performer: String
    let moment: String
    let caption: String
    let coverName: String
    let coverPath: String?
    let clipFileName: String
    let avatarName: String
    let avatarPath: String?
    let echoCount: String

    init(
        performer: String,
        moment: String,
        caption: String,
        coverName: String,
        coverPath: String? = nil,
        clipFileName: String,
        avatarName: String,
        avatarPath: String? = nil,
        echoCount: String
    ) {
        self.performer = performer
        self.moment = moment
        self.caption = caption
        self.coverName = coverName
        self.coverPath = coverPath
        self.clipFileName = clipFileName
        self.avatarName = avatarName
        self.avatarPath = avatarPath
        self.echoCount = echoCount
    }
}

struct TinkiBeatPulse {
    let title: String
    let note: String
    let coverName: String
    let coverPath: String?

    init(title: String, note: String, coverName: String, coverPath: String? = nil) {
        self.title = title
        self.note = note
        self.coverName = coverName
        self.coverPath = coverPath
    }
}

typealias TinkieProfileMoment = TinkiBeatPulse

struct TinkieMelodyScoreot {
    let isSignedIn: Bool
    let nickname: String
    let uid: String
    let balance: Int
    let followers: Int
    let following: Int
    let heroImageName: String
    let heroImagePath: String?
    let signature: String
    let moments: [TinkiBeatPulse]
}

typealias TinkieProfileSnapshot = TinkieMelodyScoreot

struct TrinkieMelodyGuess {
    let nickname: String
    let uid: String
    let balance: Int
    let followers: Int
    let following: Int
    let heroImageName: String
    let signature: String
    let moments: [TinkiBeatPulse]
}

typealias TinkiePersona = TrinkieMelodyGuess

struct TinkieMelodyQuest {
    let name: String
    let tags: [String]
    let joinedCount: Int
    let spotsLeft: Int
    let gemNeed: Int
    let avatarNames: [String]
    let roomMembers: [TinkieMelodyCue]
    let roomLines: [tinkieMelodyArc]
}

typealias TinkieEventGroup = TinkieMelodyQuest

struct TinkieMelodyCue {
    let name: String
    let avatarName: String
    let avatarPath: String?
    let isOwner: Bool
    let isMuted: Bool

    init(name: String, avatarName: String, avatarPath: String? = nil, isOwner: Bool, isMuted: Bool) {
        self.name = name
        self.avatarName = avatarName
        self.avatarPath = avatarPath
        self.isOwner = isOwner
        self.isMuted = isMuted
    }
}

typealias TinkieRoomMember = TinkieMelodyCue

struct tinkieMelodyArc {
    let speaker: String
    let text: String
}

typealias TinkieRoomLine = tinkieMelodyArc

enum tinkieMelodyWave {
    case open
    case ended
}

typealias TinkieEventAvailability = tinkieMelodyWave

struct tinkieHookRadar {
    let availability: tinkieMelodyWave
    let joinedGroupName: String?
}

typealias TinkieEventDetailState = tinkieHookRadar
