import UIKit

final class TinkieSongRoomViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    private let event: TinkieLyricFlow
    private let group: TinkieMelodyQuest
    private var roomLines: [tinkieMelodyArc]

    private let backgroundImageView = UIImageView()
    private let shadeView = UIView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let memberCollectionView: UICollectionView
    private let lineStack = UIStackView()
    private let inputContainer = UIView()
    private let inputField = UITextField()
    private let sendButton = TinkieRoomGradientButton()
    private var inputBottomConstraint: NSLayoutConstraint?
    private var exitOverlay: TinkieRoomExitOverlay?

    init(event: TinkieLyricFlow, group: TinkieMelodyQuest) {
        self.event = event
        self.group = group
        self.roomLines = group.roomLines

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 14
        layout.minimumInteritemSpacing = 10
        self.memberCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        buildLayout()
        reloadLines()
        registerKeyboardObservers()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private var owner: TinkieMelodyCue {
        group.roomMembers.first(where: { $0.isOwner }) ?? group.roomMembers.first ?? TinkieMelodyCue(name: event.hostName, avatarName: event.avatarNames.first ?? "tinkie_avatar_neon_voice", isOwner: true, isMuted: false)
    }

    private var sideMembers: [TinkieMelodyCue] {
        Array(group.roomMembers.filter { !$0.isOwner && !TinkieBassTrailre.hasBlockedPerson($0.name) }.prefix(8))
    }

    private func buildLayout() {
        view.backgroundColor = .black

        if let coverPath = event.coverPath, let localArt = UIImage(contentsOfFile: coverPath) {
            backgroundImageView.image = localArt
        } else {
            backgroundImageView.image = UIImage(named: event.coverName)
        }
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)

        shadeView.backgroundColor = UIColor.black.withAlphaComponent(0.64)
        shadeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shadeView)

        let aura = TinkieRoomAuraView()
        aura.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aura)

        let topBar = buildTopBar()
        topBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBar)

        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        let stageLayout = buildStageLayout()
        stageLayout.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stageLayout)

        let safetyLabel = UILabel()
        safetyLabel.text = "Illegal, harmful, hateful, harassing, fraudulent, or otherwise inappropriate content is prohibited. Tinkie song rooms are reviewed to keep guessing rounds respectful and safe."
        safetyLabel.textColor = UIColor(red: 1, green: 0.39, blue: 0.18, alpha: 0.88)
        safetyLabel.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        safetyLabel.numberOfLines = 0
        safetyLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(safetyLabel)

        lineStack.axis = .vertical
        lineStack.alignment = .leading
        lineStack.spacing = 12
        lineStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(lineStack)

        buildInputBar()

        inputBottomConstraint = inputContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            shadeView.topAnchor.constraint(equalTo: view.topAnchor),
            shadeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shadeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            shadeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            aura.topAnchor.constraint(equalTo: view.topAnchor),
            aura.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            aura.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            aura.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),

            scrollView.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 8),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: inputContainer.topAnchor, constant: -8),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            stageLayout.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            stageLayout.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            stageLayout.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),

            safetyLabel.topAnchor.constraint(equalTo: stageLayout.bottomAnchor, constant: 18),
            safetyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 26),
            safetyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),

            lineStack.topAnchor.constraint(equalTo: safetyLabel.bottomAnchor, constant: 28),
            lineStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            lineStack.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
            lineStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            inputContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            inputContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            inputContainer.heightAnchor.constraint(equalToConstant: 52),
            inputBottomConstraint!
        ])
    }

    private func buildTopBar() -> UIView {
        let container = UIView()

        let home = UIImageView(image: UIImage(systemName: "house"))
        home.tintColor = .white
        home.contentMode = .scaleAspectFit
        home.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = event.title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        titleLabel.lineBreakMode = .byTruncatingTail

        let groupLabel = UILabel()
        groupLabel.text = "\(group.name)   \(group.joinedCount) joined"
        groupLabel.textColor = UIColor.white.withAlphaComponent(0.72)
        groupLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)

        let textStack = UIStackView(arrangedSubviews: [titleLabel, groupLabel])
        textStack.axis = .vertical
        textStack.spacing = 2
        textStack.translatesAutoresizingMaskIntoConstraints = false

        let memberStack = TinkieRoomAvatarStack(names: group.avatarNames)
        memberStack.translatesAutoresizingMaskIntoConstraints = false

        let moreButton = TinkieRoomRoundIconButton(symbolName: "ellipsis")
        moreButton.addTarget(self, action: #selector(openMore), for: .touchUpInside)
        moreButton.translatesAutoresizingMaskIntoConstraints = false

        let closeButton = TinkieRoomRoundIconButton(symbolName: "xmark")
        closeButton.addTarget(self, action: #selector(openExitPrompt), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        [home, textStack, memberStack, moreButton, closeButton].forEach(container.addSubview)

        NSLayoutConstraint.activate([
            home.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            home.centerYAnchor.constraint(equalTo: textStack.centerYAnchor),
            home.widthAnchor.constraint(equalToConstant: 14),
            home.heightAnchor.constraint(equalToConstant: 14),

            textStack.topAnchor.constraint(equalTo: container.topAnchor),
            textStack.leadingAnchor.constraint(equalTo: home.trailingAnchor, constant: 4),
            textStack.trailingAnchor.constraint(lessThanOrEqualTo: memberStack.leadingAnchor, constant: -10),
            textStack.bottomAnchor.constraint(equalTo: container.bottomAnchor),

            closeButton.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            closeButton.centerYAnchor.constraint(equalTo: textStack.centerYAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 34),
            closeButton.heightAnchor.constraint(equalToConstant: 34),

            moreButton.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -8),
            moreButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            moreButton.widthAnchor.constraint(equalToConstant: 34),
            moreButton.heightAnchor.constraint(equalToConstant: 34),

            memberStack.trailingAnchor.constraint(equalTo: moreButton.leadingAnchor, constant: -10),
            memberStack.centerYAnchor.constraint(equalTo: moreButton.centerYAnchor),
            memberStack.widthAnchor.constraint(equalToConstant: 72),
            memberStack.heightAnchor.constraint(equalToConstant: 30)
        ])
        return container
    }

    private func buildStageLayout() -> UIView {
        let container = UIView()

        let ownerView = TinkieRoomOwnerView(member: owner)
        ownerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openOwnerProfile)))
        ownerView.isUserInteractionEnabled = true
        ownerView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(ownerView)

        memberCollectionView.backgroundColor = .clear
        memberCollectionView.isScrollEnabled = false
        memberCollectionView.dataSource = self
        memberCollectionView.delegate = self
        memberCollectionView.register(TinkieSongRoomMemberCell.self, forCellWithReuseIdentifier: TinkieSongRoomMemberCell.reuseIdentifier)
        memberCollectionView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(memberCollectionView)

        NSLayoutConstraint.activate([
            container.heightAnchor.constraint(greaterThanOrEqualToConstant: 292),

            ownerView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            ownerView.topAnchor.constraint(equalTo: container.topAnchor, constant: 44),
            ownerView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.45),

            memberCollectionView.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
            memberCollectionView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            memberCollectionView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.48),
            memberCollectionView.heightAnchor.constraint(equalToConstant: 270),
            memberCollectionView.bottomAnchor.constraint(lessThanOrEqualTo: container.bottomAnchor)
        ])

        return container
    }

    private func buildInputBar() {
        inputContainer.backgroundColor = UIColor(red: 0.16, green: 0.14, blue: 0.17, alpha: 0.92)
        inputContainer.layer.cornerRadius = 26
        inputContainer.layer.borderWidth = 1
        inputContainer.layer.borderColor = UIColor.white.withAlphaComponent(0.08).cgColor
        inputContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputContainer)

        let smile = UIImageView(image: UIImage(systemName: "face.smiling"))
        smile.tintColor = UIColor.white.withAlphaComponent(0.78)
        smile.contentMode = .scaleAspectFit
        smile.translatesAutoresizingMaskIntoConstraints = false
        inputContainer.addSubview(smile)

        inputField.placeholder = "Say hi~"
        inputField.textColor = .white
        inputField.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        inputField.delegate = self
        inputField.returnKeyType = .send
        inputField.attributedPlaceholder = NSAttributedString(
            string: "Say hi~",
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.65)]
        )
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputContainer.addSubview(inputField)

        sendButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        sendButton.tintColor = .white
        sendButton.addTarget(self, action: #selector(sendLine), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        inputContainer.addSubview(sendButton)

        NSLayoutConstraint.activate([
            smile.leadingAnchor.constraint(equalTo: inputContainer.leadingAnchor, constant: 16),
            smile.centerYAnchor.constraint(equalTo: inputContainer.centerYAnchor),
            smile.widthAnchor.constraint(equalToConstant: 22),
            smile.heightAnchor.constraint(equalToConstant: 22),

            sendButton.trailingAnchor.constraint(equalTo: inputContainer.trailingAnchor, constant: -6),
            sendButton.centerYAnchor.constraint(equalTo: inputContainer.centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 44),
            sendButton.heightAnchor.constraint(equalToConstant: 40),

            inputField.leadingAnchor.constraint(equalTo: smile.trailingAnchor, constant: 8),
            inputField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -10),
            inputField.topAnchor.constraint(equalTo: inputContainer.topAnchor, constant: 5),
            inputField.bottomAnchor.constraint(equalTo: inputContainer.bottomAnchor, constant: -5)
        ])
    }

    private func reloadLines() {
        lineStack.arrangedSubviews.forEach { view in
            lineStack.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        roomLines.forEach { lineStack.addArrangedSubview(TinkieRoomLineBubble(line: $0)) }
    }

    @objc private func sendLine() {
        let text = inputField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !text.isEmpty else { return }
        let name = TinkieProfileStore.currentSnapshot().nickname
        roomLines.append(tinkieMelodyArc(speaker: name, text: text))
        inputField.text = nil
        reloadLines()
        view.layoutIfNeeded()
        let bottomOffset = max(0, scrollView.contentSize.height - scrollView.bounds.height + scrollView.adjustedContentInset.bottom)
        scrollView.setContentOffset(CGPoint(x: 0, y: bottomOffset), animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendLine()
        return true
    }

    @objc private func openMore() {
        tinkiePresentSafetyOptions(
            targetTitle: "\(event.title) \(group.name)",
            targetKey: TinkieBassTrailre.roomKey(event: event, group: group),
            targetKind: "room",
            onBlock: { [weak self] in
                self?.dismiss(animated: true)
            }
        )
    }

    @objc private func openOwnerProfile() {
        openProfile(for: owner)
    }

    private func openProfile(for member: TinkieMelodyCue) {
        guard TinkieProfileStore.isSignedIn else {
            openWelcome()
            return
        }
        let item = profilePulse(for: member)
        let key = [item.performer, item.coverName, item.clipFileName].joined(separator: "::")
        let page = TinkiePerformerProfileViewController(
            clip: item,
            bonded: TinkieRhythmBondStore.hasBond(for: key)
        )
        let navigation = UINavigationController(rootViewController: page)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    private func profilePulse(for member: TinkieMelodyCue) -> TinkieReelClip {
        if let seeded = TinkieDemoLibrary.pulseClips(for: member.name).first {
            return seeded
        }
        let snapshot = TinkieProfileStore.currentSnapshot()
        let matchedPath = member.avatarPath ?? (snapshot.isSignedIn && snapshot.nickname == member.name ? snapshot.heroImagePath : nil)
        let fallbackFile = TinkieDemoLibrary.clips.first?.clipFileName ?? "tinkie_song_room_clip_country_hint.mp4"
        return TinkieReelClip(
            performer: member.name,
            moment: "in this room",
            caption: "\(member.name) joined \(group.name) for a quick song guessing round.",
            coverName: event.coverName,
            coverPath: event.coverPath,
            clipFileName: fallbackFile,
            avatarName: member.avatarName,
            avatarPath: matchedPath,
            echoCount: "room"
        )
    }

    private func openWelcome() {
        let welcome = TinkieDrumEchoer()
        welcome.onComplete = { [weak self] in
            self?.dismiss(animated: true)
        }
        let navigation = UINavigationController(rootViewController: welcome)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    private func showNotice(title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    @objc private func openExitPrompt() {
        guard exitOverlay == nil else { return }
        let overlay = TinkieRoomExitOverlay()
        overlay.onMinimize = { [weak self] in
            self?.dismiss(animated: true)
        }
        overlay.onClose = { [weak self] in
            self?.dismiss(animated: true)
        }
        overlay.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlay)
        exitOverlay = overlay
        NSLayoutConstraint.activate([
            overlay.topAnchor.constraint(equalTo: view.topAnchor),
            overlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlay.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        overlay.show()
    }

    private func registerKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditingNow))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard
            let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else { return }
        let overlap = max(0, view.bounds.maxY - view.convert(frame, from: nil).minY - view.safeAreaInsets.bottom)
        inputBottomConstraint?.constant = -overlap - 10
        scrollView.contentInset.bottom = overlap + 16
        scrollView.scrollIndicatorInsets.bottom = overlap + 16
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
        inputBottomConstraint?.constant = -10
        scrollView.contentInset.bottom = 0
        scrollView.scrollIndicatorInsets.bottom = 0
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }

    @objc private func endEditingNow() {
        view.endEditing(true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sideMembers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TinkieSongRoomMemberCell.reuseIdentifier, for: indexPath) as! TinkieSongRoomMemberCell
        cell.configure(member: sideMembers[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openProfile(for: sideMembers[indexPath.item])
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor((collectionView.bounds.width - 10) / 2)
        return CGSize(width: width, height: 70)
    }
}

private final class TinkieRoomOwnerView: UIView {
    init(member: TinkieMelodyCue) {
        super.init(frame: .zero)
        buildLayout(member: member)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildLayout(member: TinkieMelodyCue) {
        let avatar = UIImageView()
        if let avatarPath = member.avatarPath, let localArt = UIImage(contentsOfFile: avatarPath) {
            avatar.image = localArt
        } else {
            avatar.image = UIImage(named: member.avatarName)
        }
        avatar.contentMode = .scaleAspectFill
        avatar.layer.cornerRadius = 48
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = UIColor.white.withAlphaComponent(0.72).cgColor
        avatar.layer.masksToBounds = true
        avatar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(avatar)

        let ring = TinkieRoomRingView()
        ring.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(ring, belowSubview: avatar)

        let badge = UILabel()
        badge.text = "Owner"
        badge.textColor = .black
        badge.textAlignment = .center
        badge.font = UIFont.systemFont(ofSize: 10, weight: .black)
        badge.backgroundColor = .white
        badge.layer.cornerRadius = 10
        badge.layer.masksToBounds = true
        badge.translatesAutoresizingMaskIntoConstraints = false
        addSubview(badge)

        let name = UILabel()
        name.text = member.name
        name.textColor = .white
        name.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        name.textAlignment = .center
        name.translatesAutoresizingMaskIntoConstraints = false
        addSubview(name)

        let mic = UIImageView(image: UIImage(systemName: member.isMuted ? "mic.slash.fill" : "mic.fill"))
        mic.tintColor = .white
        mic.contentMode = .scaleAspectFit
        mic.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mic)

        NSLayoutConstraint.activate([
            ring.topAnchor.constraint(equalTo: topAnchor),
            ring.centerXAnchor.constraint(equalTo: centerXAnchor),
            ring.widthAnchor.constraint(equalToConstant: 112),
            ring.heightAnchor.constraint(equalToConstant: 112),

            avatar.centerXAnchor.constraint(equalTo: ring.centerXAnchor),
            avatar.centerYAnchor.constraint(equalTo: ring.centerYAnchor),
            avatar.widthAnchor.constraint(equalToConstant: 96),
            avatar.heightAnchor.constraint(equalToConstant: 96),

            badge.centerXAnchor.constraint(equalTo: avatar.centerXAnchor),
            badge.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: -12),
            badge.widthAnchor.constraint(equalToConstant: 64),
            badge.heightAnchor.constraint(equalToConstant: 20),

            name.topAnchor.constraint(equalTo: badge.bottomAnchor, constant: 8),
            name.leadingAnchor.constraint(equalTo: leadingAnchor),
            name.trailingAnchor.constraint(equalTo: trailingAnchor),

            mic.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4),
            mic.centerXAnchor.constraint(equalTo: centerXAnchor),
            mic.widthAnchor.constraint(equalToConstant: 14),
            mic.heightAnchor.constraint(equalToConstant: 14),
            mic.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

private final class TinkieSongRoomMemberCell: UICollectionViewCell {
    static let reuseIdentifier = "TinkieSongRoomMemberCell"
    private let avatar = UIImageView()
    private let nameLabel = UILabel()
    private let micIcon = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(member: TinkieMelodyCue) {
        if let avatarPath = member.avatarPath, let localArt = UIImage(contentsOfFile: avatarPath) {
            avatar.image = localArt
        } else {
            avatar.image = UIImage(named: member.avatarName)
        }
        nameLabel.text = member.name
        micIcon.image = UIImage(systemName: member.isMuted ? "mic.slash.fill" : "mic.fill")
        avatar.backgroundColor = UIColor.white.withAlphaComponent(0.12)
    }

    private func buildLayout() {
        avatar.contentMode = .scaleAspectFill
        avatar.layer.cornerRadius = 23
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = UIColor.white.withAlphaComponent(0.55).cgColor
        avatar.layer.masksToBounds = true
        avatar.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(avatar)

        nameLabel.textColor = UIColor.white.withAlphaComponent(0.86)
        nameLabel.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        nameLabel.textAlignment = .center
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.7
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)

        micIcon.tintColor = UIColor.white.withAlphaComponent(0.84)
        micIcon.contentMode = .scaleAspectFit
        micIcon.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(micIcon)

        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatar.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatar.widthAnchor.constraint(equalToConstant: 46),
            avatar.heightAnchor.constraint(equalToConstant: 46),

            nameLabel.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 3),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            micIcon.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            micIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            micIcon.widthAnchor.constraint(equalToConstant: 10),
            micIcon.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
}

private final class TinkieRoomLineBubble: UIView {
    init(line: tinkieMelodyArc) {
        super.init(frame: .zero)
        backgroundColor = UIColor.white.withAlphaComponent(0.12)
        layer.cornerRadius = 10
        layer.masksToBounds = true

        let label = UILabel()
        label.text = "\(line.speaker): \(line.text)"
        label.textColor = UIColor.white.withAlphaComponent(0.92)
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)

        NSLayoutConstraint.activate([
            widthAnchor.constraint(lessThanOrEqualToConstant: 260),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 9),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private final class TinkieRoomAvatarStack: UIView {
    init(names: [String]) {
        super.init(frame: .zero)
        for (index, name) in names.prefix(3).enumerated() {
            let avatar = TinkieAvatarView(imageName: name, size: 30)
            avatar.translatesAutoresizingMaskIntoConstraints = false
            addSubview(avatar)
            NSLayoutConstraint.activate([
                avatar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(index) * 21),
                avatar.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private final class TinkieRoomRoundIconButton: UIButton {
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

private final class TinkieRoomGradientButton: UIButton {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let gradient = layer as! CAGradientLayer
        gradient.colors = [
            UIColor(red: 0.88, green: 0.06, blue: 0.62, alpha: 1).cgColor,
            UIColor(red: 0.11, green: 0.86, blue: 0.78, alpha: 1).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private final class TinkieRoomExitOverlay: UIView {
    var onMinimize: (() -> Void)?
    var onClose: (() -> Void)?
    private let dialog = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show() {
        alpha = 0
        dialog.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        UIView.animate(withDuration: 0.22) {
            self.alpha = 1
            self.dialog.transform = .identity
        }
    }

    private func buildLayout() {
        backgroundColor = UIColor.black.withAlphaComponent(0.62)

        dialog.backgroundColor = .white
        dialog.layer.cornerRadius = 18
        dialog.layer.masksToBounds = true
        dialog.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dialog)

        let bell = UIImageView(image: UIImage(named: "tinkie_discover_notice_bell"))
        bell.contentMode = .scaleAspectFit
        bell.translatesAutoresizingMaskIntoConstraints = false
        dialog.addSubview(bell)

        let title = UILabel()
        title.text = "Do you want to close or minimize the room?"
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 15, weight: .black)
        title.textAlignment = .center
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        dialog.addSubview(title)

        let minimize = TinkieRoomGradientButton()
        minimize.setTitle("Minimize", for: .normal)
        minimize.setTitleColor(.white, for: .normal)
        minimize.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .black)
        minimize.addTarget(self, action: #selector(minimizeTapped), for: .touchUpInside)
        minimize.translatesAutoresizingMaskIntoConstraints = false
        dialog.addSubview(minimize)

        let close = UIButton(type: .system)
        close.setTitle("Close", for: .normal)
        close.setTitleColor(UIColor.black.withAlphaComponent(0.28), for: .normal)
        close.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .black)
        close.backgroundColor = UIColor.black.withAlphaComponent(0.06)
        close.layer.cornerRadius = 19
        close.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        close.translatesAutoresizingMaskIntoConstraints = false
        dialog.addSubview(close)

        NSLayoutConstraint.activate([
            dialog.centerXAnchor.constraint(equalTo: centerXAnchor),
            dialog.centerYAnchor.constraint(equalTo: centerYAnchor),
            dialog.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 34),
            dialog.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -34),
            dialog.widthAnchor.constraint(lessThanOrEqualToConstant: 300),

            bell.topAnchor.constraint(equalTo: dialog.topAnchor, constant: 24),
            bell.centerXAnchor.constraint(equalTo: dialog.centerXAnchor),
            bell.widthAnchor.constraint(equalToConstant: 78),
            bell.heightAnchor.constraint(equalToConstant: 78),

            title.topAnchor.constraint(equalTo: bell.bottomAnchor, constant: 12),
            title.leadingAnchor.constraint(equalTo: dialog.leadingAnchor, constant: 24),
            title.trailingAnchor.constraint(equalTo: dialog.trailingAnchor, constant: -24),

            minimize.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 22),
            minimize.leadingAnchor.constraint(equalTo: dialog.leadingAnchor, constant: 24),
            minimize.widthAnchor.constraint(equalTo: close.widthAnchor),
            minimize.heightAnchor.constraint(equalToConstant: 42),
            minimize.bottomAnchor.constraint(equalTo: dialog.bottomAnchor, constant: -24),

            close.leadingAnchor.constraint(equalTo: minimize.trailingAnchor, constant: 14),
            close.trailingAnchor.constraint(equalTo: dialog.trailingAnchor, constant: -24),
            close.centerYAnchor.constraint(equalTo: minimize.centerYAnchor),
            close.heightAnchor.constraint(equalTo: minimize.heightAnchor)
        ])
    }

    @objc private func minimizeTapped() {
        onMinimize?()
    }

    @objc private func closeTapped() {
        onClose?()
    }
}

private final class TinkieRoomAuraView: UIView {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let gradient = layer as! CAGradientLayer
        gradient.colors = [
            UIColor(red: 0.01, green: 0.02, blue: 0.06, alpha: 0.9).cgColor,
            UIColor(red: 0.05, green: 0.30, blue: 0.52, alpha: 0.38).cgColor,
            UIColor(red: 0.74, green: 0.04, blue: 0.52, alpha: 0.22).cgColor,
            UIColor.black.withAlphaComponent(0.88).cgColor
        ]
        gradient.locations = [0, 0.42, 0.72, 1]
        gradient.startPoint = CGPoint(x: 0.1, y: 0)
        gradient.endPoint = CGPoint(x: 0.9, y: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private final class TinkieRoomRingView: UIView {
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2 - 5
        let colors = [
            UIColor(red: 0.91, green: 0.08, blue: 0.64, alpha: 1),
            UIColor(red: 0.12, green: 0.84, blue: 0.80, alpha: 1)
        ]
        for index in 0..<2 {
            let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(index) * .pi - .pi / 2, endAngle: CGFloat(index + 1) * .pi - .pi / 2, clockwise: true)
            path.lineWidth = 4
            colors[index].setStroke()
            path.stroke()
        }
    }
}
