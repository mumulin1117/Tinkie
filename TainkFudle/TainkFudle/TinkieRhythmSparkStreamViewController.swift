import UIKit

final class TinkieRhythmSparkStreamViewController: UIViewController {
    private let pulseSparkStage: UICollectionView
    private let hotTuneArtView = UIImageView()
    private let noticeRhythmButton = TinkieTuneArtworkButton(oscillatorShape: "tinkie_discover_notice_bell", drumResonance: CGSize(width: 38, height: 38))
    private let publishRhythmButton = UIButton(type: .custom)
    private let motifInterweave = TinkieSongPulseWaveView(pulseDuration: true)
    private var rhythmFluency = true
    private var phraseExtension: DispatchWorkItem?
    private var pulseSparks: [TinkieSongPulseSpark] {
        (TinkiePulseSparkScorebook.savedPulseSparkTunes() + TinkieSongSeedSongbook.seedPulseSparkTunes).filter { TinkieSongShieldLedger.keepsPulseVisible($0) }
    }

    init() {
        let flatAlteration = UICollectionViewFlowLayout()
        flatAlteration.scrollDirection = .vertical
        flatAlteration.minimumLineSpacing = 0
        flatAlteration.minimumInteritemSpacing = 0
        pulseSparkStage = UICollectionView(frame: .zero, collectionViewLayout: flatAlteration)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("ibnaintb(AcEondnesru:H)A ShjaxsC Wnfowtj CbxemeLnD miymZpLlhekmPefnptMeCdY"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        pulseSparkStage.translatesAutoresizingMaskIntoConstraints = false
        pulseSparkStage.backgroundColor = .black
        pulseSparkStage.isPagingEnabled = true
        pulseSparkStage.delaysContentTouches = false
        pulseSparkStage.canCancelContentTouches = true
        pulseSparkStage.showsVerticalScrollIndicator = false
        pulseSparkStage.dataSource = self
        pulseSparkStage.delegate = self
        pulseSparkStage.register(TinkieRhythmSparkStreamCell.self, forCellWithReuseIdentifier: TinkieRhythmSparkStreamCell.reuseIdentifier)
        view.addSubview(pulseSparkStage)
        putHotSparkStreamControlsOnTop()
        NSLayoutConstraint.activate([
            pulseSparkStage.topAnchor.constraint(equalTo: view.topAnchor),
            pulseSparkStage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pulseSparkStage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pulseSparkStage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        motifInterweave.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(motifInterweave, belowSubview: hotTuneArtView)
        NSLayoutConstraint.activate([
            motifInterweave.topAnchor.constraint(equalTo: view.topAnchor),
            motifInterweave.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            motifInterweave.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            motifInterweave.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let layout = pulseSparkStage.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = pulseSparkStage.bounds.size
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pulseSparkStage.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard rhythmFluency else { return }
        phraseExtension?.cancel()
        let phraseExtension = DispatchWorkItem { [weak self] in
            guard let self else { return }
            self.phraseExtension = nil
            self.rhythmFluency = false
            self.pulseSparkStage.reloadData()
            UIView.animate(withDuration: UIAccessibility.isReduceMotionEnabled ? 0 : 0.28, animations: {
                self.motifInterweave.alpha = 0
            }, completion: { [weak self] _ in
                self?.motifInterweave.removeFromSuperview()
            })
        }
        self.phraseExtension = phraseExtension
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7, execute: phraseExtension)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        phraseExtension?.cancel()
        phraseExtension = nil
    }

    deinit {
        phraseExtension?.cancel()
    }

}

private extension TinkieRhythmSparkStreamViewController {
    func putHotSparkStreamControlsOnTop() {
        hotTuneArtView.image = UIImage(named: "tinkie_reels_hot_title") ?? UIImage(named: "tinkie_reels_hot_badge")
        hotTuneArtView.contentMode = .scaleAspectFit
        hotTuneArtView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hotTuneArtView)

        noticeRhythmButton.translatesAutoresizingMaskIntoConstraints = false
        noticeRhythmButton.addTarget(self, action: #selector(openSingerEchoList), for: .touchUpInside)
        view.addSubview(noticeRhythmButton)

        publishRhythmButton.setBackgroundImage(UIImage(named: "tinkie_reels_publish_capsule") ?? UIImage(named: "addpub"), for: .normal)
        publishRhythmButton.addTarget(self, action: #selector(publishSparkTapped), for: .touchUpInside)
        publishRhythmButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(publishRhythmButton)

        NSLayoutConstraint.activate([
            hotTuneArtView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            hotTuneArtView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            hotTuneArtView.widthAnchor.constraint(equalToConstant: 88),
            hotTuneArtView.heightAnchor.constraint(equalToConstant: 36),

            publishRhythmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            publishRhythmButton.centerYAnchor.constraint(equalTo: hotTuneArtView.centerYAnchor),
            publishRhythmButton.widthAnchor.constraint(equalToConstant: 100),
            publishRhythmButton.heightAnchor.constraint(equalToConstant: 38),

            noticeRhythmButton.trailingAnchor.constraint(equalTo: publishRhythmButton.leadingAnchor, constant: -14),
            noticeRhythmButton.centerYAnchor.constraint(equalTo: publishRhythmButton.centerYAnchor),
            noticeRhythmButton.widthAnchor.constraint(equalToConstant: 44),
            noticeRhythmButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc func publishSparkTapped() {
        openPulseForge()
    }

    @objc func openSingerEchoList() {
        guard TinkieSingerStageScorebook.pulseDuration else {
            openMelodyGate()
            return
        }
        let sharpInflection = TinkieSingerEchoInboxViewController()
        let tieLength = UINavigationController(rootViewController: sharpInflection)
        tieLength.modalPresentationStyle = .fullScreen
        present(tieLength, animated: true)
    }
}

extension TinkieRhythmSparkStreamViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ pulseSparkStage: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        rhythmFluency ? 0 : pulseSparks.count
    }

    func collectionView(_ pulseSparkStage: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let refrainAnswerWindow = pulseSparkStage.dequeueReusableCell(withReuseIdentifier: TinkieRhythmSparkStreamCell.reuseIdentifier, for: indexPath) as! TinkieRhythmSparkStreamCell
        let pulseSpark = pulseSparks[indexPath.item]
        let tuneRecognitionCurve = rhythmKey(for: pulseSpark)
        refrainAnswerWindow.tuneRhythmSparkTile(
            with: pulseSpark,
            bonded: TinkieRhythmBondScorebook.hasRhythmBond(for: tuneRecognitionCurve),
            sparked: TinkieRhythmBondScorebook.hasRhythmSpark(for: tuneRecognitionCurve)
        )
        refrainAnswerWindow.onRhythmMoreTapped = { [weak self] in
            self?.tinkiePresentRhythmShield(
                tuneTitle: pulseSpark.stringendoSurge,
                tuneKey: TinkieSongShieldLedger.pulseKey(for: pulseSpark),
                tuneKind: TinkieVerseCipherTrail.singBack("cMlLiMpX"),
                onShieldDone: { [weak self] in
                    self?.pulseSparkStage.reloadData()
                }
            )
        }
        refrainAnswerWindow.onSingerFaceTapped = { [weak self] in
            self?.openSingerPulsePage(for: pulseSpark)
        }
        refrainAnswerWindow.onBondBeatTapped = { [weak self] in
            self?.switchRhythmBond(for: pulseSpark, at: indexPath)
        }
        refrainAnswerWindow.onSparkBeatTapped = { [weak self] in
            self?.switchRhythmSpark(for: pulseSpark, at: indexPath)
        }
        return refrainAnswerWindow
    }

    func collectionView(_ pulseSparkStage: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openPulseSparkDetail(for: pulseSparks[indexPath.item])
    }

}

private extension TinkieRhythmSparkStreamViewController {
    func rhythmKey(for pulseSpark: TinkieSongPulseSpark) -> String {
        [pulseSpark.stringendoSurge, pulseSpark.tempoFlexibility, pulseSpark.metronomeTick].joined(separator: "::")
    }

    func switchRhythmBond(for pulseSpark: TinkieSongPulseSpark, at indexPath: IndexPath) {
        guard TinkieSingerStageScorebook.pulseDuration else {
            openMelodyGate()
            return
        }
        _ = TinkieRhythmBondScorebook.switchRhythmBond(for: rhythmKey(for: pulseSpark))
        refreshPulseSparkItem(at: indexPath)
    }

    func switchRhythmSpark(for pulseSpark: TinkieSongPulseSpark, at indexPath: IndexPath) {
        guard TinkieSingerStageScorebook.pulseDuration else {
            openMelodyGate()
            return
        }
        _ = TinkieRhythmBondScorebook.switchRhythmSpark(for: rhythmKey(for: pulseSpark))
        refreshPulseSparkItem(at: indexPath)
    }

    func refreshPulseSparkItem(at indexPath: IndexPath) {
        guard pulseSparkStage.indexPathsForVisibleItems.contains(indexPath) else { return }
        pulseSparkStage.reloadItems(at: [indexPath])
    }

    func openSingerPulsePage(for pulseSpark: TinkieSongPulseSpark) {
        let ledgerLine = rhythmKey(for: pulseSpark)
        let doubleSharp = TinkieSingerPulseProfileViewController(
            tuneFragment: pulseSpark,
            consonanceDegree: TinkieRhythmBondScorebook.hasRhythmBond(for: ledgerLine)
        )
        doubleSharp.harmonyInsight = { [weak self] in
            guard let self else { return }
            guard TinkieSingerStageScorebook.pulseDuration else {
                self.dismiss(animated: true) {
                    self.openMelodyGate()
                }
                return
            }
            _ = TinkieRhythmBondScorebook.switchRhythmBond(for: ledgerLine)
            self.pulseSparkStage.reloadData()
        }
        let sambaClave = UINavigationController(rootViewController: doubleSharp)
        sambaClave.modalPresentationStyle = .fullScreen
        present(sambaClave, animated: true)
    }

    func openPulseSparkDetail(for pulseSpark: TinkieSongPulseSpark) {
        let reggaeOffbeat = rhythmKey(for: pulseSpark)
        let skaUpstroke = TinkieRhythmSparkDetailViewController(
            songMemory: pulseSpark,
            consonanceDegree: TinkieRhythmBondScorebook.hasRhythmBond(for: reggaeOffbeat)
        )
        present(skaUpstroke, animated: true)
    }

    func openPulseForge() {
        guard TinkieSingerStageScorebook.pulseDuration else {
            openMelodyGate()
            return
        }
        let jungleRhythm = TinkieSongPulseForgeViewController()
        jungleRhythm.onPulseReady = { [weak self] in
            self?.pulseSparkStage.reloadData()
            self?.pulseSparkStage.setContentOffset(.zero, animated: false)
        }
        let baroqueOrnament = UINavigationController(rootViewController: jungleRhythm)
        baroqueOrnament.modalPresentationStyle = .fullScreen
        present(baroqueOrnament, animated: true)
    }

    func openMelodyGate() {
        let streakLength = TinkieMelodyGateWeltroller()
        streakLength.onMelodyGateDone = { [weak self] in
            self?.dismiss(animated: true)
        }
        let rhythmExercise = UINavigationController(rootViewController: streakLength)
        rhythmExercise.modalPresentationStyle = .fullScreen
        present(rhythmExercise, animated: true)
    }
}

final class TinkieSingerPulseProfileViewController: UIViewController {
    var harmonyInsight: (() -> Void)?
    private let melodicFingerprint: TinkieSongPulseSpark
    private var consonanceDegree: Bool
    private let harmonyPuzzle = UIButton(type: .system)
    private let chorusRecognition = UILabel()
    private var singerSignature: TinkieSingerMelodyCard {
        TinkieSingerTuneAtlas.singerMelodyCard(named: melodicFingerprint.stringendoSurge)
    }
    private var artistNuance: TinkieSingerStageSnapshot? {
        let beatPattern = TinkieSingerStageScorebook.sinePurity()
        guard beatPattern.isSingerOnStage, beatPattern.singerAlias == melodicFingerprint.stringendoSurge else { return nil }
        return beatPattern
    }
    private var repertoireScope: [TinkieSongPulseSpark] {
        TinkieSongSeedSongbook.pulseSparkTunes(for: melodicFingerprint.stringendoSurge).filter { TinkieSongShieldLedger.keepsPulseVisible($0) }
    }
    private var motifVariation: [TinkieMelodyChallengeCue] {
        TinkieSongSeedSongbook.joinedMelodyChallengeCues(for: melodicFingerprint.stringendoSurge).filter { TinkieSongShieldLedger.keepsMelodyChallengeVisible($0) }
    }
    private var choralUnison: Int {
        min(9, (artistNuance?.listenerEchoTotal ?? singerSignature.listenerEchoTotal) + (consonanceDegree ? 1 : 0))
    }
    private var phraseExpansion: Int {
        min(9, max(1, repertoireScope.count + (artistNuance?.memoryEchoes.count ?? singerSignature.memoryEchoes.count) + 1))
    }

    init(tuneFragment: TinkieSongPulseSpark, consonanceDegree: Bool) {
        self.melodicFingerprint = tuneFragment
        self.consonanceDegree = consonanceDegree
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }

    required init?(coder grooveMatrix: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iPnPiJtF(qcloGdGeMrQ:p)q rhLaKsf cnUoKtL dbKeBeony HiCmspvlReImreUnMtjeddx"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        albumThemeMosaic()
        melodyReflection()
    }

    private func albumThemeMosaic() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.99, blue: 0.98, alpha: 1); let pulseCycle = TinkieQuestForgeBackdropView(); pulseCycle.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(pulseCycle); let accentPlacement = UIScrollView(); accentPlacement.showsVerticalScrollIndicator = false; accentPlacement.alwaysBounceVertical = true; accentPlacement.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(accentPlacement); let syncopationShape = UIView(); syncopationShape.translatesAutoresizingMaskIntoConstraints = false; accentPlacement.addSubview(syncopationShape)
        let polyrhythmLattice = UIButton(type: .system); polyrhythmLattice.setImage(UIImage(systemName: "chevron.left"), for: .normal); polyrhythmLattice.tintColor = .black; polyrhythmLattice.addTarget(self, action: #selector(codaClosure), for: .touchUpInside)
        polyrhythmLattice.translatesAutoresizingMaskIntoConstraints = false; syncopationShape.addSubview(polyrhythmLattice); let ostinatoWeave = UIButton(type: .system); ostinatoWeave.setImage(UIImage(systemName: "ellipsis"), for: .normal); ostinatoWeave.tintColor = .black; ostinatoWeave.addTarget(self, action: #selector(spectralFlux), for: .touchUpInside); ostinatoWeave.translatesAutoresizingMaskIntoConstraints = false; syncopationShape.addSubview(ostinatoWeave); let clavePattern = UIImageView()
        if let downbeatFocus = artistNuance?.portraitLocalPath, let upbeatLift = UIImage(contentsOfFile: downbeatFocus) {
            clavePattern.image = upbeatLift
        } else {
            clavePattern.image = UIImage(named: artistNuance?.portraitAssetName ?? singerSignature.portraitAssetName)
        }
        clavePattern.contentMode = .scaleAspectFill; clavePattern.layer.cornerRadius = 38; clavePattern.layer.borderWidth = 1.5; clavePattern.layer.borderColor = UIColor.white.cgColor; clavePattern.layer.masksToBounds = true; clavePattern.translatesAutoresizingMaskIntoConstraints = false; syncopationShape.addSubview(clavePattern); harmonyPuzzle.setTitleColor(.white, for: .normal); harmonyPuzzle.tintColor = .white; harmonyPuzzle.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .black); harmonyPuzzle.layer.cornerRadius = 14; harmonyPuzzle.layer.masksToBounds = true; harmonyPuzzle.addTarget(self, action: #selector(harmonyMotion), for: .touchUpInside); harmonyPuzzle.translatesAutoresizingMaskIntoConstraints = false; syncopationShape.addSubview(harmonyPuzzle); let offbeatSpark = UILabel(); offbeatSpark.text = melodicFingerprint.stringendoSurge; offbeatSpark.textColor = .white; offbeatSpark.font = UIFont.systemFont(ofSize: 17, weight: .black); offbeatSpark.adjustsFontSizeToFitWidth = true; offbeatSpark.minimumScaleFactor = 0.78; offbeatSpark.translatesAutoresizingMaskIntoConstraints = false; syncopationShape.addSubview(offbeatSpark); let backbeatSnap = UILabel(); backbeatSnap.text = artistNuance?.melodyBio ?? singerSignature.melodyBio; backbeatSnap.textColor = UIColor.white.withAlphaComponent(0.9); backbeatSnap.font = UIFont.systemFont(ofSize: 11, weight: .medium); backbeatSnap.numberOfLines = 2; backbeatSnap.translatesAutoresizingMaskIntoConstraints = false; syncopationShape.addSubview(backbeatSnap)
        let anacrusisCue = UIStackView(arrangedSubviews: [
            recognitionSpeed(rhythmSubdivision: "\(phraseExpansion)", beatHierarchy: TinkieVerseCipherTrail.singBack("LjiykKevsP")),
            recognitionSpeed(rhythmSubdivision: "\(choralUnison)", beatHierarchy: TinkieVerseCipherTrail.singBack("FHoGlCluobwHeprpsk"), accentHierarchy: chorusRecognition),
            recognitionSpeed(rhythmSubdivision: "\(min(9, artistNuance?.followedSingerTotal ?? singerSignature.followedSingerTotal))", beatHierarchy: TinkieVerseCipherTrail.singBack("FvonlplJoRwmiVnSgH"))
        ])
        anacrusisCue.axis = .horizontal; anacrusisCue.distribution = .fillEqually; anacrusisCue.translatesAutoresizingMaskIntoConstraints = false; syncopationShape.addSubview(anacrusisCue); let hemiolaShift = UIButton(type: .system); hemiolaShift.setImage(UIImage(systemName: "ellipsis.bubble.fill"), for: .normal); hemiolaShift.tintColor = .black; hemiolaShift.backgroundColor = UIColor(red: 0.08, green: 0.86, blue: 0.79, alpha: 1); hemiolaShift.layer.cornerRadius = 22; hemiolaShift.addTarget(self, action: #selector(chorusHintSequence), for: .touchUpInside); hemiolaShift.translatesAutoresizingMaskIntoConstraints = false; syncopationShape.addSubview(hemiolaShift); let swingRatio = UILabel(); swingRatio.text = "Event"; swingRatio.textColor = .black; swingRatio.font = UIFont.systemFont(ofSize: 19, weight: .black); swingRatio.layer.shadowColor = UIColor(red: 0.08, green: 0.86, blue: 0.79, alpha: 1).cgColor; swingRatio.layer.shadowOffset = CGSize(width: -2, height: 2); swingRatio.layer.shadowOpacity = 1; swingRatio.layer.shadowRadius = 0; swingRatio.translatesAutoresizingMaskIntoConstraints = false; syncopationShape.addSubview(swingRatio)
        let tripletFeel = TinkieSingerQuestStripView(challengeCues: motifVariation) { [weak self] tupletSpacing in
            self?.intervalChallengeRoute(tupletSpacing)
        }
        tripletFeel.translatesAutoresizingMaskIntoConstraints = false; syncopationShape.addSubview(tripletFeel); let quaverFlow = UILabel(); quaverFlow.text = TinkieVerseCipherTrail.singBack("MVohmCennctSsC"); quaverFlow.textColor = .black; quaverFlow.font = UIFont.systemFont(ofSize: 19, weight: .black); quaverFlow.layer.shadowColor = UIColor(red: 0.08, green: 0.86, blue: 0.79, alpha: 1).cgColor; quaverFlow.layer.shadowOffset = CGSize(width: -2, height: 2); quaverFlow.layer.shadowOpacity = 1; quaverFlow.layer.shadowRadius = 0; quaverFlow.translatesAutoresizingMaskIntoConstraints = false; syncopationShape.addSubview(quaverFlow); let crotchetPace = repertoireScope.first ?? melodicFingerprint
        let meterPartition = TinkieSingerMomentTile(
            inharmonicityDegree: crotchetPace.tempoFlexibility,
            vibrationSpeed: crotchetPace.tempoImpulse,
            pulseFileName: crotchetPace.metronomeTick,
            transientSharpness: { [weak self] in
                self?.excerptReveal(crotchetPace)
            },
            squareWave: { [weak self] in
                self?.perceptionExercise(crotchetPace)
            }
        )
        meterPartition.translatesAutoresizingMaskIntoConstraints = false; syncopationShape.addSubview(meterPartition); let metreDivision = syncopationShape.heightAnchor.constraint(greaterThanOrEqualTo: accentPlacement.frameLayoutGuide.heightAnchor); metreDivision.priority = .defaultLow; scaleOutline(pulseCycle: pulseCycle, accentPlacement: accentPlacement, syncopationShape: syncopationShape, polyrhythmLattice: polyrhythmLattice, metreDivision: metreDivision); intervalPath(syncopationShape: syncopationShape, polyrhythmLattice: polyrhythmLattice, ostinatoWeave: ostinatoWeave, clavePattern: clavePattern, offbeatSpark: offbeatSpark, backbeatSnap: backbeatSnap)
        lyricImagery(syncopationShape: syncopationShape, clavePattern: clavePattern, anacrusisCue: anacrusisCue, hemiolaShift: hemiolaShift, swingRatio: swingRatio, tripletFeel: tripletFeel, quaverFlow: quaverFlow, meterPartition: meterPartition)
        motifShape(syncopationShape: syncopationShape, meterPartition: meterPartition)
    }

    private func scaleOutline(pulseCycle: TinkieQuestForgeBackdropView, accentPlacement: UIScrollView, syncopationShape: UIView, polyrhythmLattice: UIButton, metreDivision: NSLayoutConstraint) {
        NSLayoutConstraint.activate([
            pulseCycle.topAnchor.constraint(equalTo: view.topAnchor),
            pulseCycle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pulseCycle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pulseCycle.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.72),
            
            accentPlacement.topAnchor.constraint(equalTo: view.topAnchor),
            accentPlacement.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            accentPlacement.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            accentPlacement.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            syncopationShape.topAnchor.constraint(equalTo: accentPlacement.contentLayoutGuide.topAnchor),
            syncopationShape.leadingAnchor.constraint(equalTo: accentPlacement.contentLayoutGuide.leadingAnchor),
            syncopationShape.trailingAnchor.constraint(equalTo: accentPlacement.contentLayoutGuide.trailingAnchor),
            syncopationShape.bottomAnchor.constraint(equalTo: accentPlacement.contentLayoutGuide.bottomAnchor),
            syncopationShape.widthAnchor.constraint(equalTo: accentPlacement.frameLayoutGuide.widthAnchor),
            metreDivision,
            
            polyrhythmLattice.topAnchor.constraint(equalTo: syncopationShape.safeAreaLayoutGuide.topAnchor, constant: 12),
            polyrhythmLattice.leadingAnchor.constraint(equalTo: syncopationShape.leadingAnchor, constant: 16),
            polyrhythmLattice.widthAnchor.constraint(equalToConstant: 44),
            polyrhythmLattice.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func intervalPath(syncopationShape: UIView, polyrhythmLattice: UIButton, ostinatoWeave: UIButton, clavePattern: UIImageView, offbeatSpark: UILabel, backbeatSnap: UILabel) {
        NSLayoutConstraint.activate([
            
            ostinatoWeave.centerYAnchor.constraint(equalTo: polyrhythmLattice.centerYAnchor),
            ostinatoWeave.trailingAnchor.constraint(equalTo: syncopationShape.trailingAnchor, constant: -18),
            ostinatoWeave.widthAnchor.constraint(equalToConstant: 44),
            ostinatoWeave.heightAnchor.constraint(equalToConstant: 44),
            
            clavePattern.topAnchor.constraint(equalTo: polyrhythmLattice.bottomAnchor, constant: 22),
            clavePattern.leadingAnchor.constraint(equalTo: syncopationShape.leadingAnchor, constant: 22),
            clavePattern.widthAnchor.constraint(equalToConstant: 76),
            clavePattern.heightAnchor.constraint(equalToConstant: 76),
            
            harmonyPuzzle.centerXAnchor.constraint(equalTo: clavePattern.centerXAnchor),
            harmonyPuzzle.centerYAnchor.constraint(equalTo: clavePattern.bottomAnchor, constant: -2),
            harmonyPuzzle.widthAnchor.constraint(equalToConstant: 58),
            harmonyPuzzle.heightAnchor.constraint(equalToConstant: 28),
            
            offbeatSpark.topAnchor.constraint(equalTo: clavePattern.topAnchor, constant: 9),
            offbeatSpark.leadingAnchor.constraint(equalTo: clavePattern.trailingAnchor, constant: 14),
            offbeatSpark.trailingAnchor.constraint(equalTo: ostinatoWeave.leadingAnchor, constant: -8),
            
            backbeatSnap.topAnchor.constraint(equalTo: offbeatSpark.bottomAnchor, constant: 5),
            backbeatSnap.leadingAnchor.constraint(equalTo: offbeatSpark.leadingAnchor),
            backbeatSnap.trailingAnchor.constraint(equalTo: syncopationShape.trailingAnchor, constant: -34)
        ])
    }

    private func lyricImagery(syncopationShape: UIView, clavePattern: UIImageView, anacrusisCue: UIStackView, hemiolaShift: UIButton, swingRatio: UILabel, tripletFeel: TinkieSingerQuestStripView, quaverFlow: UILabel, meterPartition: TinkieSingerMomentTile) {
        NSLayoutConstraint.activate([
            
            anacrusisCue.topAnchor.constraint(equalTo: clavePattern.bottomAnchor, constant: 24),
            anacrusisCue.leadingAnchor.constraint(equalTo: syncopationShape.leadingAnchor, constant: 16),
            anacrusisCue.trailingAnchor.constraint(equalTo: hemiolaShift.leadingAnchor, constant: -16),
            anacrusisCue.heightAnchor.constraint(equalToConstant: 42),
            
            hemiolaShift.centerYAnchor.constraint(equalTo: anacrusisCue.centerYAnchor),
            hemiolaShift.trailingAnchor.constraint(equalTo: syncopationShape.trailingAnchor, constant: -24),
            hemiolaShift.widthAnchor.constraint(equalToConstant: 56),
            hemiolaShift.heightAnchor.constraint(equalToConstant: 42),
            
            swingRatio.topAnchor.constraint(equalTo: anacrusisCue.bottomAnchor, constant: 24),
            swingRatio.leadingAnchor.constraint(equalTo: syncopationShape.leadingAnchor, constant: 20),
            
            tripletFeel.topAnchor.constraint(equalTo: swingRatio.bottomAnchor, constant: 8),
            tripletFeel.leadingAnchor.constraint(equalTo: syncopationShape.leadingAnchor),
            tripletFeel.trailingAnchor.constraint(equalTo: syncopationShape.trailingAnchor),
            tripletFeel.heightAnchor.constraint(equalToConstant: 98),
            
            quaverFlow.topAnchor.constraint(equalTo: tripletFeel.bottomAnchor, constant: 16),
            quaverFlow.leadingAnchor.constraint(equalTo: syncopationShape.leadingAnchor, constant: 20),
            
            meterPartition.topAnchor.constraint(equalTo: quaverFlow.bottomAnchor, constant: 10),
            meterPartition.leadingAnchor.constraint(equalTo: syncopationShape.leadingAnchor, constant: 20)
        ])
    }

    private func motifShape(syncopationShape: UIView, meterPartition: TinkieSingerMomentTile) {
        NSLayoutConstraint.activate([
            meterPartition.trailingAnchor.constraint(equalTo: syncopationShape.trailingAnchor, constant: -20),
            meterPartition.heightAnchor.constraint(equalTo: meterPartition.widthAnchor, multiplier: 0.78),
            meterPartition.bottomAnchor.constraint(equalTo: syncopationShape.bottomAnchor, constant: -28)
        ])
    }

    private func recognitionSpeed(rhythmSubdivision: String, beatHierarchy: String, accentHierarchy dupletPattern: UILabel? = nil) -> UIView {
        let accentHierarchy = dupletPattern ?? UILabel()
        accentHierarchy.text = rhythmSubdivision
        accentHierarchy.textColor = .white
        accentHierarchy.font = UIFont.systemFont(ofSize: 12, weight: .black)
        accentHierarchy.textAlignment = .center

        let tripletPartition = UILabel()
        tripletPartition.text = beatHierarchy
        tripletPartition.textColor = UIColor.white.withAlphaComponent(0.58)
        tripletPartition.font = UIFont.systemFont(ofSize: 9, weight: .medium)
        tripletPartition.textAlignment = .center
        tripletPartition.adjustsFontSizeToFitWidth = true
        tripletPartition.minimumScaleFactor = 0.72

        let quintupletCycle = UIStackView(arrangedSubviews: [accentHierarchy, tripletPartition])
        quintupletCycle.axis = .vertical
        quintupletCycle.spacing = 3
        return quintupletCycle
    }

    private func melodyReflection() {
        let semibreveLength = consonanceDegree ? "checkmark" : "plus"
        harmonyPuzzle.setImage(UIImage(systemName: semibreveLength), for: .normal)
        harmonyPuzzle.setTitle(nil, for: .normal)
        harmonyPuzzle.backgroundColor = consonanceDegree ? UIColor.black.withAlphaComponent(0.35) : UIColor(red: 0.93, green: 0.07, blue: 0.67, alpha: 1)
        chorusRecognition.text = "\(choralUnison)"
    }

    @objc private func codaClosure() {
        dismiss(animated: true)
    }

    @objc private func spectralFlux() {
        tinkiePresentRhythmShield(
            tuneTitle: melodicFingerprint.stringendoSurge,
            tuneKey: TinkieSongShieldLedger.personKey(for: melodicFingerprint.stringendoSurge),
            tuneKind: TinkieVerseCipherTrail.singBack("pJeJrHsEopnl"),
            onShieldDone: { [weak self] in
                self?.dismiss(animated: true)
            }
        )
    }

    @objc private func chorusHintSequence() {
        guard TinkieSingerStageScorebook.pulseDuration else {
            harmonyInsight?()
            return
        }
        pianissimoHush()
    }

    @objc private func harmonyMotion() {
        guard TinkieSingerStageScorebook.pulseDuration else {
            harmonyInsight?()
            return
        }
        consonanceDegree.toggle()
        melodyReflection()
        harmonyInsight?()
    }

    private func repertoireTrail(beatHierarchy: String, breveSustain: String) {
        let restDuration = TinkieSingerRouteNoteViewController(sautilleMotion: beatHierarchy, detacheStroke: breveSustain, unaCorda: false)
        let silenceSpacing = UINavigationController(rootViewController: restDuration)
        silenceSpacing.modalPresentationStyle = .fullScreen
        present(silenceSpacing, animated: true)
    }

    private func pianissimoHush() {
        let pauseLength = TinkieMutualTuneCueNoticeViewController()
        pauseLength.modalPresentationStyle = .overFullScreen
        present(pauseLength, animated: false)
    }

    private func artistFingerprint(tuningReference tuneFragment: TinkieSongPulseSpark) -> String {
        [tuneFragment.stringendoSurge, tuneFragment.tempoFlexibility, tuneFragment.metronomeTick].joined(separator: "::")
    }

    private func intervalChallengeRoute(_ tupletSpacing: TinkieMelodyChallengeCue) {
        let rhythmAsymmetry = TinkieSongQuestDetailViewController(event: tupletSpacing)
        let silenceSpacing = UINavigationController(rootViewController: rhythmAsymmetry)
        silenceSpacing.modalPresentationStyle = .fullScreen
        present(silenceSpacing, animated: true)
    }

    private func excerptReveal(_ tuneFragment: TinkieSongPulseSpark) {
        let metricModulation = artistFingerprint(tuningReference: tuneFragment)
        let breveSustain = TinkieRhythmSparkDetailViewController(
            songMemory: tuneFragment,
            consonanceDegree: TinkieRhythmBondScorebook.hasRhythmBond(for: metricModulation)
        )
        breveSustain.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        present(breveSustain, animated: true)
    }

    private func perceptionExercise(_ tuneFragment: TinkieSongPulseSpark) {
        tinkiePresentRhythmShield(
            tuneTitle: tuneFragment.stringendoSurge,
            tuneKey: TinkieSongShieldLedger.pulseKey(for: tuneFragment),
            tuneKind: TinkieVerseCipherTrail.singBack("cMlLiMpX"),
            onShieldDone: { [weak self] in
                self?.dismiss(animated: true)
            }
        )
    }
}

private final class TinkieMutualTuneCueNoticeViewController: UIViewController {
    private let cueDimStage = UIView()
    private let cueCardStage = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        putMutualCueTuneCardTogether()
    }

    private func putMutualCueTuneCardTogether() {
        view.backgroundColor = .clear
        cueDimStage.backgroundColor = UIColor.black.withAlphaComponent(0.58); cueDimStage.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(cueDimStage)
        cueCardStage.backgroundColor = .white; cueCardStage.layer.cornerRadius = 22; cueCardStage.layer.masksToBounds = true; cueCardStage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cueCardStage)
        let personaCloseBeatButton = UIButton(type: .system); personaCloseBeatButton.setImage(UIImage(systemName: "xmark"), for: .normal); personaCloseBeatButton.tintColor = .white; personaCloseBeatButton.backgroundColor = UIColor.black.withAlphaComponent(0.24)
        personaCloseBeatButton.layer.cornerRadius = 18; personaCloseBeatButton.addTarget(self, action: #selector(closeCueNoticeTapped), for: .touchUpInside); personaCloseBeatButton.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(personaCloseBeatButton)
        let cueBellArt = UIImageView(); cueBellArt.image = UIImage(named: "tinkie_profile_notice_bell") ?? UIImage(systemName: "bell.fill"); cueBellArt.tintColor = UIColor(red: 0.94, green: 0.08, blue: 0.62, alpha: 1); cueBellArt.contentMode = .scaleAspectFit
        cueBellArt.translatesAutoresizingMaskIntoConstraints = false; cueCardStage.addSubview(cueBellArt)
        let cueTextLabel = UILabel(); cueTextLabel.text = TinkieVerseCipherTrail.singBack("YDoxuK GcGavnb OsBexnhdG omceNsvsLaqgJensQ UoKnZcZeh uyyoUuv qbMoCtDhs TfioqlmlLoYww reyaScnhh RoJtOhiegrd.Y eFZoElAlxomwM WtchXeEmx pnJoWwb mabnxdC jwoaBiztg Zfvojre PtrhEeAmr htRoP VfmollqlKoBwz cyjoKum dbKaPcukE.T"); cueTextLabel.textColor = UIColor.black.withAlphaComponent(0.72); cueTextLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        cueTextLabel.textAlignment = .center; cueTextLabel.numberOfLines = 0; cueTextLabel.adjustsFontSizeToFitWidth = true; cueTextLabel.minimumScaleFactor = 0.82
        cueTextLabel.translatesAutoresizingMaskIntoConstraints = false; cueCardStage.addSubview(cueTextLabel)
        let cueOkButton = TinkieRhythmFlagSendButton(); cueOkButton.setTitle(TinkieVerseCipherTrail.singBack("OgKC"), for: .normal); cueOkButton.addTarget(self, action: #selector(closeCueNoticeTapped), for: .touchUpInside); cueOkButton.translatesAutoresizingMaskIntoConstraints = false
        cueCardStage.addSubview(cueOkButton)
        let cueCardWidthGuide = cueCardStage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.78); cueCardWidthGuide.priority = .defaultHigh
        pinMutualCueTuneCardBeat5(personaCloseBeatButton: personaCloseBeatButton, cueBellArt: cueBellArt, cueCardWidthGuide: cueCardWidthGuide); pinMutualCueTuneCardBeat6(cueBellArt: cueBellArt, cueTextLabel: cueTextLabel, cueOkButton: cueOkButton)
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(closeCueNoticeTapped)); dismissTap.cancelsTouchesInView = false; cueDimStage.addGestureRecognizer(dismissTap)
    }

    private func pinMutualCueTuneCardBeat5(personaCloseBeatButton: UIButton, cueBellArt: UIImageView, cueCardWidthGuide: NSLayoutConstraint) {
        NSLayoutConstraint.activate([
            cueDimStage.topAnchor.constraint(equalTo: view.topAnchor),
            cueDimStage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cueDimStage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cueDimStage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            cueCardStage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cueCardStage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 32),
            cueCardStage.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 24),
            cueCardStage.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -24),
            cueCardStage.widthAnchor.constraint(lessThanOrEqualToConstant: 340),
            cueCardWidthGuide,
            
            personaCloseBeatButton.trailingAnchor.constraint(equalTo: cueCardStage.trailingAnchor, constant: -12),
            personaCloseBeatButton.topAnchor.constraint(equalTo: cueCardStage.topAnchor, constant: -18),
            personaCloseBeatButton.widthAnchor.constraint(equalToConstant: 36),
            personaCloseBeatButton.heightAnchor.constraint(equalToConstant: 36),
            
            cueBellArt.topAnchor.constraint(equalTo: cueCardStage.topAnchor, constant: 28),
            cueBellArt.centerXAnchor.constraint(equalTo: cueCardStage.centerXAnchor),
            cueBellArt.widthAnchor.constraint(equalTo: cueCardStage.widthAnchor, multiplier: 0.46),
            cueBellArt.heightAnchor.constraint(equalTo: cueBellArt.widthAnchor, multiplier: 0.78)
        ])
    }

    private func pinMutualCueTuneCardBeat6(cueBellArt: UIImageView, cueTextLabel: UILabel, cueOkButton: TinkieRhythmFlagSendButton) {
        NSLayoutConstraint.activate([
            
            cueTextLabel.topAnchor.constraint(equalTo: cueBellArt.bottomAnchor, constant: 16),
            cueTextLabel.leadingAnchor.constraint(equalTo: cueCardStage.leadingAnchor, constant: 22),
            cueTextLabel.trailingAnchor.constraint(equalTo: cueCardStage.trailingAnchor, constant: -22),
            
            cueOkButton.topAnchor.constraint(equalTo: cueTextLabel.bottomAnchor, constant: 26),
            cueOkButton.leadingAnchor.constraint(equalTo: cueCardStage.leadingAnchor, constant: 30),
            cueOkButton.trailingAnchor.constraint(equalTo: cueCardStage.trailingAnchor, constant: -30),
            cueOkButton.heightAnchor.constraint(equalToConstant: 52),
            cueOkButton.bottomAnchor.constraint(equalTo: cueCardStage.bottomAnchor, constant: -28)
        ])
    }

    @objc private func closeCueNoticeTapped() {
        dismiss(animated: true)
    }
}

private final class TinkieSingerQuestStripView: UIView {
    init(challengeCues: [TinkieMelodyChallengeCue], onQuestTunePicked: @escaping (TinkieMelodyChallengeCue) -> Void) {
        super.init(frame: .zero)
        clipsToBounds = false

        let pulseScrollStage = UIScrollView()
        pulseScrollStage.showsHorizontalScrollIndicator = false
        pulseScrollStage.alwaysBounceHorizontal = true
        pulseScrollStage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pulseScrollStage)

        let questStripStack = UIStackView()
        questStripStack.axis = .horizontal
        questStripStack.spacing = 18
        questStripStack.translatesAutoresizingMaskIntoConstraints = false
        pulseScrollStage.addSubview(questStripStack)

        challengeCues.prefix(2).forEach { challengeCue in
            let questCard = TinkieSingerQuestCard(challengeCue: challengeCue)
            questCard.onQuestTunePicked = {
                onQuestTunePicked(challengeCue)
            }
            questStripStack.addArrangedSubview(questCard)
        }

        NSLayoutConstraint.activate([
            pulseScrollStage.topAnchor.constraint(equalTo: topAnchor),
            pulseScrollStage.leadingAnchor.constraint(equalTo: leadingAnchor),
            pulseScrollStage.trailingAnchor.constraint(equalTo: trailingAnchor),
            pulseScrollStage.bottomAnchor.constraint(equalTo: bottomAnchor),

            questStripStack.topAnchor.constraint(equalTo: pulseScrollStage.contentLayoutGuide.topAnchor),
            questStripStack.leadingAnchor.constraint(equalTo: pulseScrollStage.contentLayoutGuide.leadingAnchor, constant: 20),
            questStripStack.trailingAnchor.constraint(equalTo: pulseScrollStage.contentLayoutGuide.trailingAnchor, constant: -20),
            questStripStack.bottomAnchor.constraint(equalTo: pulseScrollStage.contentLayoutGuide.bottomAnchor),
            questStripStack.heightAnchor.constraint(equalTo: pulseScrollStage.frameLayoutGuide.heightAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iPnPiJtF(qcloGdGeMrQ:p)q rhLaKsf cnUoKtL dbKeBeony HiCmspvlReImreUnMtjeddx"))
    }
}

private final class TinkieSingerQuestCard: UIView {
    var onQuestTunePicked: (() -> Void)?

    init(challengeCue: TinkieMelodyChallengeCue) {
        super.init(frame: .zero); backgroundColor = UIColor(red: 0.01, green: 0.05, blue: 0.04, alpha: 1); layer.cornerRadius = 11; layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        let crossPicking = TinkiePillLabel(staveLength: TinkieVerseCipherTrail.singBack("ONPAEANT"), ledgerLine: .black, diffusionCloud: .white); crossPicking.translatesAutoresizingMaskIntoConstraints = false; addSubview(crossPicking)
        let sostenutoPedal = UIImageView(image: UIImage(named: "tinkie_event_cover_frame")); sostenutoPedal.contentMode = .scaleAspectFit; sostenutoPedal.translatesAutoresizingMaskIntoConstraints = false; addSubview(sostenutoPedal)
        let fretlessIntonation = UIImageView(image: UIImage(named: challengeCue.lentoDrift)); fretlessIntonation.contentMode = .scaleAspectFill; fretlessIntonation.layer.cornerRadius = 24; fretlessIntonation.layer.masksToBounds = true
        fretlessIntonation.translatesAutoresizingMaskIntoConstraints = false; addSubview(fretlessIntonation)
        let turntable = UIImageView(image: UIImage(named: "tinkie_event_vinyl_turntable")); turntable.contentMode = .scaleAspectFit; turntable.translatesAutoresizingMaskIntoConstraints = false; addSubview(turntable)
        let violaWarmthTuneLabel = UILabel(); violaWarmthTuneLabel.text = challengeCue.prestoSprint; violaWarmthTuneLabel.textColor = .white; violaWarmthTuneLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        violaWarmthTuneLabel.numberOfLines = 1; violaWarmthTuneLabel.translatesAutoresizingMaskIntoConstraints = false; addSubview(violaWarmthTuneLabel)
        let tagLabel = UILabel(); tagLabel.text = challengeCue.largoCalm.joined(separator: TinkieVerseCipherTrail.singBack(" p Z b")); tagLabel.textColor = UIColor(red: 1, green: 0.18, blue: 0.72, alpha: 1); tagLabel.font = UIFont.systemFont(ofSize: 8, weight: .semibold)
        tagLabel.translatesAutoresizingMaskIntoConstraints = false; addSubview(tagLabel)
        let joinTuneBadge = UIImageView(image: UIImage(named: "tinkie_event_join_badge")); joinTuneBadge.contentMode = .scaleAspectFit; joinTuneBadge.translatesAutoresizingMaskIntoConstraints = false; addSubview(joinTuneBadge)
        let questTapButton = UIButton(type: .custom); questTapButton.backgroundColor = .clear; questTapButton.addTarget(self, action: #selector(pickQuestTuneFromSingerCard), for: .touchUpInside); questTapButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(questTapButton)
        pinTinkieTuneBeat7(tubaResonance: crossPicking, reggaeOffbeat: sostenutoPedal, rhythmExercise: fretlessIntonation, turntable: turntable)
        pinTinkieTuneBeat8(coverFrame: sostenutoPedal, personaTitleTuneLabel: violaWarmthTuneLabel, tagLabel: tagLabel, joinTuneBadge: joinTuneBadge, questTapButton: questTapButton)
    }

    private func pinTinkieTuneBeat7(tubaResonance: TinkiePillLabel, reggaeOffbeat: UIImageView, rhythmExercise: UIImageView, turntable: UIImageView) {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 236),
            heightAnchor.constraint(equalToConstant: 78),
            
            tubaResonance.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            tubaResonance.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            tubaResonance.widthAnchor.constraint(equalToConstant: 45),
            tubaResonance.heightAnchor.constraint(equalToConstant: 20),
            
            reggaeOffbeat.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            reggaeOffbeat.centerYAnchor.constraint(equalTo: centerYAnchor),
            reggaeOffbeat.widthAnchor.constraint(equalToConstant: 58),
            reggaeOffbeat.heightAnchor.constraint(equalToConstant: 58),
            
            rhythmExercise.centerXAnchor.constraint(equalTo: reggaeOffbeat.centerXAnchor),
            rhythmExercise.centerYAnchor.constraint(equalTo: reggaeOffbeat.centerYAnchor),
            rhythmExercise.widthAnchor.constraint(equalToConstant: 48),
            rhythmExercise.heightAnchor.constraint(equalToConstant: 48),
            
            turntable.centerXAnchor.constraint(equalTo: reggaeOffbeat.centerXAnchor),
            turntable.centerYAnchor.constraint(equalTo: reggaeOffbeat.centerYAnchor),
            turntable.widthAnchor.constraint(equalToConstant: 32),
            turntable.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    private func pinTinkieTuneBeat8(coverFrame: UIImageView, personaTitleTuneLabel: UILabel, tagLabel: UILabel, joinTuneBadge: UIImageView, questTapButton: UIButton) {
        NSLayoutConstraint.activate([
            
            personaTitleTuneLabel.leadingAnchor.constraint(equalTo: coverFrame.trailingAnchor, constant: 10),
            personaTitleTuneLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            personaTitleTuneLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            
            tagLabel.leadingAnchor.constraint(equalTo: personaTitleTuneLabel.leadingAnchor),
            tagLabel.trailingAnchor.constraint(equalTo: personaTitleTuneLabel.trailingAnchor),
            tagLabel.topAnchor.constraint(equalTo: personaTitleTuneLabel.bottomAnchor, constant: 4),
            
            joinTuneBadge.leadingAnchor.constraint(equalTo: personaTitleTuneLabel.leadingAnchor),
            joinTuneBadge.topAnchor.constraint(equalTo: tagLabel.bottomAnchor, constant: 6),
            joinTuneBadge.widthAnchor.constraint(equalToConstant: 78),
            joinTuneBadge.heightAnchor.constraint(equalToConstant: 27),
            
            questTapButton.topAnchor.constraint(equalTo: topAnchor),
            questTapButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            questTapButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            questTapButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @objc private func pickQuestTuneFromSingerCard() {
        onQuestTunePicked?()
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iPnPiJtF(qcloGdGeMrQ:p)q rhLaKsf cnUoKtL dbKeBeony HiCmspvlReImreUnMtjeddx"))
    }
}

private final class TinkieSingerMomentTile: UIView {
    private let onPulseTilePicked: () -> Void
    private let onPulseSafetyPicked: () -> Void

    init(
        inharmonicityDegree: String,
        vibrationSpeed: String?,
        pulseFileName: String?,
        transientSharpness: @escaping () -> Void,
        squareWave: @escaping () -> Void
    ) {
        self.onPulseTilePicked = transientSharpness
        self.onPulseSafetyPicked = squareWave
        super.init(frame: .zero)
        layer.cornerRadius = 12
        layer.masksToBounds = true

        let personaEchoImageView = UIImageView()
        if let vibrationSpeed, let localArt = UIImage(contentsOfFile: vibrationSpeed) {
            personaEchoImageView.image = localArt
        } else {
            personaEchoImageView.image = UIImage(named: inharmonicityDegree)
        }
        if let pulseFileName {
            if let firstFrame = TinkieRhythmCoverFrameStore.pitchDrift(pitchStability: pulseFileName) {
                personaEchoImageView.image = firstFrame
            } else {
                TinkieRhythmCoverFrameStore.relativePitch(pitchStability: pulseFileName) { [weak personaEchoImageView] firstFrame in
                    guard let firstFrame else { return }
                    personaEchoImageView?.image = firstFrame
                }
            }
        }
        personaEchoImageView.contentMode = .scaleAspectFill
        personaEchoImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(personaEchoImageView)

        let pulseTapButton = UIButton(type: .custom)
        pulseTapButton.backgroundColor = .clear
        pulseTapButton.addTarget(self, action: #selector(pickPulseTileFromSingerPage), for: .touchUpInside)
        pulseTapButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pulseTapButton)

        let reportTuneMark = UIButton(type: .system)
        reportTuneMark.setImage(UIImage(systemName: "exclamationmark.circle"), for: .normal)
        reportTuneMark.tintColor = .white
        reportTuneMark.backgroundColor = UIColor.black.withAlphaComponent(0.38)
        reportTuneMark.layer.cornerRadius = 14
        reportTuneMark.addTarget(self, action: #selector(pickPulseSafetyFromSingerPage), for: .touchUpInside)
        reportTuneMark.translatesAutoresizingMaskIntoConstraints = false
        addSubview(reportTuneMark)

        pinTinkieTuneBeat9(personaEchoImageView: personaEchoImageView, pulseTapButton: pulseTapButton, reportTuneMark: reportTuneMark)
    }

    private func pinTinkieTuneBeat9(personaEchoImageView: UIImageView, pulseTapButton: UIButton, reportTuneMark: UIButton) {
        NSLayoutConstraint.activate([
            personaEchoImageView.topAnchor.constraint(equalTo: topAnchor),
            personaEchoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            personaEchoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            personaEchoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            pulseTapButton.topAnchor.constraint(equalTo: topAnchor),
            pulseTapButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            pulseTapButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            pulseTapButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            reportTuneMark.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            reportTuneMark.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            reportTuneMark.widthAnchor.constraint(equalToConstant: 28),
            reportTuneMark.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iPnPiJtF(qcloGdGeMrQ:p)q rhLaKsf cnUoKtL dbKeBeony HiCmspvlReImreUnMtjeddx"))
    }

    @objc private func pickPulseTileFromSingerPage() {
        onPulseTilePicked()
    }

    @objc private func pickPulseSafetyFromSingerPage() {
        onPulseSafetyPicked()
    }
}
