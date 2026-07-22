import AVFoundation
import UIKit

final class RefrainCircleController: UIViewController, UITextFieldDelegate {
    private let clip: TinkieReelClip
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

    init(clip: TinkieReelClip, bonded: Bool) {
        self.clip = clip
        self.bonded = bonded
        let key = Self.rhythmKey(for: clip)
        self.sparked = TinkieRhythmBondStore.hasSpark(for: key)
        self.saved = TinkieRhythmSaveStore.hasSaved(for: key)
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
        hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        prepareRhythm()
        registerKeyboardObservers()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rhythmLayer.frame = view.viewWithTag(410)?.bounds ?? .zero
    }

    deinit {
        stopRhythm()
        NotificationCenter.default.removeObserver(self)
    }

    private func buildLayout() {
        view.backgroundColor = UIColor(red: 0.93, green: 0.99, blue: 0.98, alpha: 1)

        let halo = TinkieQuestCreateBackdropView()
        halo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(halo)

        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .interactive
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backButton)

        let avatarImageView = UIImageView()
        if let avatarPath = clip.avatarPath, let localArt = UIImage(contentsOfFile: avatarPath) {
            avatarImageView.image = localArt
        } else {
            avatarImageView.image = UIImage(named: clip.avatarName)
        }
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 26
        avatarImageView.layer.masksToBounds = true
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openPerformerPage)))
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(avatarImageView)

        let nameLabel = UILabel()
        nameLabel.text = "\(clip.performer) 😈"
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.75
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)

        bondButton.setTitleColor(.white, for: .normal)
        bondButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .black)
        bondButton.backgroundColor = .black
        bondButton.layer.cornerRadius = 26
        bondButton.addTarget(self, action: #selector(bondTapped), for: .touchUpInside)
        bondButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bondButton)
        refreshBond()

        let rhythmView = UIView()
        rhythmView.tag = 410
        rhythmView.backgroundColor = .black
        rhythmView.layer.cornerRadius = 18
        rhythmView.layer.masksToBounds = true
        rhythmView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(rhythmView)

        let stillImageView = UIImageView()
        stillImageView.contentMode = .scaleAspectFill
        if let coverPath = clip.coverPath, let localArt = UIImage(contentsOfFile: coverPath) {
            stillImageView.image = localArt
        } else {
            stillImageView.image = UIImage(named: clip.coverName)
        }
        if let firstFrame = TinkieRhythmFirstFrameStore.art(for: clip.clipFileName) {
            stillImageView.image = firstFrame
        } else {
            TinkieRhythmFirstFrameStore.resolveArt(for: clip.clipFileName) { [weak stillImageView] firstFrame in
                guard let firstFrame else { return }
                stillImageView?.image = firstFrame
            }
        }
        stillImageView.translatesAutoresizingMaskIntoConstraints = false
        rhythmView.addSubview(stillImageView)
        rhythmLayer.videoGravity = .resizeAspectFill
        rhythmView.layer.addSublayer(rhythmLayer)

        let playButton = UIButton(type: .custom)
        playButton.addTarget(self, action: #selector(switchRhythm), for: .touchUpInside)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        rhythmView.addSubview(playMark)
        rhythmView.addSubview(playButton)
        playMark.translatesAutoresizingMaskIntoConstraints = false

        let reportButton = UIButton(type: .system)
        reportButton.setImage(UIImage(systemName: "exclamationmark.circle"), for: .normal)
        reportButton.tintColor = .white
        reportButton.addTarget(self, action: #selector(openMore), for: .touchUpInside)
        reportButton.translatesAutoresizingMaskIntoConstraints = false
        rhythmView.addSubview(reportButton)

        let statPanel = makeStatPanel()
        statPanel.translatesAutoresizingMaskIntoConstraints = false
        rhythmView.addSubview(statPanel)

        let captionLabel = UILabel()
        captionLabel.text = clip.caption
        captionLabel.textColor = UIColor.black.withAlphaComponent(0.82)
        captionLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        captionLabel.numberOfLines = 0
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(captionLabel)

        let titleLabel = UILabel()
        titleLabel.text = "Comments"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 19, weight: .black)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        commentStack.axis = .vertical
        commentStack.spacing = 16
        commentStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(commentStack)
        addComment(name: "Bruno Pham", text: "Great shot! I love it", mark: "2 mins ago", avatarName: TinkiePersonaDirectory.persona(named: "Bruno Pham").heroImageName)
        addComment(name: "Mina", text: "That melody clue feels perfect for a weekend round.", mark: "just now", avatarName: TinkiePersonaDirectory.persona(named: "Mina").heroImageName)

        inputBar.backgroundColor = .white
        inputBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputBar)

        inputField.placeholder = "What do you do on weekends?"
        inputField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        inputField.backgroundColor = UIColor.black.withAlphaComponent(0.04)
        inputField.layer.cornerRadius = 24
        inputField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 1))
        inputField.leftViewMode = .always
        inputField.returnKeyType = .send
        inputField.delegate = self
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputBar.addSubview(inputField)

        let sendButton = TinkieRhythmSendButton()
        sendButton.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        inputBar.addSubview(sendButton)

        inputBottomConstraint = inputBar.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        NSLayoutConstraint.activate([
            halo.topAnchor.constraint(equalTo: view.topAnchor),
            halo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            halo.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            halo.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: inputBar.topAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            backButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 24),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            avatarImageView.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 10),
            avatarImageView.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 52),
            avatarImageView.heightAnchor.constraint(equalToConstant: 52),

            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: bondButton.leadingAnchor, constant: -12),

            bondButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            bondButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            bondButton.widthAnchor.constraint(equalToConstant: 108),
            bondButton.heightAnchor.constraint(equalToConstant: 52),

            rhythmView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 26),
            rhythmView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            rhythmView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            rhythmView.heightAnchor.constraint(equalTo: rhythmView.widthAnchor, multiplier: 1.33),

            stillImageView.topAnchor.constraint(equalTo: rhythmView.topAnchor),
            stillImageView.leadingAnchor.constraint(equalTo: rhythmView.leadingAnchor),
            stillImageView.trailingAnchor.constraint(equalTo: rhythmView.trailingAnchor),
            stillImageView.bottomAnchor.constraint(equalTo: rhythmView.bottomAnchor),

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
            captionLabel.leadingAnchor.constraint(equalTo: rhythmView.leadingAnchor),
            captionLabel.trailingAnchor.constraint(equalTo: rhythmView.trailingAnchor),

            titleLabel.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: rhythmView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: rhythmView.trailingAnchor),

            commentStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18),
            commentStack.leadingAnchor.constraint(equalTo: rhythmView.leadingAnchor),
            commentStack.trailingAnchor.constraint(equalTo: rhythmView.trailingAnchor),
            commentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),

            inputBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inputBottomConstraint!,
            inputBar.heightAnchor.constraint(equalToConstant: 92),

            inputField.leadingAnchor.constraint(equalTo: inputBar.leadingAnchor, constant: 30),
            inputField.topAnchor.constraint(equalTo: inputBar.topAnchor, constant: 16),
            inputField.heightAnchor.constraint(equalToConstant: 48),

            sendButton.leadingAnchor.constraint(equalTo: inputField.trailingAnchor, constant: 14),
            sendButton.trailingAnchor.constraint(equalTo: inputBar.trailingAnchor, constant: -30),
            sendButton.centerYAnchor.constraint(equalTo: inputField.centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 56),
            sendButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

    private func makeStatPanel() -> UIView {
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

        refreshStatPanel()

        let stack = UIStackView(arrangedSubviews: [sparkButton, sparkValueLabel, saveButton, saveValueLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false
        panel.addSubview(stack)

        NSLayoutConstraint.activate([
            sparkButton.widthAnchor.constraint(equalToConstant: 34),
            sparkButton.heightAnchor.constraint(equalToConstant: 34),
            saveButton.widthAnchor.constraint(equalToConstant: 34),
            saveButton.heightAnchor.constraint(equalToConstant: 34),
            stack.centerXAnchor.constraint(equalTo: panel.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: panel.centerYAnchor)
        ])
        return panel
    }

    private func refreshStatPanel() {
        sparkButton.setImage(UIImage(systemName: sparked ? "heart.fill" : "heart"), for: .normal)
        saveButton.setImage(UIImage(systemName: saved ? "bookmark.fill" : "bookmark"), for: .normal)
        sparkButton.tintColor = .white
        saveButton.tintColor = .white
        sparkValueLabel.text = sparked ? "8" : "7"
        saveValueLabel.text = saved ? "9" : "8"
    }

    private func addComment(name: String, text: String, mark: String, avatarName: String, avatarPath: String? = nil) {
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

        let row = UIStackView(arrangedSubviews: [avatarImageView, textStack])
        row.axis = .horizontal
        row.alignment = .top
        row.spacing = 12
        row.translatesAutoresizingMaskIntoConstraints = false
        commentStack.addArrangedSubview(row)

        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 40),
            avatarImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func prepareRhythm() {
        guard let url = tinkieTimbreDeck.url(for: clip.clipFileName) else { return }
        let player = AVPlayer(url: url)
        player.isMuted = true
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

    private func stopRhythm() {
        rhythmPlayer?.pause()
        rhythmPlayer = nil
        rhythmLayer.player = nil
        if let loopToken {
            NotificationCenter.default.removeObserver(loopToken)
            self.loopToken = nil
        }
    }

    private func refreshBond() {
        bondButton.setTitle(bonded ? "Following" : "Follow", for: .normal)
    }

    private static func rhythmKey(for clip: TinkieReelClip) -> String {
        [clip.performer, clip.coverName, clip.clipFileName].joined(separator: "::")
    }

    private func registerKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditingNow))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func switchRhythm() {
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
        guard TinkieProfileStore.isSignedIn else {
            openWelcome()
            return
        }
        let key = Self.rhythmKey(for: clip)
        bonded = TinkieRhythmBondStore.switchBond(for: key)
        refreshBond()
    }

    @objc private func sparkTapped() {
        guard TinkieProfileStore.isSignedIn else {
            openWelcome()
            return
        }
        sparked = TinkieRhythmBondStore.switchSpark(for: Self.rhythmKey(for: clip))
        refreshStatPanel()
    }

    @objc private func saveTapped() {
        guard TinkieProfileStore.isSignedIn else {
            openWelcome()
            return
        }
        saved = TinkieRhythmSaveStore.switchSaved(for: Self.rhythmKey(for: clip))
        refreshStatPanel()
    }

    @objc private func sendTapped() {
        guard TinkieProfileStore.isSignedIn else {
            openWelcome()
            return
        }
        let text = inputField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !text.isEmpty else {
            showNotice("Please enter a comment before sending.")
            return
        }
        let snapshot = TinkieProfileStore.currentSnapshot()
        addComment(name: snapshot.nickname, text: text, mark: "just now", avatarName: snapshot.heroImageName, avatarPath: snapshot.heroImagePath)
        inputField.text = nil
        view.endEditing(true)
    }

    @objc private func openPerformerPage() {
        let key = Self.rhythmKey(for: clip)
        let page = TinkiePerformerProfileViewController(
            clip: clip,
            bonded: TinkieRhythmBondStore.hasBond(for: key)
        )
        page.onBondChange = { [weak self] in
            guard let self else { return }
            guard TinkieProfileStore.isSignedIn else {
                self.dismiss(animated: true) {
                    self.openWelcome()
                }
                return
            }
            self.bonded = TinkieRhythmBondStore.switchBond(for: key)
            self.refreshBond()
        }
        let navigation = UINavigationController(rootViewController: page)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    @objc private func openMore() {
        tinkiePresentSafetyOptions(
            targetTitle: clip.performer,
            targetKey: TinkieBassTrailre.pulseKey(for: clip),
            targetKind: "clip",
            onBlock: { [weak self] in
                self?.dismiss(animated: true)
            }
        )
    }

    private func openWelcome() {
        view.endEditing(true)
        let welcome = TinkieDrumEchoer()
        let navigation = UINavigationController(rootViewController: welcome)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    private func showNotice(_ text: String) {
        let alert = UIAlertController(title: "Tinkie", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
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

    @objc private func keyboardWillHide(_ notification: Notification) {
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
        inputBottomConstraint?.constant = 0
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }

    @objc private func endEditingNow() {
        view.endEditing(true)
    }

    @objc private func close() {
        dismiss(animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
        fatalError("init(coder:) has not been implemented")
    }
}

private enum TinkieRhythmSaveStore {
    private static let storeKey = "tinkie_rhythm_saved_records"

    static func hasSaved(for key: String) -> Bool {
        records().contains(key)
    }

    static func switchSaved(for key: String) -> Bool {
        var values = Set(records())
        if values.contains(key) {
            values.remove(key)
            UserDefaults.standard.set(Array(values), forKey: storeKey)
            return false
        }
        values.insert(key)
        UserDefaults.standard.set(Array(values), forKey: storeKey)
        return true
    }

    private static func records() -> [String] {
        UserDefaults.standard.stringArray(forKey: storeKey) ?? []
    }
}
