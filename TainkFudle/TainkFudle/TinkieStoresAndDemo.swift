import UIKit

enum TinkiePersonaDirectory {
    static let guest = TinkiePersona(
        nickname: "Login Now",
        uid: "-",
        balance: 0,
        followers: 0,
        following: 0,
        heroImageName: "tinkie_profile_guest_microphone",
        signature: "Open Tinkie to save your song rounds and rhythm moments.",
        moments: []
    )

    static let primary = TinkiePersona(
        nickname: "Jesscia",
        uid: "39400294",
        balance: 9999,
        followers: 245,
        following: 245,
        heroImageName: "tinkie_profile_singer_jesscia",
        signature: "Pop hook hunter · quick chorus guesser · bright party singer",
        moments: [
            TinkieProfileMoment(
                title: "Pop intro warm-up",
                note: "Jesscia caught the chorus before the first lyric landed.",
                coverName: "tinkie_moment_cover_song_clip_a"
            ),
            TinkieProfileMoment(
                title: "Guess the hook round",
                note: "A quick singing clue turned into a perfect answer streak.",
                coverName: "tinkie_moment_cover_song_clip_b"
            )
        ]
    )

    static let virtuals: [String: TinkiePersona] = [
        "Aria": TinkiePersona(
            nickname: "Aria",
            uid: "58120437",
            balance: 860,
            followers: 188,
            following: 74,
            heroImageName: "tinkie_avatar_neon_voice",
            signature: "Neon melody runner with a soft spot for throwback hooks.",
            moments: [
                TinkieProfileMoment(title: "Throwback chorus cue", note: "Aria spotted the classic hook before the room timer blinked.", coverName: "tinkie_event_cover_classic_throwback"),
                TinkieProfileMoment(title: "Neon answer streak", note: "Three rounds, three clean answers, one bright stage mood.", coverName: "tinkie_event_cover_pop_hits")
            ]
        ),
        "Jay": TinkiePersona(
            nickname: "Jay",
            uid: "72049186",
            balance: 740,
            followers: 120,
            following: 33,
            heroImageName: "tinkie_avatar_rhythm_jay",
            signature: "Beat-first listener who loves easy-mode warmups.",
            moments: [
                TinkieProfileMoment(title: "Easy mode warm-up", note: "Jay opened the night with a clean first-beat answer.", coverName: "tinkie_event_cover_friday_pop_hits"),
                TinkieProfileMoment(title: "Rhythm clue sprint", note: "A fast clue round turned into a crowd favorite.", coverName: "tinkie_event_cover_beat_clash")
            ]
        ),
        "Mina": TinkiePersona(
            nickname: "Mina",
            uid: "43687215",
            balance: 520,
            followers: 96,
            following: 58,
            heroImageName: "tinkie_avatar_melody_aria",
            signature: "Soundtrack fan who can name a scene from three notes.",
            moments: [
                TinkieProfileMoment(title: "Three-note reveal", note: "Mina named the title from the shortest clue of the round.", coverName: "tinkie_event_cover_soundtrack_quiz"),
                TinkieProfileMoment(title: "Soft chorus pick", note: "A quiet melody clue became the best answer of the night.", coverName: "tinkie_moment_cover_song_clip_b")
            ]
        ),
        "Theo": TinkiePersona(
            nickname: "Theo",
            uid: "66539028",
            balance: 640,
            followers: 142,
            following: 61,
            heroImageName: "tinkie_avatar_neon_voice",
            signature: "Guitar cue specialist with a fast chorus memory.",
            moments: [
                TinkieProfileMoment(title: "Guitar hook rush", note: "Theo waited for the hook and solved the round cleanly.", coverName: "tinkie_event_cover_pop_hits")
            ]
        ),
        "Rin": TinkiePersona(
            nickname: "Rin",
            uid: "30875124",
            balance: 430,
            followers: 134,
            following: 69,
            heroImageName: "tinkie_avatar_rhythm_jay",
            signature: "K-pop intro sprinter with sharp pitch memory.",
            moments: [
                TinkieProfileMoment(title: "K-pop speed round", note: "Rin caught the title before the chorus arrived.", coverName: "tinkie_event_cover_kpop_hits")
            ]
        ),
        "Nia": TinkiePersona(
            nickname: "Nia",
            uid: "92403681",
            balance: 390,
            followers: 111,
            following: 47,
            heroImageName: "tinkie_avatar_melody_aria",
            signature: "Anime opening fan with a bright refrain radar.",
            moments: [
                TinkieProfileMoment(title: "Opening theme flash", note: "Nia guessed the anime opening from the first synth line.", coverName: "tinkie_event_cover_anime_guessing")
            ]
        ),
        "Herrera": TinkiePersona(
            nickname: "Herrera",
            uid: "81756209",
            balance: 910,
            followers: 176,
            following: 82,
            heroImageName: "tinkie_avatar_neon_voice",
            signature: "Room owner who keeps every song round moving.",
            moments: [
                TinkieProfileMoment(title: "Owner warm-up cue", note: "Herrera kept the first group relaxed and on beat.", coverName: "tinkie_event_cover_friday_pop_hits")
            ]
        ),
        "Ada": TinkiePersona(
            nickname: "Ada",
            uid: "50284319",
            balance: 310,
            followers: 88,
            following: 52,
            heroImageName: "tinkie_avatar_melody_aria",
            signature: "Casual listener who loves quick song hints.",
            moments: [
                TinkieProfileMoment(title: "Casual clue pick", note: "Ada warmed up the group with a relaxed pop answer.", coverName: "tinkie_moment_cover_song_clip_a")
            ]
        ),
        "Bomaly": TinkiePersona(
            nickname: "Bomaly",
            uid: "64921873",
            balance: 280,
            followers: 73,
            following: 41,
            heroImageName: "tinkie_avatar_neon_voice",
            signature: "Relaxed party regular with a good memory for refrains.",
            moments: [
                TinkieProfileMoment(title: "Relaxed refrain call", note: "Bomaly held the room mood steady between rounds.", coverName: "tinkie_event_cover_mystery_mix")
            ]
        ),
        "Luna": TinkiePersona(
            nickname: "Luna",
            uid: "73620495",
            balance: 360,
            followers: 91,
            following: 39,
            heroImageName: "tinkie_avatar_melody_aria",
            signature: "Soft melody guesser with a strong chorus instinct.",
            moments: [
                TinkieProfileMoment(title: "One more beat", note: "Luna waited for a single beat and named the tune.", coverName: "tinkie_event_cover_classic_throwback")
            ]
        ),
        "Nova": TinkiePersona(
            nickname: "Nova",
            uid: "46812057",
            balance: 475,
            followers: 105,
            following: 64,
            heroImageName: "tinkie_avatar_neon_voice",
            signature: "Genre rush regular who likes surprise rounds.",
            moments: [
                TinkieProfileMoment(title: "Mystery mix answer", note: "Nova turned a surprise genre clue into a clean reveal.", coverName: "tinkie_event_cover_mystery_mix")
            ]
        ),
        "Peter": TinkiePersona(
            nickname: "Peter",
            uid: "25194603",
            balance: 260,
            followers: 60,
            following: 37,
            heroImageName: "tinkie_avatar_rhythm_jay",
            signature: "Intro learner who starts with simple rounds.",
            moments: [
                TinkieProfileMoment(title: "First room hello", note: "Peter joined the warm-up and caught the second clue.", coverName: "tinkie_event_cover_friday_pop_hits")
            ]
        ),
        "Sera": TinkiePersona(
            nickname: "Sera",
            uid: "58471620",
            balance: 335,
            followers: 82,
            following: 44,
            heroImageName: "tinkie_avatar_neon_voice",
            signature: "Bright stage fan with quick hook instincts.",
            moments: [
                TinkieProfileMoment(title: "Stage echo clue", note: "Sera found the answer hidden inside the echo.", coverName: "tinkie_event_cover_anime_guessing")
            ]
        ),
        "Kai": TinkiePersona(
            nickname: "Kai",
            uid: "39751026",
            balance: 455,
            followers: 118,
            following: 72,
            heroImageName: "tinkie_profile_singer_jesscia",
            signature: "Chorus clue regular with a calm guessing style.",
            moments: [
                TinkieProfileMoment(title: "Classic chorus call", note: "Kai solved the track as soon as the refrain landed.", coverName: "tinkie_event_cover_classic_throwback")
            ]
        ),
        "Bruno Pham": TinkiePersona(
            nickname: "Bruno Pham",
            uid: "67248019",
            balance: 515,
            followers: 128,
            following: 66,
            heroImageName: "tinkie_avatar_rhythm_jay",
            signature: "Weekend rhythm fan who leaves thoughtful song notes.",
            moments: [
                TinkieProfileMoment(title: "Weekend melody note", note: "Bruno saved a warm comment after a clean rhythm reveal.", coverName: "tinkie_event_cover_soundtrack_quiz")
            ]
        )
    ]

    static func persona(named name: String) -> TinkiePersona {
        if name == primary.nickname { return primary }
        return virtuals[name] ?? TinkiePersona(
            nickname: name,
            uid: String(abs(name.hashValue) % 80000000 + 19000000),
            balance: 300,
            followers: 64,
            following: 36,
            heroImageName: "tinkie_avatar_neon_voice",
            signature: "Song round regular with a playful guessing style.",
            moments: [
                TinkieProfileMoment(title: "Song clue note", note: "\(name) saved a favorite guess from a Tinkie rhythm round.", coverName: "tinkie_event_cover_friday_pop_hits")
            ]
        )
    }

    static func record(named name: String, password: String) -> [String: String] {
        let persona = persona(named: name)
        return [
            "nickname": persona.nickname,
            "uid": persona.uid,
            "balance": "\(persona.balance)",
            "followers": "\(persona.followers)",
            "following": "\(persona.following)",
            "heroImageName": persona.heroImageName,
            "password": password
        ]
    }

    static func snapshot(from record: [String: String], signedIn: Bool) -> TinkieProfileSnapshot {
        let fallback = persona(named: record["nickname"] ?? primary.nickname)
        return TinkieProfileSnapshot(
            isSignedIn: signedIn,
            nickname: record["nickname"] ?? fallback.nickname,
            uid: record["uid"] ?? fallback.uid,
            balance: Int(record["balance"] ?? "") ?? fallback.balance,
            followers: Int(record["followers"] ?? "") ?? fallback.followers,
            following: Int(record["following"] ?? "") ?? fallback.following,
            heroImageName: record["heroImageName"] ?? fallback.heroImageName,
            heroImagePath: record["heroImagePath"],
            moments: fallback.moments
        )
    }

    static func member(named name: String, owner: Bool = false, muted: Bool = false) -> TinkieRoomMember {
        let persona = persona(named: name)
        return TinkieRoomMember(name: persona.nickname, avatarName: persona.heroImageName, isOwner: owner, isMuted: muted)
    }

    static func avatarNames(for names: [String]) -> [String] {
        names.map { persona(named: $0).heroImageName }
    }
}

enum TinkieProfileStore {
    private static let statusKey = "tinkieislogin"
    private static let accountKey = "tinkiecurrentEmail"
    private static let profileKey = "tinkie_profile_records"
    private static let testAccount = "tinkie@gmail.com"

    static var isSignedIn: Bool {
        UserDefaults.standard.bool(forKey: statusKey)
    }

    static func currentSnapshot() -> TinkieProfileSnapshot {
        guard isSignedIn else { return guestSnapshot }
        let account = UserDefaults.standard.string(forKey: accountKey) ?? testAccount
        let record = storedRecords()[account] ?? defaultSignedRecord
        return TinkiePersonaDirectory.snapshot(from: record, signedIn: true)
    }

    static func signOutOnly() {
        UserDefaults.standard.set(false, forKey: statusKey)
    }

    static func spendGems(_ amount: Int) -> Bool {
        guard isSignedIn, amount > 0 else { return false }
        let account = UserDefaults.standard.string(forKey: accountKey) ?? testAccount
        var records = storedRecords()
        var record = records[account] ?? defaultSignedRecord
        let current = Int(record["balance"] ?? "") ?? 0
        guard current >= amount else { return false }
        record["balance"] = "\(current - amount)"
        records[account] = record
        saveRecords(records)
        return true
    }

    static func addGems(_ amount: Int) {
        guard isSignedIn, amount > 0 else { return }
        let account = UserDefaults.standard.string(forKey: accountKey) ?? testAccount
        var records = storedRecords()
        var record = records[account] ?? defaultSignedRecord
        let current = Int(record["balance"] ?? "") ?? 0
        record["balance"] = "\(current + amount)"
        records[account] = record
        saveRecords(records)
    }

    private static var guestSnapshot: TinkieProfileSnapshot {
        let guest = TinkiePersonaDirectory.guest
        return TinkieProfileSnapshot(
            isSignedIn: false,
            nickname: guest.nickname,
            uid: guest.uid,
            balance: guest.balance,
            followers: guest.followers,
            following: guest.following,
            heroImageName: guest.heroImageName,
            heroImagePath: nil,
            moments: guest.moments
        )
    }

    private static var defaultSignedRecord: [String: String] {
        TinkiePersonaDirectory.record(named: "Jesscia", password: "12345678")
    }

    private static func storedRecords() -> [String: [String: String]] {
        guard
            let data = UserDefaults.standard.data(forKey: profileKey),
            let records = try? JSONDecoder().decode([String: [String: String]].self, from: data)
        else {
            return [:]
        }
        return records
    }

    private static func saveRecords(_ records: [String: [String: String]]) {
        guard let data = try? JSONEncoder().encode(records) else { return }
        UserDefaults.standard.set(data, forKey: profileKey)
    }
}

enum TinkieEventDetailStore {
    private static let joinedKey = "tinkie_event_joined_groups"

    static func state(for event: TinkieSongEvent) -> TinkieEventDetailState {
        let closedTitles: Set<String> = ["Anime Song Guessing Party"]
        return TinkieEventDetailState(
            availability: closedTitles.contains(event.title) ? .ended : .open,
            joinedGroupName: joinedGroups()[event.title]
        )
    }

    static func detailGroups(for event: TinkieSongEvent) -> [TinkieEventGroup] {
        if let createdGroups = TinkieSongQuestDraftStore.groups(for: event), !createdGroups.isEmpty {
            return createdGroups
        }
        let firstTags = event.tags.isEmpty ? ["Pop Music", "Casual"] : event.tags
        let firstMembers = [
            TinkiePersonaDirectory.member(named: event.hostName, owner: true),
            TinkiePersonaDirectory.member(named: "Ada"),
            TinkiePersonaDirectory.member(named: "Peter", muted: true),
            TinkiePersonaDirectory.member(named: "Jesscia"),
            TinkiePersonaDirectory.member(named: "Bomaly", muted: true),
            TinkiePersonaDirectory.member(named: "Mina"),
            TinkiePersonaDirectory.member(named: "Rin", muted: true),
            TinkiePersonaDirectory.member(named: "Theo")
        ]
        let secondMembers = [
            TinkiePersonaDirectory.member(named: "Aria", owner: true),
            TinkiePersonaDirectory.member(named: "Nova", muted: true),
            TinkiePersonaDirectory.member(named: "Jay"),
            TinkiePersonaDirectory.member(named: "Luna"),
            TinkiePersonaDirectory.member(named: "Kai", muted: true),
            TinkiePersonaDirectory.member(named: "Sera")
        ]
        return [
            TinkieEventGroup(
                name: "Group A",
                tags: firstTags,
                joinedCount: 12,
                spotsLeft: 8,
                gemNeed: 50,
                avatarNames: firstMembers.map(\.avatarName),
                roomMembers: firstMembers,
                roomLines: [
                    TinkieRoomLine(speaker: "Peter", text: "Hello"),
                    TinkieRoomLine(speaker: "Jesscia", text: "Just joined this room and want to guess the opening hook."),
                    TinkieRoomLine(speaker: "Bomaly", text: "Relaxed in this room, ready for the next song clue.")
                ]
            ),
            TinkieEventGroup(
                name: "Group B",
                tags: ["Rock Music", "Mixed"],
                joinedCount: 9,
                spotsLeft: 11,
                gemNeed: 50,
                avatarNames: secondMembers.map(\.avatarName),
                roomMembers: secondMembers,
                roomLines: [
                    TinkieRoomLine(speaker: "Aria", text: "We are warming up with one guitar intro."),
                    TinkieRoomLine(speaker: "Jay", text: "I think the answer is from a classic chorus."),
                    TinkieRoomLine(speaker: "Luna", text: "Give me one more beat and I can name it.")
                ]
            )
        ]
    }

    static func join(group: TinkieEventGroup, for event: TinkieSongEvent) {
        var groups = joinedGroups()
        groups[event.title] = groupKey(for: event, group: group)
        saveJoinedGroups(groups)
    }

    static func isJoined(_ group: TinkieEventGroup, for event: TinkieSongEvent) -> Bool {
        joinedGroups()[event.title] == groupKey(for: event, group: group)
    }

    static func hasJoinedDifferentGroup(_ group: TinkieEventGroup, for event: TinkieSongEvent) -> Bool {
        guard let joined = joinedGroups()[event.title] else { return false }
        return joined != groupKey(for: event, group: group)
    }

    private static func groupKey(for event: TinkieSongEvent, group: TinkieEventGroup) -> String {
        [event.title, event.dateText, group.name].joined(separator: "::")
    }

    private static func joinedGroups() -> [String: String] {
        guard
            let data = UserDefaults.standard.data(forKey: joinedKey),
            let groups = try? JSONDecoder().decode([String: String].self, from: data)
        else {
            return [:]
        }
        return groups
    }

    private static func saveJoinedGroups(_ groups: [String: String]) {
        guard let data = try? JSONEncoder().encode(groups) else { return }
        UserDefaults.standard.set(data, forKey: joinedKey)
    }
}

struct TinkieSongQuestDraftRecord: Codable {
    let title: String
    let theme: String
    let dayText: String
    let hourText: String
    let genre: String
    let mode: String
    let seatLimit: Int
    let gemNeed: Int
    let groups: [TinkieSongQuestGroupRecord]
    let artPath: String?

    init(
        title: String,
        theme: String,
        dayText: String,
        hourText: String,
        genre: String,
        mode: String,
        seatLimit: Int,
        gemNeed: Int,
        groups: [TinkieSongQuestGroupRecord],
        artPath: String?
    ) {
        self.title = title
        self.theme = theme
        self.dayText = dayText
        self.hourText = hourText
        self.genre = genre
        self.mode = mode
        self.seatLimit = seatLimit
        self.gemNeed = gemNeed
        self.groups = groups
        self.artPath = artPath
    }

    private enum CodingKeys: String, CodingKey {
        case title
        case theme
        case dayText
        case hourText
        case genre
        case mode
        case seatLimit
        case gemNeed
        case groups
        case artPath
    }

    init(from decoder: Decoder) throws {
        let box = try decoder.container(keyedBy: CodingKeys.self)
        title = try box.decode(String.self, forKey: .title)
        theme = try box.decode(String.self, forKey: .theme)
        dayText = try box.decode(String.self, forKey: .dayText)
        hourText = try box.decode(String.self, forKey: .hourText)
        genre = try box.decode(String.self, forKey: .genre)
        mode = try box.decode(String.self, forKey: .mode)
        seatLimit = try box.decode(Int.self, forKey: .seatLimit)
        gemNeed = try box.decode(Int.self, forKey: .gemNeed)
        artPath = try box.decodeIfPresent(String.self, forKey: .artPath)
        groups = try box.decodeIfPresent([TinkieSongQuestGroupRecord].self, forKey: .groups) ?? [
            TinkieSongQuestGroupRecord(name: "Group A", genre: genre, mode: mode, seatLimit: seatLimit, gemNeed: gemNeed)
        ]
    }
}

struct TinkieSongQuestGroupRecord: Codable {
    let name: String
    let genre: String
    let mode: String
    let seatLimit: Int
    let gemNeed: Int
}

enum TinkieSongQuestDraftStore {
    private static let draftKey = "tinkie_songquest_draft_records"

    static func allEvents() -> [TinkieSongEvent] {
        records().map { draft in
            TinkieSongEvent(
                title: draft.title,
                dateText: draft.dayText,
                timeText: draft.hourText,
                subtitle: draft.theme,
                tags: [draft.genre, draft.mode],
                coverName: "tinkie_event_cover_friday_pop_hits",
                coverPath: draft.artPath,
                hostName: TinkieProfileStore.currentSnapshot().nickname,
                avatarNames: TinkiePersonaDirectory.avatarNames(for: [TinkieProfileStore.currentSnapshot().nickname, "Jay", "Mina"]),
                listenerNote: "\(draft.groups.count) groups · \(draft.gemNeed) gems"
            )
        }
    }

    static func groups(for event: TinkieSongEvent) -> [TinkieEventGroup]? {
        guard let draft = records().first(where: { $0.title == event.title && $0.dayText == event.dateText }) else { return nil }
        let avatarSet = TinkiePersonaDirectory.avatarNames(for: ["Jesscia", "Jay", "Mina", "Aria"])
        return draft.groups.enumerated().map { offset, group in
            let joined = min(group.seatLimit, max(1, group.seatLimit - 2 + offset))
            let left = max(0, group.seatLimit - joined)
            let members = [
                TinkiePersonaDirectory.member(named: offset == 0 ? "Jesscia" : "Aria", owner: true),
                TinkiePersonaDirectory.member(named: "Jay"),
                TinkiePersonaDirectory.member(named: "Mina", muted: true),
                TinkiePersonaDirectory.member(named: "Nova")
            ]
            return TinkieEventGroup(
                name: group.name,
                tags: [group.genre, group.mode],
                joinedCount: joined,
                spotsLeft: left,
                gemNeed: group.gemNeed,
                avatarNames: avatarSet,
                roomMembers: members,
                roomLines: [
                    TinkieRoomLine(speaker: "Jay", text: "I can name that intro if the first beat drops clean."),
                    TinkieRoomLine(speaker: "Mina", text: "Saving my guess for the chorus clue."),
                    TinkieRoomLine(speaker: "Nova", text: "This group feels ready for a fast song round.")
                ]
            )
        }
    }

    static func save(_ draft: TinkieSongQuestDraftRecord) {
        var saved = records()
        saved.insert(draft, at: 0)
        guard let data = try? JSONEncoder().encode(saved) else { return }
        UserDefaults.standard.set(data, forKey: draftKey)
    }

    private static func records() -> [TinkieSongQuestDraftRecord] {
        guard
            let data = UserDefaults.standard.data(forKey: draftKey),
            let stored = try? JSONDecoder().decode([TinkieSongQuestDraftRecord].self, from: data)
        else {
            return []
        }
        return stored
    }
}

struct TinkieSongPulsePostRecord: Codable {
    let caption: String
    let coverPath: String?
    let clipPath: String
    let performer: String
    let avatarName: String
}

enum TinkieSongPulsePostStore {
    private static let postKey = "tinkie_songpulse_post_records"

    static func clips() -> [TinkieReelClip] {
        records().map { pulse in
            TinkieReelClip(
                performer: pulse.performer,
                moment: "just now",
                caption: pulse.caption,
                coverName: "tinkie_event_cover_friday_pop_hits",
                coverPath: pulse.coverPath,
                clipFileName: pulse.clipPath,
                avatarName: pulse.avatarName,
                echoCount: "new"
            )
        }
    }

    static func save(_ pulse: TinkieSongPulsePostRecord) {
        var saved = records()
        saved.insert(pulse, at: 0)
        guard let data = try? JSONEncoder().encode(saved) else { return }
        UserDefaults.standard.set(data, forKey: postKey)
    }

    private static func records() -> [TinkieSongPulsePostRecord] {
        guard
            let data = UserDefaults.standard.data(forKey: postKey),
            let saved = try? JSONDecoder().decode([TinkieSongPulsePostRecord].self, from: data)
        else {
            return []
        }
        return saved
    }
}

enum TinkieRhythmBondStore {
    private static let bondKey = "tinkie_rhythm_bond_records"
    private static let sparkKey = "tinkie_rhythm_spark_records"

    static func hasBond(for key: String) -> Bool {
        records(for: bondKey).contains(key)
    }

    static func switchBond(for key: String) -> Bool {
        switchRecord(for: key, storeKey: bondKey)
    }

    static func hasSpark(for key: String) -> Bool {
        records(for: sparkKey).contains(key)
    }

    static func switchSpark(for key: String) -> Bool {
        switchRecord(for: key, storeKey: sparkKey)
    }

    private static func switchRecord(for key: String, storeKey: String) -> Bool {
        var values = Set(records(for: storeKey))
        if values.contains(key) {
            values.remove(key)
            UserDefaults.standard.set(Array(values), forKey: storeKey)
            return false
        }
        values.insert(key)
        UserDefaults.standard.set(Array(values), forKey: storeKey)
        return true
    }

    private static func records(for key: String) -> [String] {
        UserDefaults.standard.stringArray(forKey: key) ?? []
    }
}

enum TinkieDemoLibrary {
    static let events: [TinkieSongEvent] = [
        TinkieSongEvent(
            title: "Friday Pop Hits Challenge",
            dateText: "Jul 18, 2026",
            timeText: "8:00 PM",
            subtitle: "Guess popular songs from their intros and compete with other players to see who knows pop music best.",
            tags: ["Pop Music", "Casual"],
            coverName: "tinkie_event_cover_friday_pop_hits",
            hostName: "Aria",
            avatarNames: TinkiePersonaDirectory.avatarNames(for: ["Aria", "Jay", "Mina"]),
            listenerNote: "intro challenge"
        ),
        TinkieSongEvent(
            title: "Classic Hits Throwback Night",
            dateText: "Jul 19, 2026",
            timeText: "7:30 PM",
            subtitle: "Rediscover iconic songs from different decades and share your favorite musical memories with the group.",
            tags: ["Classic Hits", "Throwback"],
            coverName: "tinkie_event_cover_classic_throwback",
            hostName: "Jay",
            avatarNames: TinkiePersonaDirectory.avatarNames(for: ["Jay", "Luna", "Aria"]),
            listenerNote: "decade rounds"
        ),
        TinkieSongEvent(
            title: "Movie & TV Soundtrack Quiz",
            dateText: "Jul 21, 2026",
            timeText: "9:00 PM",
            subtitle: "Guess songs and titles from popular movies and TV shows, and put your soundtrack knowledge to the test.",
            tags: ["Soundtrack", "Quiz"],
            coverName: "tinkie_event_cover_soundtrack_quiz",
            hostName: "Mina",
            avatarNames: TinkiePersonaDirectory.avatarNames(for: ["Mina", "Nova", "Jay"]),
            listenerNote: "screen themes"
        ),
        TinkieSongEvent(
            title: "K-Pop Hits Challenge",
            dateText: "Jul 23, 2026",
            timeText: "8:30 PM",
            subtitle: "Name popular K-pop songs from short intros and compete for the title of K-pop guessing champion.",
            tags: ["K-Pop", "Hits"],
            coverName: "tinkie_event_cover_kpop_hits",
            hostName: "Rin",
            avatarNames: TinkiePersonaDirectory.avatarNames(for: ["Rin", "Sera", "Jay"]),
            listenerNote: "fast intro round"
        ),
        TinkieSongEvent(
            title: "Anime Song Guessing Party",
            dateText: "Jul 25, 2026",
            timeText: "6:00 PM",
            subtitle: "Test your knowledge of anime openings, endings, and iconic soundtracks with fellow anime music fans.",
            tags: ["Anime", "Openings"],
            coverName: "tinkie_event_cover_anime_guessing",
            hostName: "Nia",
            avatarNames: TinkiePersonaDirectory.avatarNames(for: ["Nia", "Rin", "Mina"]),
            listenerNote: "theme party"
        ),
        TinkieSongEvent(
            title: "Mystery Music Mix Night",
            dateText: "Jul 27, 2026",
            timeText: "8:00 PM",
            subtitle: "Every round features a surprise genre and era, making it the perfect challenge for players with wide-ranging music tastes.",
            tags: ["Mystery Mix", "Genre Rush"],
            coverName: "tinkie_event_cover_mystery_mix",
            hostName: "Theo",
            avatarNames: TinkiePersonaDirectory.avatarNames(for: ["Theo", "Nova", "Ada"]),
            listenerNote: "surprise rounds"
        )
    ]

    static let clips: [TinkieReelClip] = [
        TinkieReelClip(
            performer: "Jay",
            moment: "before two min",
            caption: "Warm-up clip from our game tonight, easy mode only.",
            coverName: "tinkie_event_cover_friday_pop_hits",
            clipFileName: "tinkie_song_room_clip_country_hint.mp4",
            avatarName: TinkiePersonaDirectory.persona(named: "Jay").heroImageName,
            echoCount: "hot"
        ),
        TinkieReelClip(
            performer: "Aria",
            moment: "after first round",
            caption: "That chorus clue landed faster than the beat.",
            coverName: "tinkie_event_cover_classic_throwback",
            clipFileName: "tinkie_song_room_clip_vocal_hook.mp4",
            avatarName: TinkiePersonaDirectory.persona(named: "Aria").heroImageName,
            echoCount: "fresh"
        ),
        TinkieReelClip(
            performer: "Mina",
            moment: "right now",
            caption: "Only three notes, but the whole room knew it.",
            coverName: "tinkie_event_cover_soundtrack_quiz",
            clipFileName: "tinkie_song_room_clip_acoustic_cue.mp4",
            avatarName: TinkiePersonaDirectory.persona(named: "Mina").heroImageName,
            echoCount: "new"
        ),
        TinkieReelClip(
            performer: "Theo",
            moment: "one round ago",
            caption: "The guitar cue fooled half the room until the hook dropped.",
            coverName: "tinkie_event_cover_pop_hits",
            clipFileName: "tinkie_song_room_clip_chorus_guess.mp4",
            avatarName: TinkiePersonaDirectory.persona(named: "Theo").heroImageName,
            echoCount: "pulse"
        ),
        TinkieReelClip(
            performer: "Rin",
            moment: "during sprint",
            caption: "Pitch round went fast, but the final answer was clean.",
            coverName: "tinkie_event_cover_kpop_hits",
            clipFileName: "tinkie_song_room_clip_pitch_round.mp4",
            avatarName: TinkiePersonaDirectory.persona(named: "Rin").heroImageName,
            echoCount: "rush"
        ),
        TinkieReelClip(
            performer: "Nia",
            moment: "after chorus",
            caption: "A bright stage echo turned into a perfect song reveal.",
            coverName: "tinkie_event_cover_anime_guessing",
            clipFileName: "tinkie_song_room_clip_stage_echo.mp4",
            avatarName: TinkiePersonaDirectory.persona(named: "Nia").heroImageName,
            echoCount: "spark"
        )
    ]
}
