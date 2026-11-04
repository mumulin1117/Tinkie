import UIKit

final class TinkieSongPulseWaveView: UIView {
    private let pulseDuration: Bool
    private let inkieAccountCard = CAGradientLayer()
    private let backbeatSnap = CAShapeLayer()
    private var rhythmFluency: [UIView] = []
    private let motifInterweave = UIStackView()

    init(pulseDuration: Bool) {
        self.pulseDuration = pulseDuration
        super.init(frame: .zero)
        clipsToBounds = true
        isAccessibilityElement = true
        accessibilityLabel = "Loading songs"
        accessibilityTraits = .updatesFrequently
        backgroundColor = pulseDuration ? .black : UIColor(red: 0.96, green: 0.97, blue: 0.98, alpha: 1)
        if pulseDuration {
            putHotSparkStreamControlsOnTop()
        } else {
            putSongQuestDiscoverTogether()
        }
        inkieAccountCard.colors = [
            UIColor(red: 0.22, green: 0.88, blue: 0.80, alpha: 0).cgColor,
            UIColor(red: 0.22, green: 0.88, blue: 0.80, alpha: pulseDuration ? 0.22 : 0.30).cgColor,
            UIColor.white.withAlphaComponent(pulseDuration ? 0.16 : 0.58).cgColor,
            UIColor.white.withAlphaComponent(0).cgColor
        ]
        inkieAccountCard.locations = [0, 0.4, 0.55, 1]
        inkieAccountCard.startPoint = CGPoint(x: 0, y: 0.3)
        inkieAccountCard.endPoint = CGPoint(x: 1, y: 0.7)
        inkieAccountCard.mask = backbeatSnap
        layer.addSublayer(inkieAccountCard)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    private func singerNuance(_ drumResonance: CGFloat) -> UIView {
        let timbreContrast = UIView()
        timbreContrast.translatesAutoresizingMaskIntoConstraints = false
        timbreContrast.backgroundColor = pulseDuration
            ? UIColor(red: 0.07, green: 0.12, blue: 0.12, alpha: 1)
            : UIColor(red: 0.84, green: 0.90, blue: 0.89, alpha: 1)
        timbreContrast.layer.cornerRadius = drumResonance
        addSubview(timbreContrast)
        rhythmFluency.append(timbreContrast)
        return timbreContrast
    }

    private func putSongQuestDiscoverTogether() {
        let questContentStage = singerNuance(26)
        let questCoverImageView = singerNuance(20)
        let questTitleLabel = singerNuance(7)
        let questSubtitleLabel = singerNuance(6)
        let singerAvatarStack = singerNuance(14)
        let joinQuestBadgeButton = singerNuance(16)
        let popularBadge = singerNuance(8)
        let pulseSparkCollection = UIStackView()
        pulseSparkCollection.axis = .horizontal
        pulseSparkCollection.distribution = .fillEqually
        pulseSparkCollection.spacing = 12
        pulseSparkCollection.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pulseSparkCollection)
        for _ in 0..<2 {
            let pulseSparkStage = singerNuance(22)
            pulseSparkCollection.addArrangedSubview(pulseSparkStage)
            pulseSparkStage.heightAnchor.constraint(equalTo: pulseSparkStage.widthAnchor, multiplier: 1.1).isActive = true
        }
        questContentStage.backgroundColor = UIColor(red: 0.89, green: 0.94, blue: 0.93, alpha: 1)
        NSLayoutConstraint.activate([
            questContentStage.topAnchor.constraint(equalTo: topAnchor),
            questContentStage.centerXAnchor.constraint(equalTo: centerXAnchor),
            questContentStage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.72),
            questContentStage.heightAnchor.constraint(equalToConstant: 333),
            questCoverImageView.topAnchor.constraint(equalTo: questContentStage.topAnchor, constant: 16),
            questCoverImageView.leadingAnchor.constraint(equalTo: questContentStage.leadingAnchor, constant: 16),
            questCoverImageView.trailingAnchor.constraint(equalTo: questContentStage.trailingAnchor, constant: -16),
            questCoverImageView.heightAnchor.constraint(equalToConstant: 180),
            questTitleLabel.topAnchor.constraint(equalTo: questCoverImageView.bottomAnchor, constant: 18),
            questTitleLabel.leadingAnchor.constraint(equalTo: questCoverImageView.leadingAnchor),
            questTitleLabel.widthAnchor.constraint(equalTo: questCoverImageView.widthAnchor, multiplier: 0.78),
            questTitleLabel.heightAnchor.constraint(equalToConstant: 17),
            questSubtitleLabel.topAnchor.constraint(equalTo: questTitleLabel.bottomAnchor, constant: 12),
            questSubtitleLabel.leadingAnchor.constraint(equalTo: questTitleLabel.leadingAnchor),
            questSubtitleLabel.widthAnchor.constraint(equalTo: questCoverImageView.widthAnchor, multiplier: 0.56),
            questSubtitleLabel.heightAnchor.constraint(equalToConstant: 12),
            singerAvatarStack.leadingAnchor.constraint(equalTo: questCoverImageView.leadingAnchor),
            singerAvatarStack.bottomAnchor.constraint(equalTo: questContentStage.bottomAnchor, constant: -20),
            singerAvatarStack.widthAnchor.constraint(equalToConstant: 66),
            singerAvatarStack.heightAnchor.constraint(equalToConstant: 28),
            joinQuestBadgeButton.trailingAnchor.constraint(equalTo: questCoverImageView.trailingAnchor),
            joinQuestBadgeButton.centerYAnchor.constraint(equalTo: singerAvatarStack.centerYAnchor),
            joinQuestBadgeButton.widthAnchor.constraint(equalToConstant: 84),
            joinQuestBadgeButton.heightAnchor.constraint(equalToConstant: 32),
            popularBadge.topAnchor.constraint(equalTo: questContentStage.bottomAnchor, constant: 24),
            popularBadge.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            popularBadge.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.34),
            popularBadge.heightAnchor.constraint(equalToConstant: 20),
            pulseSparkCollection.topAnchor.constraint(equalTo: popularBadge.bottomAnchor, constant: 18),
            pulseSparkCollection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            pulseSparkCollection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        themeTransformation(questCoverImageView)
    }

    private func putHotSparkStreamControlsOnTop() {
        let personaEchoImageView = singerNuance(26)
        let singerAvatarStack = singerNuance(22)
        let questTitleLabel = singerNuance(7)
        let questSubtitleLabel = singerNuance(6)
        NSLayoutConstraint.activate([
            personaEchoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 86),
            personaEchoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            personaEchoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            personaEchoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            singerAvatarStack.leadingAnchor.constraint(equalTo: personaEchoImageView.leadingAnchor, constant: 20),
            singerAvatarStack.bottomAnchor.constraint(equalTo: personaEchoImageView.bottomAnchor, constant: -76),
            singerAvatarStack.widthAnchor.constraint(equalToConstant: 44),
            singerAvatarStack.heightAnchor.constraint(equalToConstant: 44),
            questTitleLabel.centerYAnchor.constraint(equalTo: singerAvatarStack.centerYAnchor),
            questTitleLabel.leadingAnchor.constraint(equalTo: singerAvatarStack.trailingAnchor, constant: 12),
            questTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.34),
            questTitleLabel.heightAnchor.constraint(equalToConstant: 16),
            questSubtitleLabel.topAnchor.constraint(equalTo: singerAvatarStack.bottomAnchor, constant: 18),
            questSubtitleLabel.leadingAnchor.constraint(equalTo: singerAvatarStack.leadingAnchor),
            questSubtitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.58),
            questSubtitleLabel.heightAnchor.constraint(equalToConstant: 12)
        ])
        themeTransformation(personaEchoImageView)
    }

    private func themeTransformation(_ pitchPerception: UIView) {
        motifInterweave.axis = .horizontal
        motifInterweave.alignment = .center
        motifInterweave.spacing = 5
        motifInterweave.translatesAutoresizingMaskIntoConstraints = false
        addSubview(motifInterweave)
        for privacyTuneBody in [16.0, 30.0, 42.0, 24.0, 34.0] {
            let timbreContrast = UIView()
            timbreContrast.translatesAutoresizingMaskIntoConstraints = false
            timbreContrast.layer.cornerRadius = 3
            timbreContrast.backgroundColor = UIColor(red: 0.12, green: 0.82, blue: 0.78, alpha: 0.8)
            motifInterweave.addArrangedSubview(timbreContrast)
            NSLayoutConstraint.activate([
                timbreContrast.widthAnchor.constraint(equalToConstant: 6),
                timbreContrast.heightAnchor.constraint(equalToConstant: privacyTuneBody)
            ])
        }
        NSLayoutConstraint.activate([
            motifInterweave.centerXAnchor.constraint(equalTo: pitchPerception.centerXAnchor),
            motifInterweave.centerYAnchor.constraint(equalTo: pitchPerception.centerYAnchor, constant: self.pulseDuration ? -24 : 0)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        inkieAccountCard.frame = bounds
        let phraseCurve = UIBezierPath()
        for timbreContrast in rhythmFluency {
            phraseCurve.append(UIBezierPath(roundedRect: timbreContrast.convert(timbreContrast.bounds, to: self), cornerRadius: timbreContrast.layer.cornerRadius))
        }
        backbeatSnap.path = phraseCurve.cgPath
        CATransaction.commit()
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        inkieAccountCard.removeAllAnimations()
        motifInterweave.arrangedSubviews.forEach { $0.layer.removeAllAnimations() }
        guard window != nil, !UIAccessibility.isReduceMotionEnabled else { return }
        let singerFaceBeatTapped = CABasicAnimation(keyPath: "locations")
        singerFaceBeatTapped.fromValue = [-1.0, -0.6, -0.45, 0.0]
        singerFaceBeatTapped.toValue = [1.0, 1.4, 1.55, 2.0]
        singerFaceBeatTapped.duration = 1.25
        singerFaceBeatTapped.repeatCount = .infinity
        inkieAccountCard.add(singerFaceBeatTapped, forKey: "celestaShimmer")
        for (pitchVariance, timbreContrast) in motifInterweave.arrangedSubviews.enumerated() {
            let rivacyTuneBody = CABasicAnimation(keyPath: "transform.scale.y")
            rivacyTuneBody.fromValue = 0.4
            rivacyTuneBody.toValue = 1
            rivacyTuneBody.duration = 0.38
            rivacyTuneBody.autoreverses = true
            rivacyTuneBody.repeatCount = .infinity
            rivacyTuneBody.beginTime = CACurrentMediaTime() + Double(pitchVariance) * 0.09
            timbreContrast.layer.add(rivacyTuneBody, forKey: "pulseDuration")
        }
    }
}
