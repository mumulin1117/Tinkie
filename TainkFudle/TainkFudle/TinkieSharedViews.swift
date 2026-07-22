import UIKit

final class TinkieTabButton: UIButton {
    private let iconView = UIImageView()
    private let tabTitleLabel = UILabel()
    private let idleAssetName: String
    private let activeAssetName: String

    init(title: String, idleAssetName: String, activeAssetName: String) {
        self.idleAssetName = idleAssetName
        self.activeAssetName = activeAssetName
        super.init(frame: .zero)
        accessibilityLabel = title

        iconView.image = UIImage(named: idleAssetName)
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.isUserInteractionEnabled = false

        tabTitleLabel.text = title
        tabTitleLabel.textAlignment = .center
        tabTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        tabTitleLabel.textColor = UIColor.white.withAlphaComponent(0.45)
        tabTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        tabTitleLabel.isUserInteractionEnabled = false

        let stack = UIStackView(arrangedSubviews: [iconView, tabTitleLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        stack.isUserInteractionEnabled = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -2),
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 4),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -4),
            iconView.widthAnchor.constraint(equalToConstant: 31),
            iconView.heightAnchor.constraint(equalToConstant: 31)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isSelected: Bool {
        didSet {
            iconView.image = UIImage(named: isSelected ? activeAssetName : idleAssetName)
            tabTitleLabel.textColor = isSelected ? .white : UIColor.white.withAlphaComponent(0.45)
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
        fatalError("init(coder:) has not been implemented")
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
        fatalError("init(coder:) has not been implemented")
    }
}

final class TinkieCircleSymbolButton: UIButton {
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
        fatalError("init(coder:) has not been implemented")
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
        fatalError("init(coder:) has not been implemented")
    }
}

final class TinkieALyricRevea: UIButton {
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
        fatalError("init(coder:) has not been implemented")
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
        fatalError("init(coder:) has not been implemented")
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
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + 18, height: 22)
    }
}

final class TinkieBadgeLabel: UIView {
    private let label = UILabel()

    init(text: String) {
        super.init(frame: .zero)
        backgroundColor = UIColor.white.withAlphaComponent(0.78)
        layer.cornerRadius = 12
        layer.borderColor = UIColor(red: 0.18, green: 0.1, blue: 0.9, alpha: 1).cgColor
        layer.borderWidth = 2
        transform = CGAffineTransform(rotationAngle: -0.08)

        label.text = text
        label.textColor = .black
        label.font = UIFont.italicSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        fatalError("init(coder:) has not been implemented")
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
        fatalError("init(coder:) has not been implemented")
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
