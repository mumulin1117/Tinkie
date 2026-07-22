import AVFoundation
import UIKit

enum tinkieTimbreDeck {
    private static let folderName = "tinkie_song_room_clips"

    static func url(for fileName: String) -> URL? {
        if FileManager.default.fileExists(atPath: fileName) {
            return URL(fileURLWithPath: fileName)
        }
        return Bundle.main.url(forResource: fileName, withExtension: nil, subdirectory: folderName)
            ?? Bundle.main.url(forResource: fileName, withExtension: nil)
    }
}

enum TinkieRhythmFirstFrameStore {
    private static let frameCache = NSCache<NSString, UIImage>()

    static func art(for fileName: String) -> UIImage? {
        let cacheKey = fileName as NSString
        return frameCache.object(forKey: cacheKey)
    }

    static func resolveArt(for fileName: String, ready: @escaping (UIImage?) -> Void) {
        let cacheKey = fileName as NSString
        if let cachedArt = frameCache.object(forKey: cacheKey) {
            ready(cachedArt)
            return
        }
        guard let url = tinkieTimbreDeck.url(for: fileName) else {
            ready(nil)
            return
        }
        let asset = AVURLAsset(url: url)
        let maker = AVAssetImageGenerator(asset: asset)
        maker.appliesPreferredTrackTransform = true
        maker.maximumSize = CGSize(width: 900, height: 1600)
        let time = CMTime(seconds: 0.08, preferredTimescale: 600)
        maker.generateCGImageAsynchronously(for: time) { cgArt, _, _ in
            let art = cgArt.map { UIImage(cgImage: $0) }
            if let art {
                frameCache.setObject(art, forKey: cacheKey)
            }
            DispatchQueue.main.async {
                ready(art)
            }
        }
    }
}

final class tinkiTuneEchoCell: UICollectionViewCell {
    static let reuseIdentifier = "tinkiTuneEchoCell"
    var onMoreTapped: (() -> Void)?
    private let panelImageView = UIImageView(image: UIImage(named: "tinkie_event_card_shadow_panel"))
    private let coverFrameImageView = UIImageView(image: UIImage(named: "tinkie_event_cover_frame"))
    private let imageView = UIImageView()
    private let turntableImageView = UIImageView(image: UIImage(named: "tinkie_event_vinyl_turntable"))
    private let moreButton = TinkieCircleSymbolButton(symbolName: "ellipsis", tint: .white)
    private let titleLabel = UILabel()
//    private let scheduleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let tagLabel = UILabel()
    private let hostLabel = UILabel()
    private let joinButton = TinkieALyricRevea(assetName: "tinkie_event_join_badge", size: CGSize(width: 96, height: 33))
    private let avatarStack = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        onMoreTapped = nil
    }

    func configure(with event: TinkieSongEvent) {
        if let coverPath = event.coverPath, let localArt = UIImage(contentsOfFile: coverPath) {
            imageView.image = localArt
        } else {
            imageView.image = UIImage(named: event.coverName)
        }
        titleLabel.text = event.title
//        scheduleLabel.text = "\(event.dateText)  •  \(event.timeText)"
        subtitleLabel.text = event.subtitle
        tagLabel.text = event.tags.joined(separator: "   ")
        hostLabel.text = "\(event.hostName) · \(event.listenerNote)"
        avatarStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        event.avatarNames.prefix(3).forEach { name in
            avatarStack.addArrangedSubview(TinkieAvatarView(imageName: name, size: 26))
        }
    }

    private func buildLayout() {
        contentView.backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.05, alpha: 1)
        contentView.layer.cornerRadius = 26
        contentView.layer.masksToBounds = true

        panelImageView.contentMode = .scaleAspectFill
        panelImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(panelImageView)

        coverFrameImageView.contentMode = .scaleAspectFit
        coverFrameImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(coverFrameImageView)

        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 146/2
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)

        turntableImageView.contentMode = .scaleAspectFit
        turntableImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(turntableImageView)

        moreButton.addTarget(self, action: #selector(moreTapped), for: .touchUpInside)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(moreButton)

        let gradient = TinkieBottomShadeView()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(gradient)

        let openLabel = TinkiePillLabel(text: "OPEN", foreground: .black, background: .white)
        openLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(openLabel)

        tagLabel.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        tagLabel.textColor = UIColor(red: 1, green: 0.17, blue: 0.72, alpha: 1)
        tagLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

//        scheduleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
//        scheduleLabel.textColor = UIColor.white.withAlphaComponent(0.9)
//        scheduleLabel.numberOfLines = 1
//        scheduleLabel.translatesAutoresizingMaskIntoConstraints = false

        subtitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        subtitleLabel.textColor = UIColor.white.withAlphaComponent(0.82)
        subtitleLabel.numberOfLines = 2
        subtitleLabel.lineBreakMode = .byTruncatingTail
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        hostLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        hostLabel.textColor = UIColor.white.withAlphaComponent(0.65)
        hostLabel.translatesAutoresizingMaskIntoConstraints = false

        avatarStack.axis = .horizontal
        avatarStack.spacing = -8
        avatarStack.translatesAutoresizingMaskIntoConstraints = false

        joinButton.translatesAutoresizingMaskIntoConstraints = false

        [tagLabel, titleLabel, subtitleLabel, hostLabel, avatarStack, joinButton].forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([
            panelImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            panelImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            panelImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            panelImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            coverFrameImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            coverFrameImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            coverFrameImageView.widthAnchor.constraint(equalToConstant: 180),
            coverFrameImageView.heightAnchor.constraint(equalTo: coverFrameImageView.widthAnchor),

            imageView.centerXAnchor.constraint(equalTo: coverFrameImageView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: coverFrameImageView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 146),
            imageView.heightAnchor.constraint(equalToConstant: 146),

            turntableImageView.centerXAnchor.constraint(equalTo: coverFrameImageView.centerXAnchor),
            turntableImageView.centerYAnchor.constraint(equalTo: coverFrameImageView.centerYAnchor),
            turntableImageView.widthAnchor.constraint(equalToConstant: 94),
            turntableImageView.heightAnchor.constraint(equalToConstant: 94),

            moreButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            moreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            gradient.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gradient.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gradient.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            gradient.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.72),

            openLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            openLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),

            tagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            tagLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            tagLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -6),

            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -6),

//            scheduleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
//            scheduleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
//            scheduleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -6),

            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            subtitleLabel.bottomAnchor.constraint(equalTo: hostLabel.topAnchor, constant: -8),

            hostLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            hostLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            hostLabel.bottomAnchor.constraint(equalTo: avatarStack.topAnchor, constant: -12),

            avatarStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            avatarStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18),
            avatarStack.heightAnchor.constraint(equalToConstant: 26),

            joinButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            joinButton.centerYAnchor.constraint(equalTo: avatarStack.centerYAnchor),
            joinButton.widthAnchor.constraint(equalToConstant: 96),
            joinButton.heightAnchor.constraint(equalToConstant: 33)
        ])
    }

    @objc private func moreTapped() {
        onMoreTapped?()
    }
}

final class tinkiTSingerHint: UICollectionViewCell {
    static let reuseIdentifier = "tinkiTSingerHint"
    var onMoreTapped: (() -> Void)?
    private let imageView = UIImageView()
    private let playView = TinkiePlayMarkView()
    private let label = TinkiePillLabel(text: "", foreground: .white, background: UIColor.black.withAlphaComponent(0.32))
    private let moreButton = TinkieCircleSymbolButton(symbolName: "ellipsis", tint: .white)
    private var firstFrameKey: String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        playView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        moreButton.addTarget(self, action: #selector(moreTapped), for: .touchUpInside)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        contentView.addSubview(playView)
        contentView.addSubview(label)
        contentView.addSubview(moreButton)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            playView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            playView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playView.widthAnchor.constraint(equalToConstant: 50),
            playView.heightAnchor.constraint(equalToConstant: 50),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            moreButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            moreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        onMoreTapped = nil
        firstFrameKey = nil
        imageView.image = nil
    }

    func configure(with clip: TinkieReelClip) {
        firstFrameKey = clip.clipFileName
        if let coverPath = clip.coverPath, let localArt = UIImage(contentsOfFile: coverPath) {
            imageView.image = localArt
        } else {
            imageView.image = UIImage(named: clip.coverName)
        }
        if let firstFrame = TinkieRhythmFirstFrameStore.art(for: clip.clipFileName) {
            imageView.image = firstFrame
        } else {
            TinkieRhythmFirstFrameStore.resolveArt(for: clip.clipFileName) { [weak self] firstFrame in
                guard let self, self.firstFrameKey == clip.clipFileName, let firstFrame else { return }
                self.imageView.image = firstFrame
            }
        }
        label.text = clip.echoCount.uppercased()
    }

    @objc private func moreTapped() {
        onMoreTapped?()
    }
}

final class tinkiTSingerWave: UICollectionViewCell {
    static let reuseIdentifier = "tinkiTSingerWave"
    var onMoreTapped: (() -> Void)?
    var onAvatarTapped: (() -> Void)?
    var onBondTapped: (() -> Void)?
    var onSparkTapped: (() -> Void)?
    private let imageView = UIImageView()
    private var firstFrameKey: String?
    private let avatar = UIImageView()
    private let avatarTapButton = UIButton(type: .custom)
    private let bondButton = UIButton(type: .system)
    private let sparkButton = TinkieCircleSymbolButton(symbolName: "heart", tint: .white)
    private let playView = TinkiePlayMarkView()
    private let centerPlayButton = UIButton(type: .custom)
    private let nameLabel = UILabel()
    private let timeLabel = UILabel()
    private let captionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        onMoreTapped = nil
        onAvatarTapped = nil
        onBondTapped = nil
        onSparkTapped = nil
        firstFrameKey = nil
        imageView.image = nil
        avatar.image = nil
    }

    func configure(with clip: TinkieReelClip, bonded: Bool, sparked: Bool) {
        firstFrameKey = clip.clipFileName
        if let coverPath = clip.coverPath, let localArt = UIImage(contentsOfFile: coverPath) {
            imageView.image = localArt
        } else {
            imageView.image = UIImage(named: clip.coverName)
        }
        if let firstFrame = TinkieRhythmFirstFrameStore.art(for: clip.clipFileName) {
            imageView.image = firstFrame
        } else {
            TinkieRhythmFirstFrameStore.resolveArt(for: clip.clipFileName) { [weak self] firstFrame in
                guard let self, self.firstFrameKey == clip.clipFileName, let firstFrame else { return }
                self.imageView.image = firstFrame
            }
        }
        if let avatarPath = clip.avatarPath, let localArt = UIImage(contentsOfFile: avatarPath) {
            avatar.image = localArt
        } else {
            avatar.image = UIImage(named: clip.avatarName)
        }
        nameLabel.text = clip.performer
        timeLabel.text = clip.moment
        captionLabel.text = clip.caption
        refreshBondStyle(bonded)
        refreshSparkStyle(sparked)
    }

    private func buildLayout() {
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)

        let shade = TinkieBottomShadeView()
        shade.isUserInteractionEnabled = false
        shade.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(shade)

        playView.isUserInteractionEnabled = false
        playView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(playView)
        centerPlayButton.isUserInteractionEnabled = false
        centerPlayButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(centerPlayButton)

        let moreButton = TinkieCircleSymbolButton(symbolName: "ellipsis", tint: .white)
        moreButton.addTarget(self, action: #selector(moreTapped), for: .touchUpInside)
        sparkButton.addTarget(self, action: #selector(sparkTapped), for: .touchUpInside)
        let actionRow = UIStackView(arrangedSubviews: [sparkButton, moreButton])
        actionRow.axis = .horizontal
        actionRow.alignment = .center
        actionRow.spacing = 12
        actionRow.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(actionRow)

        avatar.contentMode = .scaleAspectFill
        avatar.layer.cornerRadius = 30
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.layer.masksToBounds = true
        avatar.isUserInteractionEnabled = false
        avatar.translatesAutoresizingMaskIntoConstraints = false

        avatarTapButton.addTarget(self, action: #selector(avatarTapped), for: .touchUpInside)
        avatarTapButton.isExclusiveTouch = true
        avatarTapButton.accessibilityLabel = "Open performer profile"
        avatarTapButton.translatesAutoresizingMaskIntoConstraints = false

        bondButton.setBackgroundImage(UIImage(named: "tinkie_reels_follow_pluseee"), for: .normal)
      
        bondButton.addTarget(self, action: #selector(bondTapped), for: .touchUpInside)
        bondButton.translatesAutoresizingMaskIntoConstraints = false

        nameLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        nameLabel.textColor = .white
        timeLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        timeLabel.textColor = UIColor.white.withAlphaComponent(0.75)
        let nameStack = UIStackView(arrangedSubviews: [nameLabel, timeLabel])
        nameStack.axis = .vertical
        nameStack.spacing = 1
        nameStack.translatesAutoresizingMaskIntoConstraints = false

        captionLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        captionLabel.textColor = .white
        captionLabel.numberOfLines = 2
        captionLabel.translatesAutoresizingMaskIntoConstraints = false

        let inputPill = UILabel()
        inputPill.text = "  Say something..."
        inputPill.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        inputPill.textColor = UIColor.white.withAlphaComponent(0.55)
        inputPill.layer.cornerRadius = 18
        inputPill.layer.borderWidth = 1
        inputPill.layer.borderColor = UIColor.white.withAlphaComponent(0.55).cgColor
        inputPill.layer.masksToBounds = true
        inputPill.backgroundColor = UIColor.white.withAlphaComponent(0.12)
        inputPill.translatesAutoresizingMaskIntoConstraints = false

        [avatar, avatarTapButton, bondButton, nameStack, captionLabel, inputPill].forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            shade.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shade.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shade.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            shade.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.62),

            playView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            playView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -12),
            playView.widthAnchor.constraint(equalToConstant: 64),
            playView.heightAnchor.constraint(equalToConstant: 64),
            centerPlayButton.centerXAnchor.constraint(equalTo: playView.centerXAnchor),
            centerPlayButton.centerYAnchor.constraint(equalTo: playView.centerYAnchor),
            centerPlayButton.widthAnchor.constraint(equalToConstant: 96),
            centerPlayButton.heightAnchor.constraint(equalToConstant: 96),

            actionRow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            actionRow.bottomAnchor.constraint(equalTo: inputPill.topAnchor, constant: -22),

            avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            avatar.bottomAnchor.constraint(equalTo: captionLabel.topAnchor, constant: -8),
            avatar.widthAnchor.constraint(equalToConstant: 50),
            avatar.heightAnchor.constraint(equalToConstant:50),
            avatarTapButton.centerXAnchor.constraint(equalTo: avatar.centerXAnchor),
            avatarTapButton.centerYAnchor.constraint(equalTo: avatar.centerYAnchor, constant: -4),
            avatarTapButton.widthAnchor.constraint(equalToConstant: 64),
            avatarTapButton.heightAnchor.constraint(equalToConstant: 64),
            bondButton.centerXAnchor.constraint(equalTo: avatar.centerXAnchor, constant: 0),
            bondButton.bottomAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 8),
            bondButton.widthAnchor.constraint(equalToConstant: 40),
            bondButton.heightAnchor.constraint(equalToConstant: 22),
            nameStack.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 10),
            nameStack.centerYAnchor.constraint(equalTo: avatar.centerYAnchor),
            nameStack.trailingAnchor.constraint(lessThanOrEqualTo: actionRow.leadingAnchor, constant: -12),

            captionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            captionLabel.trailingAnchor.constraint(equalTo: actionRow.leadingAnchor, constant: -16),
            captionLabel.bottomAnchor.constraint(equalTo: inputPill.topAnchor, constant: -14),

            inputPill.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            inputPill.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            inputPill.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -18),
            inputPill.heightAnchor.constraint(equalToConstant: 38)
        ])

        [actionRow, avatar, avatarTapButton, bondButton, nameStack, captionLabel, inputPill, playView, centerPlayButton].forEach {
            contentView.bringSubviewToFront($0)
        }
    }

    @objc private func moreTapped() {
        onMoreTapped?()
    }

    @objc private func avatarTapped() {
        onAvatarTapped?()
    }

    @objc private func bondTapped() {
        onBondTapped?()
    }

    @objc private func sparkTapped() {
        onSparkTapped?()
    }

    private func refreshBondStyle(_ bonded: Bool) {
        bondButton.setBackgroundImage(UIImage(named: bonded ? "areadyAddf" :  "tinkie_reels_follow_pluseee"), for: .normal)
      
//        bondButton.tintColor = bonded ? UIColor(red: 0.04, green: 0.50, blue: 0.46, alpha: 1) : .white
    }

    private func refreshSparkStyle(_ sparked: Bool) {
        sparkButton.setImage(UIImage(systemName: sparked ? "heart.fill" : "heart"), for: .normal)
        sparkButton.tintColor = .white
        sparkButton.backgroundColor = UIColor.white.withAlphaComponent(sparked ? 0.28 : 0.18)
    }
}
