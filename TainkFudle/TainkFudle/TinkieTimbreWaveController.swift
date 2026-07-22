import UIKit

enum TinkietChorusHintnd {
    case following
    case followers
    case blocked

    var title: String {
        switch self {
        case .following: return "Following"
        case .followers: return "Followers"
        case .blocked: return "Blacklist"
        }
    }

    var actionTitle: String {
        switch self {
        case .following: return "Unfollow"
        case .followers: return "Remove"
        case .blocked: return "Remove"
        }
    }
}

final class TinkieTimbreWaveController: UIViewController {
    private let kind: TinkietChorusHintnd
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()
    private var names: [String]

    init(kind: TinkietChorusHintnd) {
        self.kind = kind
        switch kind {
        case .following:
            names = TinkiePersonaDirectory.followingNames
        case .followers:
            names = TinkiePersonaDirectory.followerNames
        case .blocked:
            let saved = TinkieBassTrailre.blockedNames()
            names = saved.isEmpty ? ["Aria", "Jay"] : saved
        }
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
        reloadRows()
    }

    private func buildLayout() {
        view.backgroundColor = UIColor(red: 0.96, green: 0.98, blue: 0.98, alpha: 1)

        let glow = TinkieTopGlowView()
        glow.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(glow)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.contentHorizontalAlignment = .leading
        backButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backButton)

        let titleLabel = UILabel()
        titleLabel.text = kind.title
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            glow.topAnchor.constraint(equalTo: view.topAnchor),
            glow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            glow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            glow.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.58),

            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.frameLayoutGuide.heightAnchor),

            backButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 18),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            backButton.widthAnchor.constraint(equalToConstant: 48),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -32)
        ])
    }

    private func reloadRows() {
        stackView.arrangedSubviews.forEach { view in
            stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }

        names.forEach { name in
            let row = TinkieimbreScoreRosterRow(
                persona: TinkiePersonaDirectory.persona(named: name),
                actionTitle: kind.actionTitle
            )
            row.onAction = { [weak self] in
                self?.removeName(name)
            }
            stackView.addArrangedSubview(row)
        }
    }

    private func removeName(_ name: String) {
        if kind == .blocked {
            TinkieBassTrailre.unblockName(name)
        }
        names.removeAll { $0 == name }
        reloadRows()
    }

    @objc private func closeTapped() {
        dismiss(animated: true)
    }
}

private final class TinkieimbreScoreRosterRow: UIView {
    var onAction: (() -> Void)?

    init(persona: TrinkieMelodyGuess, actionTitle: String) {
        super.init(frame: .zero)
        buildLayout(persona: persona, actionTitle: actionTitle)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildLayout(persona: TrinkieMelodyGuess, actionTitle: String) {
        let avatarView = UIImageView(image: UIImage(named: persona.heroImageName))
        avatarView.contentMode = .scaleAspectFill
        avatarView.layer.cornerRadius = 22
        avatarView.layer.masksToBounds = true
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(avatarView)

        let nameLabel = UILabel()
        nameLabel.text = persona.nickname
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)

        let actionButton = UIButton(type: .system)
        actionButton.setTitle(actionTitle, for: .normal)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        actionButton.backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.04, alpha: 1)
        actionButton.layer.cornerRadius = 17
        actionButton.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(actionButton)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 48),

            avatarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            avatarView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: 44),
            avatarView.heightAnchor.constraint(equalToConstant: 44),

            nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 12),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: actionButton.leadingAnchor, constant: -12),

            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            actionButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 84),
            actionButton.heightAnchor.constraint(equalToConstant: 34)
        ])
    }

    @objc private func actionTapped() {
        onAction?()
    }
}
