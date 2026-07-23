import AVFoundation
import UIKit

final class TinkieRhythmSparkDetailViewController: UIViewController, UITextFieldDelegate {
    private let pulseSpark: TinkieSongPulseSpark
    private let rhythmLayer = AVPlayerLayer()
    private var rhythmPlayer: AVPlayer?
    private var loopToken: NSObjectProtocol?
    private var isRhythmRolling = false
    private let playMark = TinkiePlayMarkView()
    private let bondButton = UIButton(type: .system)
    private let sparkButton = UIButton(type: .system)
    private let saveButton = UIButton(type: .system)
    private let sparkValueLabel = UILabel()
    private let saveValueLabel = UILabel()
    private let inputField = UITextField()
    private let inputBar = UIView()
    private var inputBottomConstraint: NSLayoutConstraint?
    private let commentStack = UIStackView()
    private var bonded: Bool
    private var sparked: Bool
    private var saved: Bool

    init(pulseSpark: TinkieSongPulseSpark, bonded: Bool) {
        self.pulseSpark = pulseSpark
        self.bonded = bonded
        let key = Self.rhythmKey(for: pulseSpark)
        self.sparked = TinkieRhythmBondScorebook.hasRhythmSpark(for: key)
        self.saved = TinkieRhythmSaveStore.hasSaved(for: key)
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
        hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("ibnaintb(AcEondnesru:H)A ShjaxsC Wnfowtj CbxemeLnD miymZpLlhekmPefnptMeCdY"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        putRhythmSparkDetailTogether()
        prepareSparkLoop()
        listenForSparkKeyboard()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rhythmLayer.frame = view.viewWithTag(410)?.bounds ?? .zero
    }

    deinit {
        stopSparkLoop()
        NotificationCenter.default.removeObserver(self)
    }

    private func putRhythmSparkDetailTogether() {
        view.backgroundColor = UIColor(red: 0.93, green: 0.99, blue: 0.98, alpha: 1); let halo = TinkieQuestForgeBackdropView(); halo.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(halo); let scrollView = UIScrollView(); scrollView.alwaysBounceVertical = true; scrollView.keyboardDismissMode = .interactive; scrollView.showsVerticalScrollIndicator = false; scrollView.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(scrollView); let sparkScrollStageView = UIView(); sparkScrollStageView.translatesAutoresizingMaskIntoConstraints = false; scrollView.addSubview(sparkScrollStageView)
        let sparkBackBeatButton = UIButton(type: .system); sparkBackBeatButton.setImage(UIImage(systemName: "chevron.left"), for: .normal); sparkBackBeatButton.tintColor = .black; sparkBackBeatButton.addTarget(self, action: #selector(leaveSparkDetail), for: .touchUpInside)
        sparkBackBeatButton.translatesAutoresizingMaskIntoConstraints = false; sparkScrollStageView.addSubview(sparkBackBeatButton); let avatarImageView = UIImageView()
        if let avatarPath = pulseSpark.avatarPath, let localArt = UIImage(contentsOfFile: avatarPath) {
            avatarImageView.image = localArt
        } else {
            avatarImageView.image = UIImage(named: pulseSpark.avatarName)
        }
        avatarImageView.contentMode = .scaleAspectFill; avatarImageView.layer.cornerRadius = 26; avatarImageView.layer.masksToBounds = true; avatarImageView.isUserInteractionEnabled = true; avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openPerformerPulsePage))); avatarImageView.translatesAutoresizingMaskIntoConstraints = false; sparkScrollStageView.addSubview(avatarImageView); let nameLabel = UILabel(); nameLabel.text = "\(pulseSpark.performer) 😈"; nameLabel.textColor = .black; nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .black); nameLabel.adjustsFontSizeToFitWidth = true; nameLabel.minimumScaleFactor = 0.75; nameLabel.translatesAutoresizingMaskIntoConstraints = false; sparkScrollStageView.addSubview(nameLabel); bondButton.setTitleColor(.white, for: .normal); bondButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .black); bondButton.backgroundColor = .black; bondButton.layer.cornerRadius = 26; bondButton.addTarget(self, action: #selector(bondTapped), for: .touchUpInside); bondButton.translatesAutoresizingMaskIntoConstraints = false; sparkScrollStageView.addSubview(bondButton); refreshBond(); let rhythmView = UIView(); rhythmView.tag = 410; rhythmView.backgroundColor = .black; rhythmView.layer.cornerRadius = 18; rhythmView.layer.masksToBounds = true; rhythmView.translatesAutoresizingMaskIntoConstraints = false; sparkScrollStageView.addSubview(rhythmView); let stillImageView = UIImageView(); stillImageView.contentMode = .scaleAspectFill
        if let coverPath = pulseSpark.coverPath, let localArt = UIImage(contentsOfFile: coverPath) {
            stillImageView.image = localArt
        } else {
            stillImageView.image = UIImage(named: pulseSpark.coverName)
        }
        if let firstFrame = TinkieRhythmCoverFrameStore.art(for: pulseSpark.pulseFileName) {
            stillImageView.image = firstFrame
        } else {
            TinkieRhythmCoverFrameStore.resolveArt(for: pulseSpark.pulseFileName) { [weak stillImageView] firstFrame in
                guard let firstFrame else { return }
                stillImageView?.image = firstFrame
            }
        }
        stillImageView.translatesAutoresizingMaskIntoConstraints = false; rhythmView.addSubview(stillImageView); rhythmLayer.videoGravity = .resizeAspectFill; rhythmView.layer.addSublayer(rhythmLayer); let playButton = UIButton(type: .custom); playButton.addTarget(self, action: #selector(switchRhythmSparkLoop), for: .touchUpInside); playButton.translatesAutoresizingMaskIntoConstraints = false; rhythmView.addSubview(playMark); rhythmView.addSubview(playButton); playMark.translatesAutoresizingMaskIntoConstraints = false
        let reportButton = UIButton(type: .system); reportButton.setImage(UIImage(systemName: "exclamationmark.circle"), for: .normal); reportButton.tintColor = .white; reportButton.addTarget(self, action: #selector(openSparkMoreSheet), for: .touchUpInside)
        reportButton.translatesAutoresizingMaskIntoConstraints = false; rhythmView.addSubview(reportButton); let statPanel = makeSparkStatDeck(); statPanel.translatesAutoresizingMaskIntoConstraints = false; rhythmView.addSubview(statPanel); let captionLabel = UILabel(); captionLabel.text = pulseSpark.caption; captionLabel.textColor = UIColor.black.withAlphaComponent(0.82); captionLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular); captionLabel.numberOfLines = 0; captionLabel.translatesAutoresizingMaskIntoConstraints = false; sparkScrollStageView.addSubview(captionLabel); let sparkCommentTitleLabel = UILabel(); sparkCommentTitleLabel.text = "Comments"; sparkCommentTitleLabel.textColor = .black; sparkCommentTitleLabel.font = UIFont.systemFont(ofSize: 19, weight: .black); sparkCommentTitleLabel.translatesAutoresizingMaskIntoConstraints = false; sparkScrollStageView.addSubview(sparkCommentTitleLabel); commentStack.axis = .vertical; commentStack.spacing = 16; commentStack.translatesAutoresizingMaskIntoConstraints = false; sparkScrollStageView.addSubview(commentStack); addRhythmReaction(name: "Bruno Pham", text: "Great shot! I love it", mark: "18 mins ago", avatarName: TinkieSingerTuneAtlas.singerMelodyCard(named: "Bruno Pham").portraitAssetName); addRhythmReaction(name: "Mina", text: "That melody clue feels perfect for a weekend round.", mark: "1 hr ago", avatarName: TinkieSingerTuneAtlas.singerMelodyCard(named: "Mina").portraitAssetName); inputBar.backgroundColor = .white; inputBar.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(inputBar)
        inputField.placeholder = TinkieVerseCipherTrail.singBack("WShFaJtV wdEoB LyWoeuV Qdwov poknq DwOeweSkreLnMdqsr?F"); inputField.font = UIFont.systemFont(ofSize: 16, weight: .regular); inputField.backgroundColor = UIColor.black.withAlphaComponent(0.04); inputField.layer.cornerRadius = 24; inputField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 1)); inputField.leftViewMode = .always; inputField.returnKeyType = .send; inputField.delegate = self; inputField.translatesAutoresizingMaskIntoConstraints = false; inputBar.addSubview(inputField); let sendButton = TinkieRhythmSendButton(); sendButton.addTarget(self, action: #selector(sendTapped), for: .touchUpInside); sendButton.translatesAutoresizingMaskIntoConstraints = false; inputBar.addSubview(sendButton); inputBottomConstraint = inputBar.bottomAnchor.constraint(equalTo: view.bottomAnchor); pinRhythmSparkDetailBeat1(halo: halo, scrollView: scrollView, sparkScrollStageView: sparkScrollStageView, sparkBackBeatButton: sparkBackBeatButton, avatarImageView: avatarImageView); pinRhythmSparkDetailBeat2(sparkScrollStageView: sparkScrollStageView, sparkBackBeatButton: sparkBackBeatButton, avatarImageView: avatarImageView, nameLabel: nameLabel, rhythmView: rhythmView, stillImageView: stillImageView); pinRhythmSparkDetailBeat3(rhythmView: rhythmView, playButton: playButton, reportButton: reportButton, statPanel: statPanel, captionLabel: captionLabel); pinRhythmSparkDetailBeat4(sparkScrollStageView: sparkScrollStageView, rhythmView: rhythmView, captionLabel: captionLabel, sparkCommentTitleLabel: sparkCommentTitleLabel, sendButton: sendButton); pinRhythmSparkDetailBeat5(sendButton: sendButton)
    }

    private func pinRhythmSparkDetailBeat1(halo: TinkieQuestForgeBackdropView, scrollView: UIScrollView, sparkScrollStageView: UIView, sparkBackBeatButton: UIButton, avatarImageView: UIImageView) {
        NSLayoutConstraint.activate([
            halo.topAnchor.constraint(equalTo: view.topAnchor),
            halo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            halo.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            halo.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: inputBar.topAnchor),
            
            sparkScrollStageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            sparkScrollStageView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            sparkScrollStageView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            sparkScrollStageView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            sparkScrollStageView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            sparkBackBeatButton.topAnchor.constraint(equalTo: sparkScrollStageView.safeAreaLayoutGuide.topAnchor, constant: 24),
            sparkBackBeatButton.leadingAnchor.constraint(equalTo: sparkScrollStageView.leadingAnchor, constant: 22),
            sparkBackBeatButton.widthAnchor.constraint(equalToConstant: 44),
            sparkBackBeatButton.heightAnchor.constraint(equalToConstant: 44),
            
            avatarImageView.leadingAnchor.constraint(equalTo: sparkBackBeatButton.trailingAnchor, constant: 10)
        ])
    }

    private func pinRhythmSparkDetailBeat2(sparkScrollStageView: UIView, sparkBackBeatButton: UIButton, avatarImageView: UIImageView, nameLabel: UILabel, rhythmView: UIView, stillImageView: UIImageView) {
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: sparkBackBeatButton.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 52),
            avatarImageView.heightAnchor.constraint(equalToConstant: 52),
            
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: bondButton.leadingAnchor, constant: -12),
            
            bondButton.trailingAnchor.constraint(equalTo: sparkScrollStageView.trailingAnchor, constant: -40),
            bondButton.centerYAnchor.constraint(equalTo: sparkBackBeatButton.centerYAnchor),
            bondButton.widthAnchor.constraint(equalToConstant: 108),
            bondButton.heightAnchor.constraint(equalToConstant: 52),
            
            rhythmView.topAnchor.constraint(equalTo: sparkBackBeatButton.bottomAnchor, constant: 26),
            rhythmView.leadingAnchor.constraint(equalTo: sparkScrollStageView.leadingAnchor, constant: 30),
            rhythmView.trailingAnchor.constraint(equalTo: sparkScrollStageView.trailingAnchor, constant: -30),
            rhythmView.heightAnchor.constraint(equalTo: rhythmView.widthAnchor, multiplier: 1.33),
            
            stillImageView.topAnchor.constraint(equalTo: rhythmView.topAnchor),
            stillImageView.leadingAnchor.constraint(equalTo: rhythmView.leadingAnchor),
            stillImageView.trailingAnchor.constraint(equalTo: rhythmView.trailingAnchor),
            stillImageView.bottomAnchor.constraint(equalTo: rhythmView.bottomAnchor)
        ])
    }

    private func pinRhythmSparkDetailBeat3(rhythmView: UIView, playButton: UIButton, reportButton: UIButton, statPanel: UIView, captionLabel: UILabel) {
        NSLayoutConstraint.activate([
            
            playMark.centerXAnchor.constraint(equalTo: rhythmView.centerXAnchor),
            playMark.centerYAnchor.constraint(equalTo: rhythmView.centerYAnchor),
            playMark.widthAnchor.constraint(equalToConstant: 74),
            playMark.heightAnchor.constraint(equalToConstant: 74),
            playButton.centerXAnchor.constraint(equalTo: playMark.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: playMark.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 104),
            playButton.heightAnchor.constraint(equalToConstant: 104),
            
            reportButton.topAnchor.constraint(equalTo: rhythmView.topAnchor, constant: 20),
            reportButton.trailingAnchor.constraint(equalTo: rhythmView.trailingAnchor, constant: -20),
            reportButton.widthAnchor.constraint(equalToConstant: 44),
            reportButton.heightAnchor.constraint(equalToConstant: 44),
            
            statPanel.trailingAnchor.constraint(equalTo: rhythmView.trailingAnchor, constant: -16),
            statPanel.bottomAnchor.constraint(equalTo: rhythmView.bottomAnchor, constant: -36),
            statPanel.widthAnchor.constraint(equalToConstant: 72),
            statPanel.heightAnchor.constraint(equalToConstant: 142),
            
            captionLabel.topAnchor.constraint(equalTo: rhythmView.bottomAnchor, constant: 26),
            captionLabel.leadingAnchor.constraint(equalTo: rhythmView.leadingAnchor)
        ])
    }

    private func pinRhythmSparkDetailBeat4(sparkScrollStageView: UIView, rhythmView: UIView, captionLabel: UILabel, sparkCommentTitleLabel: UILabel, sendButton: TinkieRhythmSendButton) {
        NSLayoutConstraint.activate([
            captionLabel.trailingAnchor.constraint(equalTo: rhythmView.trailingAnchor),
            
            sparkCommentTitleLabel.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 28),
            sparkCommentTitleLabel.leadingAnchor.constraint(equalTo: rhythmView.leadingAnchor),
            sparkCommentTitleLabel.trailingAnchor.constraint(equalTo: rhythmView.trailingAnchor),
            
            commentStack.topAnchor.constraint(equalTo: sparkCommentTitleLabel.bottomAnchor, constant: 18),
            commentStack.leadingAnchor.constraint(equalTo: rhythmView.leadingAnchor),
            commentStack.trailingAnchor.constraint(equalTo: rhythmView.trailingAnchor),
            commentStack.bottomAnchor.constraint(equalTo: sparkScrollStageView.bottomAnchor, constant: -24),
            
            inputBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inputBottomConstraint!,
            inputBar.heightAnchor.constraint(equalToConstant: 92),
            
            inputField.leadingAnchor.constraint(equalTo: inputBar.leadingAnchor, constant: 30),
            inputField.topAnchor.constraint(equalTo: inputBar.topAnchor, constant: 16),
            inputField.heightAnchor.constraint(equalToConstant: 48),
            
            sendButton.leadingAnchor.constraint(equalTo: inputField.trailingAnchor, constant: 14),
            sendButton.trailingAnchor.constraint(equalTo: inputBar.trailingAnchor, constant: -30),
            sendButton.centerYAnchor.constraint(equalTo: inputField.centerYAnchor)
        ])
    }

    private func pinRhythmSparkDetailBeat5(sendButton: TinkieRhythmSendButton) {
        NSLayoutConstraint.activate([
            sendButton.widthAnchor.constraint(equalToConstant: 56),
            sendButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

    private func makeSparkStatDeck() -> UIView {
        let panel = UIView()
        panel.backgroundColor = UIColor.black.withAlphaComponent(0.36)
        panel.layer.cornerRadius = 36

        sparkButton.addTarget(self, action: #selector(sparkTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)

        [sparkValueLabel, saveValueLabel].forEach {
            $0.textColor = .white
            $0.font = UIFont.systemFont(ofSize: 13, weight: .bold)
            $0.textAlignment = .center
        }

        paintSparkStats()

        let sparkActionStack = UIStackView(arrangedSubviews: [sparkButton, sparkValueLabel, saveButton, saveValueLabel])
        sparkActionStack.axis = .vertical
        sparkActionStack.alignment = .center
        sparkActionStack.spacing = 6
        sparkActionStack.translatesAutoresizingMaskIntoConstraints = false
        panel.addSubview(sparkActionStack)

        NSLayoutConstraint.activate([
            sparkButton.widthAnchor.constraint(equalToConstant: 34),
            sparkButton.heightAnchor.constraint(equalToConstant: 34),
            saveButton.widthAnchor.constraint(equalToConstant: 34),
            saveButton.heightAnchor.constraint(equalToConstant: 34),
            sparkActionStack.centerXAnchor.constraint(equalTo: panel.centerXAnchor),
            sparkActionStack.centerYAnchor.constraint(equalTo: panel.centerYAnchor)
        ])
        return panel
    }

    private func paintSparkStats() {
        sparkButton.setImage(UIImage(systemName: sparked ? "heart.fill" : "heart"), for: .normal)
        saveButton.setImage(UIImage(systemName: saved ? "bookmark.fill" : "bookmark"), for: .normal)
        sparkButton.tintColor = .white
        saveButton.tintColor = .white
        sparkValueLabel.text = sparked ? TinkieVerseCipherTrail.singBack("8n") : TinkieVerseCipherTrail.singBack("7v")
        saveValueLabel.text = saved ? TinkieVerseCipherTrail.singBack("9q") : TinkieVerseCipherTrail.singBack("8n")
    }

    private func addRhythmReaction(name: String, text: String, mark: String, avatarName: String, avatarPath: String? = nil) {
        let avatarImageView = UIImageView()
        if let avatarPath, let localArt = UIImage(contentsOfFile: avatarPath) {
            avatarImageView.image = localArt
        } else {
            avatarImageView.image = UIImage(named: avatarName)
        }
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 20
        avatarImageView.layer.masksToBounds = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false

        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .black)

        let textLabel = UILabel()
        textLabel.text = text
        textLabel.textColor = UIColor.black.withAlphaComponent(0.52)
        textLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textLabel.numberOfLines = 0

        let markLabel = UILabel()
        markLabel.text = mark
        markLabel.textColor = UIColor.black.withAlphaComponent(0.24)
        markLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)

        let textStack = UIStackView(arrangedSubviews: [nameLabel, textLabel, markLabel])
        textStack.axis = .vertical
        textStack.spacing = 2

        let sparkReactionRow = UIStackView(arrangedSubviews: [avatarImageView, textStack])
        sparkReactionRow.axis = .horizontal
        sparkReactionRow.alignment = .top
        sparkReactionRow.spacing = 12
        sparkReactionRow.translatesAutoresizingMaskIntoConstraints = false
        commentStack.addArrangedSubview(sparkReactionRow)

        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 40),
            avatarImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func prepareSparkLoop() {
        guard let url = TinkieRhythmSparkFileVault.url(for: pulseSpark.pulseFileName) else { return }
        tuneSparkSoundRoute()
        let player = AVPlayer(url: url)
        player.isMuted = false
        player.volume = 1
        player.actionAtItemEnd = .none
        rhythmPlayer = player
        rhythmLayer.player = player
        loopToken = NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { [weak player] _ in
            player?.seek(to: .zero)
            player?.play()
        }
    }

    private func tuneSparkSoundRoute() {
        let melodySession = AVAudioSession.sharedInstance()
        try? melodySession.setCategory(.playback, mode: .moviePlayback, options: [])
        try? melodySession.setActive(true)
    }

    private func stopSparkLoop() {
        rhythmPlayer?.pause()
        rhythmPlayer = nil
        rhythmLayer.player = nil
        if let loopToken {
            NotificationCenter.default.removeObserver(loopToken)
            self.loopToken = nil
        }
    }

    private func refreshBond() {
        bondButton.setTitle(bonded ? TinkieVerseCipherTrail.singBack("FLoOlHlqohwYiencgm") : TinkieVerseCipherTrail.singBack("FDoFlPltocwF"), for: .normal)
    }

    private static func rhythmKey(for pulseSpark: TinkieSongPulseSpark) -> String {
        [pulseSpark.performer, pulseSpark.coverName, pulseSpark.pulseFileName].joined(separator: "::")
    }

    private func listenForSparkKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(sparkKeyboardCameUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(sparkKeyboardWentAway), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(stopSparkTyping))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func switchRhythmSparkLoop() {
        guard let rhythmPlayer else { return }
        if isRhythmRolling {
            rhythmPlayer.pause()
            isRhythmRolling = false
        } else {
            rhythmPlayer.play()
            isRhythmRolling = true
        }
        playMark.setPlaying(isRhythmRolling)
    }

    @objc private func bondTapped() {
        guard TinkieSingerStageScorebook.isSingerOnStage else {
            openWelcome()
            return
        }
        let key = Self.rhythmKey(for: pulseSpark)
        bonded = TinkieRhythmBondScorebook.switchRhythmBond(for: key)
        refreshBond()
    }

    @objc private func sparkTapped() {
        guard TinkieSingerStageScorebook.isSingerOnStage else {
            openWelcome()
            return
        }
        sparked = TinkieRhythmBondScorebook.switchRhythmSpark(for: Self.rhythmKey(for: pulseSpark))
        paintSparkStats()
    }

    @objc private func saveTapped() {
        guard TinkieSingerStageScorebook.isSingerOnStage else {
            openWelcome()
            return
        }
        saved = TinkieRhythmSaveStore.switchSaved(for: Self.rhythmKey(for: pulseSpark))
        paintSparkStats()
    }

    @objc private func sendTapped() {
        guard TinkieSingerStageScorebook.isSingerOnStage else {
            openWelcome()
            return
        }
        let text = inputField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !text.isEmpty else {
            showSparkHint(TinkieVerseCipherTrail.singBack("PJlyepaHskeG IePnUtvelrj CaP XcXojmMmseFnYtm Tbrejfroxroeu rsleHnNdsinnggc.q"))
            return
        }
        let snapshot = TinkieSingerStageScorebook.currentSingerStage()
        addRhythmReaction(name: snapshot.singerAlias, text: text, mark: "moments ago", avatarName: snapshot.portraitAssetName, avatarPath: snapshot.portraitLocalPath)
        inputField.text = nil
        view.endEditing(true)
    }

    @objc private func openPerformerPulsePage() {
        let key = Self.rhythmKey(for: pulseSpark)
        let page = TinkieSingerPulseProfileViewController(
            pulseSpark: pulseSpark,
            bonded: TinkieRhythmBondScorebook.hasRhythmBond(for: key)
        )
        page.onTuneBondShift = { [weak self] in
            guard let self else { return }
            guard TinkieSingerStageScorebook.isSingerOnStage else {
                self.dismiss(animated: true) {
                    self.openWelcome()
                }
                return
            }
            self.bonded = TinkieRhythmBondScorebook.switchRhythmBond(for: key)
            self.refreshBond()
        }
        let navigation = UINavigationController(rootViewController: page)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    @objc private func openSparkMoreSheet() {
        tinkiePresentRhythmShield(
            tuneTitle: pulseSpark.performer,
            tuneKey: TinkieSongShieldLedger.pulseKey(for: pulseSpark),
            tuneKind: TinkieVerseCipherTrail.singBack("cMlLiMpX"),
            onShieldDone: { [weak self] in
                self?.dismiss(animated: true)
            }
        )
    }

    private func openWelcome() {
        view.endEditing(true)
        let welcome = TinkieMelodyGateWelcomeViewController()
        let navigation = UINavigationController(rootViewController: welcome)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    private func showSparkHint(_ text: String) {
        tinkieShowTuneNotice(title: TinkieVerseCipherTrail.singBack("TBiWnXkEiseK"), detail: text)
    }

    @objc private func sparkKeyboardCameUp(_ notification: Notification) {
        guard
            let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else { return }
        let overlap = max(0, view.bounds.maxY - view.convert(frame, from: nil).minY)
        inputBottomConstraint?.constant = -overlap
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }

    @objc private func sparkKeyboardWentAway(_ notification: Notification) {
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
        inputBottomConstraint?.constant = 0
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }

    @objc private func stopSparkTyping() {
        view.endEditing(true)
    }

    @objc private func leaveSparkDetail() {
        dismiss(animated: true)
    }

    func textFieldShouldReturn(_ melodyTextField: UITextField) -> Bool {
        sendTapped()
        return true
    }
}

final class TinkieRhythmSendButton: UIButton {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        tintColor = .white
        layer.cornerRadius = 28
        layer.masksToBounds = true
        let gradient = layer as! CAGradientLayer
        gradient.colors = [
            UIColor(red: 0.90, green: 0.08, blue: 0.63, alpha: 1).cgColor,
            UIColor(red: 0.09, green: 0.83, blue: 0.76, alpha: 1).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iPnPiJtF(qcloGdGeMrQ:p)q rhLaKsf cnUoKtL dbKeBeony HiCmspvlReImreUnMtjeddx"))
    }
}

private enum TinkieRhythmSaveStore {
    private static let storeKey = "tinkie_rhythm_saved_records"

    static func hasSaved(for key: String) -> Bool {
        storedChallengeDrafts().contains(key)
    }

    static func switchSaved(for key: String) -> Bool {
        var values = Set(storedChallengeDrafts())
        if values.contains(key) {
            values.remove(key)
            UserDefaults.standard.set(Array(values), forKey: storeKey)
            return false
        }
        values.insert(key)
        UserDefaults.standard.set(Array(values), forKey: storeKey)
        return true
    }

    private static func storedChallengeDrafts() -> [String] {
        UserDefaults.standard.stringArray(forKey: storeKey) ?? []
    }
}
