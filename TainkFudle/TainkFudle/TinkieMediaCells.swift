import AVFoundation
import UIKit

enum TinkieSongRoomClipResource {
    private static let folderName = "tinkie_song_room_clips"

    static func url(for fileName: String) -> URL? {
        if FileManager.default.fileExists(atPath: fileName) {
            return URL(fileURLWithPath: fileName)
        }
        return Bundle.main.url(forResource: fileName, withExtension: nil, subdirectory: folderName)
            ?? Bundle.main.url(forResource: fileName, withExtension: nil)
    }
}

final class TinkieEventCell: UICollectionViewCell {
    static let reuseIdentifier = "TinkieEventCell"
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
    private let joinButton = TinkieAssetImageButton(assetName: "tinkie_event_join_badge", size: CGSize(width: 96, height: 33))
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

final class TinkiePopularClipCell: UICollectionViewCell {
    static let reuseIdentifier = "TinkiePopularClipCell"
    private let imageView = UIImageView()
    private let playView = TinkiePlayMarkView()
    private let label = TinkiePillLabel(text: "", foreground: .white, background: UIColor.black.withAlphaComponent(0.32))

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        playView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        contentView.addSubview(playView)
        contentView.addSubview(label)
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
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with clip: TinkieReelClip) {
        if let coverPath = clip.coverPath, let localArt = UIImage(contentsOfFile: coverPath) {
            imageView.image = localArt
        } else {
            imageView.image = UIImage(named: clip.coverName)
        }
        label.text = clip.echoCount.uppercased()
    }
}

final class TinkieReelCell: UICollectionViewCell {
    static let reuseIdentifier = "TinkieReelCell"
    var onMoreTapped: (() -> Void)?
    var onAvatarTapped: (() -> Void)?
    var onBondTapped: (() -> Void)?
    var onSparkTapped: (() -> Void)?
    var onCenterPlayTapped: (() -> Void)?
    private let imageView = UIImageView()
    private let clipLayer = AVPlayerLayer()
    private var clipPlayer: AVPlayer?
    private var replayToken: NSObjectProtocol?
    private var isRhythmRolling = false
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
        stopClip()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        clipLayer.frame = imageView.bounds
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        stopClip()
        onMoreTapped = nil
        onAvatarTapped = nil
        onBondTapped = nil
        onSparkTapped = nil
        onCenterPlayTapped = nil
        imageView.image = nil
        avatar.image = nil
    }

    func configure(with clip: TinkieReelClip, bonded: Bool, sparked: Bool) {
        if let coverPath = clip.coverPath, let localArt = UIImage(contentsOfFile: coverPath) {
            imageView.image = localArt
        } else {
            imageView.image = UIImage(named: clip.coverName)
        }
        prepareClip(named: clip.clipFileName)
        avatar.image = UIImage(named: clip.avatarName)
        nameLabel.text = clip.performer
        timeLabel.text = clip.moment
        captionLabel.text = clip.caption
        refreshBondStyle(bonded)
        refreshSparkStyle(sparked)
    }

    private func buildLayout() {
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        clipLayer.videoGravity = .resizeAspectFill
        imageView.layer.addSublayer(clipLayer)
        contentView.addSubview(imageView)

        let shade = TinkieBottomShadeView()
        shade.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(shade)

        playView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(playView)
        centerPlayButton.addTarget(self, action: #selector(centerPlayTapped), for: .touchUpInside)
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
        avatar.translatesAutoresizingMaskIntoConstraints = false

        avatarTapButton.addTarget(self, action: #selector(avatarTapped), for: .touchUpInside)
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
            centerPlayButton.widthAnchor.constraint(equalToConstant: 92),
            centerPlayButton.heightAnchor.constraint(equalToConstant: 92),

            actionRow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            actionRow.bottomAnchor.constraint(equalTo: inputPill.topAnchor, constant: -22),

            avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            avatar.bottomAnchor.constraint(equalTo: captionLabel.topAnchor, constant: -8),
            avatar.widthAnchor.constraint(equalToConstant: 50),
            avatar.heightAnchor.constraint(equalToConstant:50),
            avatarTapButton.topAnchor.constraint(equalTo: avatar.topAnchor),
            avatarTapButton.leadingAnchor.constraint(equalTo: avatar.leadingAnchor),
            avatarTapButton.trailingAnchor.constraint(equalTo: avatar.trailingAnchor),
            avatarTapButton.bottomAnchor.constraint(equalTo: avatar.bottomAnchor),
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
    }

    func stopClip() {
        clipPlayer?.pause()
        clipPlayer = nil
        clipLayer.player = nil
        isRhythmRolling = false
        playView.setPlaying(false)
        if let replayToken {
            NotificationCenter.default.removeObserver(replayToken)
            self.replayToken = nil
        }
    }

    private func prepareClip(named fileName: String) {
        stopClip()
        guard let url = TinkieSongRoomClipResource.url(for: fileName) else { return }
        let player = AVPlayer(url: url)
        player.isMuted = true
        player.actionAtItemEnd = .none
        clipPlayer = player
        clipLayer.player = player
        replayToken = NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { [weak player] _ in
            player?.seek(to: .zero)
            player?.play()
        }
        playView.setPlaying(false)
    }

    func switchPulsePlaying() {
        guard let clipPlayer else { return }
        if isRhythmRolling {
            clipPlayer.pause()
            isRhythmRolling = false
        } else {
            clipPlayer.play()
            isRhythmRolling = true
        }
        playView.setPlaying(isRhythmRolling)
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

    @objc private func centerPlayTapped() {
        switchPulsePlaying()
        onCenterPlayTapped?()
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
