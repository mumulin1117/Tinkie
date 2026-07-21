import UIKit

final class TinkieReelsViewController: UIViewController {
    private let collectionView: UICollectionView
    private let titleArtView = UIImageView()
    private let noticeButton = TinkieAssetImageButton(assetName: "tinkie_discover_notice_bell", size: CGSize(width: 38, height: 38))
    private let publishButton = UIButton(type: .custom)
    private var clips: [TinkieReelClip] {
        TinkieSongPulsePostStore.clips() + TinkieDemoLibrary.clips
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
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TinkieReelCell.self, forCellWithReuseIdentifier: TinkieReelCell.reuseIdentifier)
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
}

private extension TinkieReelsViewController {
    func buildTopControls() {
        titleArtView.image = UIImage(named: "tinkie_reels_hot_title") ?? UIImage(named: "tinkie_reels_hot_badge")
        titleArtView.contentMode = .scaleAspectFit
        titleArtView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleArtView)

        noticeButton.translatesAutoresizingMaskIntoConstraints = false
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
}

extension TinkieReelsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        clips.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TinkieReelCell.reuseIdentifier, for: indexPath) as! TinkieReelCell
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
                targetKey: "clip:\(clip.performer):\(clip.coverName)",
                targetKind: "clip"
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
        cell.onCenterPlayTapped = {}
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openRhythmDetail(for: clips[indexPath.item])
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? TinkieReelCell)?.stopClip()
    }
}

private extension TinkieReelsViewController {
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
        let detail = TinkieRhythmDetailViewController(
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
        let welcome = TinkieAuthWelcomeViewController()
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
    private var persona: TinkiePersona {
        TinkiePersonaDirectory.persona(named: clip.performer)
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
        view.backgroundColor = UIColor(red: 0.93, green: 0.99, blue: 0.98, alpha: 1)

        let halo = TinkieQuestCreateBackdropView()
        halo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(halo)

        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)

        let moreButton = UIButton(type: .system)
        moreButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        moreButton.tintColor = .black
        moreButton.backgroundColor = UIColor.white.withAlphaComponent(0.28)
        moreButton.layer.cornerRadius = 18
        moreButton.addTarget(self, action: #selector(openMore), for: .touchUpInside)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(moreButton)

        let artImageView = UIImageView()
        if let coverPath = clip.coverPath, let localArt = UIImage(contentsOfFile: coverPath) {
            artImageView.image = localArt
        } else {
            artImageView.image = UIImage(named: clip.coverName)
        }
        artImageView.contentMode = .scaleAspectFill
        artImageView.layer.cornerRadius = 28
        artImageView.layer.masksToBounds = true
        artImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(artImageView)

        let avatarImageView = UIImageView(image: UIImage(named: persona.heroImageName))
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 44
        avatarImageView.layer.borderWidth = 2
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.masksToBounds = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(avatarImageView)

        let nameLabel = UILabel()
        nameLabel.text = clip.performer
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 28, weight: .black)
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)

        let noteLabel = UILabel()
        noteLabel.text = persona.signature
        noteLabel.textColor = UIColor.black.withAlphaComponent(0.62)
        noteLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        noteLabel.textAlignment = .center
        noteLabel.numberOfLines = 2
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noteLabel)

        let statStack = UIStackView(arrangedSubviews: [
            makeStat(value: "\(max(12, persona.moments.count * 31))", title: "Likes"),
            makeStat(value: "\(persona.followers)", title: "Followers"),
            makeStat(value: "\(persona.following)", title: "Following")
        ])
        statStack.axis = .horizontal
        statStack.distribution = .fillEqually
        statStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statStack)

        bondButton.setTitleColor(.white, for: .normal)
        bondButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .black)
        bondButton.layer.cornerRadius = 23
        bondButton.addTarget(self, action: #selector(bondTapped), for: .touchUpInside)
        bondButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bondButton)

        let momentTitle = UILabel()
        momentTitle.text = "Moments"
        momentTitle.textColor = .black
        momentTitle.font = UIFont.systemFont(ofSize: 24, weight: .black)
        momentTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(momentTitle)

        let momentCard = UIImageView()
        let showcase = persona.moments.first?.coverName ?? clip.coverName
        if let coverPath = clip.coverPath, let localArt = UIImage(contentsOfFile: coverPath) {
            momentCard.image = localArt
        } else {
            momentCard.image = UIImage(named: showcase)
        }
        momentCard.contentMode = .scaleAspectFill
        momentCard.layer.cornerRadius = 16
        momentCard.layer.masksToBounds = true
        momentCard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(momentCard)

        NSLayoutConstraint.activate([
            halo.topAnchor.constraint(equalTo: view.topAnchor),
            halo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            halo.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            halo.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            moreButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            moreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            moreButton.widthAnchor.constraint(equalToConstant: 36),
            moreButton.heightAnchor.constraint(equalToConstant: 36),

            artImageView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 18),
            artImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            artImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            artImageView.heightAnchor.constraint(equalTo: artImageView.widthAnchor, multiplier: 0.78),

            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: artImageView.bottomAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 88),
            avatarImageView.heightAnchor.constraint(equalToConstant: 88),

            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 14),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            noteLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            noteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            noteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),

            statStack.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 22),
            statStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            statStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            statStack.heightAnchor.constraint(equalToConstant: 52),

            bondButton.topAnchor.constraint(equalTo: statStack.bottomAnchor, constant: 22),
            bondButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            bondButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -42),
            bondButton.heightAnchor.constraint(equalToConstant: 46),

            momentTitle.topAnchor.constraint(equalTo: bondButton.bottomAnchor, constant: 28),
            momentTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),

            momentCard.topAnchor.constraint(equalTo: momentTitle.bottomAnchor, constant: 16),
            momentCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            momentCard.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.42),
            momentCard.heightAnchor.constraint(equalTo: momentCard.widthAnchor, multiplier: 1.36),
            momentCard.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }

    private func makeStat(value: String, title: String) -> UIView {
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.textColor = .black
        valueLabel.font = UIFont.systemFont(ofSize: 17, weight: .black)
        valueLabel.textAlignment = .center

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = UIColor.black.withAlphaComponent(0.55)
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        titleLabel.textAlignment = .center

        let stack = UIStackView(arrangedSubviews: [valueLabel, titleLabel])
        stack.axis = .vertical
        stack.spacing = 2
        return stack
    }

    private func refreshBondTitle() {
        bondButton.setTitle(bonded ? "Following" : "Follow", for: .normal)
        bondButton.backgroundColor = bonded ? UIColor.black.withAlphaComponent(0.78) : UIColor(red: 0.08, green: 0.84, blue: 0.76, alpha: 1)
    }

    @objc private func close() {
        dismiss(animated: true)
    }

    @objc private func openMore() {
        tinkiePresentSafetyOptions(
            targetTitle: clip.performer,
            targetKey: "performer:\(clip.performer):\(clip.avatarName)",
            targetKind: "profile"
        )
    }

    @objc private func bondTapped() {
        bonded.toggle()
        refreshBondTitle()
        onBondChange?()
    }
}
