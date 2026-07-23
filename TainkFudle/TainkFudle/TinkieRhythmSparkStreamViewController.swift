import UIKit

final class TinkieRhythmSparkStreamViewController: UIViewController {
    private let pulseSparkStage: UICollectionView
    private let hotTuneArtView = UIImageView()
    private let noticeRhythmButton = TinkieTuneArtworkButton(assetName: "tinkie_discover_notice_bell", size: CGSize(width: 38, height: 38))
    private let publishRhythmButton = UIButton(type: .custom)
    private var pulseSparks: [TinkieSongPulseSpark] {
        (TinkiePulseSparkScorebook.savedPulseSparkTunes() + TinkieSongSeedSongbook.seedPulseSparkTunes).filter { TinkieSongShieldLedger.keepsPulseVisible($0) }
    }

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        pulseSparkStage = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
        guard TinkieSingerStageScorebook.isSingerOnStage else {
            openMelodyGate()
            return
        }
        let inbox = TinkieSingerEchoInboxViewController()
        let navigation = UINavigationController(rootViewController: inbox)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }
}

extension TinkieRhythmSparkStreamViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ pulseSparkStage: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pulseSparks.count
    }

    func collectionView(_ pulseSparkStage: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pulseCell = pulseSparkStage.dequeueReusableCell(withReuseIdentifier: TinkieRhythmSparkStreamCell.reuseIdentifier, for: indexPath) as! TinkieRhythmSparkStreamCell
        let pulseSpark = pulseSparks[indexPath.item]
        let key = rhythmKey(for: pulseSpark)
        pulseCell.tuneRhythmSparkTile(
            with: pulseSpark,
            bonded: TinkieRhythmBondScorebook.hasRhythmBond(for: key),
            sparked: TinkieRhythmBondScorebook.hasRhythmSpark(for: key)
        )
        pulseCell.onRhythmMoreTapped = { [weak self] in
            self?.tinkiePresentRhythmShield(
                tuneTitle: pulseSpark.performer,
                tuneKey: TinkieSongShieldLedger.pulseKey(for: pulseSpark),
                tuneKind: TinkieVerseCipherTrail.singBack("cMlLiMpX"),
                onShieldDone: { [weak self] in
                    self?.pulseSparkStage.reloadData()
                }
            )
        }
        pulseCell.onSingerFaceTapped = { [weak self] in
            self?.openSingerPulsePage(for: pulseSpark)
        }
        pulseCell.onBondBeatTapped = { [weak self] in
            self?.switchRhythmBond(for: pulseSpark, at: indexPath)
        }
        pulseCell.onSparkBeatTapped = { [weak self] in
            self?.switchRhythmSpark(for: pulseSpark, at: indexPath)
        }
        return pulseCell
    }

    func collectionView(_ pulseSparkStage: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openPulseSparkDetail(for: pulseSparks[indexPath.item])
    }

}

private extension TinkieRhythmSparkStreamViewController {
    func rhythmKey(for pulseSpark: TinkieSongPulseSpark) -> String {
        [pulseSpark.performer, pulseSpark.coverName, pulseSpark.pulseFileName].joined(separator: "::")
    }

    func switchRhythmBond(for pulseSpark: TinkieSongPulseSpark, at indexPath: IndexPath) {
        guard TinkieSingerStageScorebook.isSingerOnStage else {
            openMelodyGate()
            return
        }
        _ = TinkieRhythmBondScorebook.switchRhythmBond(for: rhythmKey(for: pulseSpark))
        refreshPulseSparkItem(at: indexPath)
    }

    func switchRhythmSpark(for pulseSpark: TinkieSongPulseSpark, at indexPath: IndexPath) {
        guard TinkieSingerStageScorebook.isSingerOnStage else {
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
        let key = rhythmKey(for: pulseSpark)
        let page = TinkieSingerPulseProfileViewController(
            pulseSpark: pulseSpark,
            bonded: TinkieRhythmBondScorebook.hasRhythmBond(for: key)
        )
        page.onTuneBondShift = { [weak self] in
            guard let self else { return }
            guard TinkieSingerStageScorebook.isSingerOnStage else {
                self.dismiss(animated: true) {
                    self.openMelodyGate()
                }
                return
            }
            _ = TinkieRhythmBondScorebook.switchRhythmBond(for: key)
            self.pulseSparkStage.reloadData()
        }
        let navigation = UINavigationController(rootViewController: page)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    func openPulseSparkDetail(for pulseSpark: TinkieSongPulseSpark) {
        let key = rhythmKey(for: pulseSpark)
        let detail = TinkieRhythmSparkDetailViewController(
            pulseSpark: pulseSpark,
            bonded: TinkieRhythmBondScorebook.hasRhythmBond(for: key)
        )
        present(detail, animated: true)
    }

    func openPulseForge() {
        guard TinkieSingerStageScorebook.isSingerOnStage else {
            openMelodyGate()
            return
        }
        let post = TinkieSongPulseForgeViewController()
        post.onPulseReady = { [weak self] in
            self?.pulseSparkStage.reloadData()
            self?.pulseSparkStage.setContentOffset(.zero, animated: false)
        }
        let navigation = UINavigationController(rootViewController: post)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    func openMelodyGate() {
        let welcome = TinkieMelodyGateWelcomeViewController()
        welcome.onMelodyGateDone = { [weak self] in
            self?.dismiss(animated: true)
        }
        let navigation = UINavigationController(rootViewController: welcome)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }
}

final class TinkieSingerPulseProfileViewController: UIViewController {
    var onTuneBondShift: (() -> Void)?
    private let profilePulseSpark: TinkieSongPulseSpark
    private var bonded: Bool
    private let bondButton = UIButton(type: .system)
    private let followerValueLabel = UILabel()
    private var singerMelodyCard: TinkieSingerMelodyCard {
        TinkieSingerTuneAtlas.singerMelodyCard(named: profilePulseSpark.performer)
    }
    private var signedSnapshot: TinkieSingerStageSnapshot? {
        let snapshot = TinkieSingerStageScorebook.currentSingerStage()
        guard snapshot.isSingerOnStage, snapshot.singerAlias == profilePulseSpark.performer else { return nil }
        return snapshot
    }
    private var performerPulseSparks: [TinkieSongPulseSpark] {
        TinkieSongSeedSongbook.pulseSparkTunes(for: profilePulseSpark.performer).filter { TinkieSongShieldLedger.keepsPulseVisible($0) }
    }
    private var performerChallengeCues: [TinkieMelodyChallengeCue] {
        TinkieSongSeedSongbook.joinedMelodyChallengeCues(for: profilePulseSpark.performer).filter { TinkieSongShieldLedger.keepsMelodyChallengeVisible($0) }
    }
    private var followerTotal: Int {
        min(9, (signedSnapshot?.listenerEchoTotal ?? singerMelodyCard.listenerEchoTotal) + (bonded ? 1 : 0))
    }
    private var pulseTotal: Int {
        min(9, max(1, performerPulseSparks.count + (signedSnapshot?.memoryEchoes.count ?? singerMelodyCard.memoryEchoes.count) + 1))
    }

    init(pulseSpark: TinkieSongPulseSpark, bonded: Bool) {
        self.profilePulseSpark = pulseSpark
        self.bonded = bonded
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iPnPiJtF(qcloGdGeMrQ:p)q rhLaKsf cnUoKtL dbKeBeony HiCmspvlReImreUnMtjeddx"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        putSingerPulseProfileTogether()
        refreshBondTuneTitle()
    }

    private func putSingerPulseProfileTogether() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.99, blue: 0.98, alpha: 1); let halo = TinkieQuestForgeBackdropView(); halo.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(halo); let pulseScrollStage = UIScrollView(); pulseScrollStage.showsVerticalScrollIndicator = false; pulseScrollStage.alwaysBounceVertical = true; pulseScrollStage.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(pulseScrollStage); let pulseContentStage = UIView(); pulseContentStage.translatesAutoresizingMaskIntoConstraints = false; pulseScrollStage.addSubview(pulseContentStage)
        let personaBackBeatButton = UIButton(type: .system); personaBackBeatButton.setImage(UIImage(systemName: "chevron.left"), for: .normal); personaBackBeatButton.tintColor = .black; personaBackBeatButton.addTarget(self, action: #selector(leavePulseSpark), for: .touchUpInside)
        personaBackBeatButton.translatesAutoresizingMaskIntoConstraints = false; pulseContentStage.addSubview(personaBackBeatButton); let moreButton = UIButton(type: .system); moreButton.setImage(UIImage(systemName: "ellipsis"), for: .normal); moreButton.tintColor = .black; moreButton.addTarget(self, action: #selector(openMoreRhythmActions), for: .touchUpInside); moreButton.translatesAutoresizingMaskIntoConstraints = false; pulseContentStage.addSubview(moreButton); let avatarImageView = UIImageView()
        if let path = signedSnapshot?.portraitLocalPath, let localArt = UIImage(contentsOfFile: path) {
            avatarImageView.image = localArt
        } else {
            avatarImageView.image = UIImage(named: signedSnapshot?.portraitAssetName ?? singerMelodyCard.portraitAssetName)
        }
        avatarImageView.contentMode = .scaleAspectFill; avatarImageView.layer.cornerRadius = 38; avatarImageView.layer.borderWidth = 1.5; avatarImageView.layer.borderColor = UIColor.white.cgColor; avatarImageView.layer.masksToBounds = true; avatarImageView.translatesAutoresizingMaskIntoConstraints = false; pulseContentStage.addSubview(avatarImageView); bondButton.setTitleColor(.white, for: .normal); bondButton.tintColor = .white; bondButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .black); bondButton.layer.cornerRadius = 14; bondButton.layer.masksToBounds = true; bondButton.addTarget(self, action: #selector(bondRhythmTapped), for: .touchUpInside); bondButton.translatesAutoresizingMaskIntoConstraints = false; pulseContentStage.addSubview(bondButton); let nameLabel = UILabel(); nameLabel.text = profilePulseSpark.performer; nameLabel.textColor = .white; nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .black); nameLabel.adjustsFontSizeToFitWidth = true; nameLabel.minimumScaleFactor = 0.78; nameLabel.translatesAutoresizingMaskIntoConstraints = false; pulseContentStage.addSubview(nameLabel); let noteLabel = UILabel(); noteLabel.text = signedSnapshot?.melodyBio ?? singerMelodyCard.melodyBio; noteLabel.textColor = UIColor.white.withAlphaComponent(0.9); noteLabel.font = UIFont.systemFont(ofSize: 11, weight: .medium); noteLabel.numberOfLines = 2; noteLabel.translatesAutoresizingMaskIntoConstraints = false; pulseContentStage.addSubview(noteLabel)
        let statStack = UIStackView(arrangedSubviews: [
            makeSingerStat(value: "\(pulseTotal)", title: TinkieVerseCipherTrail.singBack("LjiykKevsP")),
            makeSingerStat(value: "\(followerTotal)", title: TinkieVerseCipherTrail.singBack("FHoGlCluobwHeprpsk"), valueLabel: followerValueLabel),
            makeSingerStat(value: "\(min(9, signedSnapshot?.followedSingerTotal ?? singerMelodyCard.followedSingerTotal))", title: TinkieVerseCipherTrail.singBack("FvonlplJoRwmiVnSgH"))
        ])
        statStack.axis = .horizontal; statStack.distribution = .fillEqually; statStack.translatesAutoresizingMaskIntoConstraints = false; pulseContentStage.addSubview(statStack); let cueButton = UIButton(type: .system); cueButton.setImage(UIImage(systemName: "ellipsis.bubble.fill"), for: .normal); cueButton.tintColor = .black; cueButton.backgroundColor = UIColor(red: 0.08, green: 0.86, blue: 0.79, alpha: 1); cueButton.layer.cornerRadius = 22; cueButton.addTarget(self, action: #selector(cueRhythmTapped), for: .touchUpInside); cueButton.translatesAutoresizingMaskIntoConstraints = false; pulseContentStage.addSubview(cueButton); let eventTitle = UILabel(); eventTitle.text = "Event"; eventTitle.textColor = .black; eventTitle.font = UIFont.systemFont(ofSize: 19, weight: .black); eventTitle.layer.shadowColor = UIColor(red: 0.08, green: 0.86, blue: 0.79, alpha: 1).cgColor; eventTitle.layer.shadowOffset = CGSize(width: -2, height: 2); eventTitle.layer.shadowOpacity = 1; eventTitle.layer.shadowRadius = 0; eventTitle.translatesAutoresizingMaskIntoConstraints = false; pulseContentStage.addSubview(eventTitle)
        let eventStrip = TinkieSingerQuestStripView(challengeCues: performerChallengeCues) { [weak self] challengeCue in
            self?.openProfileQuestTune(challengeCue)
        }
        eventStrip.translatesAutoresizingMaskIntoConstraints = false; pulseContentStage.addSubview(eventStrip); let momentTitle = UILabel(); momentTitle.text = TinkieVerseCipherTrail.singBack("MVohmCennctSsC"); momentTitle.textColor = .black; momentTitle.font = UIFont.systemFont(ofSize: 19, weight: .black); momentTitle.layer.shadowColor = UIColor(red: 0.08, green: 0.86, blue: 0.79, alpha: 1).cgColor; momentTitle.layer.shadowOffset = CGSize(width: -2, height: 2); momentTitle.layer.shadowOpacity = 1; momentTitle.layer.shadowRadius = 0; momentTitle.translatesAutoresizingMaskIntoConstraints = false; pulseContentStage.addSubview(momentTitle); let showcasePulseSpark = performerPulseSparks.first ?? profilePulseSpark
        let momentCard = TinkieSingerMomentTile(
            imageName: showcasePulseSpark.coverName,
            imagePath: showcasePulseSpark.coverPath,
            pulseFileName: showcasePulseSpark.pulseFileName,
            onPulseTilePicked: { [weak self] in
                self?.openProfilePulseTune(showcasePulseSpark)
            },
            onPulseSafetyPicked: { [weak self] in
                self?.openProfilePulseSafety(showcasePulseSpark)
            }
        )
        momentCard.translatesAutoresizingMaskIntoConstraints = false; pulseContentStage.addSubview(momentCard); let pageHeightGuide = pulseContentStage.heightAnchor.constraint(greaterThanOrEqualTo: pulseScrollStage.frameLayoutGuide.heightAnchor); pageHeightGuide.priority = .defaultLow; pinSingerPulseProfileBeat1(halo: halo, pulseScrollStage: pulseScrollStage, pulseContentStage: pulseContentStage, personaBackBeatButton: personaBackBeatButton, pageHeightGuide: pageHeightGuide); pinSingerPulseProfileBeat2(pulseContentStage: pulseContentStage, personaBackBeatButton: personaBackBeatButton, moreButton: moreButton, avatarImageView: avatarImageView, nameLabel: nameLabel, noteLabel: noteLabel)
        pinSingerPulseProfileBeat3(pulseContentStage: pulseContentStage, avatarImageView: avatarImageView, statStack: statStack, cueButton: cueButton, eventTitle: eventTitle, eventStrip: eventStrip, momentTitle: momentTitle, momentCard: momentCard)
        pinSingerPulseProfileBeat4(pulseContentStage: pulseContentStage, momentCard: momentCard)
    }

    private func pinSingerPulseProfileBeat1(halo: TinkieQuestForgeBackdropView, pulseScrollStage: UIScrollView, pulseContentStage: UIView, personaBackBeatButton: UIButton, pageHeightGuide: NSLayoutConstraint) {
        NSLayoutConstraint.activate([
            halo.topAnchor.constraint(equalTo: view.topAnchor),
            halo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            halo.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            halo.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.72),
            
            pulseScrollStage.topAnchor.constraint(equalTo: view.topAnchor),
            pulseScrollStage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pulseScrollStage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pulseScrollStage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pulseContentStage.topAnchor.constraint(equalTo: pulseScrollStage.contentLayoutGuide.topAnchor),
            pulseContentStage.leadingAnchor.constraint(equalTo: pulseScrollStage.contentLayoutGuide.leadingAnchor),
            pulseContentStage.trailingAnchor.constraint(equalTo: pulseScrollStage.contentLayoutGuide.trailingAnchor),
            pulseContentStage.bottomAnchor.constraint(equalTo: pulseScrollStage.contentLayoutGuide.bottomAnchor),
            pulseContentStage.widthAnchor.constraint(equalTo: pulseScrollStage.frameLayoutGuide.widthAnchor),
            pageHeightGuide,
            
            personaBackBeatButton.topAnchor.constraint(equalTo: pulseContentStage.safeAreaLayoutGuide.topAnchor, constant: 12),
            personaBackBeatButton.leadingAnchor.constraint(equalTo: pulseContentStage.leadingAnchor, constant: 16),
            personaBackBeatButton.widthAnchor.constraint(equalToConstant: 44),
            personaBackBeatButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func pinSingerPulseProfileBeat2(pulseContentStage: UIView, personaBackBeatButton: UIButton, moreButton: UIButton, avatarImageView: UIImageView, nameLabel: UILabel, noteLabel: UILabel) {
        NSLayoutConstraint.activate([
            
            moreButton.centerYAnchor.constraint(equalTo: personaBackBeatButton.centerYAnchor),
            moreButton.trailingAnchor.constraint(equalTo: pulseContentStage.trailingAnchor, constant: -18),
            moreButton.widthAnchor.constraint(equalToConstant: 44),
            moreButton.heightAnchor.constraint(equalToConstant: 44),
            
            avatarImageView.topAnchor.constraint(equalTo: personaBackBeatButton.bottomAnchor, constant: 22),
            avatarImageView.leadingAnchor.constraint(equalTo: pulseContentStage.leadingAnchor, constant: 22),
            avatarImageView.widthAnchor.constraint(equalToConstant: 76),
            avatarImageView.heightAnchor.constraint(equalToConstant: 76),
            
            bondButton.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
            bondButton.centerYAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -2),
            bondButton.widthAnchor.constraint(equalToConstant: 58),
            bondButton.heightAnchor.constraint(equalToConstant: 28),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 9),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 14),
            nameLabel.trailingAnchor.constraint(equalTo: moreButton.leadingAnchor, constant: -8),
            
            noteLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            noteLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            noteLabel.trailingAnchor.constraint(equalTo: pulseContentStage.trailingAnchor, constant: -34)
        ])
    }

    private func pinSingerPulseProfileBeat3(pulseContentStage: UIView, avatarImageView: UIImageView, statStack: UIStackView, cueButton: UIButton, eventTitle: UILabel, eventStrip: TinkieSingerQuestStripView, momentTitle: UILabel, momentCard: TinkieSingerMomentTile) {
        NSLayoutConstraint.activate([
            
            statStack.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 24),
            statStack.leadingAnchor.constraint(equalTo: pulseContentStage.leadingAnchor, constant: 16),
            statStack.trailingAnchor.constraint(equalTo: cueButton.leadingAnchor, constant: -16),
            statStack.heightAnchor.constraint(equalToConstant: 42),
            
            cueButton.centerYAnchor.constraint(equalTo: statStack.centerYAnchor),
            cueButton.trailingAnchor.constraint(equalTo: pulseContentStage.trailingAnchor, constant: -24),
            cueButton.widthAnchor.constraint(equalToConstant: 56),
            cueButton.heightAnchor.constraint(equalToConstant: 42),
            
            eventTitle.topAnchor.constraint(equalTo: statStack.bottomAnchor, constant: 24),
            eventTitle.leadingAnchor.constraint(equalTo: pulseContentStage.leadingAnchor, constant: 20),
            
            eventStrip.topAnchor.constraint(equalTo: eventTitle.bottomAnchor, constant: 8),
            eventStrip.leadingAnchor.constraint(equalTo: pulseContentStage.leadingAnchor),
            eventStrip.trailingAnchor.constraint(equalTo: pulseContentStage.trailingAnchor),
            eventStrip.heightAnchor.constraint(equalToConstant: 98),
            
            momentTitle.topAnchor.constraint(equalTo: eventStrip.bottomAnchor, constant: 16),
            momentTitle.leadingAnchor.constraint(equalTo: pulseContentStage.leadingAnchor, constant: 20),
            
            momentCard.topAnchor.constraint(equalTo: momentTitle.bottomAnchor, constant: 10),
            momentCard.leadingAnchor.constraint(equalTo: pulseContentStage.leadingAnchor, constant: 20)
        ])
    }

    private func pinSingerPulseProfileBeat4(pulseContentStage: UIView, momentCard: TinkieSingerMomentTile) {
        NSLayoutConstraint.activate([
            momentCard.trailingAnchor.constraint(equalTo: pulseContentStage.trailingAnchor, constant: -20),
            momentCard.heightAnchor.constraint(equalTo: momentCard.widthAnchor, multiplier: 0.78),
            momentCard.bottomAnchor.constraint(equalTo: pulseContentStage.bottomAnchor, constant: -28)
        ])
    }

    private func makeSingerStat(value: String, title: String, valueLabel externalValueLabel: UILabel? = nil) -> UIView {
        let valueLabel = externalValueLabel ?? UILabel()
        valueLabel.text = value
        valueLabel.textColor = .white
        valueLabel.font = UIFont.systemFont(ofSize: 12, weight: .black)
        valueLabel.textAlignment = .center

        let personaTitleTuneLabel = UILabel()
        personaTitleTuneLabel.text = title
        personaTitleTuneLabel.textColor = UIColor.white.withAlphaComponent(0.58)
        personaTitleTuneLabel.font = UIFont.systemFont(ofSize: 9, weight: .medium)
        personaTitleTuneLabel.textAlignment = .center
        personaTitleTuneLabel.adjustsFontSizeToFitWidth = true
        personaTitleTuneLabel.minimumScaleFactor = 0.72

        let personaMetricStack = UIStackView(arrangedSubviews: [valueLabel, personaTitleTuneLabel])
        personaMetricStack.axis = .vertical
        personaMetricStack.spacing = 3
        return personaMetricStack
    }

    private func refreshBondTuneTitle() {
        let symbolName = bonded ? "checkmark" : "plus"
        bondButton.setImage(UIImage(systemName: symbolName), for: .normal)
        bondButton.setTitle(nil, for: .normal)
        bondButton.backgroundColor = bonded ? UIColor.black.withAlphaComponent(0.35) : UIColor(red: 0.93, green: 0.07, blue: 0.67, alpha: 1)
        followerValueLabel.text = "\(followerTotal)"
    }

    @objc private func leavePulseSpark() {
        dismiss(animated: true)
    }

    @objc private func openMoreRhythmActions() {
        tinkiePresentRhythmShield(
            tuneTitle: profilePulseSpark.performer,
            tuneKey: TinkieSongShieldLedger.personKey(for: profilePulseSpark.performer),
            tuneKind: TinkieVerseCipherTrail.singBack("pJeJrHsEopnl"),
            onShieldDone: { [weak self] in
                self?.dismiss(animated: true)
            }
        )
    }

    @objc private func cueRhythmTapped() {
        guard TinkieSingerStageScorebook.isSingerOnStage else {
            onTuneBondShift?()
            return
        }
        presentCueLimitTuneNotice()
    }

    @objc private func bondRhythmTapped() {
        guard TinkieSingerStageScorebook.isSingerOnStage else {
            onTuneBondShift?()
            return
        }
        bonded.toggle()
        refreshBondTuneTitle()
        onTuneBondShift?()
    }

    private func presentSingerRoute(title: String, detail: String) {
        let route = TinkieSingerRouteNoteViewController(titleText: title, detailText: detail, showsSignOut: false)
        let navigation = UINavigationController(rootViewController: route)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    private func presentCueLimitTuneNotice() {
        let notice = TinkieMutualTuneCueNoticeViewController()
        notice.modalPresentationStyle = .overFullScreen
        present(notice, animated: false)
    }

    private func profileRhythmKey(for pulseSpark: TinkieSongPulseSpark) -> String {
        [pulseSpark.performer, pulseSpark.coverName, pulseSpark.pulseFileName].joined(separator: "::")
    }

    private func openProfileQuestTune(_ challengeCue: TinkieMelodyChallengeCue) {
        let questDetail = TinkieSongQuestDetailViewController(event: challengeCue)
        let navigation = UINavigationController(rootViewController: questDetail)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    private func openProfilePulseTune(_ pulseSpark: TinkieSongPulseSpark) {
        let key = profileRhythmKey(for: pulseSpark)
        let detail = TinkieRhythmSparkDetailViewController(
            pulseSpark: pulseSpark,
            bonded: TinkieRhythmBondScorebook.hasRhythmBond(for: key)
        )
        detail.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        present(detail, animated: true)
    }

    private func openProfilePulseSafety(_ pulseSpark: TinkieSongPulseSpark) {
        tinkiePresentRhythmShield(
            tuneTitle: pulseSpark.performer,
            tuneKey: TinkieSongShieldLedger.pulseKey(for: pulseSpark),
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
        let openLabel = TinkiePillLabel(text: TinkieVerseCipherTrail.singBack("ONPAEANT"), foreground: .black, background: .white); openLabel.translatesAutoresizingMaskIntoConstraints = false; addSubview(openLabel)
        let coverFrame = UIImageView(image: UIImage(named: "tinkie_event_cover_frame")); coverFrame.contentMode = .scaleAspectFit; coverFrame.translatesAutoresizingMaskIntoConstraints = false; addSubview(coverFrame)
        let cover = UIImageView(image: UIImage(named: challengeCue.sleeveAssetName)); cover.contentMode = .scaleAspectFill; cover.layer.cornerRadius = 24; cover.layer.masksToBounds = true
        cover.translatesAutoresizingMaskIntoConstraints = false; addSubview(cover)
        let turntable = UIImageView(image: UIImage(named: "tinkie_event_vinyl_turntable")); turntable.contentMode = .scaleAspectFit; turntable.translatesAutoresizingMaskIntoConstraints = false; addSubview(turntable)
        let personaTitleTuneLabel = UILabel(); personaTitleTuneLabel.text = challengeCue.challengeTitle; personaTitleTuneLabel.textColor = .white; personaTitleTuneLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        personaTitleTuneLabel.numberOfLines = 1; personaTitleTuneLabel.translatesAutoresizingMaskIntoConstraints = false; addSubview(personaTitleTuneLabel)
        let tagLabel = UILabel(); tagLabel.text = challengeCue.challengeTags.joined(separator: TinkieVerseCipherTrail.singBack(" p Z b")); tagLabel.textColor = UIColor(red: 1, green: 0.18, blue: 0.72, alpha: 1); tagLabel.font = UIFont.systemFont(ofSize: 8, weight: .semibold)
        tagLabel.translatesAutoresizingMaskIntoConstraints = false; addSubview(tagLabel)
        let joinTuneBadge = UIImageView(image: UIImage(named: "tinkie_event_join_badge")); joinTuneBadge.contentMode = .scaleAspectFit; joinTuneBadge.translatesAutoresizingMaskIntoConstraints = false; addSubview(joinTuneBadge)
        let questTapButton = UIButton(type: .custom); questTapButton.backgroundColor = .clear; questTapButton.addTarget(self, action: #selector(pickQuestTuneFromSingerCard), for: .touchUpInside); questTapButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(questTapButton)
        pinTinkieTuneBeat7(openLabel: openLabel, coverFrame: coverFrame, cover: cover, turntable: turntable)
        pinTinkieTuneBeat8(coverFrame: coverFrame, personaTitleTuneLabel: personaTitleTuneLabel, tagLabel: tagLabel, joinTuneBadge: joinTuneBadge, questTapButton: questTapButton)
    }

    private func pinTinkieTuneBeat7(openLabel: TinkiePillLabel, coverFrame: UIImageView, cover: UIImageView, turntable: UIImageView) {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 236),
            heightAnchor.constraint(equalToConstant: 78),
            
            openLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            openLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            openLabel.widthAnchor.constraint(equalToConstant: 45),
            openLabel.heightAnchor.constraint(equalToConstant: 20),
            
            coverFrame.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            coverFrame.centerYAnchor.constraint(equalTo: centerYAnchor),
            coverFrame.widthAnchor.constraint(equalToConstant: 58),
            coverFrame.heightAnchor.constraint(equalToConstant: 58),
            
            cover.centerXAnchor.constraint(equalTo: coverFrame.centerXAnchor),
            cover.centerYAnchor.constraint(equalTo: coverFrame.centerYAnchor),
            cover.widthAnchor.constraint(equalToConstant: 48),
            cover.heightAnchor.constraint(equalToConstant: 48),
            
            turntable.centerXAnchor.constraint(equalTo: coverFrame.centerXAnchor),
            turntable.centerYAnchor.constraint(equalTo: coverFrame.centerYAnchor),
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
        imageName: String,
        imagePath: String?,
        pulseFileName: String?,
        onPulseTilePicked: @escaping () -> Void,
        onPulseSafetyPicked: @escaping () -> Void
    ) {
        self.onPulseTilePicked = onPulseTilePicked
        self.onPulseSafetyPicked = onPulseSafetyPicked
        super.init(frame: .zero)
        layer.cornerRadius = 12
        layer.masksToBounds = true

        let personaEchoImageView = UIImageView()
        if let imagePath, let localArt = UIImage(contentsOfFile: imagePath) {
            personaEchoImageView.image = localArt
        } else {
            personaEchoImageView.image = UIImage(named: imageName)
        }
        if let pulseFileName {
            if let firstFrame = TinkieRhythmCoverFrameStore.art(for: pulseFileName) {
                personaEchoImageView.image = firstFrame
            } else {
                TinkieRhythmCoverFrameStore.resolveArt(for: pulseFileName) { [weak personaEchoImageView] firstFrame in
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
