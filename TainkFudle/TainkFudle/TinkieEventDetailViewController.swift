import UIKit

final class TinkieEventDetailViewController: UIViewController {
    private let event: TinkieSongEvent
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let heroView = UIView()
    
    private let coverFrameImageView = UIImageView(image: UIImage(named: "tinkie_event_cover_frame"))
//    private let imageView = UIImageView()
    private let turntableImageView = UIImageView(image: UIImage(named: "tinkie_event_vinyl_turntable"))
    
    
    private let coverImageView = UIImageView()
    private let statusLabel = TinkiePillLabel(text: "", foreground: .black, background: UIColor(red: 0.17, green: 0.92, blue: 0.78, alpha: 1))
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let panelView = UIView()
    private let groupStack = UIStackView()
    private var state: TinkieEventDetailState

    init(event: TinkieSongEvent) {
        self.event = event
        self.state = TinkieEventDetailStore.state(for: event)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        reloadState()
    }

    private func buildLayout() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.98, blue: 0.98, alpha: 1)
        navigationController?.setNavigationBarHidden(true, animated: false)
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        heroView.translatesAutoresizingMaskIntoConstraints = false
        heroView.backgroundColor = UIColor(red: 0.01, green: 0.03, blue: 0.03, alpha: 1)
        heroView.layer.masksToBounds = true
        contentView.addSubview(heroView)

        let glow = TinkieEventAuraView()
        glow.translatesAutoresizingMaskIntoConstraints = false
        heroView.addSubview(glow)

        let backButton = TinkieEventIconButton(symbolName: "chevron.left")
        backButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        heroView.addSubview(backButton)

        let headingLabel = UILabel()
        headingLabel.text = "Event Details"
        headingLabel.textColor = .white
        headingLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        heroView.addSubview(headingLabel)

        let moreButton = TinkieEventIconButton(symbolName: "ellipsis")
        moreButton.addTarget(self, action: #selector(openMore), for: .touchUpInside)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        heroView.addSubview(moreButton)

        let ringView = TinkieEventRingView()
        ringView.translatesAutoresizingMaskIntoConstraints = false
        heroView.addSubview(ringView)

        
        coverFrameImageView.contentMode = .scaleAspectFit
        coverFrameImageView.translatesAutoresizingMaskIntoConstraints = false
        heroView.addSubview(coverFrameImageView)

        
        if let coverPath = event.coverPath, let localArt = UIImage(contentsOfFile: coverPath) {
            coverImageView.image = localArt
        } else {
            coverImageView.image = UIImage(named: event.coverName)
        }
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.layer.cornerRadius = 146/2
        coverImageView.layer.masksToBounds = true
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        heroView.addSubview(coverImageView)

        turntableImageView.contentMode = .scaleAspectFit
        turntableImageView.translatesAutoresizingMaskIntoConstraints = false
        heroView.addSubview(turntableImageView)

        
      
//        coverImageView.contentMode = .scaleAspectFill
//        coverImageView.layer.cornerRadius = 58
//        coverImageView.layer.masksToBounds = true
//        coverImageView.translatesAutoresizingMaskIntoConstraints = false
//        heroView.addSubview(coverImageView)

        titleLabel.text = event.title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        heroView.addSubview(titleLabel)

        subtitleLabel.text = event.subtitle
        subtitleLabel.textColor = UIColor.white.withAlphaComponent(0.78)
        subtitleLabel.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 3
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        heroView.addSubview(subtitleLabel)

        panelView.backgroundColor = .white
        panelView.layer.cornerRadius = 18
        panelView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        panelView.layer.masksToBounds = true
        panelView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(panelView)

        let dateRow = buildScheduleRow()
        dateRow.translatesAutoresizingMaskIntoConstraints = false
        panelView.addSubview(dateRow)

        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        panelView.addSubview(statusLabel)

        let separator = UIView()
        separator.backgroundColor = UIColor.black.withAlphaComponent(0.06)
        separator.translatesAutoresizingMaskIntoConstraints = false
        panelView.addSubview(separator)

        let groupTitle = UILabel()
        groupTitle.text = "Group Details"
        groupTitle.textColor = UIColor.black.withAlphaComponent(0.25)
        groupTitle.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        groupTitle.translatesAutoresizingMaskIntoConstraints = false
        panelView.addSubview(groupTitle)

        groupStack.axis = .vertical
        groupStack.spacing = 18
        groupStack.translatesAutoresizingMaskIntoConstraints = false
        panelView.addSubview(groupStack)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            heroView.topAnchor.constraint(equalTo: contentView.topAnchor),
            heroView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            heroView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            heroView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            glow.topAnchor.constraint(equalTo: heroView.topAnchor),
            glow.leadingAnchor.constraint(equalTo: heroView.leadingAnchor),
            glow.trailingAnchor.constraint(equalTo: heroView.trailingAnchor),
            glow.bottomAnchor.constraint(equalTo: heroView.bottomAnchor),

            backButton.leadingAnchor.constraint(equalTo: heroView.leadingAnchor, constant: 18),
            backButton.topAnchor.constraint(equalTo: heroView.safeAreaLayoutGuide.topAnchor, constant: 12),
            headingLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            headingLabel.centerXAnchor.constraint(equalTo: heroView.centerXAnchor),
            moreButton.trailingAnchor.constraint(equalTo: heroView.trailingAnchor, constant: -18),
            moreButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),

         

            coverFrameImageView.topAnchor.constraint(equalTo: moreButton.bottomAnchor, constant: 16),
            coverFrameImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            coverFrameImageView.widthAnchor.constraint(equalToConstant: 180),
            coverFrameImageView.heightAnchor.constraint(equalTo: coverFrameImageView.widthAnchor),
            ringView.centerYAnchor.constraint(equalTo: coverFrameImageView.centerYAnchor),
            ringView.centerXAnchor.constraint(equalTo: coverFrameImageView.centerXAnchor),
            ringView.widthAnchor.constraint(equalToConstant: 208),
            ringView.heightAnchor.constraint(equalToConstant: 208),
         
            coverImageView.centerXAnchor.constraint(equalTo: coverFrameImageView.centerXAnchor),
            coverImageView.centerYAnchor.constraint(equalTo: coverFrameImageView.centerYAnchor),
            coverImageView.widthAnchor.constraint(equalToConstant: 146),
            coverImageView.heightAnchor.constraint(equalToConstant: 146),

            turntableImageView.centerXAnchor.constraint(equalTo: coverFrameImageView.centerXAnchor),
            turntableImageView.centerYAnchor.constraint(equalTo: coverFrameImageView.centerYAnchor),
            turntableImageView.widthAnchor.constraint(equalToConstant: 94),
            turntableImageView.heightAnchor.constraint(equalToConstant: 94),
            
          

            titleLabel.topAnchor.constraint(equalTo: ringView.bottomAnchor, constant: 18),
            titleLabel.leadingAnchor.constraint(equalTo: heroView.leadingAnchor, constant: 36),
            titleLabel.trailingAnchor.constraint(equalTo: heroView.trailingAnchor, constant: -36),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: heroView.leadingAnchor, constant: 42),
            subtitleLabel.trailingAnchor.constraint(equalTo: heroView.trailingAnchor, constant: -42),
            subtitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: heroView.bottomAnchor, constant: -36),

            panelView.topAnchor.constraint(equalTo: heroView.bottomAnchor, constant: -30),
            panelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            panelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            panelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),

            dateRow.topAnchor.constraint(equalTo: panelView.topAnchor, constant: 14),
            dateRow.leadingAnchor.constraint(equalTo: panelView.leadingAnchor, constant: 14),
            dateRow.trailingAnchor.constraint(lessThanOrEqualTo: statusLabel.leadingAnchor, constant: -10),

            statusLabel.topAnchor.constraint(equalTo: panelView.topAnchor, constant: 10),
            statusLabel.trailingAnchor.constraint(equalTo: panelView.trailingAnchor, constant: -10),

            separator.topAnchor.constraint(equalTo: dateRow.bottomAnchor, constant: 14),
            separator.leadingAnchor.constraint(equalTo: panelView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: panelView.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),

            groupTitle.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 16),
            groupTitle.leadingAnchor.constraint(equalTo: panelView.leadingAnchor, constant: 14),
            groupTitle.trailingAnchor.constraint(equalTo: panelView.trailingAnchor, constant: -14),

            groupStack.topAnchor.constraint(equalTo: groupTitle.bottomAnchor, constant: 14),
            groupStack.leadingAnchor.constraint(equalTo: panelView.leadingAnchor, constant: 14),
            groupStack.trailingAnchor.constraint(equalTo: panelView.trailingAnchor, constant: -14),
            groupStack.bottomAnchor.constraint(equalTo: panelView.bottomAnchor, constant: -18)
        ])
    }

    private func buildScheduleRow() -> UIStackView {
        let date = TinkieEventScheduleItem(symbolName: "calendar", text: event.dateText)
        let time = TinkieEventScheduleItem(symbolName: "clock", text: event.timeText)
        let row = UIStackView(arrangedSubviews: [date, time])
        row.axis = .horizontal
        row.alignment = .center
        row.spacing = 22
        return row
    }

    private func reloadState() {
        state = TinkieEventDetailStore.state(for: event)
        switch state.availability {
        case .open:
            statusLabel.text = "OPEN"
            statusLabel.backgroundColor = UIColor(red: 0.17, green: 0.92, blue: 0.78, alpha: 1)
            statusLabel.textColor = .black
        case .ended:
            statusLabel.text = "Ended"
            statusLabel.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
            statusLabel.textColor = UIColor.black.withAlphaComponent(0.25)
        }

        groupStack.arrangedSubviews.forEach { view in
            groupStack.removeArrangedSubview(view)
            view.removeFromSuperview()
        }

        TinkieEventDetailStore.detailGroups(for: event).forEach { group in
            let card = TinkieEventGroupCard()
            let isJoined = TinkieEventDetailStore.isJoined(group, for: event)
            card.configure(group: group, eventEnded: state.availability == .ended, joined: isJoined)
            card.onAction = { [weak self] in
                self?.handleGroupAction(group)
            }
            groupStack.addArrangedSubview(card)
        }
    }

    private func handleGroupAction(_ group: TinkieEventGroup) {
        guard state.availability == .open else { return }
        if TinkieEventDetailStore.isJoined(group, for: event) {
            openRoundSpace(group)
            return
        }
        if TinkieEventDetailStore.hasJoinedDifferentGroup(group, for: event) {
            showAlreadyJoinedNotice()
            return
        }
        guard TinkieProfileStore.isSignedIn else {
            openWelcome(joinAfterEntry: group)
            return
        }
        guard TinkieProfileStore.spendGems(group.gemNeed) else {
            showInsufficientGems(for: group)
            return
        }
        TinkieEventDetailStore.join(group: group, for: event)
        reloadState()
    }

    private func openWelcome(joinAfterEntry group: TinkieEventGroup?) {
        let welcome = TinkieAuthWelcomeViewController()
        welcome.onComplete = { [weak self] in
            self?.dismiss(animated: true) {
                if let group {
                    self?.handleGroupAction(group)
                } else {
                    self?.reloadState()
                }
            }
        }
        let navigation = UINavigationController(rootViewController: welcome)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    private func showInsufficientGems(for group: TinkieEventGroup) {
        let balance = TinkieProfileStore.currentSnapshot().balance
        let alert = UIAlertController(
            title: "Not Enough Gems",
            message: "Joining this event needs \(group.gemNeed) Gems. Your current balance is \(balance). Do you want to recharge now?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Recharge", style: .default) { [weak self] _ in
            self?.openWallet()
        })
        present(alert, animated: true)
    }

    private func openWallet() {
        let wallet = TinkieWalletViewController()
        wallet.onBalanceChanged = { [weak self] in
            self?.reloadState()
        }
        let navigation = UINavigationController(rootViewController: wallet)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    private func showAlreadyJoinedNotice() {
        let alert = UIAlertController(
            title: "Already Joined",
            message: "You have already joined another group for this event. Open that group room from its own button.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func openRoundSpace(_ group: TinkieEventGroup) {
        let room = TinkieSongRoomViewController(event: event, group: group)
        let navigation = UINavigationController(rootViewController: room)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    @objc private func openMore() {
        tinkiePresentSafetyOptions(
            targetTitle: event.title,
            targetKey: "eventDetail:\(event.title):\(event.dateText)",
            targetKind: "activity"
        )
    }

    private func guardedOption(title: String, detail: String) {
        guard TinkieProfileStore.isSignedIn else {
            openWelcome(joinAfterEntry: nil)
            return
        }
        let route = TinkieProfileRouteViewController(titleText: title, detailText: detail, showsSignOut: false)
        let navigation = UINavigationController(rootViewController: route)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    @objc private func close() {
        dismiss(animated: true)
    }
}

final class TinkieEventGroupCard: UIView {
    var onAction: (() -> Void)?
    private let titleLabel = UILabel()
    private let tagStack = UIStackView()
    private let avatarStack = UIStackView()
    private let countLabel = UILabel()
    private let actionButton = TinkieEventActionButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(group: TinkieEventGroup, eventEnded: Bool, joined: Bool) {
        titleLabel.text = group.name
        countLabel.text = "\(group.joinedCount) joined · \(group.spotsLeft) spots left"

        tagStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        group.tags.forEach { tagStack.addArrangedSubview(TinkieEventTagLabel(text: $0)) }

        avatarStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        group.avatarNames.prefix(4).forEach { avatarStack.addArrangedSubview(TinkieAvatarView(imageName: $0, size: 24)) }

        if eventEnded {
            actionButton.configure(title: "Registration Closed", mode: .closed)
        } else if joined {
            actionButton.configure(title: "Open Event Room", mode: .active)
        } else {
            actionButton.configure(title: "Join for \(group.gemNeed) Gems", mode: .active, showsGem: true)
        }
        actionButton.isEnabled = !eventEnded
    }

    private func buildLayout() {
        backgroundColor = UIColor(red: 0.985, green: 0.985, blue: 0.985, alpha: 1)
        layer.cornerRadius = 14
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.04
        layer.shadowRadius = 12
        layer.shadowOffset = CGSize(width: 0, height: 6)

        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        tagStack.axis = .horizontal
        tagStack.spacing = 8
        tagStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tagStack)

        avatarStack.axis = .horizontal
        avatarStack.spacing = -8
        avatarStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(avatarStack)

        countLabel.textColor = UIColor.black.withAlphaComponent(0.62)
        countLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        countLabel.adjustsFontSizeToFitWidth = true
        countLabel.minimumScaleFactor = 0.78
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(countLabel)

        actionButton.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(actionButton)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(greaterThanOrEqualToConstant: 146),

            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            tagStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            tagStack.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            tagStack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),

            avatarStack.topAnchor.constraint(equalTo: tagStack.bottomAnchor, constant: 14),
            avatarStack.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            avatarStack.heightAnchor.constraint(equalToConstant: 24),

            countLabel.leadingAnchor.constraint(equalTo: avatarStack.trailingAnchor, constant: 12),
            countLabel.centerYAnchor.constraint(equalTo: avatarStack.centerYAnchor),
            countLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),

            actionButton.topAnchor.constraint(equalTo: avatarStack.bottomAnchor, constant: 14),
            actionButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            actionButton.heightAnchor.constraint(equalToConstant: 42),
            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    @objc private func actionTapped() {
        onAction?()
    }
}

final class TinkieEventOptionViewController: UIViewController {
    var onReport: (() -> Void)?
    var onKeep: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.96, green: 0.98, blue: 0.98, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(closeOnly))

        let title = UILabel()
        title.text = "Event Options"
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 28, weight: .black)

        let report = TinkieEventMenuButton(title: "Report")
        report.addTarget(self, action: #selector(reportTapped), for: .touchUpInside)

        let keep = TinkieEventMenuButton(title: "Keep")
        keep.addTarget(self, action: #selector(keepTapped), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [title, report, keep])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            report.heightAnchor.constraint(equalToConstant: 50),
            keep.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func closeOnly() {
        dismiss(animated: true)
    }

    @objc private func reportTapped() {
        dismiss(animated: true) { [onReport] in onReport?() }
    }

    @objc private func keepTapped() {
        dismiss(animated: true) { [onKeep] in onKeep?() }
    }
}

final class TinkieEventMenuButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        backgroundColor = .white
        layer.cornerRadius = 12
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TinkieEventActionButton: UIButton {
    enum Mode {
        case active
        case closed
    }

    override class var layerClass: AnyClass { CAGradientLayer.self }
    private let gemImageView = UIImageView(image: UIImage(named: "tinkie_profile_balance_gem"))
    private var titleText = ""

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 21
        layer.masksToBounds = true
        titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .black)
        setTitleColor(.white, for: .normal)
        gemImageView.contentMode = .scaleAspectFit
        gemImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gemImageView)
        NSLayoutConstraint.activate([
            gemImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            gemImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 68),
            gemImageView.widthAnchor.constraint(equalToConstant: 18),
            gemImageView.heightAnchor.constraint(equalToConstant: 18)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(title: String, mode: Mode, showsGem: Bool = false) {
        titleText = title
        setTitle(title, for: .normal)
        gemImageView.isHidden = !showsGem
        let gradient = layer as! CAGradientLayer
        switch mode {
        case .active:
            gradient.colors = [
                UIColor(red: 0.88, green: 0.06, blue: 0.62, alpha: 1).cgColor,
                UIColor(red: 0.13, green: 0.85, blue: 0.79, alpha: 1).cgColor
            ]
            alpha = 1
        case .closed:
            gradient.colors = [
                UIColor(red: 0.93, green: 0.42, blue: 0.70, alpha: 1).cgColor,
                UIColor(red: 0.42, green: 0.88, blue: 0.84, alpha: 1).cgColor
            ]
            alpha = 0.72
        }
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
    }

    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        var rect = super.titleRect(forContentRect: contentRect)
        if !gemImageView.isHidden {
            rect.origin.x -= 10
        }
        return rect
    }
}

final class TinkieEventScheduleItem: UIStackView {
    init(symbolName: String, text: String) {
        let icon = UIImageView(image: UIImage(systemName: symbolName))
        icon.tintColor = UIColor.black.withAlphaComponent(0.7)
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.widthAnchor.constraint(equalToConstant: 16),
            icon.heightAnchor.constraint(equalToConstant: 16)
        ])

        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8

        super.init(frame: .zero)
        axis = .horizontal
        alignment = .center
        spacing = 7
        addArrangedSubview(icon)
        addArrangedSubview(label)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TinkieEventTagLabel: UILabel {
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

final class TinkieEventIconButton: UIButton {
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

final class TinkieEventRingView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2 - 8
        let lineWidth: CGFloat = 16
        let colors = [
            UIColor(red: 0.10, green: 0.86, blue: 0.80, alpha: 1),
            UIColor(red: 0.96, green: 0.09, blue: 0.68, alpha: 1),
            UIColor(red: 0.18, green: 0.28, blue: 0.95, alpha: 1)
        ]
        for index in 0..<3 {
            let start = CGFloat(index) * .pi * 2 / 3 - .pi / 2
            let end = start + .pi * 1.58 / 3
            let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: start, endAngle: end, clockwise: true)
            path.lineWidth = lineWidth
            path.lineCapStyle = .round
            colors[index].setStroke()
            path.stroke()
        }
    }
}

final class TinkieEventAuraView: UIView {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let gradient = layer as! CAGradientLayer
        gradient.colors = [
            UIColor.black.cgColor,
            UIColor(red: 0.02, green: 0.22, blue: 0.14, alpha: 1).cgColor,
            UIColor.black.cgColor
        ]
        gradient.locations = [0, 0.48, 1]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
