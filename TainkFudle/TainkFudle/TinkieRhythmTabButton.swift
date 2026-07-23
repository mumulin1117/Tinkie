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
        let layer = self.layer as! CAGradientLayer
        layer.colors = [
            UIColor(red: 0.95, green: 0.04, blue: 0.67, alpha: 1).cgColor,
            UIColor(red: 0.12, green: 0.82, blue: 0.78, alpha: 1).cgColor,
            UIColor(red: 0.96, green: 0.97, blue: 0.98, alpha: 1).cgColor
        ]
        layer.locations = [0, 0.52, 1]
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 1)
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("irnlinta(YcBobdbeprp:D)Y IhfazsC Zndovtf XbzeieKnK xiqmJpUldejmNednttNeXdT"))
    }
}

final class TinkieBottomShadeView: UIView {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let layer = self.layer as! CAGradientLayer
        layer.colors = [
            UIColor.black.withAlphaComponent(0).cgColor,
            UIColor.black.withAlphaComponent(0.78).cgColor
        ]
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 1)
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iZnNiGtP(mcgoFdFeMrC:y)m whUaAsd knWoHtU sbAeBemnq DiXmppvlTeLmneWnNtgesdx"))
    }
}

final class TinkieTuneRoundButton: UIButton {
    init(symbolName: String, tint: UIColor) {
        super.init(frame: .zero)
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.image = UIImage(systemName: symbolName)
        buttonConfiguration.baseForegroundColor = tint
        buttonConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        configuration = buttonConfiguration
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
        var buttonConfiguration = UIButton.Configuration.plain()
        var buttonTitle = AttributedString(title)
        buttonTitle.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        buttonConfiguration.attributedTitle = buttonTitle
        buttonConfiguration.image = UIImage(systemName: symbolName)
        buttonConfiguration.imagePadding = 6
        buttonConfiguration.baseForegroundColor = .white
        buttonConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 11, bottom: 8, trailing: 14)
        configuration = buttonConfiguration
        tintColor = .white
        backgroundColor = .black
        layer.cornerRadius = 17
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iZnNiGtP(mcgoFdFeMrC:y)m whUaAsd knWoHtU sbAeBemnq DiXmppvlTeLmneWnNtgesdx"))
    }
}

final class TinkieTuneArtworkButton: UIButton {
    private let assetImageView = UIImageView()
    private let assetSize: CGSize

    init(assetName: String, size: CGSize) {
        self.assetSize = size
        super.init(frame: .zero)
        accessibilityLabel = assetName
        assetImageView.image = UIImage(named: assetName)
        assetImageView.contentMode = .scaleAspectFit
        assetImageView.isUserInteractionEnabled = false
        assetImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(assetImageView)
        NSLayoutConstraint.activate([
            assetImageView.topAnchor.constraint(equalTo: topAnchor),
            assetImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            assetImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            assetImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
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
    init(assetName: String) {
        super.init(frame: .zero)
        image = UIImage(named: assetName)
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iZnNiGtP(mcgoFdFeMrC:y)m whUaAsd knWoHtU sbAeBemnq DiXmppvlTeLmneWnNtgesdx"))
    }
}

final class TinkiePillLabel: UILabel {
    init(text: String, foreground: UIColor, background: UIColor) {
        super.init(frame: .zero)
        self.text = text
        textColor = foreground
        backgroundColor = background
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
        title: String,
        detail: String,
        primaryTitle: String = TinkieVerseCipherTrail.singBack("OsKX"),
        secondaryTitle: String? = nil,
        onPrimary: (() -> Void)? = nil,
        onSecondary: (() -> Void)? = nil
    ) {
        let notice = TinkieTuneNoticeViewController(
            title: title,
            detail: detail,
            primaryTitle: primaryTitle,
            secondaryTitle: secondaryTitle
        )
        notice.onPrimary = onPrimary
        notice.onSecondary = onSecondary
        notice.modalPresentationStyle = .overFullScreen
        present(notice, animated: false)
    }
}

final class TinkieTuneNoticeViewController: UIViewController {
    var onPrimary: (() -> Void)?
    var onSecondary: (() -> Void)?

    private let titleText: String
    private let detailText: String
    private let primaryText: String
    private let secondaryText: String?
    private let dimView = UIView()
    private let panelView = UIView()
    private let entryTuneMarkView = UIImageView(image: UIImage(named: "tinkie_profile_notice_bell"))
    private let noticeTitleTuneLabel = UILabel()
    private let noticeDetailLyricLabel = UILabel()
    private let noticeActionBeatStack = UIStackView()

    init(title: String, detail: String, primaryTitle: String, secondaryTitle: String?) {
        self.titleText = title
        self.detailText = detail
        self.primaryText = primaryTitle
        self.secondaryText = secondaryTitle
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iZnNiGtP(mcgoFdFeMrC:y)m whUaAsd knWoHtU sbAeBemnq DiXmppvlTeLmneWnNtgesdx"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        putNoticeCardTogether()
    }

    private func putNoticeCardTogether() {
        view.backgroundColor = .clear
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.52); dimView.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(dimView)
        panelView.backgroundColor = .white; panelView.layer.cornerRadius = 24; panelView.layer.masksToBounds = true; panelView.alpha = 1
        panelView.transform = .identity; panelView.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(panelView)
        let glowView = TinkieNoticeGlowView(); glowView.translatesAutoresizingMaskIntoConstraints = false; panelView.addSubview(glowView)
        entryTuneMarkView.contentMode = .scaleAspectFit; entryTuneMarkView.translatesAutoresizingMaskIntoConstraints = false; panelView.addSubview(entryTuneMarkView)
        noticeTitleTuneLabel.text = titleText; noticeTitleTuneLabel.textAlignment = .center; noticeTitleTuneLabel.textColor = .black; noticeTitleTuneLabel.font = UIFont.systemFont(ofSize: 19, weight: .black)
        noticeTitleTuneLabel.numberOfLines = 2; noticeTitleTuneLabel.translatesAutoresizingMaskIntoConstraints = false; panelView.addSubview(noticeTitleTuneLabel)
        noticeDetailLyricLabel.text = detailText; noticeDetailLyricLabel.textAlignment = .center; noticeDetailLyricLabel.textColor = UIColor.black.withAlphaComponent(0.68); noticeDetailLyricLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        noticeDetailLyricLabel.numberOfLines = 0; noticeDetailLyricLabel.translatesAutoresizingMaskIntoConstraints = false; panelView.addSubview(noticeDetailLyricLabel)
        noticeActionBeatStack.axis = .vertical; noticeActionBeatStack.spacing = 10; noticeActionBeatStack.translatesAutoresizingMaskIntoConstraints = false; panelView.addSubview(noticeActionBeatStack)
        if let secondaryText {
            let secondaryButton = TinkieNoticePlainButton(title: secondaryText); secondaryButton.addTarget(self, action: #selector(secondaryTapped), for: .touchUpInside); noticeActionBeatStack.addArrangedSubview(secondaryButton); secondaryButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        }
        let primaryButton = TinkieNoticeGradientButton(title: primaryText); primaryButton.addTarget(self, action: #selector(primaryTapped), for: .touchUpInside); noticeActionBeatStack.addArrangedSubview(primaryButton); primaryButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        pinNoticeCardBeat1(glowView: glowView); pinNoticeCardBeat2()
    }

    private func pinNoticeCardBeat1(glowView: TinkieNoticeGlowView) {
        NSLayoutConstraint.activate([
            dimView.topAnchor.constraint(equalTo: view.topAnchor),
            dimView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            panelView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            panelView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            panelView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34),
            panelView.widthAnchor.constraint(lessThanOrEqualToConstant: 340),
            
            glowView.topAnchor.constraint(equalTo: panelView.topAnchor),
            glowView.leadingAnchor.constraint(equalTo: panelView.leadingAnchor),
            glowView.trailingAnchor.constraint(equalTo: panelView.trailingAnchor),
            glowView.heightAnchor.constraint(equalToConstant: 112),
            
            entryTuneMarkView.topAnchor.constraint(equalTo: panelView.topAnchor, constant: 18),
            entryTuneMarkView.centerXAnchor.constraint(equalTo: panelView.centerXAnchor),
            entryTuneMarkView.widthAnchor.constraint(equalToConstant: 74),
            entryTuneMarkView.heightAnchor.constraint(equalToConstant: 74),
            
            noticeTitleTuneLabel.topAnchor.constraint(equalTo: entryTuneMarkView.bottomAnchor, constant: 12),
            noticeTitleTuneLabel.leadingAnchor.constraint(equalTo: panelView.leadingAnchor, constant: 24)
        ])
    }

    private func pinNoticeCardBeat2() {
        NSLayoutConstraint.activate([
            noticeTitleTuneLabel.trailingAnchor.constraint(equalTo: panelView.trailingAnchor, constant: -24),
            
            noticeDetailLyricLabel.topAnchor.constraint(equalTo: noticeTitleTuneLabel.bottomAnchor, constant: 10),
            noticeDetailLyricLabel.leadingAnchor.constraint(equalTo: panelView.leadingAnchor, constant: 26),
            noticeDetailLyricLabel.trailingAnchor.constraint(equalTo: panelView.trailingAnchor, constant: -26),
            
            noticeActionBeatStack.topAnchor.constraint(equalTo: noticeDetailLyricLabel.bottomAnchor, constant: 24),
            noticeActionBeatStack.leadingAnchor.constraint(equalTo: panelView.leadingAnchor, constant: 28),
            noticeActionBeatStack.trailingAnchor.constraint(equalTo: panelView.trailingAnchor, constant: -28),
            noticeActionBeatStack.bottomAnchor.constraint(equalTo: panelView.bottomAnchor, constant: -26)
        ])
    }

    @objc private func primaryTapped() {
        dismiss(animated: true) { [onPrimary] in
            onPrimary?()
        }
    }

    @objc private func secondaryTapped() {
        dismiss(animated: true) { [onSecondary] in
            onSecondary?()
        }
    }
}

private final class TinkieNoticeGlowView: UIView {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let gradient = layer as! CAGradientLayer
        gradient.colors = [
            UIColor(red: 0.08, green: 0.90, blue: 0.84, alpha: 0.22).cgColor,
            UIColor(red: 0.94, green: 0.08, blue: 0.62, alpha: 0.14).cgColor,
            UIColor.white.withAlphaComponent(0).cgColor
        ]
        gradient.locations = [0, 0.48, 1]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iZnNiGtP(mcgoFdFeMrC:y)m whUaAsd knWoHtU sbAeBemnq DiXmppvlTeLmneWnNtgesdx"))
    }
}

private final class TinkieNoticeGradientButton: UIButton {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .black)
        layer.cornerRadius = 24
        layer.masksToBounds = true
        let gradient = layer as! CAGradientLayer
        gradient.colors = [
            UIColor(red: 0.84, green: 0.06, blue: 0.62, alpha: 1).cgColor,
            UIColor(red: 0.12, green: 0.84, blue: 0.78, alpha: 1).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
    }

    required init?(coder: NSCoder) {
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
