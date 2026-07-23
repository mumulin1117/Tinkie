import UIKit

final class TinkieRhythmRoomStageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    private let rhythmEvent: TinkieSongQuestTune
    private let questChord: TinkieSongQuestChord
    private var roomCueLines: [TinkieRhythmCueLine]

    private let roomBackdropImageView = UIImageView()
    private let roomShadeView = UIView()
    private let roomScrollStage = UIScrollView()
    private let roomContentStage = UIView()
    private let singerSeatGrid: UICollectionView
    private let cueLineStack = UIStackView()
    private let cueInputShell = UIView()
    private let cuePhraseField = UITextField()
    private let cueSendButton = TinkieRhythmSendCueButton()
    private var cueInputBottomConstraint: NSLayoutConstraint?
    private var rhythmExitOverlay: TinkieRhythmExitOverlay?

    init(event: TinkieSongQuestTune, group: TinkieSongQuestChord) {
        self.rhythmEvent = event
        self.questChord = group
        self.roomCueLines = questChord.rhythmCueLines

        let rhythmSeatFlow = UICollectionViewFlowLayout()
        rhythmSeatFlow.scrollDirection = .vertical
        rhythmSeatFlow.minimumLineSpacing = 14
        rhythmSeatFlow.minimumInteritemSpacing = 10
        self.singerSeatGrid = UICollectionView(frame: .zero, collectionViewLayout: rhythmSeatFlow)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        putRhythmStageScreenTogether()
        reloadCueLines()
        listenForRhythmKeyboard()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private var roomOwnerSinger: TinkieRhythmSingerSeat {
        questChord.rhythmSeats.first(where: { $0.isOwner }) ?? questChord.rhythmSeats.first ?? TinkieRhythmSingerSeat(name: rhythmEvent.hostName, avatarName: rhythmEvent.avatarNames.first ?? "tinkie_avatar_neon_voice", isOwner: true, isMuted: false)
    }

    private var sideSingerSeats: [TinkieRhythmSingerSeat] {
        Array(questChord.rhythmSeats.filter { !$0.isOwner && !TinkieSongShieldLedger.alreadyShieldedSinger($0.name) }.prefix(8))
    }

    private func putRhythmStageScreenTogether() {
        view.backgroundColor = .black

        if let coverPath = rhythmEvent.coverPath, let localArt = UIImage(contentsOfFile: coverPath) {
            roomBackdropImageView.image = localArt
        } else {
            roomBackdropImageView.image = UIImage(named: rhythmEvent.coverName)
        }
        roomBackdropImageView.contentMode = .scaleAspectFill
        roomBackdropImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(roomBackdropImageView)

        roomShadeView.backgroundColor = UIColor.black.withAlphaComponent(0.64)
        roomShadeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(roomShadeView)

        let rhythmGlowWash = TinkieRhythmAuraView()
        rhythmGlowWash.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rhythmGlowWash)

        let rhythmTopStrip = makeRhythmStageTopStrip()
        rhythmTopStrip.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rhythmTopStrip)

        roomScrollStage.contentInsetAdjustmentBehavior = .never
        roomScrollStage.alwaysBounceVertical = true
        roomScrollStage.showsVerticalScrollIndicator = false
        roomScrollStage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(roomScrollStage)

        roomContentStage.translatesAutoresizingMaskIntoConstraints = false
        roomScrollStage.addSubview(roomContentStage)

        let rhythmSeatStage = makeRhythmSeatArea()
        rhythmSeatStage.translatesAutoresizingMaskIntoConstraints = false
        roomContentStage.addSubview(rhythmSeatStage)

        let rhythmGuardNote = UILabel()
        rhythmGuardNote.text = "Illegal, harmful, hateful, harassing, fraudulent, or otherwise inappropriate content is prohibited. Tinkie song rooms are reviewed to keep guessing rounds respectful and safe."
        rhythmGuardNote.textColor = UIColor(red: 1, green: 0.39, blue: 0.18, alpha: 0.88)
        rhythmGuardNote.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        rhythmGuardNote.numberOfLines = 0
        rhythmGuardNote.translatesAutoresizingMaskIntoConstraints = false
        roomContentStage.addSubview(rhythmGuardNote)

        cueLineStack.axis = .vertical
        cueLineStack.alignment = .leading
        cueLineStack.spacing = 12
        cueLineStack.translatesAutoresizingMaskIntoConstraints = false
        roomContentStage.addSubview(cueLineStack)

        putCueBarAtBottom()

        cueInputBottomConstraint = cueInputShell.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)

        NSLayoutConstraint.activate([
            roomBackdropImageView.topAnchor.constraint(equalTo: view.topAnchor),
            roomBackdropImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            roomBackdropImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            roomBackdropImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            roomShadeView.topAnchor.constraint(equalTo: view.topAnchor),
            roomShadeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            roomShadeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            roomShadeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            rhythmGlowWash.topAnchor.constraint(equalTo: view.topAnchor),
            rhythmGlowWash.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rhythmGlowWash.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rhythmGlowWash.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            rhythmTopStrip.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            rhythmTopStrip.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            rhythmTopStrip.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),

            roomScrollStage.topAnchor.constraint(equalTo: rhythmTopStrip.bottomAnchor, constant: 8),
            roomScrollStage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            roomScrollStage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            roomScrollStage.bottomAnchor.constraint(equalTo: cueInputShell.topAnchor, constant: -8),

            roomContentStage.topAnchor.constraint(equalTo: roomScrollStage.contentLayoutGuide.topAnchor),
            roomContentStage.leadingAnchor.constraint(equalTo: roomScrollStage.contentLayoutGuide.leadingAnchor),
            roomContentStage.trailingAnchor.constraint(equalTo: roomScrollStage.contentLayoutGuide.trailingAnchor),
            roomContentStage.bottomAnchor.constraint(equalTo: roomScrollStage.contentLayoutGuide.bottomAnchor),
            roomContentStage.widthAnchor.constraint(equalTo: roomScrollStage.frameLayoutGuide.widthAnchor),

            rhythmSeatStage.topAnchor.constraint(equalTo: roomContentStage.topAnchor, constant: 22),
            rhythmSeatStage.leadingAnchor.constraint(equalTo: roomContentStage.leadingAnchor, constant: 18),
            rhythmSeatStage.trailingAnchor.constraint(equalTo: roomContentStage.trailingAnchor, constant: -18),

            rhythmGuardNote.topAnchor.constraint(equalTo: rhythmSeatStage.bottomAnchor, constant: 18),
            rhythmGuardNote.leadingAnchor.constraint(equalTo: roomContentStage.leadingAnchor, constant: 26),
            rhythmGuardNote.trailingAnchor.constraint(equalTo: roomContentStage.trailingAnchor, constant: -26),

            cueLineStack.topAnchor.constraint(equalTo: rhythmGuardNote.bottomAnchor, constant: 28),
            cueLineStack.leadingAnchor.constraint(equalTo: roomContentStage.leadingAnchor, constant: 20),
            cueLineStack.trailingAnchor.constraint(lessThanOrEqualTo: roomContentStage.trailingAnchor, constant: -20),
            cueLineStack.bottomAnchor.constraint(equalTo: roomContentStage.bottomAnchor, constant: -20),

            cueInputShell.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cueInputShell.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cueInputShell.heightAnchor.constraint(equalToConstant: 52),
            cueInputBottomConstraint!
        ])
    }

    private func makeRhythmStageTopStrip() -> UIView {
        let rhythmShell = UIView()

        let questHomeGlyph = UIImageView(image: UIImage(systemName: "house"))
        questHomeGlyph.tintColor = .white
        questHomeGlyph.contentMode = .scaleAspectFit
        questHomeGlyph.translatesAutoresizingMaskIntoConstraints = false

        let rhythmTitleNote = UILabel()
        rhythmTitleNote.text = rhythmEvent.title
        rhythmTitleNote.textColor = .white
        rhythmTitleNote.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        rhythmTitleNote.lineBreakMode = .byTruncatingTail

        let chordCountNote = UILabel()
        chordCountNote.text = "\(questChord.name)   \(questChord.joinedCount) joined"
        chordCountNote.textColor = UIColor.white.withAlphaComponent(0.72)
        chordCountNote.font = UIFont.systemFont(ofSize: 10, weight: .medium)

        let rhythmTitleStack = UIStackView(arrangedSubviews: [rhythmTitleNote, chordCountNote])
        rhythmTitleStack.axis = .vertical
        rhythmTitleStack.spacing = 2
        rhythmTitleStack.translatesAutoresizingMaskIntoConstraints = false

        let singerMiniStack = TinkieRhythmAvatarStack(names: questChord.avatarNames)
        singerMiniStack.translatesAutoresizingMaskIntoConstraints = false

        let rhythmMoreKnob = TinkieRhythmRoundIconButton(symbolName: "ellipsis")
        rhythmMoreKnob.addTarget(self, action: #selector(openRhythmMore), for: .touchUpInside)
        rhythmMoreKnob.translatesAutoresizingMaskIntoConstraints = false

        let rhythmExitKnob = TinkieRhythmRoundIconButton(symbolName: "xmark")
        rhythmExitKnob.addTarget(self, action: #selector(openRhythmExitPrompt), for: .touchUpInside)
        rhythmExitKnob.translatesAutoresizingMaskIntoConstraints = false

        [questHomeGlyph, rhythmTitleStack, singerMiniStack, rhythmMoreKnob, rhythmExitKnob].forEach(rhythmShell.addSubview)

        NSLayoutConstraint.activate([
            questHomeGlyph.leadingAnchor.constraint(equalTo: rhythmShell.leadingAnchor),
            questHomeGlyph.centerYAnchor.constraint(equalTo: rhythmTitleStack.centerYAnchor),
            questHomeGlyph.widthAnchor.constraint(equalToConstant: 14),
            questHomeGlyph.heightAnchor.constraint(equalToConstant: 14),

            rhythmTitleStack.topAnchor.constraint(equalTo: rhythmShell.topAnchor),
            rhythmTitleStack.leadingAnchor.constraint(equalTo: questHomeGlyph.trailingAnchor, constant: 4),
            rhythmTitleStack.trailingAnchor.constraint(lessThanOrEqualTo: singerMiniStack.leadingAnchor, constant: -10),
            rhythmTitleStack.bottomAnchor.constraint(equalTo: rhythmShell.bottomAnchor),

            rhythmExitKnob.trailingAnchor.constraint(equalTo: rhythmShell.trailingAnchor),
            rhythmExitKnob.centerYAnchor.constraint(equalTo: rhythmTitleStack.centerYAnchor),
            rhythmExitKnob.widthAnchor.constraint(equalToConstant: 34),
            rhythmExitKnob.heightAnchor.constraint(equalToConstant: 34),

            rhythmMoreKnob.trailingAnchor.constraint(equalTo: rhythmExitKnob.leadingAnchor, constant: -8),
            rhythmMoreKnob.centerYAnchor.constraint(equalTo: rhythmExitKnob.centerYAnchor),
            rhythmMoreKnob.widthAnchor.constraint(equalToConstant: 34),
            rhythmMoreKnob.heightAnchor.constraint(equalToConstant: 34),

            singerMiniStack.trailingAnchor.constraint(equalTo: rhythmMoreKnob.leadingAnchor, constant: -10),
            singerMiniStack.centerYAnchor.constraint(equalTo: rhythmMoreKnob.centerYAnchor),
            singerMiniStack.widthAnchor.constraint(equalToConstant: 72),
            singerMiniStack.heightAnchor.constraint(equalToConstant: 30)
        ])
        return rhythmShell
    }

    private func makeRhythmSeatArea() -> UIView {
        let rhythmShell = UIView()

        let ownerRhythmSpot = TinkieRhythmOwnerSpotView(member: roomOwnerSinger)
        ownerRhythmSpot.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openOwnerSingerProfile)))
        ownerRhythmSpot.isUserInteractionEnabled = true
        ownerRhythmSpot.translatesAutoresizingMaskIntoConstraints = false
        rhythmShell.addSubview(ownerRhythmSpot)

        singerSeatGrid.backgroundColor = .clear
        singerSeatGrid.isScrollEnabled = false
        singerSeatGrid.dataSource = self
        singerSeatGrid.delegate = self
        singerSeatGrid.register(TinkieRhythmSingerSeatCell.self, forCellWithReuseIdentifier: TinkieRhythmSingerSeatCell.reuseIdentifier)
        singerSeatGrid.translatesAutoresizingMaskIntoConstraints = false
        rhythmShell.addSubview(singerSeatGrid)

        NSLayoutConstraint.activate([
            rhythmShell.heightAnchor.constraint(greaterThanOrEqualToConstant: 292),

            ownerRhythmSpot.leadingAnchor.constraint(equalTo: rhythmShell.leadingAnchor),
            ownerRhythmSpot.topAnchor.constraint(equalTo: rhythmShell.topAnchor, constant: 44),
            ownerRhythmSpot.widthAnchor.constraint(equalTo: rhythmShell.widthAnchor, multiplier: 0.45),

            singerSeatGrid.topAnchor.constraint(equalTo: rhythmShell.topAnchor, constant: 8),
            singerSeatGrid.trailingAnchor.constraint(equalTo: rhythmShell.trailingAnchor),
            singerSeatGrid.widthAnchor.constraint(equalTo: rhythmShell.widthAnchor, multiplier: 0.48),
            singerSeatGrid.heightAnchor.constraint(equalToConstant: 270),
            singerSeatGrid.bottomAnchor.constraint(lessThanOrEqualTo: rhythmShell.bottomAnchor)
        ])

        return rhythmShell
    }

    private func putCueBarAtBottom() {
        cueInputShell.backgroundColor = UIColor(red: 0.16, green: 0.14, blue: 0.17, alpha: 0.92)
        cueInputShell.layer.cornerRadius = 26
        cueInputShell.layer.borderWidth = 1
        cueInputShell.layer.borderColor = UIColor.white.withAlphaComponent(0.08).cgColor
        cueInputShell.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cueInputShell)

        let cueSmileGlyph = UIImageView(image: UIImage(systemName: "face.smiling"))
        cueSmileGlyph.tintColor = UIColor.white.withAlphaComponent(0.78)
        cueSmileGlyph.contentMode = .scaleAspectFit
        cueSmileGlyph.translatesAutoresizingMaskIntoConstraints = false
        cueInputShell.addSubview(cueSmileGlyph)

        cuePhraseField.placeholder = "Say hi~"
        cuePhraseField.textColor = .white
        cuePhraseField.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        cuePhraseField.delegate = self
        cuePhraseField.returnKeyType = .send
        cuePhraseField.attributedPlaceholder = NSAttributedString(
            string: "Say hi~",
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.65)]
        )
        cuePhraseField.translatesAutoresizingMaskIntoConstraints = false
        cueInputShell.addSubview(cuePhraseField)

        cueSendButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        cueSendButton.tintColor = .white
        cueSendButton.addTarget(self, action: #selector(sendCueLine), for: .touchUpInside)
        cueSendButton.translatesAutoresizingMaskIntoConstraints = false
        cueInputShell.addSubview(cueSendButton)

        NSLayoutConstraint.activate([
            cueSmileGlyph.leadingAnchor.constraint(equalTo: cueInputShell.leadingAnchor, constant: 16),
            cueSmileGlyph.centerYAnchor.constraint(equalTo: cueInputShell.centerYAnchor),
            cueSmileGlyph.widthAnchor.constraint(equalToConstant: 22),
            cueSmileGlyph.heightAnchor.constraint(equalToConstant: 22),

            cueSendButton.trailingAnchor.constraint(equalTo: cueInputShell.trailingAnchor, constant: -6),
            cueSendButton.centerYAnchor.constraint(equalTo: cueInputShell.centerYAnchor),
            cueSendButton.widthAnchor.constraint(equalToConstant: 44),
            cueSendButton.heightAnchor.constraint(equalToConstant: 40),

            cuePhraseField.leadingAnchor.constraint(equalTo: cueSmileGlyph.trailingAnchor, constant: 8),
            cuePhraseField.trailingAnchor.constraint(equalTo: cueSendButton.leadingAnchor, constant: -10),
            cuePhraseField.topAnchor.constraint(equalTo: cueInputShell.topAnchor, constant: 5),
            cuePhraseField.bottomAnchor.constraint(equalTo: cueInputShell.bottomAnchor, constant: -5)
        ])
    }

    private func reloadCueLines() {
        cueLineStack.arrangedSubviews.forEach { view in
            cueLineStack.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        roomCueLines.forEach { cueLineStack.addArrangedSubview(TinkieRhythmLineBubble(line: $0)) }
    }

    @objc private func sendCueLine() {
        let text = cuePhraseField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !text.isEmpty else { return }
        let singerAlias = TinkieSingerStageScorebook.currentSingerStage().nickname
        roomCueLines.append(TinkieRhythmCueLine(speaker: singerAlias, text: text))
        cuePhraseField.text = nil
        reloadCueLines()
        view.layoutIfNeeded()
        let bottomOffset = max(0, roomScrollStage.contentSize.height - roomScrollStage.bounds.height + roomScrollStage.adjustedContentInset.bottom)
        roomScrollStage.setContentOffset(CGPoint(x: 0, y: bottomOffset), animated: true)
    }

    func textFieldShouldReturn(_ melodyTextField: UITextField) -> Bool {
        sendCueLine()
        return true
    }

    @objc private func openRhythmMore() {
        tinkiePresentRhythmShield(
            tuneTitle: "\(rhythmEvent.title) \(questChord.name)",
            tuneKey: TinkieSongShieldLedger.roomKey(event: rhythmEvent, group: questChord),
            tuneKind: "room",
            onShieldDone: { [weak self] in
                self?.dismiss(animated: true)
            }
        )
    }

    @objc private func openOwnerSingerProfile() {
        openSingerProfile(for: roomOwnerSinger)
    }

    private func openSingerProfile(for member: TinkieRhythmSingerSeat) {
        guard TinkieSingerStageScorebook.isSingerOnStage else {
            openRhythmWelcome()
            return
        }
        let item = singerProfilePulse(for: member)
        let key = [item.performer, item.coverName, item.pulseFileName].joined(separator: "::")
        let page = TinkieSingerPulseProfileViewController(
            pulseSpark: item,
            bonded: TinkieRhythmBondScorebook.hasRhythmBond(for: key)
        )
        let navigation = UINavigationController(rootViewController: page)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    private func singerProfilePulse(for member: TinkieRhythmSingerSeat) -> TinkieSongPulseSpark {
        if let seeded = TinkieSongSeedSongbook.pulseSparkTunes(for: member.name).first {
            return seeded
        }
        let snapshot = TinkieSingerStageScorebook.currentSingerStage()
        let matchedPath = member.avatarPath ?? (snapshot.isSingerOnStage && snapshot.nickname == member.name ? snapshot.heroImagePath : nil)
        let fallbackFile = TinkieSongSeedSongbook.seedPulseSparkTunes.first?.pulseFileName ?? "tinkie_song_room_clip_country_hint.mp4"
        return TinkieSongPulseSpark(
            performer: member.name,
            moment: "in this room",
            caption: "\(member.name) joined \(questChord.name) for a quick song guessing round.",
            coverName: rhythmEvent.coverName,
            coverPath: rhythmEvent.coverPath,
            pulseFileName: fallbackFile,
            avatarName: member.avatarName,
            avatarPath: matchedPath,
            echoCount: "room"
        )
    }

    private func openRhythmWelcome() {
        let welcome = TinkieMelodyGateWelcomeViewController()
        welcome.onMelodyGateDone = { [weak self] in
            self?.dismiss(animated: true)
        }
        let navigation = UINavigationController(rootViewController: welcome)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    private func showRhythmNotice(title: String, text: String) {
        tinkieShowTuneNotice(title: title, detail: text)
    }

    @objc private func openRhythmExitPrompt() {
        guard rhythmExitOverlay == nil else { return }
        let overlay = TinkieRhythmExitOverlay()
        overlay.onMinimize = { [weak self] in
            self?.dismiss(animated: true)
        }
        overlay.onClose = { [weak self] in
            self?.dismiss(animated: true)
        }
        overlay.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlay)
        rhythmExitOverlay = overlay
        NSLayoutConstraint.activate([
            overlay.topAnchor.constraint(equalTo: view.topAnchor),
            overlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlay.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        overlay.show()
    }

    private func listenForRhythmKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(rhythmKeyboardCameUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(rhythmKeyboardWentAway), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(stopRhythmTyping))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func rhythmKeyboardCameUp(_ notification: Notification) {
        guard
            let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else { return }
        let overlap = max(0, view.bounds.maxY - view.convert(frame, from: nil).minY - view.safeAreaInsets.bottom)
        cueInputBottomConstraint?.constant = -overlap - 10
        roomScrollStage.contentInset.bottom = overlap + 16
        roomScrollStage.verticalScrollIndicatorInsets.bottom = overlap + 16
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }

    @objc private func rhythmKeyboardWentAway(_ notification: Notification) {
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
        cueInputBottomConstraint?.constant = -10
        roomScrollStage.contentInset.bottom = 0
        roomScrollStage.verticalScrollIndicatorInsets.bottom = 0
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }

    @objc private func stopRhythmTyping() {
        view.endEditing(true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sideSingerSeats.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TinkieRhythmSingerSeatCell.reuseIdentifier, for: indexPath) as! TinkieRhythmSingerSeatCell
        cell.tuneSeatFace(member: sideSingerSeats[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openSingerProfile(for: sideSingerSeats[indexPath.item])
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor((collectionView.bounds.width - 10) / 2)
        return CGSize(width: width, height: 70)
    }
}

private final class TinkieRhythmOwnerSpotView: UIView {
    init(member: TinkieRhythmSingerSeat) {
        super.init(frame: .zero)
        putOwnerSingerBubbleTogether(member: member)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func putOwnerSingerBubbleTogether(member: TinkieRhythmSingerSeat) {
        let ownerSingerFace = UIImageView()
        if let avatarPath = member.avatarPath, let localArt = UIImage(contentsOfFile: avatarPath) {
            ownerSingerFace.image = localArt
        } else {
            ownerSingerFace.image = UIImage(named: member.avatarName)
        }
        ownerSingerFace.contentMode = .scaleAspectFill
        ownerSingerFace.layer.cornerRadius = 48
        ownerSingerFace.layer.borderWidth = 1
        ownerSingerFace.layer.borderColor = UIColor.white.withAlphaComponent(0.72).cgColor
        ownerSingerFace.layer.masksToBounds = true
        ownerSingerFace.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ownerSingerFace)

        let ownerRhythmRing = TinkieRhythmRingView()
        ownerRhythmRing.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(ownerRhythmRing, belowSubview: ownerSingerFace)

        let ownerBadgeNote = UILabel()
        ownerBadgeNote.text = "Owner"
        ownerBadgeNote.textColor = .black
        ownerBadgeNote.textAlignment = .center
        ownerBadgeNote.font = UIFont.systemFont(ofSize: 10, weight: .black)
        ownerBadgeNote.backgroundColor = .white
        ownerBadgeNote.layer.cornerRadius = 10
        ownerBadgeNote.layer.masksToBounds = true
        ownerBadgeNote.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ownerBadgeNote)

        let ownerNameNote = UILabel()
        ownerNameNote.text = member.name
        ownerNameNote.textColor = .white
        ownerNameNote.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        ownerNameNote.textAlignment = .center
        ownerNameNote.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ownerNameNote)

        let ownerMicGlyph = UIImageView(image: UIImage(systemName: member.isMuted ? "mic.slash.fill" : "mic.fill"))
        ownerMicGlyph.tintColor = .white
        ownerMicGlyph.contentMode = .scaleAspectFit
        ownerMicGlyph.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ownerMicGlyph)

        NSLayoutConstraint.activate([
            ownerRhythmRing.topAnchor.constraint(equalTo: topAnchor),
            ownerRhythmRing.centerXAnchor.constraint(equalTo: centerXAnchor),
            ownerRhythmRing.widthAnchor.constraint(equalToConstant: 112),
            ownerRhythmRing.heightAnchor.constraint(equalToConstant: 112),

            ownerSingerFace.centerXAnchor.constraint(equalTo: ownerRhythmRing.centerXAnchor),
            ownerSingerFace.centerYAnchor.constraint(equalTo: ownerRhythmRing.centerYAnchor),
            ownerSingerFace.widthAnchor.constraint(equalToConstant: 96),
            ownerSingerFace.heightAnchor.constraint(equalToConstant: 96),

            ownerBadgeNote.centerXAnchor.constraint(equalTo: ownerSingerFace.centerXAnchor),
            ownerBadgeNote.topAnchor.constraint(equalTo: ownerSingerFace.bottomAnchor, constant: -12),
            ownerBadgeNote.widthAnchor.constraint(equalToConstant: 64),
            ownerBadgeNote.heightAnchor.constraint(equalToConstant: 20),

            ownerNameNote.topAnchor.constraint(equalTo: ownerBadgeNote.bottomAnchor, constant: 8),
            ownerNameNote.leadingAnchor.constraint(equalTo: leadingAnchor),
            ownerNameNote.trailingAnchor.constraint(equalTo: trailingAnchor),

            ownerMicGlyph.topAnchor.constraint(equalTo: ownerNameNote.bottomAnchor, constant: 4),
            ownerMicGlyph.centerXAnchor.constraint(equalTo: centerXAnchor),
            ownerMicGlyph.widthAnchor.constraint(equalToConstant: 14),
            ownerMicGlyph.heightAnchor.constraint(equalToConstant: 14),
            ownerMicGlyph.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

private final class TinkieRhythmSingerSeatCell: UICollectionViewCell {
    static let reuseIdentifier = "TinkieRhythmSingerSeatCell"
    private let seatSingerFace = UIImageView()
    private let seatNameNote = UILabel()
    private let seatMicGlyph = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        putSmallSingerSeatTogether()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tuneSeatFace(member: TinkieRhythmSingerSeat) {
        if let avatarPath = member.avatarPath, let localArt = UIImage(contentsOfFile: avatarPath) {
            seatSingerFace.image = localArt
        } else {
            seatSingerFace.image = UIImage(named: member.avatarName)
        }
        seatNameNote.text = member.name
        seatMicGlyph.image = UIImage(systemName: member.isMuted ? "mic.slash.fill" : "mic.fill")
        seatSingerFace.backgroundColor = UIColor.white.withAlphaComponent(0.12)
    }

    private func putSmallSingerSeatTogether() {
        seatSingerFace.contentMode = .scaleAspectFill
        seatSingerFace.layer.cornerRadius = 23
        seatSingerFace.layer.borderWidth = 1
        seatSingerFace.layer.borderColor = UIColor.white.withAlphaComponent(0.55).cgColor
        seatSingerFace.layer.masksToBounds = true
        seatSingerFace.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(seatSingerFace)

        seatNameNote.textColor = UIColor.white.withAlphaComponent(0.86)
        seatNameNote.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        seatNameNote.textAlignment = .center
        seatNameNote.adjustsFontSizeToFitWidth = true
        seatNameNote.minimumScaleFactor = 0.7
        seatNameNote.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(seatNameNote)

        seatMicGlyph.tintColor = UIColor.white.withAlphaComponent(0.84)
        seatMicGlyph.contentMode = .scaleAspectFit
        seatMicGlyph.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(seatMicGlyph)

        NSLayoutConstraint.activate([
            seatSingerFace.topAnchor.constraint(equalTo: contentView.topAnchor),
            seatSingerFace.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            seatSingerFace.widthAnchor.constraint(equalToConstant: 46),
            seatSingerFace.heightAnchor.constraint(equalToConstant: 46),

            seatNameNote.topAnchor.constraint(equalTo: seatSingerFace.bottomAnchor, constant: 3),
            seatNameNote.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            seatNameNote.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            seatMicGlyph.topAnchor.constraint(equalTo: seatNameNote.bottomAnchor, constant: 2),
            seatMicGlyph.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            seatMicGlyph.widthAnchor.constraint(equalToConstant: 10),
            seatMicGlyph.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
}

private final class TinkieRhythmLineBubble: UIView {
    init(line: TinkieRhythmCueLine) {
        super.init(frame: .zero)
        backgroundColor = UIColor.white.withAlphaComponent(0.12)
        layer.cornerRadius = 10
        layer.masksToBounds = true

        let cueBubbleNote = UILabel()
        cueBubbleNote.text = "\(line.speaker): \(line.text)"
        cueBubbleNote.textColor = UIColor.white.withAlphaComponent(0.92)
        cueBubbleNote.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        cueBubbleNote.numberOfLines = 0
        cueBubbleNote.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cueBubbleNote)

        NSLayoutConstraint.activate([
            widthAnchor.constraint(lessThanOrEqualToConstant: 260),
            cueBubbleNote.topAnchor.constraint(equalTo: topAnchor, constant: 9),
            cueBubbleNote.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            cueBubbleNote.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            cueBubbleNote.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private final class TinkieRhythmAvatarStack: UIView {
    init(names: [String]) {
        super.init(frame: .zero)
        for (rhythmIndex, singerImageName) in names.prefix(3).enumerated() {
            let stackedSingerFace = TinkieAvatarView(imageName: singerImageName, size: 30)
            stackedSingerFace.translatesAutoresizingMaskIntoConstraints = false
            addSubview(stackedSingerFace)
            NSLayoutConstraint.activate([
                stackedSingerFace.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(rhythmIndex) * 21),
                stackedSingerFace.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private final class TinkieRhythmRoundIconButton: UIButton {
    init(symbolName: String) {
        super.init(frame: .zero)
        setImage(UIImage(systemName: symbolName), for: .normal)
        tintColor = .white
        backgroundColor = UIColor.black.withAlphaComponent(0.36)
        imageView?.contentMode = .scaleAspectFit
        layer.cornerRadius = 17
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private final class TinkieRhythmSendCueButton: UIButton {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let cueButtonGlow = layer as! CAGradientLayer
        cueButtonGlow.colors = [
            UIColor(red: 0.88, green: 0.06, blue: 0.62, alpha: 1).cgColor,
            UIColor(red: 0.11, green: 0.86, blue: 0.78, alpha: 1).cgColor
        ]
        cueButtonGlow.startPoint = CGPoint(x: 0, y: 0.5)
        cueButtonGlow.endPoint = CGPoint(x: 1, y: 0.5)
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private final class TinkieRhythmExitOverlay: UIView {
    var onMinimize: (() -> Void)?
    var onClose: (() -> Void)?
    private let exitCard = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        putRhythmExitCardTogether()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show() {
        alpha = 1
        exitCard.transform = .identity
    }

    private func putRhythmExitCardTogether() {
        backgroundColor = UIColor.black.withAlphaComponent(0.62)

        exitCard.backgroundColor = .white
        exitCard.layer.cornerRadius = 18
        exitCard.layer.masksToBounds = true
        exitCard.translatesAutoresizingMaskIntoConstraints = false
        addSubview(exitCard)

        let exitBellArt = UIImageView(image: UIImage(named: "tinkie_discover_notice_bell"))
        exitBellArt.contentMode = .scaleAspectFit
        exitBellArt.translatesAutoresizingMaskIntoConstraints = false
        exitCard.addSubview(exitBellArt)

        let exitQuestionNote = UILabel()
        exitQuestionNote.text = "Do you want to close or minimize the room?"
        exitQuestionNote.textColor = .black
        exitQuestionNote.font = UIFont.systemFont(ofSize: 15, weight: .black)
        exitQuestionNote.textAlignment = .center
        exitQuestionNote.numberOfLines = 0
        exitQuestionNote.translatesAutoresizingMaskIntoConstraints = false
        exitCard.addSubview(exitQuestionNote)

        let minimizeChordButton = TinkieRhythmSendCueButton()
        minimizeChordButton.setTitle("Minimize", for: .normal)
        minimizeChordButton.setTitleColor(.white, for: .normal)
        minimizeChordButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .black)
        minimizeChordButton.addTarget(self, action: #selector(minimizeRhythmTapped), for: .touchUpInside)
        minimizeChordButton.translatesAutoresizingMaskIntoConstraints = false
        exitCard.addSubview(minimizeChordButton)

        let closeChordButton = UIButton(type: .system)
        closeChordButton.setTitle("Close", for: .normal)
        closeChordButton.setTitleColor(UIColor.black.withAlphaComponent(0.28), for: .normal)
        closeChordButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .black)
        closeChordButton.backgroundColor = UIColor.black.withAlphaComponent(0.06)
        closeChordButton.layer.cornerRadius = 19
        closeChordButton.addTarget(self, action: #selector(closeRhythmTapped), for: .touchUpInside)
        closeChordButton.translatesAutoresizingMaskIntoConstraints = false
        exitCard.addSubview(closeChordButton)

        NSLayoutConstraint.activate([
            exitCard.centerXAnchor.constraint(equalTo: centerXAnchor),
            exitCard.centerYAnchor.constraint(equalTo: centerYAnchor),
            exitCard.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 34),
            exitCard.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -34),
            exitCard.widthAnchor.constraint(lessThanOrEqualToConstant: 300),

            exitBellArt.topAnchor.constraint(equalTo: exitCard.topAnchor, constant: 24),
            exitBellArt.centerXAnchor.constraint(equalTo: exitCard.centerXAnchor),
            exitBellArt.widthAnchor.constraint(equalToConstant: 78),
            exitBellArt.heightAnchor.constraint(equalToConstant: 78),

            exitQuestionNote.topAnchor.constraint(equalTo: exitBellArt.bottomAnchor, constant: 12),
            exitQuestionNote.leadingAnchor.constraint(equalTo: exitCard.leadingAnchor, constant: 24),
            exitQuestionNote.trailingAnchor.constraint(equalTo: exitCard.trailingAnchor, constant: -24),

            minimizeChordButton.topAnchor.constraint(equalTo: exitQuestionNote.bottomAnchor, constant: 22),
            minimizeChordButton.leadingAnchor.constraint(equalTo: exitCard.leadingAnchor, constant: 24),
            minimizeChordButton.widthAnchor.constraint(equalTo: closeChordButton.widthAnchor),
            minimizeChordButton.heightAnchor.constraint(equalToConstant: 42),
            minimizeChordButton.bottomAnchor.constraint(equalTo: exitCard.bottomAnchor, constant: -24),

            closeChordButton.leadingAnchor.constraint(equalTo: minimizeChordButton.trailingAnchor, constant: 14),
            closeChordButton.trailingAnchor.constraint(equalTo: exitCard.trailingAnchor, constant: -24),
            closeChordButton.centerYAnchor.constraint(equalTo: minimizeChordButton.centerYAnchor),
            closeChordButton.heightAnchor.constraint(equalTo: minimizeChordButton.heightAnchor)
        ])
    }

    @objc private func minimizeRhythmTapped() {
        onMinimize?()
    }

    @objc private func closeRhythmTapped() {
        onClose?()
    }
}

private final class TinkieRhythmAuraView: UIView {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let stageAuraBlend = layer as! CAGradientLayer
        stageAuraBlend.colors = [
            UIColor(red: 0.01, green: 0.02, blue: 0.06, alpha: 0.9).cgColor,
            UIColor(red: 0.05, green: 0.30, blue: 0.52, alpha: 0.38).cgColor,
            UIColor(red: 0.74, green: 0.04, blue: 0.52, alpha: 0.22).cgColor,
            UIColor.black.withAlphaComponent(0.88).cgColor
        ]
        stageAuraBlend.locations = [0, 0.42, 0.72, 1]
        stageAuraBlend.startPoint = CGPoint(x: 0.1, y: 0)
        stageAuraBlend.endPoint = CGPoint(x: 0.9, y: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private final class TinkieRhythmRingView: UIView {
    override func draw(_ rect: CGRect) {
        let ringCenter = CGPoint(x: rect.midX, y: rect.midY)
        let ringRadius = min(rect.width, rect.height) / 2 - 5
        let ringColors = [
            UIColor(red: 0.91, green: 0.08, blue: 0.64, alpha: 1),
            UIColor(red: 0.12, green: 0.84, blue: 0.80, alpha: 1)
        ]
        for ringPart in 0..<2 {
            let ringArc = UIBezierPath(arcCenter: ringCenter, radius: ringRadius, startAngle: CGFloat(ringPart) * .pi - .pi / 2, endAngle: CGFloat(ringPart + 1) * .pi - .pi / 2, clockwise: true)
            ringArc.lineWidth = 4
            ringColors[ringPart].setStroke()
            ringArc.stroke()
        }
    }
}
