import UIKit

struct TinkieSongEvent {
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

struct TinkieReelClip {
    let performer: String
    let moment: String
    let caption: String
    let coverName: String
    let coverPath: String?
    let clipFileName: String
    let avatarName: String
    let echoCount: String

    init(
        performer: String,
        moment: String,
        caption: String,
        coverName: String,
        coverPath: String? = nil,
        clipFileName: String,
        avatarName: String,
        echoCount: String
    ) {
        self.performer = performer
        self.moment = moment
        self.caption = caption
        self.coverName = coverName
        self.coverPath = coverPath
        self.clipFileName = clipFileName
        self.avatarName = avatarName
        self.echoCount = echoCount
    }
}

struct TinkieProfileMoment {
    let title: String
    let note: String
    let coverName: String
}

struct TinkieProfileSnapshot {
    let isSignedIn: Bool
    let nickname: String
    let uid: String
    let balance: Int
    let followers: Int
    let following: Int
    let heroImageName: String
    let heroImagePath: String?
    let moments: [TinkieProfileMoment]
}

struct TinkiePersona {
    let nickname: String
    let uid: String
    let balance: Int
    let followers: Int
    let following: Int
    let heroImageName: String
    let signature: String
    let moments: [TinkieProfileMoment]
}

struct TinkieEventGroup {
    let name: String
    let tags: [String]
    let joinedCount: Int
    let spotsLeft: Int
    let gemNeed: Int
    let avatarNames: [String]
    let roomMembers: [TinkieRoomMember]
    let roomLines: [TinkieRoomLine]
}

struct TinkieRoomMember {
    let name: String
    let avatarName: String
    let isOwner: Bool
    let isMuted: Bool
}

struct TinkieRoomLine {
    let speaker: String
    let text: String
}

enum TinkieEventAvailability {
    case open
    case ended
}

struct TinkieEventDetailState {
    let availability: TinkieEventAvailability
    let joinedGroupName: String?
}
