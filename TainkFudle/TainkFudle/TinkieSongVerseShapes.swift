import UIKit

struct TinkieSongQuestTune {
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

struct TinkieSongPulseEcho {
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
struct TinkieSingerSnapshot {
    let isSingerOnStage: Bool
    let nickname: String
    let uid: String
    let balance: Int
    let followers: Int
    let following: Int
    let heroImageName: String
    let heroImagePath: String?
    let signature: String
    let moments: [TinkieSongPulseEcho]
}
struct TinkieSingerTuneCard {
    let nickname: String
    let uid: String
    let balance: Int
    let followers: Int
    let following: Int
    let heroImageName: String
    let signature: String
    let moments: [TinkieSongPulseEcho]
}
struct TinkieSongQuestChord {
    let name: String
    let tags: [String]
    let joinedCount: Int
    let spotsLeft: Int
    let gemNeed: Int
    let avatarNames: [String]
    let rhythmSeats: [TinkieRhythmSingerSeat]
    let rhythmCueLines: [TinkieRhythmCueLine]
}
struct TinkieRhythmSingerSeat {
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
struct TinkieRhythmCueLine {
    let speaker: String
    let text: String
}
enum TinkieQuestAvailability {
    case open
    case ended
}
struct TinkieQuestEntryState {
    let availability: TinkieQuestAvailability
    let joinedGroupName: String?
}
