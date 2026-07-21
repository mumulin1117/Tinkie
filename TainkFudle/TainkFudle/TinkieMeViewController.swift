import UIKit

final class TinkieMeViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let headerView = UIView()
    private let heroImageView = UIImageView()
    private let titleLabel = UILabel()
    private let noticeButton = TinkieAssetRoundButton(assetName: "tinkie_profile_notice_bell", diameter: 54)
    private let settingsButton = TinkieAssetRoundButton(assetName: "tinkie_profile_settings_gear", diameter: 54)
    private let nameButton = UIButton(type: .system)
    private let editImageView = UIImageView(image: UIImage(named: "tinkie_profile_edit_mark"))
    private let uidLabel = UILabel()
    private let balanceCard = TinkieProfileMetricCard(style: .balance)
    private let followersCard = TinkieProfileMetricCard(style: .dark)
    private let followingCard = TinkieProfileMetricCard(style: .dark)
    private let pulseImageView = UIImageView(image: UIImage(named: "tinkie_profile_pulse_badge"))
    private let momentsTitleLabel = UILabel()
    private let emptyButton = UIButton(type: .system)
    private let emptyImageView = UIImageView(image: UIImage(named: "tinkie_profile_empty_record"))
    private let collectionView: UICollectionView
    private var headerHeightConstraint: NSLayoutConstraint?
    private var collectionHeightConstraint: NSLayoutConstraint?
    private var snapshot = TinkieProfileStore.currentSnapshot()

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 14
        layout.minimumLineSpacing = 14
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        reloadProfile()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadProfile()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tinkieMelodyStageHeight: CGFloat
        if snapshot.isSignedIn {
            tinkieMelodyStageHeight = max(360, min(430, view.bounds.height * 0.48))
        } else {
            tinkieMelodyStageHeight = max(304, min(350, view.bounds.width * 0.88))
        }
        headerHeightConstraint?.constant = tinkieMelodyStageHeight
        let tabRoom = tabBarController?.tabBar.frame.height ?? 0
        scrollView.contentInset.bottom = tabRoom + view.safeAreaInsets.bottom + 18
        scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: scrollView.contentInset.bottom, right: 0)

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let spacing: CGFloat = view.bounds.width <= 340 ? 10 : 14
            let sideInset: CGFloat = view.bounds.width <= 340 ? 20 : 24
            let width = max(120, floor((view.bounds.width - sideInset * 2 - spacing) / 2))
            layout.minimumInteritemSpacing = spacing
            layout.minimumLineSpacing = spacing
            layout.sectionInset = UIEdgeInsets(top: 0, left: sideInset, bottom: 18, right: sideInset)
            layout.itemSize = CGSize(width: width, height: width * 1.14)
            let rows = ceil(CGFloat(max(snapshot.moments.count, 1)) / 2)
            collectionHeightConstraint?.constant = snapshot.moments.isEmpty ? 230 : rows * (width * 1.14) + max(0, rows - 1) * spacing + 18
        }
    }

    private func buildLayout() {
        view.backgroundColor = UIColor(red: 0.96, green: 0.98, blue: 0.98, alpha: 1)

        let glow = TinkieTopGlowView()
        glow.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(glow)
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = UIColor(red: 0.02, green: 0.03, blue: 0.05, alpha: 1)
        headerView.layer.cornerRadius = 34
        headerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        headerView.layer.masksToBounds = true
        contentView.addSubview(headerView)

        heroImageView.contentMode = .scaleAspectFill
        heroImageView.clipsToBounds = true
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(heroImageView)

        let headerShade = TinkieBottomShadeView()
        headerShade.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(headerShade)

        titleLabel.text = "Me"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 38, weight: .black)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)

        noticeButton.addTarget(self, action: #selector(openNotice), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        noticeButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(noticeButton)
        headerView.addSubview(settingsButton)

        nameButton.setTitleColor(.white, for: .normal)
        nameButton.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        nameButton.titleLabel?.lineBreakMode = .byTruncatingTail
        nameButton.addTarget(self, action: #selector(nameTapped), for: .touchUpInside)
        nameButton.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(nameButton)

        editImageView.contentMode = .scaleAspectFit
        editImageView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(editImageView)

        uidLabel.textColor = UIColor.white.withAlphaComponent(0.72)
        uidLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        uidLabel.textAlignment = .center
        uidLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(uidLabel)

        let statsStack = UIStackView(arrangedSubviews: [balanceCard, followersCard, followingCard])
        statsStack.axis = .horizontal
        statsStack.alignment = .fill
        statsStack.distribution = .fill
        statsStack.spacing = 10
        statsStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(statsStack)
        balanceCard.widthAnchor.constraint(equalTo: statsStack.widthAnchor, multiplier: 0.52).isActive = true
        followersCard.widthAnchor.constraint(equalTo: followingCard.widthAnchor).isActive = true

        [balanceCard, followersCard, followingCard].forEach { card in
            card.addTarget(self, action: #selector(metricTapped), for: .touchUpInside)
        }

        pulseImageView.contentMode = .scaleAspectFit
        pulseImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pulseImageView)

        momentsTitleLabel.text = "Moments"
        momentsTitleLabel.textColor = .black
        momentsTitleLabel.font = UIFont.systemFont(ofSize: 28, weight: .black)
        momentsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(momentsTitleLabel)

        emptyButton.addTarget(self, action: #selector(emptyTapped), for: .touchUpInside)
        emptyButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(emptyButton)

        emptyImageView.contentMode = .scaleAspectFit
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        emptyButton.addSubview(emptyImageView)

        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TinkieMomentCell.self, forCellWithReuseIdentifier: TinkieMomentCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collectionView)

        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 344)
        collectionHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 230)

        NSLayoutConstraint.activate([
            glow.topAnchor.constraint(equalTo: view.topAnchor),
            glow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            glow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            glow.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.64),

            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerHeightConstraint!,

            heroImageView.topAnchor.constraint(equalTo: headerView.topAnchor),
            heroImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            heroImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            heroImageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),

            headerShade.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headerShade.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            headerShade.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            headerShade.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.55),

            titleLabel.topAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.topAnchor, constant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 28),

            settingsButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -24),
            settingsButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            noticeButton.trailingAnchor.constraint(equalTo: settingsButton.leadingAnchor, constant: -12),
            noticeButton.centerYAnchor.constraint(equalTo: settingsButton.centerYAnchor),

            nameButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            nameButton.bottomAnchor.constraint(equalTo: uidLabel.topAnchor, constant: -4),
            nameButton.leadingAnchor.constraint(greaterThanOrEqualTo: headerView.leadingAnchor, constant: 44),
            nameButton.trailingAnchor.constraint(lessThanOrEqualTo: headerView.trailingAnchor, constant: -44),

            editImageView.leadingAnchor.constraint(equalTo: nameButton.trailingAnchor, constant: 7),
            editImageView.centerYAnchor.constraint(equalTo: nameButton.centerYAnchor, constant: 2),
            editImageView.widthAnchor.constraint(equalToConstant: 20),
            editImageView.heightAnchor.constraint(equalToConstant: 20),

            uidLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            uidLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -24),

            statsStack.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 22),
            statsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            statsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            statsStack.heightAnchor.constraint(equalToConstant: 82),

            pulseImageView.topAnchor.constraint(equalTo: statsStack.bottomAnchor, constant: 26),
            pulseImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            pulseImageView.widthAnchor.constraint(equalToConstant: 138),
            pulseImageView.heightAnchor.constraint(equalToConstant: 34),

            momentsTitleLabel.topAnchor.constraint(equalTo: pulseImageView.bottomAnchor, constant: 12),
            momentsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            momentsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            emptyButton.topAnchor.constraint(equalTo: momentsTitleLabel.bottomAnchor, constant: 16),
            emptyButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            emptyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            emptyButton.heightAnchor.constraint(equalToConstant: 218),

            emptyImageView.centerXAnchor.constraint(equalTo: emptyButton.centerXAnchor),
            emptyImageView.centerYAnchor.constraint(equalTo: emptyButton.centerYAnchor),
            emptyImageView.widthAnchor.constraint(lessThanOrEqualTo: emptyButton.widthAnchor, multiplier: 0.72),
            emptyImageView.heightAnchor.constraint(equalToConstant: 150),

            collectionView.topAnchor.constraint(equalTo: momentsTitleLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionHeightConstraint!,
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -28)
        ])
    }

    private func reloadProfile() {
        snapshot = TinkieProfileStore.currentSnapshot()
        if let path = snapshot.heroImagePath, let image = UIImage(contentsOfFile: path) {
            heroImageView.image = image
        } else {
            heroImageView.image = UIImage(named: snapshot.heroImageName)
        }
        heroImageView.contentMode = snapshot.isSignedIn ? .scaleAspectFill : .scaleAspectFit
        nameButton.setTitle(snapshot.nickname, for: .normal)
        uidLabel.text = "Uid:\(snapshot.uid)"
        editImageView.isHidden = !snapshot.isSignedIn
        balanceCard.configure(value: "\(snapshot.balance)", title: "My Balance")
        followersCard.configure(value: "\(snapshot.followers)", title: "Followers")
        followingCard.configure(value: "\(snapshot.following)", title: "Following")
        emptyButton.isHidden = !snapshot.moments.isEmpty
        collectionView.isHidden = snapshot.moments.isEmpty
        collectionView.reloadData()
        view.setNeedsLayout()
    }

    @objc private func nameTapped() {
        snapshot.isSignedIn ? openProfileEditor() : openWelcome()
    }

    @objc private func metricTapped(_ sender: UIButton) {
        guard snapshot.isSignedIn else {
            openWelcome()
            return
        }
        if sender === balanceCard {
            openWallet()
            return
        }
        presentRoute(title: "Profile Stats", detail: "Your Tinkie rhythm stats stay on this device and update from local activity.")
    }

    @objc private func emptyTapped() {
        openWelcome()
    }

    @objc private func openNotice() {
        guard snapshot.isSignedIn else {
            openWelcome()
            return
        }
        presentRoute(title: "Notifications", detail: "Song challenge reminders, answer streak updates, and room activity will appear here.")
    }

    @objc private func openSettings() {
        guard snapshot.isSignedIn else {
            openWelcome()
            return
        }
        let route = TinkieProfileRouteViewController(
            titleText: "Settings",
            detailText: "Manage local profile preferences for your Tinkie song sessions.",
            showsSignOut: true
        )
        route.onSignOut = { [weak self] in
            TinkieProfileStore.signOutOnly()
            self?.dismiss(animated: true) {
                self?.reloadProfile()
            }
        }
        presentWrapped(route)
    }

    private func openProfileEditor() {
        presentRoute(title: "Edit Profile", detail: "Nickname, avatar, and singer-style profile details can be adjusted from this local profile area.")
    }

    private func openWallet() {
        let wallet = TinkieWalletViewController()
        wallet.onBalanceChanged = { [weak self] in
            self?.reloadProfile()
        }
        presentWrapped(wallet)
    }

    private func openWelcome() {
        let welcome = TinkieAuthWelcomeViewController()
        welcome.onComplete = { [weak self] in
            self?.dismiss(animated: true) {
                self?.reloadProfile()
            }
        }
        presentWrapped(welcome)
    }

    private func presentRoute(title: String, detail: String) {
        presentWrapped(TinkieProfileRouteViewController(titleText: title, detailText: detail, showsSignOut: false))
    }

    private func presentWrapped(_ controller: UIViewController) {
        let navigation = UINavigationController(rootViewController: controller)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }
}

extension TinkieMeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        snapshot.moments.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TinkieMomentCell.reuseIdentifier, for: indexPath) as! TinkieMomentCell
        cell.configure(with: snapshot.moments[indexPath.item])
        return cell
    }
}

final class TinkieProfileRouteViewController: UIViewController {
    var onSignOut: (() -> Void)?
    private let titleText: String
    private let detailText: String
    private let showsSignOut: Bool

    init(titleText: String, detailText: String, showsSignOut: Bool) {
        self.titleText = titleText
        self.detailText = detailText
        self.showsSignOut = showsSignOut
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.96, green: 0.98, blue: 0.98, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(close))

        let title = UILabel()
        title.text = titleText
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 28, weight: .black)
        title.numberOfLines = 0

        let detail = UILabel()
        detail.text = detailText
        detail.textColor = UIColor.black.withAlphaComponent(0.64)
        detail.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        detail.numberOfLines = 0

        let stack = UIStackView(arrangedSubviews: [title, detail])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])

        if showsSignOut {
            let button = TinkieGradientActionButton(title: "Sign Out")
            button.addTarget(self, action: #selector(signOutTapped), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(button)
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
                button.heightAnchor.constraint(equalToConstant: 52)
            ])
        }
    }

    @objc private func close() {
        dismiss(animated: true)
    }

    @objc private func signOutTapped() {
        onSignOut?()
    }
}

final class TinkieMomentCell: UICollectionViewCell {
    static let reuseIdentifier = "TinkieMomentCell"
    private let coverImageView = UIImageView()
    private let playImageView = UIImageView(image: UIImage(named: "tinkie_moment_play_mark"))
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 14
        contentView.layer.masksToBounds = true

        coverImageView.contentMode = .scaleAspectFill
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(coverImageView)

        let shade = TinkieBottomShadeView()
        shade.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(shade)

        playImageView.contentMode = .scaleAspectFit
        playImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(playImageView)

        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            shade.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shade.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shade.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            shade.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.48),

            playImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            playImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playImageView.widthAnchor.constraint(equalToConstant: 56),
            playImageView.heightAnchor.constraint(equalToConstant: 56),

            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with moment: TinkieProfileMoment) {
        coverImageView.image = UIImage(named: moment.coverName)
        titleLabel.text = moment.title
    }
}

final class TinkieAssetRoundButton: UIButton {
    init(assetName: String, diameter: CGFloat) {
        super.init(frame: .zero)
        setImage(UIImage(named: assetName), for: .normal)
        imageView?.contentMode = .scaleAspectFit
        backgroundColor = UIColor.black.withAlphaComponent(0.05)
        layer.cornerRadius = diameter / 2
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: diameter),
            heightAnchor.constraint(equalToConstant: diameter)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TinkieGradientActionButton: UIButton {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .black)
        layer.cornerRadius = 26
        layer.masksToBounds = true
        let gradient = layer as! CAGradientLayer
        gradient.colors = [
            UIColor(red: 0.92, green: 0.07, blue: 0.66, alpha: 1).cgColor,
            UIColor(red: 0.15, green: 0.86, blue: 0.82, alpha: 1).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TinkieProfileMetricCard: UIButton {
    enum Style {
        case balance
        case dark
    }

    private let style: Style
    private let valueLabel = UILabel()
    private let captionLabel = UILabel()
    private let gemImageView = UIImageView(image: UIImage(named: "tinkie_profile_balance_gem"))

    override class var layerClass: AnyClass { CAGradientLayer.self }

    init(style: Style) {
        self.style = style
        super.init(frame: .zero)
        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(value: String, title: String) {
        valueLabel.text = value
        captionLabel.text = title
    }

    private func buildLayout() {
        layer.cornerRadius = 14
        layer.masksToBounds = true

        let gradient = layer as! CAGradientLayer
        if style == .balance {
            gradient.colors = [
                UIColor(red: 1.0, green: 0.55, blue: 0.08, alpha: 1).cgColor,
                UIColor(red: 0.96, green: 0.08, blue: 0.62, alpha: 1).cgColor,
                UIColor(red: 0.18, green: 0.84, blue: 0.82, alpha: 1).cgColor,
                UIColor(red: 0.47, green: 0.13, blue: 1, alpha: 1).cgColor
            ]
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 1)
        } else {
            gradient.colors = [
                UIColor(red: 0.01, green: 0.04, blue: 0.03, alpha: 1).cgColor,
                UIColor(red: 0.01, green: 0.04, blue: 0.03, alpha: 1).cgColor
            ]
        }

        gemImageView.contentMode = .scaleAspectFit
        gemImageView.isHidden = style != .balance
        gemImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gemImageView)

        valueLabel.textColor = .white
        valueLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        valueLabel.textAlignment = style == .balance ? .left : .center

        captionLabel.textColor = UIColor.white.withAlphaComponent(0.65)
        captionLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        captionLabel.textAlignment = style == .balance ? .left : .center
        captionLabel.adjustsFontSizeToFitWidth = true
        captionLabel.minimumScaleFactor = 0.78

        let labels = UIStackView(arrangedSubviews: [valueLabel, captionLabel])
        labels.axis = .vertical
        labels.alignment = style == .balance ? .leading : .center
        labels.spacing = 6
        labels.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labels)

        if style == .balance {
            NSLayoutConstraint.activate([
                gemImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
                gemImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                gemImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.32),
                gemImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.62),

                labels.leadingAnchor.constraint(equalTo: gemImageView.trailingAnchor, constant: 10),
                labels.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                labels.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                labels.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
                labels.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
                labels.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
    }
}
