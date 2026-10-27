import UIKit

enum TinkieSingerCircleRoster {
    case forgetSingerTotal
    case listenerEchoTotal
    case Tiredked

    var title: String {
        switch self {
        case .forgetSingerTotal: return "Following"
        case .listenerEchoTotal: return "Followers"
        case .Tiredked: return "Blacklist"
        }
    }

    var actionTitle: String {
        switch self {
        case .forgetSingerTotal: return "Unfollow"
        case .listenerEchoTotal: return "Remove"
        case .Tiredked: return "Remove"
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
        case .forgetSingerTotal:
            singerNames = TinkieSingerTuneAtlas.followedSingerTuneNames
        case .listenerEchoTotal:
            singerNames = TinkieSingerTuneAtlas.listenerEchoSingerNames
        case .Tiredked:
            let saved = TinkieSongShieldLedger.shieldedSingerNames()
            singerNames = saved.isEmpty ? [TinkieVerseCipherTrail.singBack("ADrPiCan"), TinkieVerseCipherTrail.singBack("JCaWyd")] : saved
        }
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iPnPiJtF(qcloGdGeMrQ:p)q rhLaKsf cnUoKtL dbKeBeony HiCmspvlReImreUnMtjeddx"))
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

        let rosterBackBeatButton = UIButton(type: .system)
        rosterBackBeatButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        rosterBackBeatButton.tintColor = .black
        rosterBackBeatButton.contentHorizontalAlignment = .leading
        rosterBackBeatButton.addTarget(self, action: #selector(closeSingerRosterTapped), for: .touchUpInside)
        rosterBackBeatButton.translatesAutoresizingMaskIntoConstraints = false
        rosterContentStage.addSubview(rosterBackBeatButton)

        let rosterTitleTuneLabel = UILabel()
        rosterTitleTuneLabel.text = rosterCircle.title
        rosterTitleTuneLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        rosterTitleTuneLabel.textColor = .black
        rosterTitleTuneLabel.textAlignment = .center
        rosterTitleTuneLabel.translatesAutoresizingMaskIntoConstraints = false
        rosterContentStage.addSubview(rosterTitleTuneLabel)

        singerRowStack.axis = .vertical
        singerRowStack.spacing = 12
        singerRowStack.translatesAutoresizingMaskIntoConstraints = false
        rosterContentStage.addSubview(singerRowStack)

        pinSingerCircleRosterStageBeat1(glow: glow, rosterBackBeatButton: rosterBackBeatButton)
        pinSingerCircleRosterStageBeat2(rosterBackBeatButton: rosterBackBeatButton, rosterTitleTuneLabel: rosterTitleTuneLabel)
    }

    private func pinSingerCircleRosterStageBeat1(glow: TinkieTopGlowView, rosterBackBeatButton: UIButton) {
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
            
            rosterBackBeatButton.topAnchor.constraint(equalTo: rosterContentStage.safeAreaLayoutGuide.topAnchor, constant: 18),
            rosterBackBeatButton.leadingAnchor.constraint(equalTo: rosterContentStage.leadingAnchor, constant: 22),
            rosterBackBeatButton.widthAnchor.constraint(equalToConstant: 48),
            rosterBackBeatButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func pinSingerCircleRosterStageBeat2(rosterBackBeatButton: UIButton, rosterTitleTuneLabel: UILabel) {
        NSLayoutConstraint.activate([
            
            rosterTitleTuneLabel.centerYAnchor.constraint(equalTo: rosterBackBeatButton.centerYAnchor),
            rosterTitleTuneLabel.centerXAnchor.constraint(equalTo: rosterContentStage.centerXAnchor),
            
            singerRowStack.topAnchor.constraint(equalTo: rosterTitleTuneLabel.bottomAnchor, constant: 32),
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
                singerMelodyCard: TinkieSingerTuneAtlas.singerMelodyCard(named: singerName),
                actionTitle: rosterCircle.actionTitle
            )
            singerRow.onRosterBeat = { [weak self] in
                self?.removeSingerCircleName(singerName)
            }
            singerRowStack.addArrangedSubview(singerRow)
        }
    }

    private func removeSingerCircleName(_ name: String) {
        if rosterCircle == .forgetSingerTotal {
            TinkieRhythmBondScorebook.removeBondedSinger(name)
            singerNames = TinkieSingerTuneAtlas.followedSingerTuneNames
        } else if rosterCircle == .Tiredked {
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

    init(singerMelodyCard: TinkieSingerMelodyCard, actionTitle: String) {
        super.init(frame: .zero)
        putSingerCircleRosterStageTogether(singerMelodyCard: singerMelodyCard, actionTitle: actionTitle)
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("isnriptb(JcNotdtezrj:C)J LhvaqsU Snvomtv WbqegeEnC pidmMpHlbewmZevnjtYeWdD"))
    }

    private func putSingerCircleRosterStageTogether(singerMelodyCard: TinkieSingerMelodyCard, actionTitle: String) {
        let singerFaceView = UIImageView(image: UIImage(named: singerMelodyCard.portraitAssetName))
        singerFaceView.contentMode = .scaleAspectFill
        singerFaceView.layer.cornerRadius = 22
        singerFaceView.layer.masksToBounds = true
        singerFaceView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(singerFaceView)

        let singerNameLabel = UILabel()
        singerNameLabel.text = singerMelodyCard.singerAlias
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
