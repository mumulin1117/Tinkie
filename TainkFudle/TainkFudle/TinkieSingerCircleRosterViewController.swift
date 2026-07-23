import UIKit

enum TinkieSingerCircleRoster {
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

final class TinkieSingerCircleRosterViewController: UIViewController {
    private let rosterCircle: TinkieSingerCircleRoster
    private let rosterScrollStage = UIScrollView()
    private let rosterContentStage = UIView()
    private let singerRowStack = UIStackView()
    private var singerNames: [String]

    init(rosterCircle: TinkieSingerCircleRoster) {
        self.rosterCircle = rosterCircle
        switch rosterCircle {
        case .following:
            singerNames = TinkieSingerTuneAtlas.followingTuneNames
        case .followers:
            singerNames = TinkieSingerTuneAtlas.followerTuneNames
        case .blocked:
            let saved = TinkieSongShieldLedger.shieldedSingerNames()
            singerNames = saved.isEmpty ? ["Aria", "Jay"] : saved
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
        putSingerCircleRosterStageTogether()
        reloadSingerRosterRows()
    }

    private func putSingerCircleRosterStageTogether() {
        view.backgroundColor = UIColor(red: 0.96, green: 0.98, blue: 0.98, alpha: 1)

        let glow = TinkieTopGlowView()
        glow.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(glow)

        rosterScrollStage.translatesAutoresizingMaskIntoConstraints = false
        rosterScrollStage.alwaysBounceVertical = true
        rosterScrollStage.showsVerticalScrollIndicator = false
        view.addSubview(rosterScrollStage)

        rosterContentStage.translatesAutoresizingMaskIntoConstraints = false
        rosterScrollStage.addSubview(rosterContentStage)

        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.contentHorizontalAlignment = .leading
        backButton.addTarget(self, action: #selector(closeSingerRosterTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        rosterContentStage.addSubview(backButton)

        let titleLabel = UILabel()
        titleLabel.text = rosterCircle.title
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        rosterContentStage.addSubview(titleLabel)

        singerRowStack.axis = .vertical
        singerRowStack.spacing = 12
        singerRowStack.translatesAutoresizingMaskIntoConstraints = false
        rosterContentStage.addSubview(singerRowStack)

        NSLayoutConstraint.activate([
            glow.topAnchor.constraint(equalTo: view.topAnchor),
            glow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            glow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            glow.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.58),

            rosterScrollStage.topAnchor.constraint(equalTo: view.topAnchor),
            rosterScrollStage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rosterScrollStage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rosterScrollStage.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            rosterContentStage.topAnchor.constraint(equalTo: rosterScrollStage.contentLayoutGuide.topAnchor),
            rosterContentStage.leadingAnchor.constraint(equalTo: rosterScrollStage.contentLayoutGuide.leadingAnchor),
            rosterContentStage.trailingAnchor.constraint(equalTo: rosterScrollStage.contentLayoutGuide.trailingAnchor),
            rosterContentStage.bottomAnchor.constraint(equalTo: rosterScrollStage.contentLayoutGuide.bottomAnchor),
            rosterContentStage.widthAnchor.constraint(equalTo: rosterScrollStage.frameLayoutGuide.widthAnchor),
            rosterContentStage.heightAnchor.constraint(greaterThanOrEqualTo: rosterScrollStage.frameLayoutGuide.heightAnchor),

            backButton.topAnchor.constraint(equalTo: rosterContentStage.safeAreaLayoutGuide.topAnchor, constant: 18),
            backButton.leadingAnchor.constraint(equalTo: rosterContentStage.leadingAnchor, constant: 22),
            backButton.widthAnchor.constraint(equalToConstant: 48),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: rosterContentStage.centerXAnchor),

            singerRowStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            singerRowStack.leadingAnchor.constraint(equalTo: rosterContentStage.leadingAnchor, constant: 24),
            singerRowStack.trailingAnchor.constraint(equalTo: rosterContentStage.trailingAnchor, constant: -24),
            singerRowStack.bottomAnchor.constraint(lessThanOrEqualTo: rosterContentStage.safeAreaLayoutGuide.bottomAnchor, constant: -32)
        ])
    }

    private func reloadSingerRosterRows() {
        singerRowStack.arrangedSubviews.forEach { staleSingerRow in
            singerRowStack.removeArrangedSubview(staleSingerRow)
            staleSingerRow.removeFromSuperview()
        }

        singerNames.forEach { singerName in
            let singerRow = TinkieSingerCircleRosterRow(
                singerTuneCard: TinkieSingerTuneAtlas.singerTuneCard(named: singerName),
                actionTitle: rosterCircle.actionTitle
            )
            singerRow.onRosterBeat = { [weak self] in
                self?.removeSingerCircleName(singerName)
            }
            singerRowStack.addArrangedSubview(singerRow)
        }
    }

    private func removeSingerCircleName(_ name: String) {
        if rosterCircle == .following {
            TinkieRhythmBondScorebook.removeBondedSinger(name)
            singerNames = TinkieSingerTuneAtlas.followingTuneNames
        } else if rosterCircle == .blocked {
            TinkieSongShieldLedger.bringSingerBack(name)
            singerNames.removeAll { $0 == name }
        } else {
            singerNames.removeAll { $0 == name }
        }
        reloadSingerRosterRows()
    }

    @objc private func closeSingerRosterTapped() {
        dismiss(animated: true)
    }
}

private final class TinkieSingerCircleRosterRow: UIView {
    var onRosterBeat: (() -> Void)?

    init(singerTuneCard: TinkieSingerTuneCard, actionTitle: String) {
        super.init(frame: .zero)
        putSingerCircleRosterStageTogether(singerTuneCard: singerTuneCard, actionTitle: actionTitle)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func putSingerCircleRosterStageTogether(singerTuneCard: TinkieSingerTuneCard, actionTitle: String) {
        let singerFaceView = UIImageView(image: UIImage(named: singerTuneCard.heroImageName))
        singerFaceView.contentMode = .scaleAspectFill
        singerFaceView.layer.cornerRadius = 22
        singerFaceView.layer.masksToBounds = true
        singerFaceView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(singerFaceView)

        let singerNameLabel = UILabel()
        singerNameLabel.text = singerTuneCard.nickname
        singerNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        singerNameLabel.textColor = .black
        singerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(singerNameLabel)

        let rosterBeatButton = UIButton(type: .system)
        rosterBeatButton.setTitle(actionTitle, for: .normal)
        rosterBeatButton.setTitleColor(.white, for: .normal)
        rosterBeatButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        rosterBeatButton.backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.04, alpha: 1)
        rosterBeatButton.layer.cornerRadius = 17
        rosterBeatButton.addTarget(self, action: #selector(rosterSingerBeatTapped), for: .touchUpInside)
        rosterBeatButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rosterBeatButton)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 48),

            singerFaceView.leadingAnchor.constraint(equalTo: leadingAnchor),
            singerFaceView.centerYAnchor.constraint(equalTo: centerYAnchor),
            singerFaceView.widthAnchor.constraint(equalToConstant: 44),
            singerFaceView.heightAnchor.constraint(equalToConstant: 44),

            singerNameLabel.leadingAnchor.constraint(equalTo: singerFaceView.trailingAnchor, constant: 12),
            singerNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            singerNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: rosterBeatButton.leadingAnchor, constant: -12),

            rosterBeatButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            rosterBeatButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            rosterBeatButton.widthAnchor.constraint(equalToConstant: 84),
            rosterBeatButton.heightAnchor.constraint(equalToConstant: 34)
        ])
    }

    @objc private func rosterSingerBeatTapped() {
        onRosterBeat?()
    }
}
