import UIKit

extension Notification.Name {
    static let tinkieSongPulseSessionDidShift = Notification.Name("tinkie_song_pulse_session_did_shift")
}

enum TinkiePersonaDirectory {
    static let guest = TrinkieMelodyGuess(
        nickname: "Login Now",
        uid: "-",
        balance: 0,
        followers: 0,
        following: 0,
        heroImageName: "tinkie_profile_guest_microphone",
        signature: "Open Tinkie to save your song rounds and rhythm moments.",
        moments: []
    )

    static let primary = TrinkieMelodyGuess(
        nickname: "Jesscia",
        uid: "39400294",
        balance: 9999,
        followers: 9,
        following: 8,
        heroImageName: "tinkie_profile_singer_jesscia",
        signature: "Pop hook hunter · quick chorus guesser · bright party singer",
        moments: [
            TinkiBeatPulse(
                title: "Pop intro warm-up",
                note: "Jesscia caught the chorus before the first lyric landed.",
                coverName: "tinkie_moment_cover_song_clip_a"
            ),
            TinkiBeatPulse(
                title: "Guess the hook round",
                note: "A quick singing clue turned into a perfect answer streak.",
                coverName: "tinkie_moment_cover_song_clip_b"
            )
        ]
    )

    static let virtuals: [String: TrinkieMelodyGuess] = [
        "Aria": TrinkieMelodyGuess(
            nickname: "Aria",
            uid: "58120437",
            balance: 860,
            followers: 7,
            following: 4,
            heroImageName: "tinkie_avatar_aria_song_spark",
            signature: "Neon melody runner with a soft spot for throwback hooks.",
            moments: [
                TinkiBeatPulse(title: "Throwback chorus cue", note: "Aria spotted the classic hook before the room timer blinked.", coverName: "tinkie_event_cover_classic_throwback"),
                TinkiBeatPulse(title: "Neon answer streak", note: "Three rounds, three clean answers, one bright stage mood.", coverName: "tinkie_event_cover_pop_hits")
            ]
        ),
        "Jay": TrinkieMelodyGuess(
            nickname: "Jay",
            uid: "72049186",
            balance: 740,
            followers: 6,
            following: 3,
            heroImageName: "tinkie_avatar_jay_rhythm_cue",
            signature: "Beat-first listener who loves easy-mode warmups.",
            moments: [
                TinkiBeatPulse(title: "Easy mode warm-up", note: "Jay opened the night with a clean first-beat answer.", coverName: "tinkie_event_cover_friday_pop_hits"),
                TinkiBeatPulse(title: "Rhythm clue sprint", note: "A fast clue round turned into a crowd favorite.", coverName: "tinkie_event_cover_beat_clash")
            ]
        ),
        "Mina": TrinkieMelodyGuess(
            nickname: "Mina",
            uid: "43687215",
            balance: 520,
            followers: 5,
            following: 4,
            heroImageName: "tinkie_avatar_mina_melody_arc",
            signature: "Soundtrack fan who can name a scene from three notes.",
            moments: [
                TinkiBeatPulse(title: "Three-note reveal", note: "Mina named the title from the shortest clue of the round.", coverName: "tinkie_event_cover_soundtrack_quiz"),
                TinkiBeatPulse(title: "Soft chorus pick", note: "A quiet melody clue became the best answer of the night.", coverName: "tinkie_moment_cover_song_clip_b")
            ]
        ),
        "Theo": TrinkieMelodyGuess(
            nickname: "Theo",
            uid: "66539028",
            balance: 640,
            followers: 8,
            following: 3,
            heroImageName: "tinkie_avatar_theo_tempo_trail",
            signature: "Guitar cue specialist with a fast chorus memory.",
            moments: [
                TinkiBeatPulse(title: "Guitar hook rush", note: "Theo waited for the hook and solved the round cleanly.", coverName: "tinkie_event_cover_pop_hits")
            ]
        ),
        "Rin": TrinkieMelodyGuess(
            nickname: "Rin",
            uid: "30875124",
            balance: 430,
            followers: 7,
            following: 5,
            heroImageName: "tinkie_avatar_rin_chorus_glow",
            signature: "K-pop intro sprinter with sharp pitch memory.",
            moments: [
                TinkiBeatPulse(title: "K-pop speed round", note: "Rin caught the title before the chorus arrived.", coverName: "tinkie_event_cover_kpop_hits")
            ]
        ),
        "Nia": TrinkieMelodyGuess(
            nickname: "Nia",
            uid: "92403681",
            balance: 390,
            followers: 6,
            following: 4,
            heroImageName: "tinkie_avatar_nia_pitch_wave",
            signature: "Anime opening fan with a bright refrain radar.",
            moments: [
                TinkiBeatPulse(title: "Opening theme flash", note: "Nia guessed the anime opening from the first synth line.", coverName: "tinkie_event_cover_anime_guessing")
            ]
        ),
        "Herrera": TrinkieMelodyGuess(
            nickname: "Herrera",
            uid: "81756209",
            balance: 910,
            followers: 8,
            following: 5,
            heroImageName: "tinkie_avatar_herrera_song_stage",
            signature: "Room owner who keeps every song round moving.",
            moments: [
                TinkiBeatPulse(title: "Owner warm-up cue", note: "Herrera kept the first group relaxed and on beat.", coverName: "tinkie_event_cover_friday_pop_hits")
            ]
        ),
        "Ada": TrinkieMelodyGuess(
            nickname: "Ada",
            uid: "50284319",
            balance: 310,
            followers: 4,
            following: 3,
            heroImageName: "tinkie_avatar_ada_timbre_pulse",
            signature: "Casual listener who loves quick song hints.",
            moments: [
                TinkiBeatPulse(title: "Casual clue pick", note: "Ada warmed up the group with a relaxed pop answer.", coverName: "tinkie_moment_cover_song_clip_a")
            ]
        ),
        "Bomaly": TrinkieMelodyGuess(
            nickname: "Bomaly",
            uid: "64921873",
            balance: 280,
            followers: 3,
            following: 2,
            heroImageName: "tinkie_avatar_bomaly_verse_flow",
            signature: "Relaxed party regular with a good memory for refrains.",
            moments: [
                TinkiBeatPulse(title: "Relaxed refrain call", note: "Bomaly held the room mood steady between rounds.", coverName: "tinkie_event_cover_mystery_mix")
            ]
        ),
        "Luna": TrinkieMelodyGuess(
            nickname: "Luna",
            uid: "73620495",
            balance: 360,
            followers: 5,
            following: 2,
            heroImageName: "tinkie_avatar_luna_hook_flash",
            signature: "Soft melody guesser with a strong chorus instinct.",
            moments: [
                TinkiBeatPulse(title: "One more beat", note: "Luna waited for a single beat and named the tune.", coverName: "tinkie_event_cover_classic_throwback")
            ]
        ),
        "Nova": TrinkieMelodyGuess(
            nickname: "Nova",
            uid: "46812057",
            balance: 475,
            followers: 6,
            following: 5,
            heroImageName: "tinkie_avatar_nova_bridge_mood",
            signature: "Genre rush regular who likes surprise rounds.",
            moments: [
                TinkiBeatPulse(title: "Mystery mix answer", note: "Nova turned a surprise genre clue into a clean reveal.", coverName: "tinkie_event_cover_mystery_mix")
            ]
        ),
        "Peter": TrinkieMelodyGuess(
            nickname: "Peter",
            uid: "25194603",
            balance: 260,
            followers: 2,
            following: 3,
            heroImageName: "tinkie_avatar_peter_album_dash",
            signature: "Intro learner who starts with simple rounds.",
            moments: [
                TinkiBeatPulse(title: "First room hello", note: "Peter joined the warm-up and caught the second clue.", coverName: "tinkie_event_cover_friday_pop_hits")
            ]
        ),
        "Sera": TrinkieMelodyGuess(
            nickname: "Sera",
            uid: "58471620",
            balance: 335,
            followers: 4,
            following: 3,
            heroImageName: "tinkie_avatar_sera_genre_bloom",
            signature: "Bright stage fan with quick hook instincts.",
            moments: [
                TinkiBeatPulse(title: "Stage echo clue", note: "Sera found the answer hidden inside the echo.", coverName: "tinkie_event_cover_anime_guessing")
            ]
        ),
        "Kai": TrinkieMelodyGuess(
            nickname: "Kai",
            uid: "39751026",
            balance: 455,
            followers: 5,
            following: 4,
            heroImageName: "tinkie_avatar_kai_groove_ray",
            signature: "Chorus clue regular with a calm guessing style.",
            moments: [
                TinkiBeatPulse(title: "Classic chorus call", note: "Kai solved the track as soon as the refrain landed.", coverName: "tinkie_event_cover_classic_throwback")
            ]
        ),
        "Bruno Pham": TrinkieMelodyGuess(
            nickname: "Bruno Pham",
            uid: "67248019",
            balance: 515,
            followers: 6,
            following: 4,
            heroImageName: "tinkie_avatar_bruno_bass_rise",
            signature: "Weekend rhythm fan who leaves thoughtful song notes.",
            moments: [
                TinkiBeatPulse(title: "Weekend melody note", note: "Bruno saved a warm comment after a clean rhythm reveal.", coverName: "tinkie_event_cover_soundtrack_quiz")
            ]
        )
    ]

    static let followingNames = ["Aria", "Jay", "Mina", "Theo", "Rin", "Nia", "Herrera", "Ada"]
    static let followerNames = ["Bomaly", "Luna", "Nova", "Peter", "Sera", "Kai", "Bruno Pham", "Aria", "Mina"]

    static func persona(named name: String) -> TrinkieMelodyGuess {
        if name == primary.nickname { return primary }
        return virtuals[name] ?? TrinkieMelodyGuess(
            nickname: name,
            uid: String(abs(name.hashValue) % 80000000 + 19000000),
            balance: 300,
            followers: 3,
            following: 2,
            heroImageName: "tinkie_avatar_neon_voice",
            signature: "Song round regular with a playful guessing style.",
            moments: [
                TinkiBeatPulse(title: "Song clue note", note: "\(name) saved a favorite guess from a Tinkie rhythm round.", coverName: "tinkie_event_cover_friday_pop_hits")
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
            "signature": persona.signature,
            "password": password
        ]
    }

    static func snapshot(from record: [String: String], signedIn: Bool) -> TinkieMelodyScoreot {
        let fallback = persona(named: record["nickname"] ?? primary.nickname)
        let nickname = record["nickname"] ?? fallback.nickname
        let shouldShowSeededMoments = record["momentSeedMode"] != "empty"
        let pulseMoments = shouldShowSeededMoments ? TinkieSongPulsePostStore.profileMoments(for: nickname) : []
        let fallbackMoments = shouldShowSeededMoments ? fallback.moments : []
        return TinkieMelodyScoreot(
            isSignedIn: signedIn,
            nickname: nickname,
            uid: record["uid"] ?? fallback.uid,
            balance: Int(record["balance"] ?? "") ?? fallback.balance,
            followers: Int(record["followers"] ?? "") ?? fallback.followers,
            following: Int(record["following"] ?? "") ?? fallback.following,
            heroImageName: record["heroImageName"] ?? fallback.heroImageName,
            heroImagePath: record["heroImagePath"],
            signature: record["signature"] ?? fallback.signature,
            moments: pulseMoments + fallbackMoments
        )
    }

    static func zeroedTestRecord(password: String) -> [String: String] {
        [
            "nickname": primary.nickname,
            "uid": primary.uid,
            "balance": "0",
            "followers": "0",
            "following": "0",
            "heroImageName": primary.heroImageName,
            "signature": primary.signature,
            "momentSeedMode": "empty",
            "password": password
        ]
    }

    static func completedRecord(from record: [String: String], nickname: String? = nil, password: String? = nil) -> [String: String] {
        let fallback = persona(named: nickname ?? record["nickname"] ?? primary.nickname)
        var completed = record
        completed["nickname"] = completed["nickname"] ?? fallback.nickname
        completed["uid"] = completed["uid"] ?? fallback.uid
        completed["balance"] = completed["balance"] ?? "\(fallback.balance)"
        completed["followers"] = completed["followers"] ?? "\(fallback.followers)"
        completed["following"] = completed["following"] ?? "\(fallback.following)"
        completed["heroImageName"] = completed["heroImageName"] ?? fallback.heroImageName
        completed["signature"] = completed["signature"] ?? fallback.signature
        completed["momentSeedMode"] = completed["momentSeedMode"] ?? record["momentSeedMode"]
        if let password {
            completed["password"] = completed["password"] ?? password
        }
        return completed
    }

    static func member(named name: String, owner: Bool = false, muted: Bool = false) -> TinkieMelodyCue {
        let persona = persona(named: name)
        let snapshot = TinkieProfileStore.currentSnapshot()
        let matchedPath = snapshot.isSignedIn && snapshot.nickname == persona.nickname ? snapshot.heroImagePath : nil
        return TinkieMelodyCue(name: persona.nickname, avatarName: persona.heroImageName, avatarPath: matchedPath, isOwner: owner, isMuted: muted)
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

    static func currentSnapshot() -> TinkieMelodyScoreot {
        guard isSignedIn else { return guestSnapshot }
        let account = UserDefaults.standard.string(forKey: accountKey) ?? testAccount
        var records = storedRecords()
        let record = TinkiePersonaDirectory.completedRecord(
            from: records[account] ?? defaultSignedRecord,
            nickname: records[account]?["nickname"],
            password: records[account]?["password"]
        )
        if records[account] != record {
            records[account] = record
            saveRecords(records)
        }
        return TinkiePersonaDirectory.snapshot(from: record, signedIn: true)
    }

    static func signOutOnly() {
        UserDefaults.standard.set(false, forKey: statusKey)
        NotificationCenter.default.post(name: .tinkieSongPulseSessionDidShift, object: nil)
    }

    static func removeCurrentProfileAndSignOut() {
        let account = UserDefaults.standard.string(forKey: accountKey) ?? testAccount
        var records = storedRecords()
        records.removeValue(forKey: account)
        saveRecords(records)
        UserDefaults.standard.set(false, forKey: statusKey)
        UserDefaults.standard.removeObject(forKey: accountKey)
        NotificationCenter.default.post(name: .tinkieSongPulseSessionDidShift, object: nil)
    }

    static func updateCurrentProfile(nickname: String, signature: String) -> Bool {
        guard isSignedIn else { return false }
        let trimmedName = nickname.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedSignature = signature.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return false }
        let account = UserDefaults.standard.string(forKey: accountKey) ?? testAccount
        var records = storedRecords()
        var record = TinkiePersonaDirectory.completedRecord(from: records[account] ?? defaultSignedRecord)
        record["nickname"] = trimmedName
        record["signature"] = trimmedSignature.isEmpty ? "Song round regular with a playful guessing style." : trimmedSignature
        records[account] = record
        saveRecords(records)
        return true
    }

    static func spendGems(_ amount: Int) -> Bool {
        guard isSignedIn, amount > 0 else { return false }
        let account = UserDefaults.standard.string(forKey: accountKey) ?? testAccount
        var records = storedRecords()
        var record = TinkiePersonaDirectory.completedRecord(from: records[account] ?? defaultSignedRecord)
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
        var record = TinkiePersonaDirectory.completedRecord(from: records[account] ?? defaultSignedRecord)
        let current = Int(record["balance"] ?? "") ?? 0
        record["balance"] = "\(current + amount)"
        records[account] = record
        saveRecords(records)
    }

    private static var guestSnapshot: TinkieMelodyScoreot {
        let guest = TinkiePersonaDirectory.guest
        return TinkieMelodyScoreot(
            isSignedIn: false,
            nickname: guest.nickname,
            uid: guest.uid,
            balance: guest.balance,
            followers: guest.followers,
            following: guest.following,
            heroImageName: guest.heroImageName,
            heroImagePath: nil,
            signature: guest.signature,
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

    static func state(for event: TinkieLyricFlow) -> tinkieHookRadar {
        let closedTitles: Set<String> = ["Anime Song Guessing Party"]
        return tinkieHookRadar(
            availability: closedTitles.contains(event.title) ? .ended : .open,
            joinedGroupName: joinedGroups()[event.title]
        )
    }

    static func detailGroups(for event: TinkieLyricFlow) -> [TinkieMelodyQuest] {
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
            TinkieMelodyQuest(
                name: "Group A",
                tags: firstTags,
                joinedCount: 12,
                spotsLeft: 8,
                gemNeed: 50,
                avatarNames: firstMembers.map(\.avatarName),
                roomMembers: firstMembers,
                roomLines: [
                    tinkieMelodyArc(speaker: "Peter", text: "Hello"),
                    tinkieMelodyArc(speaker: "Jesscia", text: "Just joined this room and want to guess the opening hook."),
                    tinkieMelodyArc(speaker: "Bomaly", text: "Relaxed in this room, ready for the next song clue.")
                ]
            ),
            TinkieMelodyQuest(
                name: "Group B",
                tags: ["Rock Music", "Mixed"],
                joinedCount: 9,
                spotsLeft: 11,
                gemNeed: 50,
                avatarNames: secondMembers.map(\.avatarName),
                roomMembers: secondMembers,
                roomLines: [
                    tinkieMelodyArc(speaker: "Aria", text: "We are warming up with one guitar intro."),
                    tinkieMelodyArc(speaker: "Jay", text: "I think the answer is from a classic chorus."),
                    tinkieMelodyArc(speaker: "Luna", text: "Give me one more beat and I can name it.")
                ]
            )
        ]
    }

    static func join(group: TinkieMelodyQuest, for event: TinkieLyricFlow) {
        var groups = joinedGroups()
        groups[event.title] = groupKey(for: event, group: group)
        saveJoinedGroups(groups)
    }

    static func isJoined(_ group: TinkieMelodyQuest, for event: TinkieLyricFlow) -> Bool {
        joinedGroups()[event.title] == groupKey(for: event, group: group)
    }

    static func hasJoinedDifferentGroup(_ group: TinkieMelodyQuest, for event: TinkieLyricFlow) -> Bool {
        guard let joined = joinedGroups()[event.title] else { return false }
        return joined != groupKey(for: event, group: group)
    }

    private static func groupKey(for event: TinkieLyricFlow, group: TinkieMelodyQuest) -> String {
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

    static func allEvents() -> [TinkieLyricFlow] {
        records().map { draft in
            TinkieLyricFlow(
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

    static func groups(for event: TinkieLyricFlow) -> [TinkieMelodyQuest]? {
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
            return TinkieMelodyQuest(
                name: group.name,
                tags: [group.genre, group.mode],
                joinedCount: joined,
                spotsLeft: left,
                gemNeed: group.gemNeed,
                avatarNames: avatarSet,
                roomMembers: members,
                roomLines: [
                    tinkieMelodyArc(speaker: "Jay", text: "I can name that intro if the first beat drops clean."),
                    tinkieMelodyArc(speaker: "Mina", text: "Saving my guess for the chorus clue."),
                    tinkieMelodyArc(speaker: "Nova", text: "This group feels ready for a fast song round.")
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
    let avatarPath: String?
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
                avatarPath: pulse.avatarPath,
                echoCount: "new"
            )
        }
    }

    static func profileMoments(for performer: String) -> [TinkiBeatPulse] {
        records()
            .filter { $0.performer == performer }
            .map {
                TinkiBeatPulse(
                    title: "Fresh song round",
                    note: $0.caption,
                    coverName: "tinkie_event_cover_friday_pop_hits",
                    coverPath: $0.coverPath
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
    static let events: [TinkieLyricFlow] = [
        TinkieLyricFlow(
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
        TinkieLyricFlow(
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
        TinkieLyricFlow(
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
        TinkieLyricFlow(
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
        TinkieLyricFlow(
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
        TinkieLyricFlow(
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

    static func pulseClips(for performer: String) -> [TinkieReelClip] {
        let local = TinkieSongPulsePostStore.clips().filter { $0.performer == performer }
        let seeded = clips.filter { $0.performer == performer }
        return local + seeded
    }

    static func joinedEvents(for performer: String) -> [TinkieLyricFlow] {
        let authored = TinkieSongQuestDraftStore.allEvents().filter { $0.hostName == performer }
        let seeded = events.filter { event in
            event.hostName == performer || event.avatarNames.contains(TinkiePersonaDirectory.persona(named: performer).heroImageName)
        }
        let linked = authored + seeded
        if !linked.isEmpty { return Array(linked.prefix(2)) }
        guard !events.isEmpty else { return [] }
        let offset = abs(performer.hashValue % events.count)
        return [events[offset]]
    }
}
