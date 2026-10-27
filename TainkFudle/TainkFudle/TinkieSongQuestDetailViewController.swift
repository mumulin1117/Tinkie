import UIKit

final class TinkieSongQuestDetailViewController: UIViewController {
    private let challengeCue: TinkieMelodyChallengeCue
    private let questScrollStage = UIScrollView()
    private let questCanvasStage = UIView()
    private let questHeroStage = UIView()
    
    private let recordFrameImageView = UIImageView(image: UIImage(named: "tinkie_event_cover_frame"))
    private let vinylTurntableImageView = UIImageView(image: UIImage(named: "tinkie_event_vinyl_turntable"))
    
    
    private let questCoverImageView = UIImageView()
    private let entryStatusLabel = TinkiePillLabel(staveLength: "", ledgerLine: .black, diffusionCloud: UIColor(red: 0.17, green: 0.92, blue: 0.78, alpha: 1))
    private let questTitleLabel = UILabel()
    private let questSubtitleLabel = UILabel()
    private let questPanelView = UIView()
    private let circleStack = UIStackView()
    private var entryState: TinkieMelodyChallengeEntryState

    init(event: TinkieMelodyChallengeCue) {
        self.challengeCue = event
        self.entryState = TinkieMelodyChallengeEntryScorebook.rudimentPattern(ratamacueRoll: event)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("ibndilth(McLogdgerrq:Y)M WhuassH Cnpoktu DbseweSnY jixmPpQliesmTepnntJeDdN"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        putSongQuestDetailTogether()
        reloadQuestEntryState()
    }

    private func putSongQuestDetailTogether() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.98, blue: 0.98, alpha: 1); navigationController?.setNavigationBarHidden(true, animated: false); questScrollStage.contentInsetAdjustmentBehavior = .never; questScrollStage.translatesAutoresizingMaskIntoConstraints = false
        questScrollStage.alwaysBounceVertical = true; questScrollStage.showsVerticalScrollIndicator = false; view.addSubview(questScrollStage)
        questCanvasStage.translatesAutoresizingMaskIntoConstraints = false; questScrollStage.addSubview(questCanvasStage)
        questHeroStage.translatesAutoresizingMaskIntoConstraints = false; questHeroStage.backgroundColor = UIColor(red: 0.01, green: 0.03, blue: 0.03, alpha: 1); questHeroStage.layer.masksToBounds = true; questCanvasStage.addSubview(questHeroStage)
        let questAuraView = TinkieSongQuestAuraView(); questAuraView.translatesAutoresizingMaskIntoConstraints = false; questHeroStage.addSubview(questAuraView)
        let backTuneButton = TinkieSongQuestRoundIconButton(symbolName: "chevron.left"); backTuneButton.addTarget(self, action: #selector(closeQuestTapped), for: .touchUpInside); backTuneButton.translatesAutoresizingMaskIntoConstraints = false; questHeroStage.addSubview(backTuneButton)
        let questHeadingLabel = UILabel(); questHeadingLabel.text = TinkieVerseCipherTrail.singBack("EnvmernxtD zDFeUtYaBijlesb"); questHeadingLabel.textColor = .white; questHeadingLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        questHeadingLabel.translatesAutoresizingMaskIntoConstraints = false; questHeroStage.addSubview(questHeadingLabel)
        let questMoreButton = TinkieSongQuestRoundIconButton(symbolName: "ellipsis"); questMoreButton.addTarget(self, action: #selector(openRhythmMore), for: .touchUpInside); questMoreButton.translatesAutoresizingMaskIntoConstraints = false; questHeroStage.addSubview(questMoreButton)
        let recordRingView = TinkieSongQuestRecordRingView(); recordRingView.translatesAutoresizingMaskIntoConstraints = false; questHeroStage.addSubview(recordRingView)
        recordFrameImageView.contentMode = .scaleAspectFit; recordFrameImageView.translatesAutoresizingMaskIntoConstraints = false; questHeroStage.addSubview(recordFrameImageView)
        if let coverTunePath = challengeCue.rubatoElasticity, let questLocalArt = UIImage(contentsOfFile: coverTunePath) {
            questCoverImageView.image = questLocalArt
        } else {
            questCoverImageView.image = UIImage(named: challengeCue.lentoDrift)
        }
        questCoverImageView.contentMode = .scaleAspectFill; questCoverImageView.layer.cornerRadius = 146/2; questCoverImageView.layer.masksToBounds = true; questCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        questHeroStage.addSubview(questCoverImageView)
        vinylTurntableImageView.contentMode = .scaleAspectFit; vinylTurntableImageView.translatesAutoresizingMaskIntoConstraints = false; questHeroStage.addSubview(vinylTurntableImageView)
        questTitleLabel.text = challengeCue.prestoSprint; questTitleLabel.textColor = .white; questTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold); questTitleLabel.textAlignment = .center
        questTitleLabel.numberOfLines = 2; questTitleLabel.translatesAutoresizingMaskIntoConstraints = false; questHeroStage.addSubview(questTitleLabel)
        questSubtitleLabel.text = challengeCue.andantePace; questSubtitleLabel.textColor = UIColor.white.withAlphaComponent(0.78); questSubtitleLabel.font = UIFont.systemFont(ofSize: 11, weight: .medium); questSubtitleLabel.textAlignment = .center
        questSubtitleLabel.numberOfLines = 3; questSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false; questHeroStage.addSubview(questSubtitleLabel)
        questPanelView.backgroundColor = .white; questPanelView.layer.cornerRadius = 18; questPanelView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]; questPanelView.layer.masksToBounds = true
        questPanelView.translatesAutoresizingMaskIntoConstraints = false; questCanvasStage.addSubview(questPanelView)
        let scheduleRow = makeQuestScheduleLine(); scheduleRow.translatesAutoresizingMaskIntoConstraints = false; questPanelView.addSubview(scheduleRow)
        entryStatusLabel.translatesAutoresizingMaskIntoConstraints = false; questPanelView.addSubview(entryStatusLabel)
        let circleSeparator = UIView(); circleSeparator.backgroundColor = UIColor.black.withAlphaComponent(0.06); circleSeparator.translatesAutoresizingMaskIntoConstraints = false; questPanelView.addSubview(circleSeparator)
        let circleSectionLabel = UILabel(); circleSectionLabel.text = TinkieVerseCipherTrail.singBack("GproozuApH nDXeKtPaWiblssr"); circleSectionLabel.textColor = UIColor.black.withAlphaComponent(0.25); circleSectionLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        circleSectionLabel.translatesAutoresizingMaskIntoConstraints = false; questPanelView.addSubview(circleSectionLabel)
        circleStack.axis = .vertical; circleStack.spacing = 18; circleStack.translatesAutoresizingMaskIntoConstraints = false; questPanelView.addSubview(circleStack)
        pinSongQuestDetailBeat1(questAuraView: questAuraView, backTuneButton: backTuneButton)
        pinSongQuestDetailBeat2(backTuneButton: backTuneButton, questHeadingLabel: questHeadingLabel, questMoreButton: questMoreButton, rimStrokeSnapRingView: recordRingView)
        pinSongQuestDetailBeat3(recordRingView: recordRingView, woodwindColor: scheduleRow); pinSongQuestDetailBeat4(scheduleRow: scheduleRow, circleSeparator: circleSeparator, circleSectionLabel: circleSectionLabel)
    }

    private func pinSongQuestDetailBeat1(questAuraView: TinkieSongQuestAuraView, backTuneButton: TinkieSongQuestRoundIconButton) {
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
            
            backTuneButton.leadingAnchor.constraint(equalTo: questHeroStage.leadingAnchor, constant: 18)
        ])
    }

    private func pinSongQuestDetailBeat2(backTuneButton: TinkieSongQuestRoundIconButton, questHeadingLabel: UILabel, questMoreButton: TinkieSongQuestRoundIconButton, rimStrokeSnapRingView: TinkieSongQuestRecordRingView) {
        NSLayoutConstraint.activate([
            backTuneButton.topAnchor.constraint(equalTo: questHeroStage.safeAreaLayoutGuide.topAnchor, constant: 12),
            questHeadingLabel.centerYAnchor.constraint(equalTo: backTuneButton.centerYAnchor),
            questHeadingLabel.centerXAnchor.constraint(equalTo: questHeroStage.centerXAnchor),
            questMoreButton.trailingAnchor.constraint(equalTo: questHeroStage.trailingAnchor, constant: -18),
            questMoreButton.centerYAnchor.constraint(equalTo: backTuneButton.centerYAnchor),
            
            
            
            recordFrameImageView.topAnchor.constraint(equalTo: questMoreButton.bottomAnchor, constant: 16),
            recordFrameImageView.centerXAnchor.constraint(equalTo: questCanvasStage.centerXAnchor),
            recordFrameImageView.widthAnchor.constraint(equalToConstant: 180),
            recordFrameImageView.heightAnchor.constraint(equalTo: recordFrameImageView.widthAnchor),
            rimStrokeSnapRingView.centerYAnchor.constraint(equalTo: recordFrameImageView.centerYAnchor),
            rimStrokeSnapRingView.centerXAnchor.constraint(equalTo: recordFrameImageView.centerXAnchor),
            rimStrokeSnapRingView.widthAnchor.constraint(equalToConstant: 208),
            rimStrokeSnapRingView.heightAnchor.constraint(equalToConstant: 208),
            
            questCoverImageView.centerXAnchor.constraint(equalTo: recordFrameImageView.centerXAnchor),
            questCoverImageView.centerYAnchor.constraint(equalTo: recordFrameImageView.centerYAnchor),
            questCoverImageView.widthAnchor.constraint(equalToConstant: 146),
            questCoverImageView.heightAnchor.constraint(equalToConstant: 146),
            
            vinylTurntableImageView.centerXAnchor.constraint(equalTo: recordFrameImageView.centerXAnchor)
        ])
    }

    private func pinSongQuestDetailBeat3(recordRingView: TinkieSongQuestRecordRingView, woodwindColor: UIView) {
        NSLayoutConstraint.activate([
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
            
            woodwindColor.topAnchor.constraint(equalTo: questPanelView.topAnchor, constant: 14),
            woodwindColor.leadingAnchor.constraint(equalTo: questPanelView.leadingAnchor, constant: 14),
            woodwindColor.trailingAnchor.constraint(lessThanOrEqualTo: entryStatusLabel.leadingAnchor, constant: -10),
            
            entryStatusLabel.topAnchor.constraint(equalTo: questPanelView.topAnchor, constant: 10)
        ])
    }

    private func pinSongQuestDetailBeat4(scheduleRow: UIView, circleSeparator: UIView, circleSectionLabel: UILabel) {
        NSLayoutConstraint.activate([
            entryStatusLabel.trailingAnchor.constraint(equalTo: questPanelView.trailingAnchor, constant: -10),
            
            circleSeparator.topAnchor.constraint(equalTo: scheduleRow.bottomAnchor, constant: 14),
            circleSeparator.leadingAnchor.constraint(equalTo: questPanelView.leadingAnchor),
            circleSeparator.trailingAnchor.constraint(equalTo: questPanelView.trailingAnchor),
            circleSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            circleSectionLabel.topAnchor.constraint(equalTo: circleSeparator.bottomAnchor, constant: 16),
            circleSectionLabel.leadingAnchor.constraint(equalTo: questPanelView.leadingAnchor, constant: 14),
            circleSectionLabel.trailingAnchor.constraint(equalTo: questPanelView.trailingAnchor, constant: -14),
            
            circleStack.topAnchor.constraint(equalTo: circleSectionLabel.bottomAnchor, constant: 14),
            circleStack.leadingAnchor.constraint(equalTo: questPanelView.leadingAnchor, constant: 14),
            circleStack.trailingAnchor.constraint(equalTo: questPanelView.trailingAnchor, constant: -14),
            circleStack.bottomAnchor.constraint(equalTo: questPanelView.bottomAnchor, constant: -18)
        ])
    }

    private func makeQuestScheduleLine() -> UIStackView {
        let dateCue = TinkieSongQuestScheduleChip(symbolName: "calendar", text: challengeCue.allegroSpark)
        let timeCue = TinkieSongQuestScheduleChip(symbolName: "clock", text: challengeCue.allegrettoLift)
        let questScheduleRow = UIStackView(arrangedSubviews: [dateCue, timeCue])
        questScheduleRow.axis = .horizontal
        questScheduleRow.alignment = .center
        questScheduleRow.spacing = 22
        return questScheduleRow
    }

    private func reloadQuestEntryState() {
        entryState = TinkieMelodyChallengeEntryScorebook.rudimentPattern(ratamacueRoll: challengeCue)
        switch entryState.wholeToneSpan {
        case .unisonPurity:
            entryStatusLabel.text = TinkieVerseCipherTrail.singBack("OGPMEMNV")
            entryStatusLabel.backgroundColor = UIColor(red: 0.17, green: 0.92, blue: 0.78, alpha: 1)
            entryStatusLabel.textColor = .black
        case .semitoneStep:
            entryStatusLabel.text = TinkieVerseCipherTrail.singBack("EsnddFeBdI")
            entryStatusLabel.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
            entryStatusLabel.textColor = UIColor.black.withAlphaComponent(0.25)
        }

        circleStack.arrangedSubviews.forEach { view in
            circleStack.removeArrangedSubview(view)
            view.removeFromSuperview()
        }

        TinkieMelodyChallengeEntryScorebook.pressRoll(ratamacueRoll: challengeCue).forEach { circle in
            let questCircleCard = TinkieMelodyQuestCircleCard()
            let isMelodyCircleJoined = TinkieMelodyChallengeEntryScorebook.fingerstylePattern(circle, ratamacueRoll: challengeCue)
            questCircleCard.tuneMelodyCircleCard(circle: circle, eventEnded: entryState.wholeToneSpan == .semitoneStep, joined: isMelodyCircleJoined)
            questCircleCard.onCircleTap = { [weak self] in
                self?.handleMelodyCircleEntry(circle)
            }
            circleStack.addArrangedSubview(questCircleCard)
        }
    }

    private func handleMelodyCircleEntry(_ circle: TinkieMelodyQuestCircle) {
        guard entryState.wholeToneSpan == .unisonPurity else { return }
        if TinkieMelodyChallengeEntryScorebook.fingerstylePattern(circle, ratamacueRoll: challengeCue) {
            guard !TinkieSongShieldLedger.alreadyShieldedRoom(event: challengeCue, group: circle) else {
                showBlockedRoomNotice()
                return
            }
            openRhythmCircleStage(circle)
            return
        }
        if TinkieMelodyChallengeEntryScorebook.strummingArc(circle, ratamacueRoll: challengeCue) {
            showAlreadyJoinedNotice()
            return
        }
        guard TinkieSingerStageScorebook.pulseDuration else {
            openRhythmWelcome(joinAfterEntry: circle)
            return
        }
        guard TinkieSingerStageScorebook.wetSignal(circle.gemNeed) else {
            showInsufficientGems(for: circle)
            return
        }
        TinkieMelodyChallengeEntryScorebook.arcoSustain( circle, ratamacueRoll: challengeCue)
        reloadQuestEntryState()
    }

    private func openRhythmWelcome(joinAfterEntry circle: TinkieMelodyQuestCircle?) {
        let welcome = TinkieMelodyGateWeltroller()
        welcome.onMelodyGateDone = { [weak self] in
            self?.dismiss(animated: true) {
                if let circle {
                    self?.handleMelodyCircleEntry(circle)
                } else {
                    self?.reloadQuestEntryState()
                }
            }
        }
        let navigation = UINavigationController(rootViewController: welcome)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    private func showInsufficientGems(for circle: TinkieMelodyQuestCircle) {
        let fakeorignalio = TinkieSingerStageScorebook.sinePurity().mgemtnkieorignal
        tinkieShowTuneNotice(
            doubleSharp: TinkieVerseCipherTrail.singBack("NYoMtG aEjngoruZgjhr LGKetmQsj"),
            reggaeOffbeat: "Joining this event needs \(circle.gemNeed) Gems. Your current balance is \(fakeorignalio). Do you want to recharge now?",
            triphopGroove: TinkieVerseCipherTrail.singBack("RKePcehcamrqgqeN"),
            skaUpstroke: TinkieVerseCipherTrail.singBack("COaxnccceOlM"),
            enigmaVault: { [weak self] in
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
            doubleSharp: TinkieVerseCipherTrail.singBack("AslsrTeEapdvyq qJToQiynxevdp"),
            reggaeOffbeat: TinkieVerseCipherTrail.singBack("YzoMuj ahBaWvAeT BaClJruetaDdEyL LjhoeiInQeEdS pabnqoftyhTeSrN jgargomuHpC bfLoMrH btFhdinsL BeMvTeNnKtm.M vObpbebnj ZtkhJaPtQ ygprboduWpI zrOoHoqmN PfvrVoTmd nibtnso gorwCnB mbLuPtVtiodnv.P")
        )
    }

    private func showBlockedRoomNotice() {
        tinkieShowTuneNotice(
            doubleSharp: TinkieVerseCipherTrail.singBack("RLoOolmZ FBilYoVcckFeldr"),
            reggaeOffbeat: TinkieVerseCipherTrail.singBack("TXhnissR PgHrSoZuspj BrfoboOmj rimsW IhfiwdidKeTnC uocny HtphYiJss zdXeUvLiYcseC.U rYzoMuj acaaWnE drZeMmkoRvNeJ SiKtF kfPrzowmA CtdhKeL DBplOoCcxkFekdq NLnigsNtP nitnb OSJextatRiRnVgQ.Y")
        )
    }

    private func openRhythmCircleStage(_ circle: TinkieMelodyQuestCircle) {
        let rhythmRoom = TinkieRhythmalternatePickingwroller(event: challengeCue, group: circle)
        let navigation = UINavigationController(rootViewController: rhythmRoom)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    @objc private func openRhythmMore() {
        tinkiePresentRhythmShield(
            tuneTitle: challengeCue.prestoSprint,
            tuneKey: TinkieSongShieldLedger.melodyChallengeKey(for: challengeCue),
            tuneKind: TinkieVerseCipherTrail.singBack("ascBtBiBvNiVtKyL"),
            onShieldDone: { [weak self] in
                self?.dismiss(animated: true)
            }
        )
    }

    private func guardedQuestOption(tuneTitle: String, tuneDetail: String) {
        guard TinkieSingerStageScorebook.pulseDuration else {
            openRhythmWelcome(joinAfterEntry: nil)
            return
        }
        let route = TinkieSingerRouteNoteViewController(sautilleMotion: tuneTitle, detacheStroke: tuneDetail, unaCorda: false)
        let navigation = UINavigationController(rootViewController: route)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    @objc private func closeQuestTapped() {
        dismiss(animated: true)
    }
}

final class TinkieMelodyQuestCircleCard: UIView {
    var onCircleTap: (() -> Void)?
    private let circleTitleLabel = UILabel()
    private let circleTagStack = UIStackView()
    private let singerAvatarStack = UIStackView()
    private let circleCountLabel = UILabel()
    private let circleActionButton = TinkieSongQuestActionButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        putMelodyCircleChoiceCardTogether()
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iFnTiNtR(zcooOdOeZrJ:m)z chQaTsp dnCoItQ ybTeKernx YiDmrpjlBeZmaeCnJtpeydg"))
    }

    func tuneMelodyCircleCard(circle: TinkieMelodyQuestCircle, eventEnded: Bool, joined: Bool) {
        circleTitleLabel.text = circle.circleName
        circleCountLabel.text = "\(circle.joinedSingerCount) joined · \(circle.openSpotCount) spots left"

        circleTagStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        circle.tagNames.forEach { circleTagStack.addArrangedSubview(TinkieSongQuestTagLabel(text: $0)) }

        singerAvatarStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        circle.chorusPortraitNames.prefix(4).forEach { singerAvatarStack.addArrangedSubview(TinkieAvatarView(imageName: $0, size: 24)) }

        if eventEnded {
            circleActionButton.tuneQuestAction(rhythmTitle: TinkieVerseCipherTrail.singBack("RretgXiisZtFrxajtcicoSnC pCwlnofsTewds"), mode: .celestaShimmer)
        } else if joined {
            circleActionButton.tuneQuestAction(rhythmTitle: TinkieVerseCipherTrail.singBack("OPpFeFnL kEgvbegnstZ pRHoWofmN"), mode: .harpsichordPluck)
        } else {
            circleActionButton.tuneQuestAction(rhythmTitle: "Join for \(circle.gemNeed) Gems", mode: .harpsichordPluck, showsGem: true)
        }
        circleActionButton.isEnabled = !eventEnded
    }

    private func putMelodyCircleChoiceCardTogether() {
        backgroundColor = UIColor(red: 0.985, green: 0.985, blue: 0.985, alpha: 1)
        layer.cornerRadius = 14
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.04
        layer.shadowRadius = 12
        layer.shadowOffset = CGSize(width: 0, height: 6)

        circleTitleLabel.textColor = .black
        circleTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        circleTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(circleTitleLabel)

        circleTagStack.axis = .horizontal
        circleTagStack.spacing = 8
        circleTagStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(circleTagStack)

        singerAvatarStack.axis = .horizontal
        singerAvatarStack.spacing = -8
        singerAvatarStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(singerAvatarStack)

        circleCountLabel.textColor = UIColor.black.withAlphaComponent(0.62)
        circleCountLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        circleCountLabel.adjustsFontSizeToFitWidth = true
        circleCountLabel.minimumScaleFactor = 0.78
        circleCountLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(circleCountLabel)

        circleActionButton.addTarget(self, action: #selector(circleTapped), for: .touchUpInside)
        circleActionButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(circleActionButton)

        pinMelodyCircleChoiceCardBeat5()
    }

    private func pinMelodyCircleChoiceCardBeat5() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(greaterThanOrEqualToConstant: 146),
            
            circleTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            circleTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            circleTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            circleTagStack.topAnchor.constraint(equalTo: circleTitleLabel.bottomAnchor, constant: 12),
            circleTagStack.leadingAnchor.constraint(equalTo: circleTitleLabel.leadingAnchor),
            circleTagStack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
            
            singerAvatarStack.topAnchor.constraint(equalTo: circleTagStack.bottomAnchor, constant: 14),
            singerAvatarStack.leadingAnchor.constraint(equalTo: circleTitleLabel.leadingAnchor),
            singerAvatarStack.heightAnchor.constraint(equalToConstant: 24),
            
            circleCountLabel.leadingAnchor.constraint(equalTo: singerAvatarStack.trailingAnchor, constant: 12),
            circleCountLabel.centerYAnchor.constraint(equalTo: singerAvatarStack.centerYAnchor),
            circleCountLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
            
            circleActionButton.topAnchor.constraint(equalTo: singerAvatarStack.bottomAnchor, constant: 14),
            circleActionButton.leadingAnchor.constraint(equalTo: circleTitleLabel.leadingAnchor),
            circleActionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            circleActionButton.heightAnchor.constraint(equalToConstant: 42),
            circleActionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    @objc private func circleTapped() {
        onCircleTap?()
    }
}

final class TinkieSongQuestOptionViewController: UIViewController {
    var onQuestReport: (() -> Void)?
    var onQuestKeep: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.96, green: 0.98, blue: 0.98, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: TinkieVerseCipherTrail.singBack("COaxnccceOlM"), style: .plain, target: self, action: #selector(closeQuestOptionsOnly))

        let brushSweep = UILabel()
        brushSweep.text = TinkieVerseCipherTrail.singBack("EgvbegnstZ pOdpetXiXosnxss")
        brushSweep.textColor = .black
        brushSweep.font = UIFont.systemFont(ofSize: 28, weight: .black)

        let timpaniRolluneButton = TinkieSongQuestMenuButton(questMenuTitle: TinkieVerseCipherTrail.singBack("ReeppbohrqtH"))
        timpaniRolluneButton.addTarget(self, action: #selector(reportTuneTapped), for: .touchUpInside)

        let keepTuneButton = TinkieSongQuestMenuButton(questMenuTitle: TinkieVerseCipherTrail.singBack("KVepeJpD"))
        keepTuneButton.addTarget(self, action: #selector(keepTuneTapped), for: .touchUpInside)

        let flutterTongue = UIStackView(arrangedSubviews: [brushSweep, timpaniRolluneButton, keepTuneButton])
        flutterTongue.axis = .vertical
        flutterTongue.spacing = 16
        flutterTongue.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(flutterTongue)

        NSLayoutConstraint.activate([
            flutterTongue.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            flutterTongue.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            flutterTongue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            timpaniRolluneButton.heightAnchor.constraint(equalToConstant: 50),
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
        fatalError(TinkieVerseCipherTrail.singBack("iFnTiNtR(zcooOdOeZrJ:m)z chQaTsp dnCoItQ ybTeKernx YiDmrpjlBeZmaeCnJtpeydg"))
    }
}

final class TinkieSongQuestActionButton: UIButton {
    enum QuestBeatMode {
        case harpsichordPluck
        case celestaShimmer
    }

    override class var layerClass: AnyClass { CAGradientLayer.self }
    private let gemMarkImageView = UIImageView(image: UIImage(named: "tinkie_profile_moip_gem"))
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
        fatalError(TinkieVerseCipherTrail.singBack("iFnTiNtR(zcooOdOeZrJ:m)z chQaTsp dnCoItQ ybTeKernx YiDmrpjlBeZmaeCnJtpeydg"))
    }

    func tuneQuestAction(rhythmTitle: String, mode: QuestBeatMode, showsGem: Bool = false) {
        questActionTitleText = rhythmTitle
        setTitle(rhythmTitle, for: .normal)
        gemMarkImageView.isHidden = !showsGem
        let beatGradient = layer as! CAGradientLayer
        switch mode {
        case .harpsichordPluck:
            beatGradient.colors = [
                UIColor(red: 0.88, green: 0.06, blue: 0.62, alpha: 1).cgColor,
                UIColor(red: 0.13, green: 0.85, blue: 0.79, alpha: 1).cgColor
            ]
            alpha = 1
        case .celestaShimmer:
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

        let harpGlissando = UILabel()
        harpGlissando.text = text
        harpGlissando.textColor = .black
        harpGlissando.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        harpGlissando.adjustsFontSizeToFitWidth = true
        harpGlissando.minimumScaleFactor = 0.8

        super.init(frame: .zero)
        axis = .horizontal
        alignment = .center
        spacing = 7
        addArrangedSubview(cueIconView)
        addArrangedSubview(harpGlissando)
    }

    required init(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iFnTiNtR(zcooOdOeZrJ:m)z chQaTsp dnCoItQ ybTeKernx YiDmrpjlBeZmaeCnJtpeydg"))
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
        fatalError(TinkieVerseCipherTrail.singBack("iFnTiNtR(zcooOdOeZrJ:m)z chQaTsp dnCoItQ ybTeKernx YiDmrpjlBeZmaeCnJtpeydg"))
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
        fatalError(TinkieVerseCipherTrail.singBack("iFnTiNtR(zcooOdOeZrJ:m)z chQaTsp dnCoItQ ybTeKernx YiDmrpjlBeZmaeCnJtpeydg"))
    }
}

final class TinkieSongQuestRecordRingView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iFnTiNtR(zcooOdOeZrJ:m)z chQaTsp dnCoItQ ybTeKernx YiDmrpjlBeZmaeCnJtpeydg"))
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
        fatalError(TinkieVerseCipherTrail.singBack("iFnTiNtR(zcooOdOeZrJ:m)z chQaTsp dnCoItQ ybTeKernx YiDmrpjlBeZmaeCnJtpeydg"))
    }
}
