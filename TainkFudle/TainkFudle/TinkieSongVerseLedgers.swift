import UIKit

extension Notification.Name {
    static let tinkieSongPulseSessionDidShift = Notification.Name("tinkie_song_pulse_session_did_shift")
}

enum TinkieSingerTuneAtlas {
    static let guest = TinkieSingerTuneCard(
        nickname: "Login Now",
        uid: "-",
        balance: 0,
        followers: 0,
        following: 0,
        heroImageName: "tinkie_profile_guest_microphone",
        signature: "Open Tinkie to save your song rounds and rhythm moments.",
        moments: []
    )

    static let primary = TinkieSingerTuneCard(
        nickname: "Jesscia",
        uid: "39400294",
        balance: 9999,
        followers: 9,
        following: 8,
        heroImageName: "tinkie_profile_singer_jesscia",
        signature: "Pop hook hunter · quick chorus guesser · bright party singer",
        moments: [
            TinkieSongPulseEcho(
                title: "Pop intro warm-up",
                note: "Jesscia caught the chorus before the first lyric landed.",
                coverName: "tinkie_moment_cover_song_clip_a"
            ),
            TinkieSongPulseEcho(
                title: "Guess the hook round",
                note: "A quick singing clue turned into a perfect answer streak.",
                coverName: "tinkie_moment_cover_song_clip_b"
            )
        ]
    )

    static let virtuals: [String: TinkieSingerTuneCard] = [
        "Aria": TinkieSingerTuneCard(
            nickname: "Aria",
            uid: "58120437",
            balance: 860,
            followers: 7,
            following: 4,
            heroImageName: "tinkie_avatar_aria_song_spark",
            signature: "Neon melody runner with a soft spot for throwback hooks.",
            moments: [
                TinkieSongPulseEcho(title: "Throwback chorus cue", note: "Aria spotted the classic hook before the room timer blinked.", coverName: "tinkie_event_cover_classic_throwback"),
                TinkieSongPulseEcho(title: "Neon answer streak", note: "Three rounds, three clean answers, one bright stage mood.", coverName: "tinkie_event_cover_pop_hits")
            ]
        ),
        "Jay": TinkieSingerTuneCard(
            nickname: "Jay",
            uid: "72049186",
            balance: 740,
            followers: 6,
            following: 3,
            heroImageName: "tinkie_avatar_jay_rhythm_cue",
            signature: "Beat-first listener who loves easy-mode warmups.",
            moments: [
                TinkieSongPulseEcho(title: "Easy mode warm-up", note: "Jay opened the night with a clean first-beat answer.", coverName: "tinkie_event_cover_friday_pop_hits"),
                TinkieSongPulseEcho(title: "Rhythm clue sprint", note: "A fast clue round turned into a crowd favorite.", coverName: "tinkie_event_cover_beat_clash")
            ]
        ),
        "Mina": TinkieSingerTuneCard(
            nickname: "Mina",
            uid: "43687215",
            balance: 520,
            followers: 5,
            following: 4,
            heroImageName: "tinkie_avatar_mina_melody_arc",
            signature: "Soundtrack fan who can name a scene from three notes.",
            moments: [
                TinkieSongPulseEcho(title: "Three-note reveal", note: "Mina named the title from the shortest clue of the round.", coverName: "tinkie_event_cover_soundtrack_quiz"),
                TinkieSongPulseEcho(title: "Soft chorus pick", note: "A quiet melody clue became the best answer of the night.", coverName: "tinkie_moment_cover_song_clip_b")
            ]
        ),
        "Theo": TinkieSingerTuneCard(
            nickname: "Theo",
            uid: "66539028",
            balance: 640,
            followers: 8,
            following: 3,
            heroImageName: "tinkie_avatar_theo_tempo_trail",
            signature: "Guitar cue specialist with a fast chorus memory.",
            moments: [
                TinkieSongPulseEcho(title: "Guitar hook rush", note: "Theo waited for the hook and solved the round cleanly.", coverName: "tinkie_event_cover_pop_hits")
            ]
        ),
        "Rin": TinkieSingerTuneCard(
            nickname: "Rin",
            uid: "30875124",
            balance: 430,
            followers: 7,
            following: 5,
            heroImageName: "tinkie_avatar_rin_chorus_glow",
            signature: "K-pop intro sprinter with sharp pitch memory.",
            moments: [
                TinkieSongPulseEcho(title: "K-pop speed round", note: "Rin caught the title before the chorus arrived.", coverName: "tinkie_event_cover_kpop_hits")
            ]
        ),
        "Nia": TinkieSingerTuneCard(
            nickname: "Nia",
            uid: "92403681",
            balance: 390,
            followers: 6,
            following: 4,
            heroImageName: "tinkie_avatar_nia_pitch_wave",
            signature: "Anime opening fan with a bright refrain radar.",
            moments: [
                TinkieSongPulseEcho(title: "Opening theme flash", note: "Nia guessed the anime opening from the first synth line.", coverName: "tinkie_event_cover_anime_guessing")
            ]
        ),
        "Herrera": TinkieSingerTuneCard(
            nickname: "Herrera",
            uid: "81756209",
            balance: 910,
            followers: 8,
            following: 5,
            heroImageName: "tinkie_avatar_herrera_song_stage",
            signature: "Room owner who keeps every song round moving.",
            moments: [
                TinkieSongPulseEcho(title: "Owner warm-up cue", note: "Herrera kept the first group relaxed and on beat.", coverName: "tinkie_event_cover_friday_pop_hits")
            ]
        ),
        "Ada": TinkieSingerTuneCard(
            nickname: "Ada",
            uid: "50284319",
            balance: 310,
            followers: 4,
            following: 3,
            heroImageName: "tinkie_avatar_ada_timbre_pulse",
            signature: "Casual listener who loves quick song hints.",
            moments: [
                TinkieSongPulseEcho(title: "Casual clue pick", note: "Ada warmed up the group with a relaxed pop answer.", coverName: "tinkie_moment_cover_song_clip_a")
            ]
        ),
        "Bomaly": TinkieSingerTuneCard(
            nickname: "Bomaly",
            uid: "64921873",
            balance: 280,
            followers: 3,
            following: 2,
            heroImageName: "tinkie_avatar_bomaly_verse_flow",
            signature: "Relaxed party regular with a good memory for refrains.",
            moments: [
                TinkieSongPulseEcho(title: "Relaxed refrain call", note: "Bomaly held the room mood steady between rounds.", coverName: "tinkie_event_cover_mystery_mix")
            ]
        ),
        "Luna": TinkieSingerTuneCard(
            nickname: "Luna",
            uid: "73620495",
            balance: 360,
            followers: 5,
            following: 2,
            heroImageName: "tinkie_avatar_luna_hook_flash",
            signature: "Soft melody guesser with a strong chorus instinct.",
            moments: [
                TinkieSongPulseEcho(title: "One more beat", note: "Luna waited for a single beat and named the tune.", coverName: "tinkie_event_cover_classic_throwback")
            ]
        ),
        "Nova": TinkieSingerTuneCard(
            nickname: "Nova",
            uid: "46812057",
            balance: 475,
            followers: 6,
            following: 5,
            heroImageName: "tinkie_avatar_nova_bridge_mood",
            signature: "Genre rush regular who likes surprise rounds.",
            moments: [
                TinkieSongPulseEcho(title: "Mystery mix answer", note: "Nova turned a surprise genre clue into a clean reveal.", coverName: "tinkie_event_cover_mystery_mix")
            ]
        ),
        "Peter": TinkieSingerTuneCard(
            nickname: "Peter",
            uid: "25194603",
            balance: 260,
            followers: 2,
            following: 3,
            heroImageName: "tinkie_avatar_peter_album_dash",
            signature: "Intro learner who starts with simple rounds.",
            moments: [
                TinkieSongPulseEcho(title: "First room hello", note: "Peter joined the warm-up and caught the second clue.", coverName: "tinkie_event_cover_friday_pop_hits")
            ]
        ),
        "Sera": TinkieSingerTuneCard(
            nickname: "Sera",
            uid: "58471620",
            balance: 335,
            followers: 4,
            following: 3,
            heroImageName: "tinkie_avatar_sera_genre_bloom",
            signature: "Bright stage fan with quick hook instincts.",
            moments: [
                TinkieSongPulseEcho(title: "Stage echo clue", note: "Sera found the answer hidden inside the echo.", coverName: "tinkie_event_cover_anime_guessing")
            ]
        ),
        "Kai": TinkieSingerTuneCard(
            nickname: "Kai",
            uid: "39751026",
            balance: 455,
            followers: 5,
            following: 4,
            heroImageName: "tinkie_avatar_kai_groove_ray",
            signature: "Chorus clue regular with a calm guessing style.",
            moments: [
                TinkieSongPulseEcho(title: "Classic chorus call", note: "Kai solved the track as soon as the refrain landed.", coverName: "tinkie_event_cover_classic_throwback")
            ]
        ),
        "Bruno Pham": TinkieSingerTuneCard(
            nickname: "Bruno Pham",
            uid: "67248019",
            balance: 515,
            followers: 6,
            following: 4,
            heroImageName: "tinkie_avatar_bruno_bass_rise",
            signature: "Weekend rhythm fan who leaves thoughtful song notes.",
            moments: [
                TinkieSongPulseEcho(title: "Weekend melody note", note: "Bruno saved a warm comment after a clean rhythm reveal.", coverName: "tinkie_event_cover_soundtrack_quiz")
            ]
        )
    ]

    static var followingTuneNames: [String] {
        TinkieRhythmBondScorebook.bondedSingerNames()
    }

    static var followerTuneNames: [String] {
        []
    }

    static func singerTuneCard(named name: String) -> TinkieSingerTuneCard {
        if name == primary.nickname { return primary }
        return virtuals[name] ?? TinkieSingerTuneCard(
            nickname: name,
            uid: String(abs(name.hashValue) % 80000000 + 19000000),
            balance: 300,
            followers: 3,
            following: 2,
            heroImageName: "tinkie_avatar_neon_voice",
            signature: "Song round regular with a playful guessing style.",
            moments: [
                TinkieSongPulseEcho(title: "Song clue note", note: "\(name) saved a favorite guess from a Tinkie rhythm round.", coverName: "tinkie_event_cover_friday_pop_hits")
            ]
        )
    }

    static func singerTuneRecord(named name: String, password: String) -> [String: String] {
        let singerTuneCard = singerTuneCard(named: name)
        return [
            "nickname": singerTuneCard.nickname,
            "uid": singerTuneCard.uid,
            "balance": "\(singerTuneCard.balance)",
            "followers": "\(singerTuneCard.followers)",
            "following": "\(singerTuneCard.following)",
            "heroImageName": singerTuneCard.heroImageName,
            "signature": singerTuneCard.signature,
            "password": password
        ]
    }

    static func stageSnapshot(from singerTuneRecord: [String: String], signedIn: Bool) -> TinkieSingerSnapshot {
        let fallbackTuneCard = singerTuneCard(named: singerTuneRecord["nickname"] ?? primary.nickname)
        let nickname = singerTuneRecord["nickname"] ?? fallbackTuneCard.nickname
        let shouldShowSeededMoments = singerTuneRecord["momentSeedMode"] != "empty"
        let pulseEchoes = shouldShowSeededMoments ? TinkiePulseSparkScorebook.pulseEchoTunes(for: nickname) : []
        let fallbackEchoes = shouldShowSeededMoments ? fallbackTuneCard.moments : []
        return TinkieSingerSnapshot(
            isSingerOnStage: signedIn,
            nickname: nickname,
            uid: singerTuneRecord["uid"] ?? fallbackTuneCard.uid,
            balance: Int(singerTuneRecord["balance"] ?? "") ?? fallbackTuneCard.balance,
            followers: followerTuneNames.count,
            following: followingTuneNames.count,
            heroImageName: singerTuneRecord["heroImageName"] ?? fallbackTuneCard.heroImageName,
            heroImagePath: singerTuneRecord["heroImagePath"],
            signature: singerTuneRecord["signature"] ?? fallbackTuneCard.signature,
            moments: pulseEchoes + fallbackEchoes
        )
    }

    static func zeroedTestSingerTuneCard(password: String) -> [String: String] {
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

    static func completedSingerTuneCard(from singerTuneRecord: [String: String], nickname: String? = nil, password: String? = nil) -> [String: String] {
        let fallbackTuneCard = singerTuneCard(named: nickname ?? singerTuneRecord["nickname"] ?? primary.nickname)
        var completed = singerTuneRecord
        completed["nickname"] = completed["nickname"] ?? fallbackTuneCard.nickname
        completed["uid"] = completed["uid"] ?? fallbackTuneCard.uid
        completed["balance"] = completed["balance"] ?? "\(fallbackTuneCard.balance)"
        completed["followers"] = "\(followerTuneNames.count)"
        completed["following"] = "\(followingTuneNames.count)"
        completed["heroImageName"] = completed["heroImageName"] ?? fallbackTuneCard.heroImageName
        completed["signature"] = completed["signature"] ?? fallbackTuneCard.signature
        completed["momentSeedMode"] = completed["momentSeedMode"] ?? singerTuneRecord["momentSeedMode"]
        if let password {
            completed["password"] = completed["password"] ?? password
        }
        return completed
    }

    static func rhythmSingerSeat(named name: String, owner: Bool = false, muted: Bool = false) -> TinkieRhythmSingerSeat {
        let singerTuneCard = singerTuneCard(named: name)
        let snapshot = TinkieSingerStageScorebook.currentSingerStage()
        let matchedPath = snapshot.isSingerOnStage && snapshot.nickname == singerTuneCard.nickname ? snapshot.heroImagePath : nil
        return TinkieRhythmSingerSeat(name: singerTuneCard.nickname, avatarName: singerTuneCard.heroImageName, avatarPath: matchedPath, isOwner: owner, isMuted: muted)
    }

    static func avatarTuneNames(for names: [String]) -> [String] {
        names.map { singerTuneCard(named: $0).heroImageName }
    }
}

enum TinkieSingerStageScorebook {
    private static let statusKey = "tinkieislogin"
    private static let accountKey = "tinkiecurrentEmail"
    private static let profileKey = "tinkie_profile_records"
    private static let testAccount = "tinkie@gmail.com"

    static var isSingerOnStage: Bool {
        UserDefaults.standard.bool(forKey: statusKey)
    }

    static func currentSingerStage() -> TinkieSingerSnapshot {
        guard isSingerOnStage else { return guestSnapshot }
        let account = UserDefaults.standard.string(forKey: accountKey) ?? testAccount
        var records = loadSingerTuneCards()
        let record = TinkieSingerTuneAtlas.completedSingerTuneCard(
            from: records[account] ?? defaultSingerCard,
            nickname: records[account]?["nickname"],
            password: records[account]?["password"]
        )
        if records[account] != record {
            records[account] = record
            saveSingerCards(records)
        }
        return TinkieSingerTuneAtlas.stageSnapshot(from: record, signedIn: true)
    }

    static func dimSingerStageOnly() {
        UserDefaults.standard.set(false, forKey: statusKey)
        NotificationCenter.default.post(name: .tinkieSongPulseSessionDidShift, object: nil)
    }

    static func eraseCurrentSingerAndDimStage() {
        let account = UserDefaults.standard.string(forKey: accountKey) ?? testAccount
        var records = loadSingerTuneCards()
        records.removeValue(forKey: account)
        saveSingerCards(records)
        UserDefaults.standard.set(false, forKey: statusKey)
        UserDefaults.standard.removeObject(forKey: accountKey)
        NotificationCenter.default.post(name: .tinkieSongPulseSessionDidShift, object: nil)
    }

    static func retuneCurrentSinger(nickname: String, signature: String, heroImagePath: String? = nil) -> Bool {
        guard isSingerOnStage else { return false }
        let trimmedName = nickname.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedSignature = signature.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return false }
        let account = UserDefaults.standard.string(forKey: accountKey) ?? testAccount
        var records = loadSingerTuneCards()
        var record = TinkieSingerTuneAtlas.completedSingerTuneCard(from: records[account] ?? defaultSingerCard)
        record["nickname"] = trimmedName
        record["signature"] = trimmedSignature.isEmpty ? "Song round regular with a playful guessing style." : trimmedSignature
        if let heroImagePath, !heroImagePath.isEmpty {
            record["heroImagePath"] = heroImagePath
        }
        records[account] = record
        saveSingerCards(records)
        return true
    }

    static func spendGemRhythm(_ amount: Int) -> Bool {
        guard isSingerOnStage, amount > 0 else { return false }
        let account = UserDefaults.standard.string(forKey: accountKey) ?? testAccount
        var records = loadSingerTuneCards()
        var record = TinkieSingerTuneAtlas.completedSingerTuneCard(from: records[account] ?? defaultSingerCard)
        let current = Int(record["balance"] ?? "") ?? 0
        guard current >= amount else { return false }
        record["balance"] = "\(current - amount)"
        records[account] = record
        saveSingerCards(records)
        return true
    }

    static func addGemRhythm(_ amount: Int) {
        guard isSingerOnStage, amount > 0 else { return }
        let account = UserDefaults.standard.string(forKey: accountKey) ?? testAccount
        var records = loadSingerTuneCards()
        var record = TinkieSingerTuneAtlas.completedSingerTuneCard(from: records[account] ?? defaultSingerCard)
        let current = Int(record["balance"] ?? "") ?? 0
        record["balance"] = "\(current + amount)"
        records[account] = record
        saveSingerCards(records)
    }

    private static var guestSnapshot: TinkieSingerSnapshot {
        let guest = TinkieSingerTuneAtlas.guest
        return TinkieSingerSnapshot(
            isSingerOnStage: false,
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

    private static var defaultSingerCard: [String: String] {
        TinkieSingerTuneAtlas.singerTuneRecord(named: "Jesscia", password: "12345678")
    }

    private static func loadSingerTuneCards() -> [String: [String: String]] {
        guard
            let data = UserDefaults.standard.data(forKey: profileKey),
            let records = try? JSONDecoder().decode([String: [String: String]].self, from: data)
        else {
            return [:]
        }
        return records
    }

    private static func saveSingerCards(_ records: [String: [String: String]]) {
        guard let data = try? JSONEncoder().encode(records) else { return }
        UserDefaults.standard.set(data, forKey: profileKey)
    }
}

enum TinkieQuestEntryScorebook {
    private static let joinedKey = "tinkie_event_joined_groups"

    static func entryState(for event: TinkieSongQuestTune) -> TinkieQuestEntryState {
        let closedTitles: Set<String> = ["Anime Song Guessing Party"]
        return TinkieQuestEntryState(
            availability: closedTitles.contains(event.title) ? .ended : .open,
            joinedGroupName: joinedChordMap()[event.title]
        )
    }

    static func detailChords(for event: TinkieSongQuestTune) -> [TinkieSongQuestChord] {
        if let createdGroups = TinkieQuestForgeScorebook.forgedChords(for: event), !createdGroups.isEmpty {
            return createdGroups
        }
        let firstTags = event.tags.isEmpty ? ["Pop Music", "Casual"] : event.tags
        let firstRhythmSeats = [
            TinkieSingerTuneAtlas.rhythmSingerSeat(named: event.hostName, owner: true),
            TinkieSingerTuneAtlas.rhythmSingerSeat(named: "Ada"),
            TinkieSingerTuneAtlas.rhythmSingerSeat(named: "Peter", muted: true),
            TinkieSingerTuneAtlas.rhythmSingerSeat(named: "Jesscia"),
            TinkieSingerTuneAtlas.rhythmSingerSeat(named: "Bomaly", muted: true),
            TinkieSingerTuneAtlas.rhythmSingerSeat(named: "Mina"),
            TinkieSingerTuneAtlas.rhythmSingerSeat(named: "Rin", muted: true),
            TinkieSingerTuneAtlas.rhythmSingerSeat(named: "Theo")
        ]
        let secondRhythmSeats = [
            TinkieSingerTuneAtlas.rhythmSingerSeat(named: "Aria", owner: true),
            TinkieSingerTuneAtlas.rhythmSingerSeat(named: "Nova", muted: true),
            TinkieSingerTuneAtlas.rhythmSingerSeat(named: "Jay"),
            TinkieSingerTuneAtlas.rhythmSingerSeat(named: "Luna"),
            TinkieSingerTuneAtlas.rhythmSingerSeat(named: "Kai", muted: true),
            TinkieSingerTuneAtlas.rhythmSingerSeat(named: "Sera")
        ]
        return [
            TinkieSongQuestChord(
                name: "Group A",
                tags: firstTags,
                joinedCount: 12,
                spotsLeft: 8,
                gemNeed: 50,
                avatarNames: firstRhythmSeats.map(\.avatarName),
                rhythmSeats: firstRhythmSeats,
                rhythmCueLines: [
                    TinkieRhythmCueLine(speaker: "Peter", text: "Hello"),
                    TinkieRhythmCueLine(speaker: "Jesscia", text: "Just joined this room and want to guess the opening hook."),
                    TinkieRhythmCueLine(speaker: "Bomaly", text: "Relaxed in this room, ready for the next song clue.")
                ]
            ),
            TinkieSongQuestChord(
                name: "Group B",
                tags: ["Rock Music", "Mixed"],
                joinedCount: 9,
                spotsLeft: 11,
                gemNeed: 50,
                avatarNames: secondRhythmSeats.map(\.avatarName),
                rhythmSeats: secondRhythmSeats,
                rhythmCueLines: [
                    TinkieRhythmCueLine(speaker: "Aria", text: "We are warming up with one guitar intro."),
                    TinkieRhythmCueLine(speaker: "Jay", text: "I think the answer is from a classic chorus."),
                    TinkieRhythmCueLine(speaker: "Luna", text: "Give me one more beat and I can name it.")
                ]
            )
        ]
    }

    static func joinChord(_ group: TinkieSongQuestChord, for event: TinkieSongQuestTune) {
        var groups = joinedChordMap()
        groups[event.title] = chordKey(for: event, group: group)
        saveJoinedChordMap(groups)
    }

    static func isChordJoined(_ group: TinkieSongQuestChord, for event: TinkieSongQuestTune) -> Bool {
        joinedChordMap()[event.title] == chordKey(for: event, group: group)
    }

    static func hasJoinedDifferentChord(_ group: TinkieSongQuestChord, for event: TinkieSongQuestTune) -> Bool {
        guard let joined = joinedChordMap()[event.title] else { return false }
        return joined != chordKey(for: event, group: group)
    }

    private static func chordKey(for event: TinkieSongQuestTune, group: TinkieSongQuestChord) -> String {
        [event.title, event.dateText, group.name].joined(separator: "::")
    }

    private static func joinedChordMap() -> [String: String] {
        guard
            let data = UserDefaults.standard.data(forKey: joinedKey),
            let groups = try? JSONDecoder().decode([String: String].self, from: data)
        else {
            return [:]
        }
        return groups
    }

    private static func saveJoinedChordMap(_ groups: [String: String]) {
        guard let data = try? JSONEncoder().encode(groups) else { return }
        UserDefaults.standard.set(data, forKey: joinedKey)
    }
}

struct TinkieSongQuestForgeDraft: Codable {
    let title: String
    let theme: String
    let dayText: String
    let hourText: String
    let genre: String
    let mode: String
    let seatLimit: Int
    let gemNeed: Int
    let groups: [TinkieSongQuestChordDraft]
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
        groups: [TinkieSongQuestChordDraft],
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
        groups = try box.decodeIfPresent([TinkieSongQuestChordDraft].self, forKey: .groups) ?? [
            TinkieSongQuestChordDraft(name: "Group A", genre: genre, mode: mode, seatLimit: seatLimit, gemNeed: gemNeed)
        ]
    }
}

struct TinkieSongQuestChordDraft: Codable {
    let name: String
    let genre: String
    let mode: String
    let seatLimit: Int
    let gemNeed: Int
}

enum TinkieQuestForgeScorebook {
    private static let draftKey = "tinkie_songquest_draft_records"

    static func allForgedSongQuests() -> [TinkieSongQuestTune] {
        storedQuestDrafts().map { draft in
            TinkieSongQuestTune(
                title: draft.title,
                dateText: draft.dayText,
                timeText: draft.hourText,
                subtitle: draft.theme,
                tags: [draft.genre, draft.mode],
                coverName: "tinkie_event_cover_friday_pop_hits",
                coverPath: draft.artPath,
                hostName: TinkieSingerStageScorebook.currentSingerStage().nickname,
                avatarNames: TinkieSingerTuneAtlas.avatarTuneNames(for: [TinkieSingerStageScorebook.currentSingerStage().nickname, "Jay", "Mina"]),
                listenerNote: "\(draft.groups.count) groups · \(draft.gemNeed) gems"
            )
        }
    }

    static func forgedChords(for event: TinkieSongQuestTune) -> [TinkieSongQuestChord]? {
        guard let draft = storedQuestDrafts().first(where: { $0.title == event.title && $0.dayText == event.dateText }) else { return nil }
        let avatarSet = TinkieSingerTuneAtlas.avatarTuneNames(for: ["Jesscia", "Jay", "Mina", "Aria"])
        return draft.groups.enumerated().map { offset, group in
            let joined = min(group.seatLimit, max(1, group.seatLimit - 2 + offset))
            let left = max(0, group.seatLimit - joined)
            let rhythmSeats = [
                TinkieSingerTuneAtlas.rhythmSingerSeat(named: offset == 0 ? "Jesscia" : "Aria", owner: true),
                TinkieSingerTuneAtlas.rhythmSingerSeat(named: "Jay"),
                TinkieSingerTuneAtlas.rhythmSingerSeat(named: "Mina", muted: true),
                TinkieSingerTuneAtlas.rhythmSingerSeat(named: "Nova")
            ]
            return TinkieSongQuestChord(
                name: group.name,
                tags: [group.genre, group.mode],
                joinedCount: joined,
                spotsLeft: left,
                gemNeed: group.gemNeed,
                avatarNames: avatarSet,
                rhythmSeats: rhythmSeats,
                rhythmCueLines: [
                    TinkieRhythmCueLine(speaker: "Jay", text: "I can name that intro if the first beat drops clean."),
                    TinkieRhythmCueLine(speaker: "Mina", text: "Saving my guess for the chorus clue."),
                    TinkieRhythmCueLine(speaker: "Nova", text: "This group feels ready for a fast song round.")
                ]
            )
        }
    }

    static func save(_ draft: TinkieSongQuestForgeDraft) {
        var saved = storedQuestDrafts()
        saved.insert(draft, at: 0)
        guard let data = try? JSONEncoder().encode(saved) else { return }
        UserDefaults.standard.set(data, forKey: draftKey)
    }

    private static func storedQuestDrafts() -> [TinkieSongQuestForgeDraft] {
        guard
            let data = UserDefaults.standard.data(forKey: draftKey),
            let stored = try? JSONDecoder().decode([TinkieSongQuestForgeDraft].self, from: data)
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
            TinkieSongPulseSpark(
                performer: pulse.performer,
                moment: "just now",
                caption: pulse.caption,
                coverName: "tinkie_event_cover_friday_pop_hits",
                coverPath: pulse.coverPath,
                pulseFileName: pulse.clipPath,
                avatarName: pulse.avatarName,
                avatarPath: pulse.avatarPath,
                echoCount: "new"
            )
        }
    }

    static func pulseEchoTunes(for performer: String) -> [TinkieSongPulseEcho] {
        storedPulseSparkDrafts()
            .filter { $0.performer == performer }
            .map {
                TinkieSongPulseEcho(
                    title: "Fresh song round",
                    note: $0.caption,
                    coverName: "tinkie_event_cover_friday_pop_hits",
                    coverPath: $0.coverPath
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
        let name = key.components(separatedBy: "::").first?.trimmingCharacters(in: .whitespacesAndNewlines)
        return name?.isEmpty == false ? name : nil
    }
}

enum TinkieSongSeedSongbook {
    static let songQuestSongbook: [TinkieSongQuestTune] = [
        TinkieSongQuestTune(
            title: "Friday Pop Hits Challenge",
            dateText: "Jul 18, 2026",
            timeText: "8:00 PM",
            subtitle: "Guess popular songs from their intros and compete with other players to see who knows pop music best.",
            tags: ["Pop Music", "Casual"],
            coverName: "tinkie_event_cover_friday_pop_hits",
            hostName: "Aria",
            avatarNames: TinkieSingerTuneAtlas.avatarTuneNames(for: ["Aria", "Jay", "Mina"]),
            listenerNote: "intro challenge"
        ),
        TinkieSongQuestTune(
            title: "Classic Hits Throwback Night",
            dateText: "Jul 19, 2026",
            timeText: "7:30 PM",
            subtitle: "Rediscover iconic songs from different decades and share your favorite musical memories with the group.",
            tags: ["Classic Hits", "Throwback"],
            coverName: "tinkie_event_cover_classic_throwback",
            hostName: "Jay",
            avatarNames: TinkieSingerTuneAtlas.avatarTuneNames(for: ["Jay", "Luna", "Aria"]),
            listenerNote: "decade rounds"
        ),
        TinkieSongQuestTune(
            title: "Movie & TV Soundtrack Quiz",
            dateText: "Jul 21, 2026",
            timeText: "9:00 PM",
            subtitle: "Guess songs and titles from popular movies and TV shows, and put your soundtrack knowledge to the test.",
            tags: ["Soundtrack", "Quiz"],
            coverName: "tinkie_event_cover_soundtrack_quiz",
            hostName: "Mina",
            avatarNames: TinkieSingerTuneAtlas.avatarTuneNames(for: ["Mina", "Nova", "Jay"]),
            listenerNote: "screen themes"
        ),
        TinkieSongQuestTune(
            title: "K-Pop Hits Challenge",
            dateText: "Jul 23, 2026",
            timeText: "8:30 PM",
            subtitle: "Name popular K-pop songs from short intros and compete for the title of K-pop guessing champion.",
            tags: ["K-Pop", "Hits"],
            coverName: "tinkie_event_cover_kpop_hits",
            hostName: "Rin",
            avatarNames: TinkieSingerTuneAtlas.avatarTuneNames(for: ["Rin", "Sera", "Jay"]),
            listenerNote: "fast intro round"
        ),
        TinkieSongQuestTune(
            title: "Anime Song Guessing Party",
            dateText: "Jul 25, 2026",
            timeText: "6:00 PM",
            subtitle: "Test your knowledge of anime openings, endings, and iconic soundtracks with fellow anime music fans.",
            tags: ["Anime", "Openings"],
            coverName: "tinkie_event_cover_anime_guessing",
            hostName: "Nia",
            avatarNames: TinkieSingerTuneAtlas.avatarTuneNames(for: ["Nia", "Rin", "Mina"]),
            listenerNote: "theme party"
        ),
        TinkieSongQuestTune(
            title: "Mystery Music Mix Night",
            dateText: "Jul 27, 2026",
            timeText: "8:00 PM",
            subtitle: "Every round features a surprise genre and era, making it the perfect challenge for players with wide-ranging music tastes.",
            tags: ["Mystery Mix", "Genre Rush"],
            coverName: "tinkie_event_cover_mystery_mix",
            hostName: "Theo",
            avatarNames: TinkieSingerTuneAtlas.avatarTuneNames(for: ["Theo", "Nova", "Ada"]),
            listenerNote: "surprise rounds"
        )
    ]

    static let seedPulseSparkTunes: [TinkieSongPulseSpark] = [
        TinkieSongPulseSpark(
            performer: "Jay",
            moment: "before two min",
            caption: "Warm-up clip from our game tonight, easy mode only.",
            coverName: "tinkie_event_cover_friday_pop_hits",
            pulseFileName: "tinkie_song_room_clip_country_hint.mp4",
            avatarName: TinkieSingerTuneAtlas.singerTuneCard(named: "Jay").heroImageName,
            echoCount: "hot"
        ),
        TinkieSongPulseSpark(
            performer: "Aria",
            moment: "after first round",
            caption: "That chorus clue landed faster than the beat.",
            coverName: "tinkie_event_cover_classic_throwback",
            pulseFileName: "tinkie_song_room_clip_vocal_hook.mp4",
            avatarName: TinkieSingerTuneAtlas.singerTuneCard(named: "Aria").heroImageName,
            echoCount: "fresh"
        ),
        TinkieSongPulseSpark(
            performer: "Mina",
            moment: "right now",
            caption: "Only three notes, but the whole room knew it.",
            coverName: "tinkie_event_cover_soundtrack_quiz",
            pulseFileName: "tinkie_song_room_clip_acoustic_cue.mp4",
            avatarName: TinkieSingerTuneAtlas.singerTuneCard(named: "Mina").heroImageName,
            echoCount: "new"
        ),
        TinkieSongPulseSpark(
            performer: "Theo",
            moment: "one round ago",
            caption: "The guitar cue fooled half the room until the hook dropped.",
            coverName: "tinkie_event_cover_pop_hits",
            pulseFileName: "tinkie_song_room_clip_chorus_guess.mp4",
            avatarName: TinkieSingerTuneAtlas.singerTuneCard(named: "Theo").heroImageName,
            echoCount: "pulse"
        ),
        TinkieSongPulseSpark(
            performer: "Rin",
            moment: "during sprint",
            caption: "Pitch round went fast, but the final answer was clean.",
            coverName: "tinkie_event_cover_kpop_hits",
            pulseFileName: "tinkie_song_room_clip_pitch_round.mp4",
            avatarName: TinkieSingerTuneAtlas.singerTuneCard(named: "Rin").heroImageName,
            echoCount: "rush"
        ),
        TinkieSongPulseSpark(
            performer: "Nia",
            moment: "after chorus",
            caption: "A bright stage echo turned into a perfect song reveal.",
            coverName: "tinkie_event_cover_anime_guessing",
            pulseFileName: "tinkie_song_room_clip_stage_echo.mp4",
            avatarName: TinkieSingerTuneAtlas.singerTuneCard(named: "Nia").heroImageName,
            echoCount: "spark"
        )
    ]

    static func pulseSparkTunes(for performer: String) -> [TinkieSongPulseSpark] {
        let local = TinkiePulseSparkScorebook.savedPulseSparkTunes().filter { $0.performer == performer }
        let seeded = seedPulseSparkTunes.filter { $0.performer == performer }
        return local + seeded
    }

    static func joinedSongQuestTunes(for performer: String) -> [TinkieSongQuestTune] {
        let authored = TinkieQuestForgeScorebook.allForgedSongQuests().filter { $0.hostName == performer }
        let seeded = songQuestSongbook.filter { songQuest in
            songQuest.hostName == performer || songQuest.avatarNames.contains(TinkieSingerTuneAtlas.singerTuneCard(named: performer).heroImageName)
        }
        let linked = authored + seeded
        if !linked.isEmpty { return Array(linked.prefix(2)) }
        guard !songQuestSongbook.isEmpty else { return [] }
        let offset = abs(performer.hashValue % songQuestSongbook.count)
        return [songQuestSongbook[offset]]
    }
}
