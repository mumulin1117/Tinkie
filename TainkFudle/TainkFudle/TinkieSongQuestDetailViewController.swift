import UIKit

final class TinkieSongQuestDetailViewController: UIViewController {
    private let songQuest: TinkieSongQuestTune
    private let questScrollStage = UIScrollView()
    private let questCanvasStage = UIView()
    private let questHeroStage = UIView()
    
    private let recordFrameImageView = UIImageView(image: UIImage(named: "tinkie_event_cover_frame"))
    private let vinylTurntableImageView = UIImageView(image: UIImage(named: "tinkie_event_vinyl_turntable"))
    
    
    private let questCoverImageView = UIImageView()
    private let entryStatusLabel = TinkiePillLabel(text: "", foreground: .black, background: UIColor(red: 0.17, green: 0.92, blue: 0.78, alpha: 1))
    private let questTitleLabel = UILabel()
    private let questSubtitleLabel = UILabel()
    private let questPanelView = UIView()
    private let chordStack = UIStackView()
    private var entryState: TinkieQuestEntryState

    init(event: TinkieSongQuestTune) {
        self.songQuest = event
        self.entryState = TinkieQuestEntryScorebook.entryState(for: event)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        putSongQuestDetailTogether()
        reloadQuestEntryState()
    }

    private func putSongQuestDetailTogether() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.98, blue: 0.98, alpha: 1)
        navigationController?.setNavigationBarHidden(true, animated: false)
        questScrollStage.contentInsetAdjustmentBehavior = .never
        questScrollStage.translatesAutoresizingMaskIntoConstraints = false
        questScrollStage.alwaysBounceVertical = true
        questScrollStage.showsVerticalScrollIndicator = false
        view.addSubview(questScrollStage)

        questCanvasStage.translatesAutoresizingMaskIntoConstraints = false
        questScrollStage.addSubview(questCanvasStage)

        questHeroStage.translatesAutoresizingMaskIntoConstraints = false
        questHeroStage.backgroundColor = UIColor(red: 0.01, green: 0.03, blue: 0.03, alpha: 1)
        questHeroStage.layer.masksToBounds = true
        questCanvasStage.addSubview(questHeroStage)

        let questAuraView = TinkieSongQuestAuraView()
        questAuraView.translatesAutoresizingMaskIntoConstraints = false
        questHeroStage.addSubview(questAuraView)

        let backTuneButton = TinkieSongQuestRoundIconButton(symbolName: "chevron.left")
        backTuneButton.addTarget(self, action: #selector(closeQuestTapped), for: .touchUpInside)
        backTuneButton.translatesAutoresizingMaskIntoConstraints = false
        questHeroStage.addSubview(backTuneButton)

        let questHeadingLabel = UILabel()
        questHeadingLabel.text = "Event Details"
        questHeadingLabel.textColor = .white
        questHeadingLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        questHeadingLabel.translatesAutoresizingMaskIntoConstraints = false
        questHeroStage.addSubview(questHeadingLabel)

        let questMoreButton = TinkieSongQuestRoundIconButton(symbolName: "ellipsis")
        questMoreButton.addTarget(self, action: #selector(openRhythmMore), for: .touchUpInside)
        questMoreButton.translatesAutoresizingMaskIntoConstraints = false
        questHeroStage.addSubview(questMoreButton)

        let recordRingView = TinkieSongQuestRecordRingView()
        recordRingView.translatesAutoresizingMaskIntoConstraints = false
        questHeroStage.addSubview(recordRingView)

        
        recordFrameImageView.contentMode = .scaleAspectFit
        recordFrameImageView.translatesAutoresizingMaskIntoConstraints = false
        questHeroStage.addSubview(recordFrameImageView)

        
        if let coverTunePath = songQuest.coverPath, let questLocalArt = UIImage(contentsOfFile: coverTunePath) {
            questCoverImageView.image = questLocalArt
        } else {
            questCoverImageView.image = UIImage(named: songQuest.coverName)
        }
        questCoverImageView.contentMode = .scaleAspectFill
        questCoverImageView.layer.cornerRadius = 146/2
        questCoverImageView.layer.masksToBounds = true
        questCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        questHeroStage.addSubview(questCoverImageView)

        vinylTurntableImageView.contentMode = .scaleAspectFit
        vinylTurntableImageView.translatesAutoresizingMaskIntoConstraints = false
        questHeroStage.addSubview(vinylTurntableImageView)

        questTitleLabel.text = songQuest.title
        questTitleLabel.textColor = .white
        questTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        questTitleLabel.textAlignment = .center
        questTitleLabel.numberOfLines = 2
        questTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        questHeroStage.addSubview(questTitleLabel)

        questSubtitleLabel.text = songQuest.subtitle
        questSubtitleLabel.textColor = UIColor.white.withAlphaComponent(0.78)
        questSubtitleLabel.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        questSubtitleLabel.textAlignment = .center
        questSubtitleLabel.numberOfLines = 3
        questSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        questHeroStage.addSubview(questSubtitleLabel)

        questPanelView.backgroundColor = .white
        questPanelView.layer.cornerRadius = 18
        questPanelView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        questPanelView.layer.masksToBounds = true
        questPanelView.translatesAutoresizingMaskIntoConstraints = false
        questCanvasStage.addSubview(questPanelView)

        let scheduleRow = makeQuestScheduleLine()
        scheduleRow.translatesAutoresizingMaskIntoConstraints = false
        questPanelView.addSubview(scheduleRow)

        entryStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        questPanelView.addSubview(entryStatusLabel)

        let chordSeparator = UIView()
        chordSeparator.backgroundColor = UIColor.black.withAlphaComponent(0.06)
        chordSeparator.translatesAutoresizingMaskIntoConstraints = false
        questPanelView.addSubview(chordSeparator)

        let chordSectionLabel = UILabel()
        chordSectionLabel.text = "Group Details"
        chordSectionLabel.textColor = UIColor.black.withAlphaComponent(0.25)
        chordSectionLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        chordSectionLabel.translatesAutoresizingMaskIntoConstraints = false
        questPanelView.addSubview(chordSectionLabel)

        chordStack.axis = .vertical
        chordStack.spacing = 18
        chordStack.translatesAutoresizingMaskIntoConstraints = false
        questPanelView.addSubview(chordStack)

        NSLayoutConstraint.activate([
            questScrollStage.topAnchor.constraint(equalTo: view.topAnchor),
            questScrollStage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            questScrollStage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            questScrollStage.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            questCanvasStage.topAnchor.constraint(equalTo: questScrollStage.contentLayoutGuide.topAnchor),
            questCanvasStage.leadingAnchor.constraint(equalTo: questScrollStage.contentLayoutGuide.leadingAnchor),
            questCanvasStage.trailingAnchor.constraint(equalTo: questScrollStage.contentLayoutGuide.trailingAnchor),
            questCanvasStage.bottomAnchor.constraint(equalTo: questScrollStage.contentLayoutGuide.bottomAnchor),
            questCanvasStage.widthAnchor.constraint(equalTo: questScrollStage.frameLayoutGuide.widthAnchor),

            questHeroStage.topAnchor.constraint(equalTo: questCanvasStage.topAnchor),
            questHeroStage.leadingAnchor.constraint(equalTo: questCanvasStage.leadingAnchor),
            questHeroStage.trailingAnchor.constraint(equalTo: questCanvasStage.trailingAnchor),
            questHeroStage.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            questAuraView.topAnchor.constraint(equalTo: questHeroStage.topAnchor),
            questAuraView.leadingAnchor.constraint(equalTo: questHeroStage.leadingAnchor),
            questAuraView.trailingAnchor.constraint(equalTo: questHeroStage.trailingAnchor),
            questAuraView.bottomAnchor.constraint(equalTo: questHeroStage.bottomAnchor),

            backTuneButton.leadingAnchor.constraint(equalTo: questHeroStage.leadingAnchor, constant: 18),
            backTuneButton.topAnchor.constraint(equalTo: questHeroStage.safeAreaLayoutGuide.topAnchor, constant: 12),
            questHeadingLabel.centerYAnchor.constraint(equalTo: backTuneButton.centerYAnchor),
            questHeadingLabel.centerXAnchor.constraint(equalTo: questHeroStage.centerXAnchor),
            questMoreButton.trailingAnchor.constraint(equalTo: questHeroStage.trailingAnchor, constant: -18),
            questMoreButton.centerYAnchor.constraint(equalTo: backTuneButton.centerYAnchor),

         

            recordFrameImageView.topAnchor.constraint(equalTo: questMoreButton.bottomAnchor, constant: 16),
            recordFrameImageView.centerXAnchor.constraint(equalTo: questCanvasStage.centerXAnchor),
            recordFrameImageView.widthAnchor.constraint(equalToConstant: 180),
            recordFrameImageView.heightAnchor.constraint(equalTo: recordFrameImageView.widthAnchor),
            recordRingView.centerYAnchor.constraint(equalTo: recordFrameImageView.centerYAnchor),
            recordRingView.centerXAnchor.constraint(equalTo: recordFrameImageView.centerXAnchor),
            recordRingView.widthAnchor.constraint(equalToConstant: 208),
            recordRingView.heightAnchor.constraint(equalToConstant: 208),
         
            questCoverImageView.centerXAnchor.constraint(equalTo: recordFrameImageView.centerXAnchor),
            questCoverImageView.centerYAnchor.constraint(equalTo: recordFrameImageView.centerYAnchor),
            questCoverImageView.widthAnchor.constraint(equalToConstant: 146),
            questCoverImageView.heightAnchor.constraint(equalToConstant: 146),

            vinylTurntableImageView.centerXAnchor.constraint(equalTo: recordFrameImageView.centerXAnchor),
            vinylTurntableImageView.centerYAnchor.constraint(equalTo: recordFrameImageView.centerYAnchor),
            vinylTurntableImageView.widthAnchor.constraint(equalToConstant: 94),
            vinylTurntableImageView.heightAnchor.constraint(equalToConstant: 94),
            
          

            questTitleLabel.topAnchor.constraint(equalTo: recordRingView.bottomAnchor, constant: 18),
            questTitleLabel.leadingAnchor.constraint(equalTo: questHeroStage.leadingAnchor, constant: 36),
            questTitleLabel.trailingAnchor.constraint(equalTo: questHeroStage.trailingAnchor, constant: -36),

            questSubtitleLabel.topAnchor.constraint(equalTo: questTitleLabel.bottomAnchor, constant: 8),
            questSubtitleLabel.leadingAnchor.constraint(equalTo: questHeroStage.leadingAnchor, constant: 42),
            questSubtitleLabel.trailingAnchor.constraint(equalTo: questHeroStage.trailingAnchor, constant: -42),
            questSubtitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: questHeroStage.bottomAnchor, constant: -36),

            questPanelView.topAnchor.constraint(equalTo: questHeroStage.bottomAnchor, constant: -30),
            questPanelView.leadingAnchor.constraint(equalTo: questCanvasStage.leadingAnchor, constant: 12),
            questPanelView.trailingAnchor.constraint(equalTo: questCanvasStage.trailingAnchor, constant: -12),
            questPanelView.bottomAnchor.constraint(equalTo: questCanvasStage.bottomAnchor, constant: -24),

            scheduleRow.topAnchor.constraint(equalTo: questPanelView.topAnchor, constant: 14),
            scheduleRow.leadingAnchor.constraint(equalTo: questPanelView.leadingAnchor, constant: 14),
            scheduleRow.trailingAnchor.constraint(lessThanOrEqualTo: entryStatusLabel.leadingAnchor, constant: -10),

            entryStatusLabel.topAnchor.constraint(equalTo: questPanelView.topAnchor, constant: 10),
            entryStatusLabel.trailingAnchor.constraint(equalTo: questPanelView.trailingAnchor, constant: -10),

            chordSeparator.topAnchor.constraint(equalTo: scheduleRow.bottomAnchor, constant: 14),
            chordSeparator.leadingAnchor.constraint(equalTo: questPanelView.leadingAnchor),
            chordSeparator.trailingAnchor.constraint(equalTo: questPanelView.trailingAnchor),
            chordSeparator.heightAnchor.constraint(equalToConstant: 1),

            chordSectionLabel.topAnchor.constraint(equalTo: chordSeparator.bottomAnchor, constant: 16),
            chordSectionLabel.leadingAnchor.constraint(equalTo: questPanelView.leadingAnchor, constant: 14),
            chordSectionLabel.trailingAnchor.constraint(equalTo: questPanelView.trailingAnchor, constant: -14),

            chordStack.topAnchor.constraint(equalTo: chordSectionLabel.bottomAnchor, constant: 14),
            chordStack.leadingAnchor.constraint(equalTo: questPanelView.leadingAnchor, constant: 14),
            chordStack.trailingAnchor.constraint(equalTo: questPanelView.trailingAnchor, constant: -14),
            chordStack.bottomAnchor.constraint(equalTo: questPanelView.bottomAnchor, constant: -18)
        ])
    }

    private func makeQuestScheduleLine() -> UIStackView {
        let dateCue = TinkieSongQuestScheduleChip(symbolName: "calendar", text: songQuest.dateText)
        let timeCue = TinkieSongQuestScheduleChip(symbolName: "clock", text: songQuest.timeText)
        let questScheduleRow = UIStackView(arrangedSubviews: [dateCue, timeCue])
        questScheduleRow.axis = .horizontal
        questScheduleRow.alignment = .center
        questScheduleRow.spacing = 22
        return questScheduleRow
    }

    private func reloadQuestEntryState() {
        entryState = TinkieQuestEntryScorebook.entryState(for: songQuest)
        switch entryState.availability {
        case .open:
            entryStatusLabel.text = "OPEN"
            entryStatusLabel.backgroundColor = UIColor(red: 0.17, green: 0.92, blue: 0.78, alpha: 1)
            entryStatusLabel.textColor = .black
        case .ended:
            entryStatusLabel.text = "Ended"
            entryStatusLabel.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
            entryStatusLabel.textColor = UIColor.black.withAlphaComponent(0.25)
        }

        chordStack.arrangedSubviews.forEach { view in
            chordStack.removeArrangedSubview(view)
            view.removeFromSuperview()
        }

        TinkieQuestEntryScorebook.detailChords(for: songQuest).forEach { chord in
            let card = TinkieSongQuestChordCard()
            let isChordJoined = TinkieQuestEntryScorebook.isChordJoined(chord, for: songQuest)
            card.tuneChordCard(chord: chord, eventEnded: entryState.availability == .ended, joined: isChordJoined)
            card.onChordTap = { [weak self] in
                self?.handleChordEntry(chord)
            }
            chordStack.addArrangedSubview(card)
        }
    }

    private func handleChordEntry(_ chord: TinkieSongQuestChord) {
        guard entryState.availability == .open else { return }
        if TinkieQuestEntryScorebook.isChordJoined(chord, for: songQuest) {
            guard !TinkieSongShieldLedger.alreadyShieldedRoom(event: songQuest, group: chord) else {
                showBlockedRoomNotice()
                return
            }
            openRhythmRoomStage(chord)
            return
        }
        if TinkieQuestEntryScorebook.hasJoinedDifferentChord(chord, for: songQuest) {
            showAlreadyJoinedNotice()
            return
        }
        guard TinkieSingerStageScorebook.isSingerOnStage else {
            openRhythmWelcome(joinAfterEntry: chord)
            return
        }
        guard TinkieSingerStageScorebook.spendGemRhythm(chord.gemNeed) else {
            showInsufficientGems(for: chord)
            return
        }
        TinkieQuestEntryScorebook.joinChord( chord, for: songQuest)
        reloadQuestEntryState()
    }

    private func openRhythmWelcome(joinAfterEntry chord: TinkieSongQuestChord?) {
        let welcome = TinkieMelodyGateWelcomeViewController()
        welcome.onMelodyGateDone = { [weak self] in
            self?.dismiss(animated: true) {
                if let chord {
                    self?.handleChordEntry(chord)
                } else {
                    self?.reloadQuestEntryState()
                }
            }
        }
        let navigation = UINavigationController(rootViewController: welcome)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    private func showInsufficientGems(for chord: TinkieSongQuestChord) {
        let balance = TinkieSingerStageScorebook.currentSingerStage().balance
        tinkieShowTuneNotice(
            title: "Not Enough Gems",
            detail: "Joining this event needs \(chord.gemNeed) Gems. Your current balance is \(balance). Do you want to recharge now?",
            primaryTitle: "Recharge",
            secondaryTitle: "Cancel",
            onPrimary: { [weak self] in
                self?.openRhythmGemVault()
            }
        )
    }

    private func openRhythmGemVault() {
        let gemVault = TinkieRhythmGemVaultViewController()
        gemVault.onGemRhythmChanged = { [weak self] in
            self?.reloadQuestEntryState()
        }
        let navigation = UINavigationController(rootViewController: gemVault)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    private func showAlreadyJoinedNotice() {
        tinkieShowTuneNotice(
            title: "Already Joined",
            detail: "You have already joined another group for this event. Open that group room from its own button."
        )
    }

    private func showBlockedRoomNotice() {
        tinkieShowTuneNotice(
            title: "Room Blocked",
            detail: "This group room is hidden on this device. You can remove it from the Blocked List in Setting."
        )
    }

    private func openRhythmRoomStage(_ chord: TinkieSongQuestChord) {
        let rhythmRoom = TinkieRhythmRoomStageViewController(event: songQuest, group: chord)
        let navigation = UINavigationController(rootViewController: rhythmRoom)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    @objc private func openRhythmMore() {
        tinkiePresentRhythmShield(
            tuneTitle: songQuest.title,
            tuneKey: TinkieSongShieldLedger.questKey(for: songQuest),
            tuneKind: "activity",
            onShieldDone: { [weak self] in
                self?.dismiss(animated: true)
            }
        )
    }

    private func guardedQuestOption(tuneTitle: String, tuneDetail: String) {
        guard TinkieSingerStageScorebook.isSingerOnStage else {
            openRhythmWelcome(joinAfterEntry: nil)
            return
        }
        let route = TinkieSingerRouteNoteViewController(titleText: tuneTitle, detailText: tuneDetail, showsSignOut: false)
        let navigation = UINavigationController(rootViewController: route)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    @objc private func closeQuestTapped() {
        dismiss(animated: true)
    }
}

final class TinkieSongQuestChordCard: UIView {
    var onChordTap: (() -> Void)?
    private let chordTitleLabel = UILabel()
    private let chordTagStack = UIStackView()
    private let singerAvatarStack = UIStackView()
    private let chordCountLabel = UILabel()
    private let chordActionButton = TinkieSongQuestActionButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        putChordChoiceCardTogether()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tuneChordCard(chord: TinkieSongQuestChord, eventEnded: Bool, joined: Bool) {
        chordTitleLabel.text = chord.name
        chordCountLabel.text = "\(chord.joinedCount) joined · \(chord.spotsLeft) spots left"

        chordTagStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        chord.tags.forEach { chordTagStack.addArrangedSubview(TinkieSongQuestTagLabel(text: $0)) }

        singerAvatarStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        chord.avatarNames.prefix(4).forEach { singerAvatarStack.addArrangedSubview(TinkieAvatarView(imageName: $0, size: 24)) }

        if eventEnded {
            chordActionButton.tuneQuestAction(rhythmTitle: "Registration Closed", mode: .closed)
        } else if joined {
            chordActionButton.tuneQuestAction(rhythmTitle: "Open Event Room", mode: .active)
        } else {
            chordActionButton.tuneQuestAction(rhythmTitle: "Join for \(chord.gemNeed) Gems", mode: .active, showsGem: true)
        }
        chordActionButton.isEnabled = !eventEnded
    }

    private func putChordChoiceCardTogether() {
        backgroundColor = UIColor(red: 0.985, green: 0.985, blue: 0.985, alpha: 1)
        layer.cornerRadius = 14
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.04
        layer.shadowRadius = 12
        layer.shadowOffset = CGSize(width: 0, height: 6)

        chordTitleLabel.textColor = .black
        chordTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        chordTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(chordTitleLabel)

        chordTagStack.axis = .horizontal
        chordTagStack.spacing = 8
        chordTagStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(chordTagStack)

        singerAvatarStack.axis = .horizontal
        singerAvatarStack.spacing = -8
        singerAvatarStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(singerAvatarStack)

        chordCountLabel.textColor = UIColor.black.withAlphaComponent(0.62)
        chordCountLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        chordCountLabel.adjustsFontSizeToFitWidth = true
        chordCountLabel.minimumScaleFactor = 0.78
        chordCountLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(chordCountLabel)

        chordActionButton.addTarget(self, action: #selector(chordTapped), for: .touchUpInside)
        chordActionButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(chordActionButton)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(greaterThanOrEqualToConstant: 146),

            chordTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            chordTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            chordTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            chordTagStack.topAnchor.constraint(equalTo: chordTitleLabel.bottomAnchor, constant: 12),
            chordTagStack.leadingAnchor.constraint(equalTo: chordTitleLabel.leadingAnchor),
            chordTagStack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),

            singerAvatarStack.topAnchor.constraint(equalTo: chordTagStack.bottomAnchor, constant: 14),
            singerAvatarStack.leadingAnchor.constraint(equalTo: chordTitleLabel.leadingAnchor),
            singerAvatarStack.heightAnchor.constraint(equalToConstant: 24),

            chordCountLabel.leadingAnchor.constraint(equalTo: singerAvatarStack.trailingAnchor, constant: 12),
            chordCountLabel.centerYAnchor.constraint(equalTo: singerAvatarStack.centerYAnchor),
            chordCountLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),

            chordActionButton.topAnchor.constraint(equalTo: singerAvatarStack.bottomAnchor, constant: 14),
            chordActionButton.leadingAnchor.constraint(equalTo: chordTitleLabel.leadingAnchor),
            chordActionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            chordActionButton.heightAnchor.constraint(equalToConstant: 42),
            chordActionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    @objc private func chordTapped() {
        onChordTap?()
    }
}

final class TinkieSongQuestOptionViewController: UIViewController {
    var onQuestReport: (() -> Void)?
    var onQuestKeep: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.96, green: 0.98, blue: 0.98, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(closeQuestOptionsOnly))

        let optionTitleLabel = UILabel()
        optionTitleLabel.text = "Event Options"
        optionTitleLabel.textColor = .black
        optionTitleLabel.font = UIFont.systemFont(ofSize: 28, weight: .black)

        let reportTuneButton = TinkieSongQuestMenuButton(questMenuTitle: "Report")
        reportTuneButton.addTarget(self, action: #selector(reportTuneTapped), for: .touchUpInside)

        let keepTuneButton = TinkieSongQuestMenuButton(questMenuTitle: "Keep")
        keepTuneButton.addTarget(self, action: #selector(keepTuneTapped), for: .touchUpInside)

        let optionStack = UIStackView(arrangedSubviews: [optionTitleLabel, reportTuneButton, keepTuneButton])
        optionStack.axis = .vertical
        optionStack.spacing = 16
        optionStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(optionStack)

        NSLayoutConstraint.activate([
            optionStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            optionStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            optionStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            reportTuneButton.heightAnchor.constraint(equalToConstant: 50),
            keepTuneButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func closeQuestOptionsOnly() {
        dismiss(animated: true)
    }

    @objc private func reportTuneTapped() {
        dismiss(animated: true) { [onQuestReport] in onQuestReport?() }
    }

    @objc private func keepTuneTapped() {
        dismiss(animated: true) { [onQuestKeep] in onQuestKeep?() }
    }
}

final class TinkieSongQuestMenuButton: UIButton {
    init(questMenuTitle: String) {
        super.init(frame: .zero)
        setTitle(questMenuTitle, for: .normal)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        backgroundColor = .white
        layer.cornerRadius = 12
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TinkieSongQuestActionButton: UIButton {
    enum QuestBeatMode {
        case active
        case closed
    }

    override class var layerClass: AnyClass { CAGradientLayer.self }
    private let gemMarkImageView = UIImageView(image: UIImage(named: "tinkie_profile_balance_gem"))
    private var questActionTitleText = ""

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 21
        layer.masksToBounds = true
        titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .black)
        setTitleColor(.white, for: .normal)
        gemMarkImageView.contentMode = .scaleAspectFit
        gemMarkImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gemMarkImageView)
        NSLayoutConstraint.activate([
            gemMarkImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            gemMarkImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 68),
            gemMarkImageView.widthAnchor.constraint(equalToConstant: 18),
            gemMarkImageView.heightAnchor.constraint(equalToConstant: 18)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tuneQuestAction(rhythmTitle: String, mode: QuestBeatMode, showsGem: Bool = false) {
        questActionTitleText = rhythmTitle
        setTitle(rhythmTitle, for: .normal)
        gemMarkImageView.isHidden = !showsGem
        let beatGradient = layer as! CAGradientLayer
        switch mode {
        case .active:
            beatGradient.colors = [
                UIColor(red: 0.88, green: 0.06, blue: 0.62, alpha: 1).cgColor,
                UIColor(red: 0.13, green: 0.85, blue: 0.79, alpha: 1).cgColor
            ]
            alpha = 1
        case .closed:
            beatGradient.colors = [
                UIColor(red: 0.93, green: 0.42, blue: 0.70, alpha: 1).cgColor,
                UIColor(red: 0.42, green: 0.88, blue: 0.84, alpha: 1).cgColor
            ]
            alpha = 0.72
        }
        beatGradient.startPoint = CGPoint(x: 0, y: 0.5)
        beatGradient.endPoint = CGPoint(x: 1, y: 0.5)
    }

    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        var rect = super.titleRect(forContentRect: contentRect)
        if !gemMarkImageView.isHidden {
            rect.origin.x -= 10
        }
        return rect
    }
}

final class TinkieSongQuestScheduleChip: UIStackView {
    init(symbolName: String, text: String) {
        let cueIconView = UIImageView(image: UIImage(systemName: symbolName))
        cueIconView.tintColor = UIColor.black.withAlphaComponent(0.7)
        cueIconView.contentMode = .scaleAspectFit
        cueIconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cueIconView.widthAnchor.constraint(equalToConstant: 16),
            cueIconView.heightAnchor.constraint(equalToConstant: 16)
        ])

        let cueTextLabel = UILabel()
        cueTextLabel.text = text
        cueTextLabel.textColor = .black
        cueTextLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        cueTextLabel.adjustsFontSizeToFitWidth = true
        cueTextLabel.minimumScaleFactor = 0.8

        super.init(frame: .zero)
        axis = .horizontal
        alignment = .center
        spacing = 7
        addArrangedSubview(cueIconView)
        addArrangedSubview(cueTextLabel)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TinkieSongQuestTagLabel: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        textColor = UIColor(red: 0.88, green: 0.06, blue: 0.62, alpha: 1)
        backgroundColor = UIColor(red: 1, green: 0.9, blue: 0.97, alpha: 1)
        font = UIFont.systemFont(ofSize: 11, weight: .medium)
        textAlignment = .center
        layer.cornerRadius = 3
        layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + 14, height: 24)
    }
}

final class TinkieSongQuestRoundIconButton: UIButton {
    init(symbolName: String) {
        super.init(frame: .zero)
        setImage(UIImage(systemName: symbolName), for: .normal)
        tintColor = .white
        imageView?.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 38),
            heightAnchor.constraint(equalToConstant: 38)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TinkieSongQuestRecordRingView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        let recordCenter = CGPoint(x: rect.midX, y: rect.midY)
        let recordRadius = min(rect.width, rect.height) / 2 - 8
        let grooveLineWidth: CGFloat = 16
        let grooveColors = [
            UIColor(red: 0.10, green: 0.86, blue: 0.80, alpha: 1),
            UIColor(red: 0.96, green: 0.09, blue: 0.68, alpha: 1),
            UIColor(red: 0.18, green: 0.28, blue: 0.95, alpha: 1)
        ]
        for index in 0..<3 {
            let grooveStart = CGFloat(index) * .pi * 2 / 3 - .pi / 2
            let grooveEnd = grooveStart + .pi * 1.58 / 3
            let groovePath = UIBezierPath(arcCenter: recordCenter, radius: recordRadius, startAngle: grooveStart, endAngle: grooveEnd, clockwise: true)
            groovePath.lineWidth = grooveLineWidth
            groovePath.lineCapStyle = .round
            grooveColors[index].setStroke()
            groovePath.stroke()
        }
    }
}

final class TinkieSongQuestAuraView: UIView {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let questAuraGradient = layer as! CAGradientLayer
        questAuraGradient.colors = [
            UIColor.black.cgColor,
            UIColor(red: 0.02, green: 0.22, blue: 0.14, alpha: 1).cgColor,
            UIColor.black.cgColor
        ]
        questAuraGradient.locations = [0, 0.48, 1]
        questAuraGradient.startPoint = CGPoint(x: 0, y: 0)
        questAuraGradient.endPoint = CGPoint(x: 1, y: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
