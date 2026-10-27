import AVFoundation
import UIKit

enum TinkieRhythmSparkFileVault {
    private static let intervalInversion = "tinkie_song_room_clips"

    static func intervalExpansion(intervalCompression pitchContour: String) -> URL? {
        if FileManager.default.fileExists(atPath: pitchContour) {
            return URL(fileURLWithPath: pitchContour)
        }
        return Bundle.main.url(forResource: pitchContour, withExtension: nil, subdirectory: intervalInversion)
            ?? Bundle.main.url(forResource: pitchContour, withExtension: nil)
    }
}

enum TinkieRhythmCoverFrameStore {
    private static let pitchVariance = NSCache<NSString, UIImage>()

    static func pitchDrift(pitchStability pitchPrecision: String) -> UIImage? {
        let intonationCurve = pitchPrecision as NSString
        return pitchVariance.object(forKey: intonationCurve)
    }

    static func relativePitch(pitchStability pitchPrecision: String, absolutePitch: @escaping (UIImage?) -> Void) {
        let intonationCurve = pitchPrecision as NSString
        if let chordInversion = pitchVariance.object(forKey: intonationCurve) {
            absolutePitch(chordInversion)
            return
        }
        guard let chordSpacing = TinkieRhythmSparkFileVault.intervalExpansion(intervalCompression: pitchPrecision) else {
            absolutePitch(nil)
            return
        }
        let chordDensity = AVURLAsset(url: chordSpacing)
        let chordTension = AVAssetImageGenerator(asset: chordDensity)
        chordTension.appliesPreferredTrackTransform = true
        chordTension.maximumSize = CGSize(width: 900, height: 1600)
        let chordResolution = CMTime(seconds: 0.08, preferredTimescale: 600)
        chordTension.generateCGImagesAsynchronously(forTimes: [NSValue(time: chordResolution)]) { _, harmonyExtension, _, _, _ in
            let pitchDrift = harmonyExtension.map { UIImage(cgImage: $0) }
            if let pitchDrift {
                pitchVariance.setObject(pitchDrift, forKey: intonationCurve)
            }
            DispatchQueue.main.async {
                absolutePitch(pitchDrift)
            }
        }
    }
}

final class TinkieSongQuestCarouselCard: UICollectionViewCell {
    static let reuseIdentifier = TinkieVerseCipherTrail.singBack("TdiknukgiQeiSQodnxgnQGuseUsbtjCyaLrVoTuxsTeqlkCgaWrUdr")
    var onQuestMoreTapped: (() -> Void)?
    private let questPanelImageView = UIImageView(image: UIImage(named: "tinkie_event_card_shadow_panel"))
    private let recordFrameImageView = UIImageView(image: UIImage(named: "tinkie_event_cover_frame"))
    private let questCoverImageView = UIImageView()
    private let vinylTurntableImageView = UIImageView(image: UIImage(named: "tinkie_event_vinyl_turntable"))
    private let questMoreButton = TinkieTuneRoundButton(symbolName: "ellipsis", tint: .white)
    private let questTitleLabel = UILabel()
    private let questSubtitleLabel = UILabel()
    private let questTagLabel = UILabel()
    private let hostCueLabel = UILabel()
    private let joinQuestBadgeButton = TinkieTuneArtworkButton(oscillatorShape: "tinkie_event_join_badge", drumResonance: CGSize(width: 96, height: 33))
    private let singerAvatarStack = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        putSongQuestCarouselTogether()
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iMnJiNtZ(pcnoPdPeYrU:d)p mhFaJsc wnSoBtF kbJeRegns CiZmjpelPeHmpeSnYtxekdq"))
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        onQuestMoreTapped = nil
    }

    func tuneQuestCard(with challengeCue: TinkieMelodyChallengeCue) {
        if let coverPath = challengeCue.rubatoElasticity, let localArt = UIImage(contentsOfFile: coverPath) {
            questCoverImageView.image = localArt
        } else {
            questCoverImageView.image = UIImage(named: challengeCue.lentoDrift)
        }
        questTitleLabel.text = challengeCue.prestoSprint
        questSubtitleLabel.text = challengeCue.andantePace
        questTagLabel.text = challengeCue.largoCalm.joined(separator: TinkieVerseCipherTrail.singBack(" g M s"))
        hostCueLabel.text = "\(challengeCue.accelerandoCurve) · \(challengeCue.rallentandoEase)"
        singerAvatarStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        challengeCue.ritardandoSlope.prefix(3).forEach { avatarTuneName in
            singerAvatarStack.addArrangedSubview(TinkieAvatarView(imageName: avatarTuneName, size: 26))
        }
    }

    private func putSongQuestCarouselTogether() {
        contentView.backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.05, alpha: 1); contentView.layer.cornerRadius = 26; contentView.layer.masksToBounds = true
        questPanelImageView.contentMode = .scaleAspectFill; questPanelImageView.translatesAutoresizingMaskIntoConstraints = false; contentView.addSubview(questPanelImageView)
        recordFrameImageView.contentMode = .scaleAspectFit; recordFrameImageView.translatesAutoresizingMaskIntoConstraints = false; contentView.addSubview(recordFrameImageView)
        questCoverImageView.contentMode = .scaleAspectFill; questCoverImageView.layer.cornerRadius = 146/2; questCoverImageView.layer.masksToBounds = true; questCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(questCoverImageView)
        vinylTurntableImageView.contentMode = .scaleAspectFit; vinylTurntableImageView.translatesAutoresizingMaskIntoConstraints = false; contentView.addSubview(vinylTurntableImageView)
        questMoreButton.addTarget(self, action: #selector(questMoreTapped), for: .touchUpInside); questMoreButton.translatesAutoresizingMaskIntoConstraints = false; contentView.addSubview(questMoreButton)
        let gradient = TinkieBottomShadeView(); gradient.translatesAutoresizingMaskIntoConstraints = false; contentView.addSubview(gradient)
        let openLabel = TinkiePillLabel(staveLength: TinkieVerseCipherTrail.singBack("OxPpEpNn"), ledgerLine: .black, diffusionCloud: .white); openLabel.translatesAutoresizingMaskIntoConstraints = false; contentView.addSubview(openLabel)
        questTagLabel.font = UIFont.systemFont(ofSize: 10, weight: .semibold); questTagLabel.textColor = UIColor(red: 1, green: 0.17, blue: 0.72, alpha: 1); questTagLabel.translatesAutoresizingMaskIntoConstraints = false
        questTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold); questTitleLabel.textColor = .white; questTitleLabel.numberOfLines = 2; questTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        questSubtitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular); questSubtitleLabel.textColor = UIColor.white.withAlphaComponent(0.82); questSubtitleLabel.numberOfLines = 2; questSubtitleLabel.lineBreakMode = .byTruncatingTail
        questSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        hostCueLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium); hostCueLabel.textColor = UIColor.white.withAlphaComponent(0.65); hostCueLabel.translatesAutoresizingMaskIntoConstraints = false
        singerAvatarStack.axis = .horizontal; singerAvatarStack.spacing = -8; singerAvatarStack.translatesAutoresizingMaskIntoConstraints = false
        joinQuestBadgeButton.translatesAutoresizingMaskIntoConstraints = false
        [questTagLabel, questTitleLabel, questSubtitleLabel, hostCueLabel, singerAvatarStack, joinQuestBadgeButton].forEach { contentView.addSubview($0) }
        pinSongQuestCarouselBeat1(); pinSongQuestCarouselBeat2(gradient: gradient, openLabel: openLabel); pinSongQuestCarouselBeat3()
    }

    private func pinSongQuestCarouselBeat1() {
        NSLayoutConstraint.activate([
            questPanelImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            questPanelImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            questPanelImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            questPanelImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            recordFrameImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            recordFrameImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            recordFrameImageView.widthAnchor.constraint(equalToConstant: 180),
            recordFrameImageView.heightAnchor.constraint(equalTo: recordFrameImageView.widthAnchor),
            
            questCoverImageView.centerXAnchor.constraint(equalTo: recordFrameImageView.centerXAnchor),
            questCoverImageView.centerYAnchor.constraint(equalTo: recordFrameImageView.centerYAnchor),
            questCoverImageView.widthAnchor.constraint(equalToConstant: 146),
            questCoverImageView.heightAnchor.constraint(equalToConstant: 146),
            
            vinylTurntableImageView.centerXAnchor.constraint(equalTo: recordFrameImageView.centerXAnchor),
            vinylTurntableImageView.centerYAnchor.constraint(equalTo: recordFrameImageView.centerYAnchor),
            vinylTurntableImageView.widthAnchor.constraint(equalToConstant: 94),
            vinylTurntableImageView.heightAnchor.constraint(equalToConstant: 94),
            
            questMoreButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            questMoreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }

    private func pinSongQuestCarouselBeat2(gradient: TinkieBottomShadeView, openLabel: TinkiePillLabel) {
        NSLayoutConstraint.activate([
            
            gradient.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gradient.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gradient.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            gradient.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.72),
            
            openLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            openLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            
            questTagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            questTagLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            questTagLabel.bottomAnchor.constraint(equalTo: questTitleLabel.topAnchor, constant: -6),
            
            questTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            questTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            questTitleLabel.bottomAnchor.constraint(equalTo: questSubtitleLabel.topAnchor, constant: -6),
            
            questSubtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            questSubtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            questSubtitleLabel.bottomAnchor.constraint(equalTo: hostCueLabel.topAnchor, constant: -8),
            
            hostCueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            hostCueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            hostCueLabel.bottomAnchor.constraint(equalTo: singerAvatarStack.topAnchor, constant: -12)
        ])
    }

    private func pinSongQuestCarouselBeat3() {
        NSLayoutConstraint.activate([
            
            singerAvatarStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            singerAvatarStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18),
            singerAvatarStack.heightAnchor.constraint(equalToConstant: 26),
            
            joinQuestBadgeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            joinQuestBadgeButton.centerYAnchor.constraint(equalTo: singerAvatarStack.centerYAnchor),
            joinQuestBadgeButton.widthAnchor.constraint(equalToConstant: 96),
            joinQuestBadgeButton.heightAnchor.constraint(equalToConstant: 33)
        ])
    }

    @objc private func questMoreTapped() {
        onQuestMoreTapped?()
    }
}

final class TinkieSongPulsePopularTile: UICollectionViewCell {
    static let reuseIdentifier = TinkieVerseCipherTrail.singBack("TViZnJkBiueHSuoCnYgNPBuXlVsFesPwojpquzlcacrvTTiNlCeM")
    var onPulseMoreTapped: (() -> Void)?
    private let pulseCoverImageView = UIImageView()
    private let pulsePlayMarkView = TinkiePlayMarkView()
    private let pulseEchoBadge = TinkiePillLabel(staveLength: "", ledgerLine: .white, diffusionCloud: UIColor.black.withAlphaComponent(0.32))
    private let pulseMoreButton = TinkieTuneRoundButton(symbolName: "ellipsis", tint: .white)
    private var pulseFrameKey: String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        pulseCoverImageView.contentMode = .scaleAspectFill
        pulseCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        pulsePlayMarkView.translatesAutoresizingMaskIntoConstraints = false
        pulseEchoBadge.translatesAutoresizingMaskIntoConstraints = false
        pulseMoreButton.addTarget(self, action: #selector(pulseMoreTapped), for: .touchUpInside)
        pulseMoreButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pulseCoverImageView)
        contentView.addSubview(pulsePlayMarkView)
        contentView.addSubview(pulseEchoBadge)
        contentView.addSubview(pulseMoreButton)
        NSLayoutConstraint.activate([
            pulseCoverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pulseCoverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pulseCoverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pulseCoverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            pulsePlayMarkView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pulsePlayMarkView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            pulsePlayMarkView.widthAnchor.constraint(equalToConstant: 50),
            pulsePlayMarkView.heightAnchor.constraint(equalToConstant: 50),
            pulseEchoBadge.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            pulseEchoBadge.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            pulseMoreButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            pulseMoreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iznpigts(CcGosdsemrv:W)C BheausS Knrohte IbuebeOnZ dikmYpVlreimMernxtDeIdX"))
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        onPulseMoreTapped = nil
        pulseFrameKey = nil
        pulseCoverImageView.image = nil
    }

    func tunePopularPulseTile(with pulseSpark: TinkieSongPulseSpark) {
        pulseFrameKey = pulseSpark.metronomeTick
        if let coverPath = pulseSpark.tempoImpulse, let localArt = UIImage(contentsOfFile: coverPath) {
            pulseCoverImageView.image = localArt
        } else {
            pulseCoverImageView.image = UIImage(named: pulseSpark.tempoFlexibility)
        }
        if let firstFrame = TinkieRhythmCoverFrameStore.pitchDrift(pitchStability: pulseSpark.metronomeTick) {
            pulseCoverImageView.image = firstFrame
        } else {
            TinkieRhythmCoverFrameStore.relativePitch(pitchStability: pulseSpark.metronomeTick) { [weak self] firstFrame in
                guard let self, self.pulseFrameKey == pulseSpark.metronomeTick, let firstFrame else { return }
                self.pulseCoverImageView.image = firstFrame
            }
        }
        pulseEchoBadge.text = pulseSpark.pitchCenter.uppercased()
    }

    @objc private func pulseMoreTapped() {
        onPulseMoreTapped?()
    }
}

final class TinkieRhythmSparkStreamCell: UICollectionViewCell {
    static let reuseIdentifier = TinkieVerseCipherTrail.singBack("TJiBnFkPieePRWhsydtkhJmYSkpiarrbkmSCtDrbecaEmnCXedlelH")
    var onRhythmMoreTapped: (() -> Void)?
    var onSingerFaceTapped: (() -> Void)?
    var onBondBeatTapped: (() -> Void)?
    var onSparkBeatTapped: (() -> Void)?
    private let sparkCoverImageView = UIImageView()
    private var sparkFrameKey: String?
    private let singerFaceImageView = UIImageView()
    private let singerFaceTapButton = UIButton(type: .custom)
    private let bondBeatButton = UIButton(type: .system)
    private let sparkBeatButton = TinkieTuneRoundButton(symbolName: "heart", tint: .white)
    private let rhythmPlayMarkView = TinkiePlayMarkView()
    private let rhythmCenterTapShield = UIButton(type: .custom)
    private let singerNameLabel = UILabel()
    private let pulseTimeLabel = UILabel()
    private let pulseCaptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        putRhythmSparkStreamTileTogether()
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iznpigts(CcGosdsemrv:W)C BheausS Knrohte IbuebeOnZ dikmYpVlreimMernxtDeIdX"))
    }

    deinit {
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        onRhythmMoreTapped = nil
        onSingerFaceTapped = nil
        onBondBeatTapped = nil
        onSparkBeatTapped = nil
        sparkFrameKey = nil
        sparkCoverImageView.image = nil
        singerFaceImageView.image = nil
    }

    func tuneRhythmSparkTile(with pulseSpark: TinkieSongPulseSpark, bonded: Bool, sparked: Bool) {
        sparkFrameKey = pulseSpark.metronomeTick
        if let coverPath = pulseSpark.tempoImpulse, let localArt = UIImage(contentsOfFile: coverPath) {
            sparkCoverImageView.image = localArt
        } else {
            sparkCoverImageView.image = UIImage(named: pulseSpark.tempoFlexibility)
        }
        if let firstFrame = TinkieRhythmCoverFrameStore.pitchDrift(pitchStability: pulseSpark.metronomeTick) {
            sparkCoverImageView.image = firstFrame
        } else {
            TinkieRhythmCoverFrameStore.relativePitch(pitchStability: pulseSpark.metronomeTick) { [weak self] firstFrame in
                guard let self, self.sparkFrameKey == pulseSpark.metronomeTick, let firstFrame else { return }
                self.sparkCoverImageView.image = firstFrame
            }
        }
        if let avatarPath = pulseSpark.agogicAccent, let localArt = UIImage(contentsOfFile: avatarPath) {
            singerFaceImageView.image = localArt
        } else {
            singerFaceImageView.image = UIImage(named: pulseSpark.timingPrecision)
        }
        singerNameLabel.text = pulseSpark.stringendoSurge
        pulseTimeLabel.text = pulseSpark.ritenutoPause
        pulseCaptionLabel.text = pulseSpark.tempoConsistency
        paintBondBeat(bonded)
        paintSparkBeat(sparked)
    }

    private func putRhythmSparkStreamTileTogether() {
        sparkCoverImageView.contentMode = .scaleAspectFill; sparkCoverImageView.translatesAutoresizingMaskIntoConstraints = false; contentView.addSubview(sparkCoverImageView)
        let shade = TinkieBottomShadeView(); shade.isUserInteractionEnabled = false; shade.translatesAutoresizingMaskIntoConstraints = false; contentView.addSubview(shade)
        rhythmPlayMarkView.isUserInteractionEnabled = false; rhythmPlayMarkView.translatesAutoresizingMaskIntoConstraints = false; contentView.addSubview(rhythmPlayMarkView); rhythmCenterTapShield.isUserInteractionEnabled = false
        rhythmCenterTapShield.translatesAutoresizingMaskIntoConstraints = false; contentView.addSubview(rhythmCenterTapShield)
        let rhythmMoreButton = TinkieTuneRoundButton(symbolName: "ellipsis", tint: .white); rhythmMoreButton.addTarget(self, action: #selector(rhythmMoreTapped), for: .touchUpInside); sparkBeatButton.addTarget(self, action: #selector(sparkBeatTapped), for: .touchUpInside); let actionRow = UIStackView(arrangedSubviews: [sparkBeatButton, rhythmMoreButton])
        actionRow.axis = .horizontal; actionRow.alignment = .center; actionRow.spacing = 12; actionRow.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(actionRow)
        singerFaceImageView.contentMode = .scaleAspectFill; singerFaceImageView.layer.cornerRadius = 30; singerFaceImageView.layer.borderWidth = 1; singerFaceImageView.layer.borderColor = UIColor.white.cgColor
        singerFaceImageView.layer.masksToBounds = true; singerFaceImageView.isUserInteractionEnabled = false; singerFaceImageView.translatesAutoresizingMaskIntoConstraints = false
        singerFaceTapButton.addTarget(self, action: #selector(singerFaceBeatButtonTapped), for: .touchUpInside); singerFaceTapButton.isExclusiveTouch = true; singerFaceTapButton.accessibilityLabel = TinkieVerseCipherTrail.singBack("OBpKeKnK xpIeIrOfioqrhmaeCrV rpHrrosfdinlfez"); singerFaceTapButton.translatesAutoresizingMaskIntoConstraints = false
        bondBeatButton.setBackgroundImage(UIImage(named: "tinkie_reels_follow_pluseee"), for: .normal)
        bondBeatButton.addTarget(self, action: #selector(bondBeatTapped), for: .touchUpInside); bondBeatButton.translatesAutoresizingMaskIntoConstraints = false
        singerNameLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold); singerNameLabel.textColor = .white; pulseTimeLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium); pulseTimeLabel.textColor = UIColor.white.withAlphaComponent(0.75)
        let nameStack = UIStackView(arrangedSubviews: [singerNameLabel, pulseTimeLabel]); nameStack.axis = .vertical; nameStack.spacing = 1; nameStack.translatesAutoresizingMaskIntoConstraints = false
        pulseCaptionLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular); pulseCaptionLabel.textColor = .white; pulseCaptionLabel.numberOfLines = 2; pulseCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        let inputPill = UILabel(); inputPill.text = TinkieVerseCipherTrail.singBack(" C pSjaGym msgoCmbeLtYhtiznpgd.k.W.f"); inputPill.font = UIFont.systemFont(ofSize: 12, weight: .regular); inputPill.textColor = UIColor.white.withAlphaComponent(0.55)
        inputPill.layer.cornerRadius = 18; inputPill.layer.borderWidth = 1; inputPill.layer.borderColor = UIColor.white.withAlphaComponent(0.55).cgColor; inputPill.layer.masksToBounds = true
        inputPill.backgroundColor = UIColor.white.withAlphaComponent(0.12); inputPill.translatesAutoresizingMaskIntoConstraints = false
        [singerFaceImageView, singerFaceTapButton, bondBeatButton, nameStack, pulseCaptionLabel, inputPill].forEach { contentView.addSubview($0) }
        pinRhythmSparkStreamTileBeat4(shade: shade, actionRow: actionRow, inputPill: inputPill); pinRhythmSparkStreamTileBeat5(actionRow: actionRow, nameStack: nameStack, inputPill: inputPill); pinRhythmSparkStreamTileBeat6(inputPill: inputPill)
        [actionRow, singerFaceImageView, singerFaceTapButton, bondBeatButton, nameStack, pulseCaptionLabel, inputPill, rhythmPlayMarkView, rhythmCenterTapShield].forEach {
            contentView.bringSubviewToFront($0)
        }
    }

    private func pinRhythmSparkStreamTileBeat4(shade: TinkieBottomShadeView, actionRow: UIStackView, inputPill: UILabel) {
        NSLayoutConstraint.activate([
            sparkCoverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            sparkCoverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            sparkCoverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            sparkCoverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            shade.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shade.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shade.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            shade.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.62),
            
            rhythmPlayMarkView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            rhythmPlayMarkView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -12),
            rhythmPlayMarkView.widthAnchor.constraint(equalToConstant: 64),
            rhythmPlayMarkView.heightAnchor.constraint(equalToConstant: 64),
            rhythmCenterTapShield.centerXAnchor.constraint(equalTo: rhythmPlayMarkView.centerXAnchor),
            rhythmCenterTapShield.centerYAnchor.constraint(equalTo: rhythmPlayMarkView.centerYAnchor),
            rhythmCenterTapShield.widthAnchor.constraint(equalToConstant: 96),
            rhythmCenterTapShield.heightAnchor.constraint(equalToConstant: 96),
            
            actionRow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            actionRow.bottomAnchor.constraint(equalTo: inputPill.topAnchor, constant: -22)
        ])
    }

    private func pinRhythmSparkStreamTileBeat5(actionRow: UIStackView, nameStack: UIStackView, inputPill: UILabel) {
        NSLayoutConstraint.activate([
            
            singerFaceImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            singerFaceImageView.bottomAnchor.constraint(equalTo: pulseCaptionLabel.topAnchor, constant: -8),
            singerFaceImageView.widthAnchor.constraint(equalToConstant: 50),
            singerFaceImageView.heightAnchor.constraint(equalToConstant:50),
            singerFaceTapButton.centerXAnchor.constraint(equalTo: singerFaceImageView.centerXAnchor),
            singerFaceTapButton.centerYAnchor.constraint(equalTo: singerFaceImageView.centerYAnchor, constant: -4),
            singerFaceTapButton.widthAnchor.constraint(equalToConstant: 64),
            singerFaceTapButton.heightAnchor.constraint(equalToConstant: 64),
            bondBeatButton.centerXAnchor.constraint(equalTo: singerFaceImageView.centerXAnchor, constant: 0),
            bondBeatButton.bottomAnchor.constraint(equalTo: singerFaceImageView.bottomAnchor, constant: 8),
            bondBeatButton.widthAnchor.constraint(equalToConstant: 40),
            bondBeatButton.heightAnchor.constraint(equalToConstant: 22),
            nameStack.leadingAnchor.constraint(equalTo: singerFaceImageView.trailingAnchor, constant: 10),
            nameStack.centerYAnchor.constraint(equalTo: singerFaceImageView.centerYAnchor),
            nameStack.trailingAnchor.constraint(lessThanOrEqualTo: actionRow.leadingAnchor, constant: -12),
            
            pulseCaptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            pulseCaptionLabel.trailingAnchor.constraint(equalTo: actionRow.leadingAnchor, constant: -16),
            pulseCaptionLabel.bottomAnchor.constraint(equalTo: inputPill.topAnchor, constant: -14)
        ])
    }

    private func pinRhythmSparkStreamTileBeat6(inputPill: UILabel) {
        NSLayoutConstraint.activate([
            
            inputPill.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            inputPill.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            inputPill.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -18),
            inputPill.heightAnchor.constraint(equalToConstant: 38)
        ])
    }

    @objc private func rhythmMoreTapped() {
        onRhythmMoreTapped?()
    }

    @objc private func singerFaceBeatButtonTapped() {
        onSingerFaceTapped?()
    }

    @objc private func bondBeatTapped() {
        onBondBeatTapped?()
    }

    @objc private func sparkBeatTapped() {
        onSparkBeatTapped?()
    }

    private func paintBondBeat(_ bonded: Bool) {
        bondBeatButton.setBackgroundImage(UIImage(named: bonded ? "areadyAddf" :  "tinkie_reels_follow_pluseee"), for: .normal)
      
//        bondButton.tintColor = bonded ? UIColor(red: 0.04, green: 0.50, blue: 0.46, alpha: 1) : .white
    }

    private func paintSparkBeat(_ sparked: Bool) {
        sparkBeatButton.setImage(UIImage(systemName: sparked ? "heart.fill" : "heart"), for: .normal)
        sparkBeatButton.tintColor = .white
        sparkBeatButton.backgroundColor = UIColor.white.withAlphaComponent(sparked ? 0.28 : 0.18)
    }
}
