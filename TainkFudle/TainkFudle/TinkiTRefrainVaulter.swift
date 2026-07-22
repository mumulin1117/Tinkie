import UIKit

final class TinkiTRefrainVaulter: UIViewController {
    private let collectionView: UICollectionView
    private let titleArtView = UIImageView()
    private let noticeButton = TinkieALyricRevea(assetName: "tinkie_discover_notice_bell", size: CGSize(width: 38, height: 38))
    private let publishButton = UIButton(type: .custom)
    private var clips: [TinkieReelClip] {
        (TinkieSongPulsePostStore.clips() + TinkieDemoLibrary.clips).filter { TinkieBassTrailre.allowsClip($0) }
    }

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        collectionView.isPagingEnabled = true
        collectionView.delaysContentTouches = false
        collectionView.canCancelContentTouches = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(tinkiTSingerWave.self, forCellWithReuseIdentifier: tinkiTSingerWave.reuseIdentifier)
        view.addSubview(collectionView)
        buildTopControls()
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = collectionView.bounds.size
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }

}

private extension TinkiTRefrainVaulter {
    func buildTopControls() {
        titleArtView.image = UIImage(named: "tinkie_reels_hot_title") ?? UIImage(named: "tinkie_reels_hot_badge")
        titleArtView.contentMode = .scaleAspectFit
        titleArtView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleArtView)

        noticeButton.translatesAutoresizingMaskIntoConstraints = false
        noticeButton.addTarget(self, action: #selector(openFriendInbox), for: .touchUpInside)
        view.addSubview(noticeButton)

        publishButton.setBackgroundImage(UIImage(named: "tinkie_reels_publish_capsule") ?? UIImage(named: "addpub"), for: .normal)
        publishButton.addTarget(self, action: #selector(publishTapped), for: .touchUpInside)
        publishButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(publishButton)

        NSLayoutConstraint.activate([
            titleArtView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleArtView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            titleArtView.widthAnchor.constraint(equalToConstant: 88),
            titleArtView.heightAnchor.constraint(equalToConstant: 36),

            publishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            publishButton.centerYAnchor.constraint(equalTo: titleArtView.centerYAnchor),
            publishButton.widthAnchor.constraint(equalToConstant: 100),
            publishButton.heightAnchor.constraint(equalToConstant: 38),

            noticeButton.trailingAnchor.constraint(equalTo: publishButton.leadingAnchor, constant: -14),
            noticeButton.centerYAnchor.constraint(equalTo: publishButton.centerYAnchor),
            noticeButton.widthAnchor.constraint(equalToConstant: 44),
            noticeButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc func publishTapped() {
        openPulsePost()
    }

    @objc func openFriendInbox() {
        guard TinkieProfileStore.isSignedIn else {
            openWelcome()
            return
        }
        let inbox = TinkieBridgeArctroller()
        let navigation = UINavigationController(rootViewController: inbox)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }
}

extension TinkiTRefrainVaulter: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        clips.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tinkiTSingerWave.reuseIdentifier, for: indexPath) as! tinkiTSingerWave
        let clip = clips[indexPath.item]
        let key = rhythmKey(for: clip)
        cell.configure(
            with: clip,
            bonded: TinkieRhythmBondStore.hasBond(for: key),
            sparked: TinkieRhythmBondStore.hasSpark(for: key)
        )
        cell.onMoreTapped = { [weak self] in
            self?.tinkiePresentSafetyOptions(
                targetTitle: clip.performer,
                targetKey: TinkieBassTrailre.pulseKey(for: clip),
                targetKind: "clip",
                onBlock: { [weak self] in
                    self?.collectionView.reloadData()
                }
            )
        }
        cell.onAvatarTapped = { [weak self] in
            self?.openPerformerPage(for: clip)
        }
        cell.onBondTapped = { [weak self] in
            self?.switchBond(for: clip, at: indexPath)
        }
        cell.onSparkTapped = { [weak self] in
            self?.switchSpark(for: clip, at: indexPath)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openRhythmDetail(for: clips[indexPath.item])
    }

}

private extension TinkiTRefrainVaulter {
    func rhythmKey(for clip: TinkieReelClip) -> String {
        [clip.performer, clip.coverName, clip.clipFileName].joined(separator: "::")
    }

    func switchBond(for clip: TinkieReelClip, at indexPath: IndexPath) {
        guard TinkieProfileStore.isSignedIn else {
            openWelcome()
            return
        }
        _ = TinkieRhythmBondStore.switchBond(for: rhythmKey(for: clip))
        refreshItem(at: indexPath)
    }

    func switchSpark(for clip: TinkieReelClip, at indexPath: IndexPath) {
        guard TinkieProfileStore.isSignedIn else {
            openWelcome()
            return
        }
        _ = TinkieRhythmBondStore.switchSpark(for: rhythmKey(for: clip))
        refreshItem(at: indexPath)
    }

    func refreshItem(at indexPath: IndexPath) {
        guard collectionView.indexPathsForVisibleItems.contains(indexPath) else { return }
        collectionView.reloadItems(at: [indexPath])
    }

    func openPerformerPage(for clip: TinkieReelClip) {
        let key = rhythmKey(for: clip)
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
            _ = TinkieRhythmBondStore.switchBond(for: key)
            self.collectionView.reloadData()
        }
        let navigation = UINavigationController(rootViewController: page)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    func openRhythmDetail(for clip: TinkieReelClip) {
        let key = rhythmKey(for: clip)
        let detail = RefrainCircleController(
            clip: clip,
            bonded: TinkieRhythmBondStore.hasBond(for: key)
        )
        present(detail, animated: true)
    }

    func openPulsePost() {
        guard TinkieProfileStore.isSignedIn else {
            openWelcome()
            return
        }
        let post = TinkieSongPulsePostViewController()
        post.onPulseReady = { [weak self] in
            self?.collectionView.reloadData()
            self?.collectionView.setContentOffset(.zero, animated: false)
        }
        let navigation = UINavigationController(rootViewController: post)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    func openWelcome() {
        let welcome = TinkieDrumEchoer()
        welcome.onComplete = { [weak self] in
            self?.dismiss(animated: true)
        }
        let navigation = UINavigationController(rootViewController: welcome)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }
}

final class TinkiePerformerProfileViewController: UIViewController {
    var onBondChange: (() -> Void)?
    private let clip: TinkieReelClip
    private var bonded: Bool
    private let bondButton = UIButton(type: .system)
    private let followerValueLabel = UILabel()
    private var persona: TrinkieMelodyGuess {
        TinkiePersonaDirectory.persona(named: clip.performer)
    }
    private var signedSnapshot: TinkieMelodyScoreot? {
        let snapshot = TinkieProfileStore.currentSnapshot()
        guard snapshot.isSignedIn, snapshot.nickname == clip.performer else { return nil }
        return snapshot
    }
    private var performerClips: [TinkieReelClip] {
        TinkieDemoLibrary.pulseClips(for: clip.performer).filter { TinkieBassTrailre.allowsClip($0) }
    }
    private var performerEvents: [TinkieLyricFlow] {
        TinkieDemoLibrary.joinedEvents(for: clip.performer).filter { TinkieBassTrailre.allowsEvent($0) }
    }
    private var followerTotal: Int {
        min(9, (signedSnapshot?.followers ?? persona.followers) + (bonded ? 1 : 0))
    }
    private var pulseTotal: Int {
        min(9, max(1, performerClips.count + (signedSnapshot?.moments.count ?? persona.moments.count) + 1))
    }

    init(clip: TinkieReelClip, bonded: Bool) {
        self.clip = clip
        self.bonded = bonded
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        buildLayout()
        refreshBondTitle()
    }

    private func buildLayout() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.99, blue: 0.98, alpha: 1)

        let halo = TinkieQuestCreateBackdropView()
        halo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(halo)

        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
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

        let moreButton = UIButton(type: .system)
        moreButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        moreButton.tintColor = .black
        moreButton.addTarget(self, action: #selector(openMore), for: .touchUpInside)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(moreButton)

        let avatarImageView = UIImageView()
        if let path = signedSnapshot?.heroImagePath, let localArt = UIImage(contentsOfFile: path) {
            avatarImageView.image = localArt
        } else {
            avatarImageView.image = UIImage(named: signedSnapshot?.heroImageName ?? persona.heroImageName)
        }
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 38
        avatarImageView.layer.borderWidth = 1.5
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.masksToBounds = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(avatarImageView)

        bondButton.setTitleColor(.white, for: .normal)
        bondButton.tintColor = .white
        bondButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .black)
        bondButton.layer.cornerRadius = 14
        bondButton.layer.masksToBounds = true
        bondButton.addTarget(self, action: #selector(bondTapped), for: .touchUpInside)
        bondButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bondButton)

        let nameLabel = UILabel()
        nameLabel.text = clip.performer
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .black)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.78
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)

        let noteLabel = UILabel()
        noteLabel.text = signedSnapshot?.signature ?? persona.signature
        noteLabel.textColor = UIColor.white.withAlphaComponent(0.9)
        noteLabel.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        noteLabel.numberOfLines = 2
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(noteLabel)

        let statStack = UIStackView(arrangedSubviews: [
            makeStat(value: "\(pulseTotal)", title: "Likes"),
            makeStat(value: "\(followerTotal)", title: "Followers", valueLabel: followerValueLabel),
            makeStat(value: "\(min(9, signedSnapshot?.following ?? persona.following))", title: "Following")
        ])
        statStack.axis = .horizontal
        statStack.distribution = .fillEqually
        statStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(statStack)

        let cueButton = UIButton(type: .system)
        cueButton.setImage(UIImage(systemName: "ellipsis.bubble.fill"), for: .normal)
        cueButton.tintColor = .black
        cueButton.backgroundColor = UIColor(red: 0.08, green: 0.86, blue: 0.79, alpha: 1)
        cueButton.layer.cornerRadius = 22
        cueButton.addTarget(self, action: #selector(cueTapped), for: .touchUpInside)
        cueButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cueButton)

        let eventTitle = UILabel()
        eventTitle.text = "Event"
        eventTitle.textColor = .black
        eventTitle.font = UIFont.systemFont(ofSize: 19, weight: .black)
        eventTitle.layer.shadowColor = UIColor(red: 0.08, green: 0.86, blue: 0.79, alpha: 1).cgColor
        eventTitle.layer.shadowOffset = CGSize(width: -2, height: 2)
        eventTitle.layer.shadowOpacity = 1
        eventTitle.layer.shadowRadius = 0
        eventTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(eventTitle)

        let eventStrip = TinkiePerformerEventStripView(events: performerEvents)
        eventStrip.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(eventStrip)

        let momentTitle = UILabel()
        momentTitle.text = "Moments"
        momentTitle.textColor = .black
        momentTitle.font = UIFont.systemFont(ofSize: 19, weight: .black)
        momentTitle.layer.shadowColor = UIColor(red: 0.08, green: 0.86, blue: 0.79, alpha: 1).cgColor
        momentTitle.layer.shadowOffset = CGSize(width: -2, height: 2)
        momentTitle.layer.shadowOpacity = 1
        momentTitle.layer.shadowRadius = 0
        momentTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(momentTitle)

        let showcaseClip = performerClips.first ?? clip
        let momentCard = TinkiePerformerMomentTile(
            imageName: showcaseClip.coverName,
            imagePath: showcaseClip.coverPath,
            clipFileName: showcaseClip.clipFileName
        )
        momentCard.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(momentCard)

        let pageHeightGuide = contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.frameLayoutGuide.heightAnchor)
        pageHeightGuide.priority = .defaultLow

        NSLayoutConstraint.activate([
            halo.topAnchor.constraint(equalTo: view.topAnchor),
            halo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            halo.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            halo.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.72),

            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            pageHeightGuide,

            backButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 12),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            moreButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            moreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            moreButton.widthAnchor.constraint(equalToConstant: 44),
            moreButton.heightAnchor.constraint(equalToConstant: 44),

            avatarImageView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 22),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            avatarImageView.widthAnchor.constraint(equalToConstant: 76),
            avatarImageView.heightAnchor.constraint(equalToConstant: 76),

            bondButton.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
            bondButton.centerYAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -2),
            bondButton.widthAnchor.constraint(equalToConstant: 58),
            bondButton.heightAnchor.constraint(equalToConstant: 28),

            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 9),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 14),
            nameLabel.trailingAnchor.constraint(equalTo: moreButton.leadingAnchor, constant: -8),

            noteLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            noteLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            noteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -34),

            statStack.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 24),
            statStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            statStack.trailingAnchor.constraint(equalTo: cueButton.leadingAnchor, constant: -16),
            statStack.heightAnchor.constraint(equalToConstant: 42),

            cueButton.centerYAnchor.constraint(equalTo: statStack.centerYAnchor),
            cueButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            cueButton.widthAnchor.constraint(equalToConstant: 56),
            cueButton.heightAnchor.constraint(equalToConstant: 42),

            eventTitle.topAnchor.constraint(equalTo: statStack.bottomAnchor, constant: 24),
            eventTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            eventStrip.topAnchor.constraint(equalTo: eventTitle.bottomAnchor, constant: 8),
            eventStrip.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            eventStrip.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            eventStrip.heightAnchor.constraint(equalToConstant: 98),

            momentTitle.topAnchor.constraint(equalTo: eventStrip.bottomAnchor, constant: 16),
            momentTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            momentCard.topAnchor.constraint(equalTo: momentTitle.bottomAnchor, constant: 10),
            momentCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            momentCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            momentCard.heightAnchor.constraint(equalTo: momentCard.widthAnchor, multiplier: 0.78),
            momentCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -28)
        ])
    }

    private func makeStat(value: String, title: String, valueLabel externalValueLabel: UILabel? = nil) -> UIView {
        let valueLabel = externalValueLabel ?? UILabel()
        valueLabel.text = value
        valueLabel.textColor = .white
        valueLabel.font = UIFont.systemFont(ofSize: 12, weight: .black)
        valueLabel.textAlignment = .center

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = UIColor.white.withAlphaComponent(0.58)
        titleLabel.font = UIFont.systemFont(ofSize: 9, weight: .medium)
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.72

        let stack = UIStackView(arrangedSubviews: [valueLabel, titleLabel])
        stack.axis = .vertical
        stack.spacing = 3
        return stack
    }

    private func refreshBondTitle() {
        let symbolName = bonded ? "checkmark" : "plus"
        bondButton.setImage(UIImage(systemName: symbolName), for: .normal)
        bondButton.setTitle(nil, for: .normal)
        bondButton.backgroundColor = bonded ? UIColor.black.withAlphaComponent(0.35) : UIColor(red: 0.93, green: 0.07, blue: 0.67, alpha: 1)
        followerValueLabel.text = "\(followerTotal)"
    }

    @objc private func close() {
        dismiss(animated: true)
    }

    @objc private func openMore() {
        tinkiePresentSafetyOptions(
            targetTitle: clip.performer,
            targetKey: TinkieBassTrailre.personKey(for: clip.performer),
            targetKind: "person",
            onBlock: { [weak self] in
                self?.dismiss(animated: true)
            }
        )
    }

    @objc private func cueTapped() {
        guard TinkieProfileStore.isSignedIn else {
            onBondChange?()
            return
        }
        presentCueLimitNotice()
    }

    @objc private func bondTapped() {
        guard TinkieProfileStore.isSignedIn else {
            onBondChange?()
            return
        }
        bonded.toggle()
        refreshBondTitle()
        onBondChange?()
    }

    private func presentRoute(title: String, detail: String) {
        let route = TinkieProfileRouteViewController(titleText: title, detailText: detail, showsSignOut: false)
        let navigation = UINavigationController(rootViewController: route)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    private func presentCueLimitNotice() {
        let notice = TinkieMutualCueNoticeViewController()
        notice.modalPresentationStyle = .overFullScreen
        notice.modalTransitionStyle = .crossDissolve
        present(notice, animated: true)
    }
}

private final class TinkieMutualCueNoticeViewController: UIViewController {
    private let dimView = UIView()
    private let cardView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }

    private func buildLayout() {
        view.backgroundColor = .clear

        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.58)
        dimView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dimView)

        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 22
        cardView.layer.masksToBounds = true
        cardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cardView)

        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .white
        closeButton.backgroundColor = UIColor.black.withAlphaComponent(0.24)
        closeButton.layer.cornerRadius = 18
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)

        let bellArt = UIImageView()
        bellArt.image = UIImage(named: "tinkie_profile_notice_bell") ?? UIImage(systemName: "bell.fill")
        bellArt.tintColor = UIColor(red: 0.94, green: 0.08, blue: 0.62, alpha: 1)
        bellArt.contentMode = .scaleAspectFit
        bellArt.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(bellArt)

        let textLabel = UILabel()
        textLabel.text = "You can send messages once you both follow each other. Follow them now and wait for them to follow you back."
        textLabel.textColor = UIColor.black.withAlphaComponent(0.72)
        textLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.minimumScaleFactor = 0.82
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(textLabel)

        let okButton = TinkieSafetyConfirmButton()
        okButton.setTitle("OK", for: .normal)
        okButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        okButton.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(okButton)

        let cardWidthGuide = cardView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.78)
        cardWidthGuide.priority = .defaultHigh

        NSLayoutConstraint.activate([
            dimView.topAnchor.constraint(equalTo: view.topAnchor),
            dimView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 32),
            cardView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 24),
            cardView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -24),
            cardView.widthAnchor.constraint(lessThanOrEqualToConstant: 340),
            cardWidthGuide,

            closeButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            closeButton.topAnchor.constraint(equalTo: cardView.topAnchor, constant: -18),
            closeButton.widthAnchor.constraint(equalToConstant: 36),
            closeButton.heightAnchor.constraint(equalToConstant: 36),

            bellArt.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 28),
            bellArt.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            bellArt.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.46),
            bellArt.heightAnchor.constraint(equalTo: bellArt.widthAnchor, multiplier: 0.78),

            textLabel.topAnchor.constraint(equalTo: bellArt.bottomAnchor, constant: 16),
            textLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 22),
            textLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -22),

            okButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 26),
            okButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 30),
            okButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -30),
            okButton.heightAnchor.constraint(equalToConstant: 52),
            okButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -28)
        ])

        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(closeTapped))
        dismissTap.cancelsTouchesInView = false
        dimView.addGestureRecognizer(dismissTap)
    }

    @objc private func closeTapped() {
        dismiss(animated: true)
    }
}

private final class TinkiePerformerEventStripView: UIView {
    init(events: [TinkieLyricFlow]) {
        super.init(frame: .zero)
        clipsToBounds = false

        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)

        let content = UIStackView()
        content.axis = .horizontal
        content.spacing = 18
        content.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(content)

        events.prefix(2).forEach { event in
            content.addArrangedSubview(TinkiePerformerQuestCard(event: event))
        }

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            content.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            content.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            content.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            content.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            content.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private final class TinkiePerformerQuestCard: UIView {
    init(event: TinkieLyricFlow) {
        super.init(frame: .zero)
        backgroundColor = UIColor(red: 0.01, green: 0.05, blue: 0.04, alpha: 1)
        layer.cornerRadius = 11
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false

        let openLabel = TinkiePillLabel(text: "OPEN", foreground: .black, background: .white)
        openLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(openLabel)

        let coverFrame = UIImageView(image: UIImage(named: "tinkie_event_cover_frame"))
        coverFrame.contentMode = .scaleAspectFit
        coverFrame.translatesAutoresizingMaskIntoConstraints = false
        addSubview(coverFrame)

        let cover = UIImageView(image: UIImage(named: event.coverName))
        cover.contentMode = .scaleAspectFill
        cover.layer.cornerRadius = 24
        cover.layer.masksToBounds = true
        cover.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cover)

        let turntable = UIImageView(image: UIImage(named: "tinkie_event_vinyl_turntable"))
        turntable.contentMode = .scaleAspectFit
        turntable.translatesAutoresizingMaskIntoConstraints = false
        addSubview(turntable)

        let titleLabel = UILabel()
        titleLabel.text = event.title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        let tagLabel = UILabel()
        tagLabel.text = event.tags.joined(separator: "   ")
        tagLabel.textColor = UIColor(red: 1, green: 0.18, blue: 0.72, alpha: 1)
        tagLabel.font = UIFont.systemFont(ofSize: 8, weight: .semibold)
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tagLabel)

        let join = UIImageView(image: UIImage(named: "tinkie_event_join_badge"))
        join.contentMode = .scaleAspectFit
        join.translatesAutoresizingMaskIntoConstraints = false
        addSubview(join)

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 236),
            heightAnchor.constraint(equalToConstant: 78),

            openLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            openLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            openLabel.widthAnchor.constraint(equalToConstant: 45),
            openLabel.heightAnchor.constraint(equalToConstant: 20),

            coverFrame.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            coverFrame.centerYAnchor.constraint(equalTo: centerYAnchor),
            coverFrame.widthAnchor.constraint(equalToConstant: 58),
            coverFrame.heightAnchor.constraint(equalToConstant: 58),

            cover.centerXAnchor.constraint(equalTo: coverFrame.centerXAnchor),
            cover.centerYAnchor.constraint(equalTo: coverFrame.centerYAnchor),
            cover.widthAnchor.constraint(equalToConstant: 48),
            cover.heightAnchor.constraint(equalToConstant: 48),

            turntable.centerXAnchor.constraint(equalTo: coverFrame.centerXAnchor),
            turntable.centerYAnchor.constraint(equalTo: coverFrame.centerYAnchor),
            turntable.widthAnchor.constraint(equalToConstant: 32),
            turntable.heightAnchor.constraint(equalToConstant: 32),

            titleLabel.leadingAnchor.constraint(equalTo: coverFrame.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),

            tagLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            tagLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            tagLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),

            join.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            join.topAnchor.constraint(equalTo: tagLabel.bottomAnchor, constant: 6),
            join.widthAnchor.constraint(equalToConstant: 78),
            join.heightAnchor.constraint(equalToConstant: 27)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private final class TinkiePerformerMomentTile: UIView {
    init(imageName: String, imagePath: String?, clipFileName: String?) {
        super.init(frame: .zero)
        layer.cornerRadius = 12
        layer.masksToBounds = true

        let imageView = UIImageView()
        if let imagePath, let localArt = UIImage(contentsOfFile: imagePath) {
            imageView.image = localArt
        } else {
            imageView.image = UIImage(named: imageName)
        }
        if let clipFileName {
            if let firstFrame = TinkieRhythmFirstFrameStore.art(for: clipFileName) {
                imageView.image = firstFrame
            } else {
                TinkieRhythmFirstFrameStore.resolveArt(for: clipFileName) { [weak imageView] firstFrame in
                    guard let firstFrame else { return }
                    imageView?.image = firstFrame
                }
            }
        }
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)

        let mark = UIButton(type: .system)
        mark.setImage(UIImage(systemName: "exclamationmark.circle"), for: .normal)
        mark.tintColor = .white
        mark.backgroundColor = UIColor.black.withAlphaComponent(0.38)
        mark.layer.cornerRadius = 14
        mark.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mark)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),

            mark.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            mark.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            mark.widthAnchor.constraint(equalToConstant: 28),
            mark.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
