import UIKit

final class TinkieRhythmTabButton: UIButton {
    private let rhythmMarkView = UIImageView()
    private let rhythmTitleLabel = UILabel()
    private let idleTuneAssetName: String
    private let activeTuneAssetName: String

    init(title: String, idleAssetName: String, activeAssetName: String) {
        self.idleTuneAssetName = idleAssetName
        self.activeTuneAssetName = activeAssetName
        super.init(frame: .zero)
        accessibilityLabel = title

        rhythmMarkView.image = UIImage(named: idleAssetName)
        rhythmMarkView.contentMode = .scaleAspectFit
        rhythmMarkView.translatesAutoresizingMaskIntoConstraints = false
        rhythmMarkView.isUserInteractionEnabled = false

        rhythmTitleLabel.text = title
        rhythmTitleLabel.textAlignment = .center
        rhythmTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        rhythmTitleLabel.textColor = UIColor.white.withAlphaComponent(0.45)
        rhythmTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        rhythmTitleLabel.isUserInteractionEnabled = false

        let tabRhythmStack = UIStackView(arrangedSubviews: [rhythmMarkView, rhythmTitleLabel])
        tabRhythmStack.axis = .vertical
        tabRhythmStack.alignment = .center
        tabRhythmStack.spacing = 4
        tabRhythmStack.isUserInteractionEnabled = false
        tabRhythmStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tabRhythmStack)

        NSLayoutConstraint.activate([
            tabRhythmStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            tabRhythmStack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -2),
            tabRhythmStack.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 4),
            tabRhythmStack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -4),
            rhythmMarkView.widthAnchor.constraint(equalToConstant: 31),
            rhythmMarkView.heightAnchor.constraint(equalToConstant: 31)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("irnlinta(YcBobdbeprp:D)Y IhfazsC Zndovtf XbzeieKnK xiqmJpUldejmNednttNeXdT"))
    }

    override var isSelected: Bool {
        didSet {
            rhythmMarkView.image = UIImage(named: isSelected ? activeTuneAssetName : idleTuneAssetName)
            rhythmTitleLabel.textColor = isSelected ? .white : UIColor.white.withAlphaComponent(0.45)
        }
    }
}

final class TinkieScalingFlowLayout: UICollectionViewFlowLayout {
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView, let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        let centerX = collectionView.contentOffset.x + collectionView.bounds.width / 2
        return attributes.map { attribute in
            let copied = attribute.copy() as! UICollectionViewLayoutAttributes
            let distance = abs(copied.center.x - centerX)
            let normalized = min(distance / max(1, itemSize.width), 1)
            let scale = 1 - normalized * 0.16
            copied.transform = CGAffineTransform(scaleX: scale, y: scale)
            copied.alpha = 1 - normalized * 0.18
            copied.zIndex = Int((1 - normalized) * 1000)
            return copied
        }
    }
}

final class TinkieTopGlowView: UIView {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let rimStrokeSnap = self.layer as! CAGradientLayer
        rimStrokeSnap.colors = [
            UIColor(red: 0.95, green: 0.04, blue: 0.67, alpha: 1).cgColor,
            UIColor(red: 0.12, green: 0.82, blue: 0.78, alpha: 1).cgColor,
            UIColor(red: 0.96, green: 0.97, blue: 0.98, alpha: 1).cgColor
        ]
        rimStrokeSnap.locations = [0, 0.52, 1]
        rimStrokeSnap.startPoint = CGPoint(x: 0.5, y: 0)
        rimStrokeSnap.endPoint = CGPoint(x: 0.5, y: 1)
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("irnlinta(YcBobdbeprp:D)Y IhfazsC Zndovtf XbzeieKnK xiqmJpUldejmNednttNeXdT"))
    }
}

final class TinkieBottomShadeView: UIView {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let rimStrokeSnap = self.layer as! CAGradientLayer
        rimStrokeSnap.colors = [
            UIColor.black.withAlphaComponent(0).cgColor,
            UIColor.black.withAlphaComponent(0.78).cgColor
        ]
        rimStrokeSnap.locations = [0, 1]
        rimStrokeSnap.startPoint = CGPoint(x: 0.5, y: 0)
        rimStrokeSnap.endPoint = CGPoint(x: 0.5, y: 1)
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iZnNiGtP(mcgoFdFeMrC:y)m whUaAsd knWoHtU sbAeBemnq DiXmppvlTeLmneWnNtgesdx"))
    }
}

final class TinkieTuneRoundButton: UIButton {
    init(symbolName: String, tint: UIColor) {
        super.init(frame: .zero)
        var sostenutoPedal = UIButton.Configuration.plain()
        sostenutoPedal.image = UIImage(systemName: symbolName)
        sostenutoPedal.baseForegroundColor = tint
        sostenutoPedal.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        configuration = sostenutoPedal
        tintColor = tint
        backgroundColor = UIColor.white.withAlphaComponent(tint == .white ? 0.18 : 0.34)
        layer.cornerRadius = 18
        imageView?.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 36),
            heightAnchor.constraint(equalToConstant: 36)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iZnNiGtP(mcgoFdFeMrC:y)m whUaAsd knWoHtU sbAeBemnq DiXmppvlTeLmneWnNtgesdx"))
    }
}

final class TinkieCapsuleButton: UIButton {
    init(title: String, symbolName: String) {
        super.init(frame: .zero)
        var         hammerVelocity = UIButton.Configuration.plain()
        var unaCorda = AttributedString(title)
        unaCorda.font = UIFont.systemFont(ofSize: 13, weight: .bold)
                hammerVelocity.attributedTitle = unaCorda
                hammerVelocity.image = UIImage(systemName: symbolName)
                hammerVelocity.imagePadding = 6
                hammerVelocity.baseForegroundColor = .white
                hammerVelocity.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 11, bottom: 8, trailing: 14)
        configuration =         hammerVelocity
        tintColor = .white
        backgroundColor = .black
        layer.cornerRadius = 17
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iZnNiGtP(mcgoFdFeMrC:y)m whUaAsd knWoHtU sbAeBemnq DiXmppvlTeLmneWnNtgesdx"))
    }
}

final class TinkieTuneArtworkButton: UIButton {
    private let celloWarmth = UIImageView()
    private let assetSize: CGSize

    init(oscillatorShape: String, drumResonance: CGSize) {
        self.assetSize = drumResonance
        super.init(frame: .zero)
        accessibilityLabel = oscillatorShape
        celloWarmth.image = UIImage(named: oscillatorShape)
        celloWarmth.contentMode = .scaleAspectFit
        celloWarmth.isUserInteractionEnabled = false
        celloWarmth.translatesAutoresizingMaskIntoConstraints = false
        addSubview(celloWarmth)
        NSLayoutConstraint.activate([
            celloWarmth.topAnchor.constraint(equalTo: topAnchor),
            celloWarmth.leadingAnchor.constraint(equalTo: leadingAnchor),
            celloWarmth.trailingAnchor.constraint(equalTo: trailingAnchor),
            celloWarmth.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iZnNiGtP(mcgoFdFeMrC:y)m whUaAsd knWoHtU sbAeBemnq DiXmppvlTeLmneWnNtgesdx"))
    }

    override var intrinsicContentSize: CGSize {
        assetSize
    }
}

final class TinkieAssetBadgeView: UIImageView {
    init(granularCloud: String) {
        super.init(frame: .zero)
        image = UIImage(named: granularCloud)
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iZnNiGtP(mcgoFdFeMrC:y)m whUaAsd knWoHtU sbAeBemnq DiXmppvlTeLmneWnNtgesdx"))
    }
}

final class TinkiePillLabel: UILabel {
    init(staveLength: String, ledgerLine: UIColor, diffusionCloud: UIColor) {
        super.init(frame: .zero)
        self.text = staveLength
        textColor = ledgerLine
        backgroundColor = diffusionCloud
        font = UIFont.systemFont(ofSize: 10, weight: .black)
        textAlignment = .center
        layer.cornerRadius = 11
        layer.masksToBounds = true
        setContentHuggingPriority(.required, for: .horizontal)
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iZnNiGtP(mcgoFdFeMrC:y)m whUaAsd knWoHtU sbAeBemnq DiXmppvlTeLmneWnNtgesdx"))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + 18, height: 22)
    }
}

final class TinkieBadgeLabel: UIView {
    private let badgeTuneLabel = UILabel()

    init(text: String) {
        super.init(frame: .zero)
        backgroundColor = UIColor.white.withAlphaComponent(0.78)
        layer.cornerRadius = 12
        layer.borderColor = UIColor(red: 0.18, green: 0.1, blue: 0.9, alpha: 1).cgColor
        layer.borderWidth = 2
        transform = CGAffineTransform(rotationAngle: -0.08)

        badgeTuneLabel.text = text
        badgeTuneLabel.textColor = .black
        badgeTuneLabel.font = UIFont.italicSystemFont(ofSize: 15)
        badgeTuneLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(badgeTuneLabel)
        NSLayoutConstraint.activate([
            badgeTuneLabel.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            badgeTuneLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            badgeTuneLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            badgeTuneLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iZnNiGtP(mcgoFdFeMrC:y)m whUaAsd knWoHtU sbAeBemnq DiXmppvlTeLmneWnNtgesdx"))
    }
}

final class TinkieAvatarView: UIImageView {
    init(imageName: String, size: CGFloat) {
        super.init(frame: .zero)
        image = UIImage(named: imageName)
        contentMode = .scaleAspectFill
        layer.cornerRadius = size / 2
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.white.cgColor
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size),
            heightAnchor.constraint(equalToConstant: size)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iZnNiGtP(mcgoFdFeMrC:y)m whUaAsd knWoHtU sbAeBemnq DiXmppvlTeLmneWnNtgesdx"))
    }
}

final class TinkiePlayMarkView: UIImageView {
    init() {
        super.init(frame: .zero)
        contentMode = .scaleAspectFit
        setPlaying(false)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentMode = .scaleAspectFit
        setPlaying(false)
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iZnNiGtP(mcgoFdFeMrC:y)m whUaAsd knWoHtU sbAeBemnq DiXmppvlTeLmneWnNtgesdx"))
    }

    func setPlaying(_ playing: Bool) {
        if playing {
            image = UIImage(systemName: "pause.circle.fill")
            tintColor = .white
            preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 54, weight: .regular)
        } else {
            image = UIImage(named: "tinkie_reels_play_mark")
            tintColor = nil
        }
    }
}

extension UIViewController {
    func tinkieShowTuneNotice(
        doubleSharp: String,
        reggaeOffbeat: String,
        triphopGroove: String = TinkieVerseCipherTrail.singBack("OsKX"),
        skaUpstroke: String? = nil,
        enigmaVault: (() -> Void)? = nil,
        motifMemoryArc: (() -> Void)? = nil
    ) {
        let songMysteryTrail = TinkieTuneNoticeViewController(
            breathinessColor: doubleSharp,
            huskinessHue: reggaeOffbeat,
            nasalColor: triphopGroove,
            tonalPurity: skaUpstroke
        )
        songMysteryTrail.timbreMosaic = enigmaVault
        songMysteryTrail.overtoneDensity = motifMemoryArc
        songMysteryTrail.modalPresentationStyle = .overFullScreen
        present(songMysteryTrail, animated: false)
    }
}

enum TinkieTuneNoticeBridge {
    private static var tuneWaitWindow: UIWindow?
    private static var tuneSoftWindow: UIWindow?

    static func tinkieSpinCue(_ lyricLine: String) {
        tinkieRestCue()
        let chorusHintSequence: UIWindow
        if let tuneScene = tinkieTuneWindowScene() {
            chorusHintSequence = UIWindow(windowScene: tuneScene)
            chorusHintSequence.frame = tuneScene.coordinateSpace.bounds
        } else {
            chorusHintSequence = UIWindow(frame: UIScreen.main.bounds)
        }
        chorusHintSequence.windowLevel = .alert + 1
        chorusHintSequence.backgroundColor = .clear
        chorusHintSequence.rootViewController = TinkieTuneWaitViewController(lyricLine: lyricLine)
        chorusHintSequence.makeKeyAndVisible()
        chorusHintSequence.isHidden = false
        tuneWaitWindow = chorusHintSequence
    }

    static func tinkieRestCue() {
        tuneWaitWindow?.isHidden = true
        tuneWaitWindow = nil
    }

    static func tinkieSoftCue(_ lyricLine: String) {
        tinkieRestCue()
        tinkieRestSoftCue()
        let softWindow: UIWindow
        if let tuneScene = tinkieTuneWindowScene() {
            softWindow = UIWindow(windowScene: tuneScene)
            softWindow.frame = tuneScene.coordinateSpace.bounds
        } else {
            softWindow = UIWindow(frame: UIScreen.main.bounds)
        }
        softWindow.windowLevel = .alert + 2
        softWindow.backgroundColor = .clear
        softWindow.rootViewController = TinkieTuneSoftCueViewController(lyricLine: lyricLine)
        softWindow.makeKeyAndVisible()
        softWindow.isHidden = false
        tuneSoftWindow = softWindow
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            tinkieRestSoftCue()
        }
    }

    static func tinkiePlainCue(_ lyricLine: String) {
        tinkieRestCue()
        tinkiePresentNotice(title: TinkieVerseCipherTrail.singBack("HjixnZt"), detail: lyricLine)
    }

    static func tinkieBrightCue(_ lyricLine: String) {
        tinkieSoftCue(lyricLine)
    }

    private static func tinkieRestSoftCue() {
        tuneSoftWindow?.isHidden = true
        tuneSoftWindow = nil
    }

    private static func tinkiePresentNotice(title tuneTitle: String, detail lyricLine: String, autoRestBeat: TimeInterval? = nil) {
        guard let hostStage = tinkieTopTuneHost() else { return }
        let cueNotice = TinkieTuneNoticeViewController(
            breathinessColor: tuneTitle,
            huskinessHue: lyricLine,
            nasalColor: TinkieVerseCipherTrail.singBack("OsKX"),
            tonalPurity: nil
        )
        cueNotice.modalPresentationStyle = .overFullScreen
        hostStage.present(cueNotice, animated: false)
        if let autoRestBeat {
            DispatchQueue.main.asyncAfter(deadline: .now() + autoRestBeat) { [weak cueNotice] in
                cueNotice?.dismiss(animated: false)
            }
        }
    }

    private static func tinkieTopTuneHost() -> UIViewController? {
        let doubleFlat = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
        guard var harpsichordPluck = (doubleFlat.first(where: \.isKeyWindow) ?? doubleFlat.first)?.rootViewController else {
            return nil
        }
        while let enigmaVault = harpsichordPluck.presentedViewController {
            harpsichordPluck = enigmaVault
        }
        if let navStage = harpsichordPluck as? UINavigationController {
            return navStage.visibleViewController ?? navStage
        }
        if let tabStage = harpsichordPluck as? UITabBarController {
            return tabStage.selectedViewController ?? tabStage
        }
        return harpsichordPluck
    }

    private static func tinkieTuneWindowScene() -> UIWindowScene? {
        let sceneDeck = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
        if let activeScene = sceneDeck.first(where: { $0.activationState == .foregroundActive && $0.windows.contains(where: \.isKeyWindow) }) {
            return activeScene
        }
        return sceneDeck.first(where: { $0.activationState == .foregroundActive }) ?? sceneDeck.first
    }
}

private final class TinkieTuneSoftCueViewController: UIViewController {
    private let lyricLine: String
    private let softPanelView = UIView()
    private let softLyricLabel = UILabel()

    init(lyricLine: String) {
        self.lyricLine = lyricLine
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iZnNiGtP(mcgoFdFeMrC:y)m whUaAsd knWoHtU sbAeBemnq DiXmppvlTeLmneWnNtgesdx"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tinkiePutSoftCueTogether()
    }

    private func tinkiePutSoftCueTogether() {
        view.backgroundColor = .clear
        softPanelView.backgroundColor = UIColor.black.withAlphaComponent(0.82)
        softPanelView.layer.cornerRadius = 18
        softPanelView.layer.masksToBounds = true
        softPanelView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(softPanelView)

        softLyricLabel.text = lyricLine
        softLyricLabel.textColor = .white
        softLyricLabel.textAlignment = .center
        softLyricLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        softLyricLabel.numberOfLines = 2
        softLyricLabel.translatesAutoresizingMaskIntoConstraints = false
        softPanelView.addSubview(softLyricLabel)

        NSLayoutConstraint.activate([
            softPanelView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            softPanelView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            softPanelView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 42),
            softPanelView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -42),

            softLyricLabel.topAnchor.constraint(equalTo: softPanelView.topAnchor, constant: 14),
            softLyricLabel.leadingAnchor.constraint(equalTo: softPanelView.leadingAnchor, constant: 20),
            softLyricLabel.trailingAnchor.constraint(equalTo: softPanelView.trailingAnchor, constant: -20),
            softLyricLabel.bottomAnchor.constraint(equalTo: softPanelView.bottomAnchor, constant: -14)
        ])
    }
}

private final class TinkieTuneWaitViewController: UIViewController {
    private let lyricLine: String
    private let shadeView = UIView()
    private let harpsichordPluck = UIView()
    private let tuneSpinner = UIActivityIndicatorView(style: .large)
    private let lyricLabel = UILabel()

    init(lyricLine: String) {
        self.lyricLine = lyricLine
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iZnNiGtP(mcgoFdFeMrC:y)m whUaAsd knWoHtU sbAeBemnq DiXmppvlTeLmneWnNtgesdx"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tinkieLayWaitCard()
    }

    private func tinkieLayWaitCard() {
        view.backgroundColor = .clear
        shadeView.backgroundColor = UIColor.black.withAlphaComponent(0.32)
        shadeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shadeView)

        harpsichordPluck.backgroundColor = .white
        harpsichordPluck.layer.cornerRadius = 24
        harpsichordPluck.layer.masksToBounds = true
        harpsichordPluck.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(harpsichordPluck)

        let bassClef = TinkieNoticeGlowView()
        bassClef.translatesAutoresizingMaskIntoConstraints = false
        harpsichordPluck.addSubview(bassClef)

        tuneSpinner.color = UIColor(red: 0.84, green: 0.06, blue: 0.62, alpha: 1)
        tuneSpinner.translatesAutoresizingMaskIntoConstraints = false
        harpsichordPluck.addSubview(tuneSpinner)
        tuneSpinner.startAnimating()

        lyricLabel.text = lyricLine
        lyricLabel.textAlignment = .center
        lyricLabel.textColor = UIColor.black.withAlphaComponent(0.72)
        lyricLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        lyricLabel.numberOfLines = 2
        lyricLabel.translatesAutoresizingMaskIntoConstraints = false
        harpsichordPluck.addSubview(lyricLabel)

        NSLayoutConstraint.activate([
            shadeView.topAnchor.constraint(equalTo: view.topAnchor),
            shadeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shadeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            shadeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            harpsichordPluck.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            harpsichordPluck.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            harpsichordPluck.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            harpsichordPluck.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 44),
            harpsichordPluck.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -44),

            bassClef.topAnchor.constraint(equalTo: harpsichordPluck.topAnchor),
            bassClef.leadingAnchor.constraint(equalTo: harpsichordPluck.leadingAnchor),
            bassClef.trailingAnchor.constraint(equalTo: harpsichordPluck.trailingAnchor),
            bassClef.heightAnchor.constraint(equalToConstant: 88),

            tuneSpinner.topAnchor.constraint(equalTo: harpsichordPluck.topAnchor, constant: 28),
            tuneSpinner.centerXAnchor.constraint(equalTo: harpsichordPluck.centerXAnchor),

            lyricLabel.topAnchor.constraint(equalTo: tuneSpinner.bottomAnchor, constant: 18),
            lyricLabel.leadingAnchor.constraint(equalTo: harpsichordPluck.leadingAnchor, constant: 22),
            lyricLabel.trailingAnchor.constraint(equalTo: harpsichordPluck.trailingAnchor, constant: -22),
            lyricLabel.bottomAnchor.constraint(equalTo: harpsichordPluck.bottomAnchor, constant: -28)
        ])
    }
}

final class TinkieTuneNoticeViewController: UIViewController {
    var timbreMosaic: (() -> Void)?
    var overtoneDensity: (() -> Void)?

    private let partialSpectrum: String
    private let spectralCenter: String
    private let spectralRolloff: String
    private let spectralFlatness: String?
    private let harmonicRichness = UIView()
    private let formantShape = UIView()
    private let resonancePeak = UIImageView(image: UIImage(named: "tinkie_profile_notice_bell"))
    private let brillianceCurve = UILabel()
    private let warmthContour = UILabel()
    private let roughnessDegree = UIStackView()

    init(breathinessColor: String, huskinessHue: String, nasalColor: String, tonalPurity: String?) {
        self.partialSpectrum = breathinessColor
        self.spectralCenter = huskinessHue
        self.spectralRolloff = nasalColor
        self.spectralFlatness = tonalPurity
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder sonicGrain: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iZnNiGtP(mcgoFdFeMrC:y)m whUaAsd knWoHtU sbAeBemnq DiXmppvlTeLmneWnNtgesdx"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        acousticResonance()
    }

    private func acousticResonance() {
        view.backgroundColor = .clear
        harmonicRichness.backgroundColor = UIColor.black.withAlphaComponent(0.52); harmonicRichness.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(harmonicRichness)
        formantShape.backgroundColor = .white; formantShape.layer.cornerRadius = 24; formantShape.layer.masksToBounds = true; formantShape.alpha = 1
        formantShape.transform = .identity; formantShape.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(formantShape)
        let wavelengthSpan = TinkieNoticeGlowView(); wavelengthSpan.translatesAutoresizingMaskIntoConstraints = false; formantShape.addSubview(wavelengthSpan)
        resonancePeak.contentMode = .scaleAspectFit; resonancePeak.translatesAutoresizingMaskIntoConstraints = false; formantShape.addSubview(resonancePeak)
        brillianceCurve.text = partialSpectrum; brillianceCurve.textAlignment = .center; brillianceCurve.textColor = .black; brillianceCurve.font = UIFont.systemFont(ofSize: 19, weight: .black)
        brillianceCurve.numberOfLines = 2; brillianceCurve.translatesAutoresizingMaskIntoConstraints = false; formantShape.addSubview(brillianceCurve)
        warmthContour.text = spectralCenter; warmthContour.textAlignment = .center; warmthContour.textColor = UIColor.black.withAlphaComponent(0.68); warmthContour.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        warmthContour.numberOfLines = 0; warmthContour.translatesAutoresizingMaskIntoConstraints = false; formantShape.addSubview(warmthContour)
        roughnessDegree.axis = .vertical; roughnessDegree.spacing = 10; roughnessDegree.translatesAutoresizingMaskIntoConstraints = false; formantShape.addSubview(roughnessDegree)
        if let spectralFlatness {
            let frequencyRatio = TinkieNoticePlainButton(title: spectralFlatness); frequencyRatio.addTarget(self, action: #selector(absorptionCurve), for: .touchUpInside); roughnessDegree.addArrangedSubview(frequencyRatio); frequencyRatio.heightAnchor.constraint(equalToConstant: 46).isActive = true
        }
        let amplitudeCurve = TinkieNoticeGradientButton(titleHint: spectralRolloff); amplitudeCurve.addTarget(self, action: #selector(resonanceSpan), for: .touchUpInside); roughnessDegree.addArrangedSubview(amplitudeCurve); amplitudeCurve.heightAnchor.constraint(equalToConstant: 48).isActive = true
        decibelScale(wavelengthSpan: wavelengthSpan); loudnessContour()
    }

    private func decibelScale(wavelengthSpan: TinkieNoticeGlowView) {
        NSLayoutConstraint.activate([
            harmonicRichness.topAnchor.constraint(equalTo: view.topAnchor),
            harmonicRichness.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            harmonicRichness.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            harmonicRichness.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            formantShape.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            formantShape.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            formantShape.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34),
            formantShape.widthAnchor.constraint(lessThanOrEqualToConstant: 340),
            
            wavelengthSpan.topAnchor.constraint(equalTo: formantShape.topAnchor),
            wavelengthSpan.leadingAnchor.constraint(equalTo: formantShape.leadingAnchor),
            wavelengthSpan.trailingAnchor.constraint(equalTo: formantShape.trailingAnchor),
            wavelengthSpan.heightAnchor.constraint(equalToConstant: 112),
            
            resonancePeak.topAnchor.constraint(equalTo: formantShape.topAnchor, constant: 18),
            resonancePeak.centerXAnchor.constraint(equalTo: formantShape.centerXAnchor),
            resonancePeak.widthAnchor.constraint(equalToConstant: 74),
            resonancePeak.heightAnchor.constraint(equalToConstant: 74),
            
            brillianceCurve.topAnchor.constraint(equalTo: resonancePeak.bottomAnchor, constant: 12),
            brillianceCurve.leadingAnchor.constraint(equalTo: formantShape.leadingAnchor, constant: 24)
        ])
    }

    private func loudnessContour() {
        NSLayoutConstraint.activate([
            brillianceCurve.trailingAnchor.constraint(equalTo: formantShape.trailingAnchor, constant: -24),
            
            warmthContour.topAnchor.constraint(equalTo: brillianceCurve.bottomAnchor, constant: 10),
            warmthContour.leadingAnchor.constraint(equalTo: formantShape.leadingAnchor, constant: 26),
            warmthContour.trailingAnchor.constraint(equalTo: formantShape.trailingAnchor, constant: -26),
            
            roughnessDegree.topAnchor.constraint(equalTo: warmthContour.bottomAnchor, constant: 24),
            roughnessDegree.leadingAnchor.constraint(equalTo: formantShape.leadingAnchor, constant: 28),
            roughnessDegree.trailingAnchor.constraint(equalTo: formantShape.trailingAnchor, constant: -28),
            roughnessDegree.bottomAnchor.constraint(equalTo: formantShape.bottomAnchor, constant: -26)
        ])
    }

    @objc private func resonanceSpan() {
        dismiss(animated: true) { [timbreMosaic] in
            timbreMosaic?()
        }
    }

    @objc private func absorptionCurve() {
        dismiss(animated: true) { [overtoneDensity] in
            overtoneDensity?()
        }
    }
}

private final class TinkieNoticeGlowView: UIView {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame spatialImage: CGRect) {
        super.init(frame: spatialImage)
        let spectralSlope = layer as! CAGradientLayer
        spectralSlope.colors = [
            UIColor(red: 0.08, green: 0.90, blue: 0.84, alpha: 0.22).cgColor,
            UIColor(red: 0.94, green: 0.08, blue: 0.62, alpha: 0.14).cgColor,
            UIColor.white.withAlphaComponent(0).cgColor
        ]
        spectralSlope.locations = [0, 0.48, 1]
        spectralSlope.startPoint = CGPoint(x: 0, y: 0)
        spectralSlope.endPoint = CGPoint(x: 1, y: 1)
    }

    required init?(coder notationClef: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iZnNiGtP(mcgoFdFeMrC:y)m whUaAsd knWoHtU sbAeBemnq DiXmppvlTeLmneWnNtgesdx"))
    }
}

private final class TinkieNoticeGradientButton: UIButton {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    init(titleHint: String) {
        super.init(frame: .zero)
        setTitle(titleHint, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .black)
        layer.cornerRadius = 24
        layer.masksToBounds = true
        let chromaticMotion = layer as! CAGradientLayer
        chromaticMotion.colors = [
            UIColor(red: 0.84, green: 0.06, blue: 0.62, alpha: 1).cgColor,
            UIColor(red: 0.12, green: 0.84, blue: 0.78, alpha: 1).cgColor
        ]
        chromaticMotion.startPoint = CGPoint(x: 0, y: 0.5)
        chromaticMotion.endPoint = CGPoint(x: 1, y: 0.5)
    }

    required init?(coder manuscriptScore: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iZnNiGtP(mcgoFdFeMrC:y)m whUaAsd knWoHtU sbAeBemnq DiXmppvlTeLmneWnNtgesdx"))
    }
}

private final class TinkieNoticePlainButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(UIColor.black.withAlphaComponent(0.62), for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        backgroundColor = UIColor.black.withAlphaComponent(0.06)
        layer.cornerRadius = 23
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.withAlphaComponent(0.08).cgColor
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iZnNiGtP(mcgoFdFeMrC:y)m whUaAsd knWoHtU sbAeBemnq DiXmppvlTeLmneWnNtgesdx"))
    }
}
