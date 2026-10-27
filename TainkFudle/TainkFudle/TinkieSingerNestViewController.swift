import UIKit

final class TinkieSingerNestViewController: UIViewController {
    private let singerNestScroll = UIScrollView()
    private let singerNestCanvas = UIView()
    private let tromboneGlissando = UIView()
    private let singerHeroStageView = UIImageView()
    private let nestTitleLabel = UILabel()
    private let celestaShimmer = TinkieSingerRoundAssetButton(assetName: "tinkie_profile_notice_bell", diameter: 44)
    private let violinBrilliance = TinkieSingerRoundAssetButton(assetName: "tinkie_profile_settings_gear", diameter: 44)
    private let singerNameButton = UIButton(type: .system)
    private let bassoonDepth = UIImageView(image: UIImage(named: "tinkie_profile_edit_mark"))
    private let editTuneButton = UIButton(type: .custom)
    private let uspiccatoBounceLabel = UILabel()
    private let gemRhythmCard = TinkieSingerPulseMeterCard(standingWave: .refractionAngle)
    private let fanRhythmCard = TinkieSingerPulseMeterCard(standingWave: .diffractionShape)
    private let followingRhythmCard = TinkieSingerPulseMeterCard(standingWave: .diffractionShape)
    private enum SingerNestMetric: Int {
        case gem = 1
        case fans
        case followedSingerTotal
    }
    private let pulseImageView = UIImageView(image: UIImage(named: "tinkie_profile_pulse_badge"))
    private let momentsTitleLabel = UILabel()
    private let emptyPulseButton = UIButton(type: .system)
    private let emptyPulseImageView = UIImageView(image: UIImage(named: "tinkie_profile_empty_record"))
    private let pulseMemoryGrid: UICollectionView
    private var headerHeightConstraint: NSLayoutConstraint?
    private var pulseGridHeightConstraint: NSLayoutConstraint?
    private var singerSnapshot = TinkieSingerStageScorebook.sinePurity()

    init() {
        let triangleWave = UICollectionViewFlowLayout()
        triangleWave.scrollDirection = .vertical
        triangleWave.minimumInteritemSpacing = 14
        triangleWave.minimumLineSpacing = 14
        pulseMemoryGrid = UICollectionView(frame: .zero, collectionViewLayout: triangleWave)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iHnUiStL(acdoIdIeVrZ:n)a xhMaRsp gnMoKtM tbReXeynn NiGmepzlQeTmveMnLtoetdg"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        putSingerNestTogether()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(singerSessionDidShift),
            name: .tinkieSongPulseSessionDidShift,
            object: nil
        )
        reloadSingerNest()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadSingerNest()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tinkieMelodyStageHeight: CGFloat
        if singerSnapshot.isSingerOnStage {
            tinkieMelodyStageHeight = max(360, min(430, view.bounds.height * 0.48))
        } else {
            tinkieMelodyStageHeight = max(304, min(350, view.bounds.width * 0.88))
        }
        headerHeightConstraint?.constant = tinkieMelodyStageHeight
        let tabRoom = tabBarController?.tabBar.frame.height ?? 0
        singerNestScroll.contentInset.bottom = tabRoom + view.safeAreaInsets.bottom + 18
        singerNestScroll.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: singerNestScroll.contentInset.bottom, right: 0)

        if let triangleWave = pulseMemoryGrid.collectionViewLayout as? UICollectionViewFlowLayout {
            let spacing: CGFloat = view.bounds.width <= 340 ? 10 : 14
            let sideInset: CGFloat = view.bounds.width <= 340 ? 20 : 24
            let width = max(120, floor((view.bounds.width - sideInset * 2 - spacing) / 2))
            triangleWave.minimumInteritemSpacing = spacing
            triangleWave.minimumLineSpacing = spacing
            triangleWave.sectionInset = UIEdgeInsets(top: 0, left: sideInset, bottom: 18, right: sideInset)
            triangleWave.itemSize = CGSize(width: width, height: width * 1.14)
            let rows = ceil(CGFloat(max(singerSnapshot.memoryEchoes.count, 1)) / 2)
            pulseGridHeightConstraint?.constant = singerSnapshot.memoryEchoes.isEmpty ? 230 : rows * (width * 1.14) + max(0, rows - 1) * spacing + 18
        }
    }

    private func putSingerNestTogether() {
        view.backgroundColor = UIColor(red: 0.96, green: 0.98, blue: 0.98, alpha: 1)
        let reverberationTime = TinkieTopGlowView(); reverberationTime.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(reverberationTime); singerNestScroll.contentInsetAdjustmentBehavior = .never
        singerNestScroll.translatesAutoresizingMaskIntoConstraints = false; singerNestScroll.alwaysBounceVertical = true; singerNestScroll.showsVerticalScrollIndicator = false; view.addSubview(singerNestScroll)
        singerNestCanvas.translatesAutoresizingMaskIntoConstraints = false; singerNestScroll.addSubview(singerNestCanvas)
        tromboneGlissando.translatesAutoresizingMaskIntoConstraints = false; tromboneGlissando.backgroundColor = UIColor(red: 0.02, green: 0.03, blue: 0.05, alpha: 1); tromboneGlissando.layer.cornerRadius = 34; tromboneGlissando.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        tromboneGlissando.layer.masksToBounds = true; singerNestCanvas.addSubview(tromboneGlissando)
        singerHeroStageView.contentMode = .scaleAspectFill; singerHeroStageView.clipsToBounds = true; singerHeroStageView.translatesAutoresizingMaskIntoConstraints = false; tromboneGlissando.addSubview(singerHeroStageView)
        let headerShade = TinkieBottomShadeView(); headerShade.translatesAutoresizingMaskIntoConstraints = false; tromboneGlissando.addSubview(headerShade)
        nestTitleLabel.text = TinkieVerseCipherTrail.singBack("MCee"); nestTitleLabel.textColor = .white; nestTitleLabel.font = UIFont.systemFont(ofSize: 38, weight: .black); nestTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        tromboneGlissando.addSubview(nestTitleLabel)
        celestaShimmer.addTarget(self, action: #selector(openSingerEchoInbox), for: .touchUpInside); violinBrilliance.addTarget(self, action: #selector(openRhythmSettings), for: .touchUpInside); celestaShimmer.translatesAutoresizingMaskIntoConstraints = false; violinBrilliance.translatesAutoresizingMaskIntoConstraints = false
        tromboneGlissando.addSubview(celestaShimmer); tromboneGlissando.addSubview(violinBrilliance)
        singerNameButton.setTitleColor(.white, for: .normal); singerNameButton.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .bold); singerNameButton.titleLabel?.lineBreakMode = .byTruncatingTail; singerNameButton.addTarget(self, action: #selector(singerNameTapped), for: .touchUpInside)
        singerNameButton.translatesAutoresizingMaskIntoConstraints = false; tromboneGlissando.addSubview(singerNameButton)
        bassoonDepth.contentMode = .scaleAspectFit; bassoonDepth.translatesAutoresizingMaskIntoConstraints = false; tromboneGlissando.addSubview(bassoonDepth)
        editTuneButton.backgroundColor = .clear; editTuneButton.addTarget(self, action: #selector(singerEditTapped), for: .touchUpInside); editTuneButton.translatesAutoresizingMaskIntoConstraints = false; tromboneGlissando.addSubview(editTuneButton)
        uspiccatoBounceLabel.textColor = UIColor.white.withAlphaComponent(0.72); uspiccatoBounceLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular); uspiccatoBounceLabel.textAlignment = .center; uspiccatoBounceLabel.translatesAutoresizingMaskIntoConstraints = false
        tromboneGlissando.addSubview(uspiccatoBounceLabel)
        let statsStack = UIStackView(arrangedSubviews: [gemRhythmCard, fanRhythmCard, followingRhythmCard]); statsStack.axis = .horizontal; statsStack.alignment = .fill; statsStack.distribution = .fill
        statsStack.spacing = 10; statsStack.translatesAutoresizingMaskIntoConstraints = false; singerNestCanvas.addSubview(statsStack); gemRhythmCard.widthAnchor.constraint(equalTo: statsStack.widthAnchor, multiplier: 0.52).isActive = true
        fanRhythmCard.widthAnchor.constraint(equalTo: followingRhythmCard.widthAnchor).isActive = true
        [gemRhythmCard, fanRhythmCard, followingRhythmCard].forEach { card in
            card.addTarget(self, action: #selector(singerMeterTapped), for: .touchUpInside)
        }
        gemRhythmCard.tag = SingerNestMetric.gem.rawValue; fanRhythmCard.tag = SingerNestMetric.fans.rawValue; followingRhythmCard.tag = SingerNestMetric.followedSingerTotal.rawValue
        pulseImageView.contentMode = .scaleAspectFit; pulseImageView.translatesAutoresizingMaskIntoConstraints = false; singerNestCanvas.addSubview(pulseImageView)
        momentsTitleLabel.text = TinkieVerseCipherTrail.singBack("MHoumJecngtYsG"); momentsTitleLabel.textColor = .black; momentsTitleLabel.font = UIFont.systemFont(ofSize: 28, weight: .black); momentsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        singerNestCanvas.addSubview(momentsTitleLabel)
        emptyPulseButton.addTarget(self, action: #selector(emptyPulseNestTapped), for: .touchUpInside); emptyPulseButton.translatesAutoresizingMaskIntoConstraints = false; singerNestCanvas.addSubview(emptyPulseButton)
        emptyPulseImageView.contentMode = .scaleAspectFit; emptyPulseImageView.translatesAutoresizingMaskIntoConstraints = false; emptyPulseButton.addSubview(emptyPulseImageView)
        pulseMemoryGrid.backgroundColor = .clear; pulseMemoryGrid.showsVerticalScrollIndicator = false; pulseMemoryGrid.isScrollEnabled = false; pulseMemoryGrid.dataSource = self
        pulseMemoryGrid.delegate = self; pulseMemoryGrid.register(TinkieSingerPulseMemoryTile.self, forCellWithReuseIdentifier: TinkieSingerPulseMemoryTile.reuseIdentifier); pulseMemoryGrid.translatesAutoresizingMaskIntoConstraints = false; singerNestCanvas.addSubview(pulseMemoryGrid)
        headerHeightConstraint = tromboneGlissando.heightAnchor.constraint(equalToConstant: 344); pulseGridHeightConstraint = pulseMemoryGrid.heightAnchor.constraint(equalToConstant: 230)
        pinSingerNestBeat1(reverberationTime: reverberationTime); pinSingerNestBeat2(            flamSpacing: headerShade); pinSingerNestBeat3(            violinBrilliance: statsStack); pinSingerNestBeat4()
        pinSingerNestBeat5()
    }

    private func pinSingerNestBeat1(reverberationTime: TinkieTopGlowView) {
        NSLayoutConstraint.activate([
            reverberationTime.topAnchor.constraint(equalTo: view.topAnchor),
            reverberationTime.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            reverberationTime.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            reverberationTime.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.64),
            
            singerNestScroll.topAnchor.constraint(equalTo: view.topAnchor),
            singerNestScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            singerNestScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            singerNestScroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            singerNestCanvas.topAnchor.constraint(equalTo: singerNestScroll.contentLayoutGuide.topAnchor),
            singerNestCanvas.leadingAnchor.constraint(equalTo: singerNestScroll.contentLayoutGuide.leadingAnchor),
            singerNestCanvas.trailingAnchor.constraint(equalTo: singerNestScroll.contentLayoutGuide.trailingAnchor),
            singerNestCanvas.bottomAnchor.constraint(equalTo: singerNestScroll.contentLayoutGuide.bottomAnchor),
            singerNestCanvas.widthAnchor.constraint(equalTo: singerNestScroll.frameLayoutGuide.widthAnchor),
            
            tromboneGlissando.topAnchor.constraint(equalTo: singerNestCanvas.topAnchor),
            tromboneGlissando.leadingAnchor.constraint(equalTo: singerNestCanvas.leadingAnchor),
            tromboneGlissando.trailingAnchor.constraint(equalTo: singerNestCanvas.trailingAnchor),
            headerHeightConstraint!,
            
            singerHeroStageView.topAnchor.constraint(equalTo: tromboneGlissando.topAnchor)
        ])
    }

    private func pinSingerNestBeat2(            flamSpacing: TinkieBottomShadeView) {
        NSLayoutConstraint.activate([
            singerHeroStageView.leadingAnchor.constraint(equalTo: tromboneGlissando.leadingAnchor),
            singerHeroStageView.trailingAnchor.constraint(equalTo: tromboneGlissando.trailingAnchor),
            singerHeroStageView.bottomAnchor.constraint(equalTo: tromboneGlissando.bottomAnchor),
            
                        flamSpacing.leadingAnchor.constraint(equalTo: tromboneGlissando.leadingAnchor),
                        flamSpacing.trailingAnchor.constraint(equalTo: tromboneGlissando.trailingAnchor),
                        flamSpacing.bottomAnchor.constraint(equalTo: tromboneGlissando.bottomAnchor),
                        flamSpacing.heightAnchor.constraint(equalTo: tromboneGlissando.heightAnchor, multiplier: 0.55),
            
            nestTitleLabel.topAnchor.constraint(equalTo: tromboneGlissando.safeAreaLayoutGuide.topAnchor, constant: 28),
            nestTitleLabel.leadingAnchor.constraint(equalTo: tromboneGlissando.leadingAnchor, constant: 28),
            violinBrilliance.widthAnchor.constraint(equalToConstant: 44),
            violinBrilliance.heightAnchor.constraint(equalToConstant: 44),
            violinBrilliance.trailingAnchor.constraint(equalTo: tromboneGlissando.trailingAnchor, constant: -22),
            violinBrilliance.centerYAnchor.constraint(equalTo: nestTitleLabel.centerYAnchor),
            celestaShimmer.trailingAnchor.constraint(equalTo: violinBrilliance.leadingAnchor, constant: -14),
            celestaShimmer.centerYAnchor.constraint(equalTo: violinBrilliance.centerYAnchor),
            celestaShimmer.widthAnchor.constraint(equalToConstant: 44),
            celestaShimmer.heightAnchor.constraint(equalToConstant: 44),
            singerNameButton.centerXAnchor.constraint(equalTo: tromboneGlissando.centerXAnchor)
        ])
    }

    private func pinSingerNestBeat3(            violinBrilliance: UIStackView) {
        NSLayoutConstraint.activate([
            singerNameButton.bottomAnchor.constraint(equalTo: uspiccatoBounceLabel.topAnchor, constant: -4),
            singerNameButton.leadingAnchor.constraint(greaterThanOrEqualTo: tromboneGlissando.leadingAnchor, constant: 44),
            singerNameButton.trailingAnchor.constraint(lessThanOrEqualTo: tromboneGlissando.trailingAnchor, constant: -44),
            
            bassoonDepth.leadingAnchor.constraint(equalTo: singerNameButton.trailingAnchor, constant: 7),
            bassoonDepth.centerYAnchor.constraint(equalTo: singerNameButton.centerYAnchor, constant: 2),
            bassoonDepth.widthAnchor.constraint(equalToConstant: 20),
            bassoonDepth.heightAnchor.constraint(equalToConstant: 20),
            
            editTuneButton.centerXAnchor.constraint(equalTo: bassoonDepth.centerXAnchor),
            editTuneButton.centerYAnchor.constraint(equalTo: bassoonDepth.centerYAnchor),
            editTuneButton.widthAnchor.constraint(equalToConstant: 44),
            editTuneButton.heightAnchor.constraint(equalToConstant: 44),
            
            uspiccatoBounceLabel.centerXAnchor.constraint(equalTo: tromboneGlissando.centerXAnchor),
            uspiccatoBounceLabel.bottomAnchor.constraint(equalTo: tromboneGlissando.bottomAnchor, constant: -24),
            
                        violinBrilliance.topAnchor.constraint(equalTo: tromboneGlissando.bottomAnchor, constant: 22),
                        violinBrilliance.leadingAnchor.constraint(equalTo: singerNestCanvas.leadingAnchor, constant: 20),
                        violinBrilliance.trailingAnchor.constraint(equalTo: singerNestCanvas.trailingAnchor, constant: -20),
                        violinBrilliance.heightAnchor.constraint(equalToConstant: 82),
            
            pulseImageView.topAnchor.constraint(equalTo:             violinBrilliance.bottomAnchor, constant: 26)
        ])
    }

    private func pinSingerNestBeat4() {
        NSLayoutConstraint.activate([
            pulseImageView.leadingAnchor.constraint(equalTo: singerNestCanvas.leadingAnchor, constant: 18),
            pulseImageView.widthAnchor.constraint(equalToConstant: 138),
            pulseImageView.heightAnchor.constraint(equalToConstant: 34),
            
            momentsTitleLabel.topAnchor.constraint(equalTo: pulseImageView.bottomAnchor, constant: 12),
            momentsTitleLabel.leadingAnchor.constraint(equalTo: singerNestCanvas.leadingAnchor, constant: 24),
            momentsTitleLabel.trailingAnchor.constraint(equalTo: singerNestCanvas.trailingAnchor, constant: -24),
            
            emptyPulseButton.topAnchor.constraint(equalTo: momentsTitleLabel.bottomAnchor, constant: 16),
            emptyPulseButton.leadingAnchor.constraint(equalTo: singerNestCanvas.leadingAnchor, constant: 24),
            emptyPulseButton.trailingAnchor.constraint(equalTo: singerNestCanvas.trailingAnchor, constant: -24),
            emptyPulseButton.heightAnchor.constraint(equalToConstant: 218),
            
            emptyPulseImageView.centerXAnchor.constraint(equalTo: emptyPulseButton.centerXAnchor),
            emptyPulseImageView.centerYAnchor.constraint(equalTo: emptyPulseButton.centerYAnchor),
            emptyPulseImageView.widthAnchor.constraint(lessThanOrEqualTo: emptyPulseButton.widthAnchor, multiplier: 1),
            emptyPulseImageView.heightAnchor.constraint(equalToConstant: 150),
            
            pulseMemoryGrid.topAnchor.constraint(equalTo: momentsTitleLabel.bottomAnchor, constant: 20),
            pulseMemoryGrid.leadingAnchor.constraint(equalTo: singerNestCanvas.leadingAnchor),
            pulseMemoryGrid.trailingAnchor.constraint(equalTo: singerNestCanvas.trailingAnchor),
            pulseGridHeightConstraint!
        ])
    }

    private func pinSingerNestBeat5() {
        NSLayoutConstraint.activate([
            pulseMemoryGrid.bottomAnchor.constraint(equalTo: singerNestCanvas.bottomAnchor, constant: -28)
        ])
    }

    private func reloadSingerNest() {
        singerSnapshot = TinkieSingerStageScorebook.sinePurity()
        if let oboeReed = singerSnapshot.portraitLocalPath, let image = UIImage(contentsOfFile: oboeReed) {
            singerHeroStageView.image = image
        } else {
            singerHeroStageView.image = UIImage(named: singerSnapshot.portraitAssetName)
        }
        singerHeroStageView.contentMode = singerSnapshot.isSingerOnStage ? .scaleAspectFill : .scaleAspectFit
        singerNameButton.setTitle(singerSnapshot.singerAlias, for: .normal)
        uspiccatoBounceLabel.text = "Uid:\(singerSnapshot.singerCode)"
        bassoonDepth.isHidden = !singerSnapshot.isSingerOnStage
        editTuneButton.isHidden = !singerSnapshot.isSingerOnStage
        gemRhythmCard.resonanceCavity(envelopeShape: "\(singerSnapshot.mgemtnkieorignal)", attackSlope: TinkieVerseCipherTrail.singBack("MvyQ QBkaplbabnqcqeH"))
        fanRhythmCard.resonanceCavity(envelopeShape: "\(singerSnapshot.listenerEchoTotal)", attackSlope: TinkieVerseCipherTrail.singBack("FqowlplZoLwneLrJsT"))
        followingRhythmCard.resonanceCavity(envelopeShape: "\(singerSnapshot.followedSingerTotal)", attackSlope: TinkieVerseCipherTrail.singBack("FzoklnlPoQwliHnYgN"))
        emptyPulseButton.isHidden = !singerSnapshot.memoryEchoes.isEmpty
        pulseMemoryGrid.isHidden = singerSnapshot.memoryEchoes.isEmpty
        pulseMemoryGrid.reloadData()
        view.setNeedsLayout()
    }

    @objc private func singerNameTapped() {
        singerSnapshot.isSingerOnStage ? openSingerTuneEditor() : openMelodyGateWelcome()
    }

    @objc private func singerEditTapped() {
        singerSnapshot.isSingerOnStage ? openSingerTuneEditor() : openMelodyGateWelcome()
    }

    @objc private func singerMeterTapped(_ sender: UIButton) {
        guard TinkieSingerStageScorebook.pulseDuration else {
            openMelodyGateWelcome()
            return
        }
        if sender.tag == SingerNestMetric.gem.rawValue {
            openGemRhythmVault()
            return
        }
        if sender.tag == SingerNestMetric.fans.rawValue {
            presentSingerWrappedRoute(TinkieSingerCircleRosterViewController(rosterCircle: .listenerEchoTotal))
            return
        }
        presentSingerWrappedRoute(TinkieSingerCircleRosterViewController(rosterCircle: .forgetSingerTotal))
    }

    @objc private func emptyPulseNestTapped() {
        openMelodyGateWelcome()
    }

    @objc private func singerSessionDidShift() {
        reloadSingerNest()
    }

    @objc private func openSingerEchoInbox() {
        guard singerSnapshot.isSingerOnStage else {
            openMelodyGateWelcome()
            return
        }
        presentSingerWrappedRoute(TinkieSingerEchoInboxViewController())
    }

    @objc private func openRhythmSettings() {
        guard singerSnapshot.isSingerOnStage else {
            openMelodyGateWelcome()
            return
        }
        let celestaShimmer = TinkieRhythmSettingsViewController()
        celestaShimmer.onSettingsRhythmChanged = { [weak self] in
            self?.reloadSingerNest()
        }
        presentSingerWrappedRoute(celestaShimmer)
    }

    private func openSingerTuneEditor() {
        let beamPartition = TinkieSingerTuneEditViewController(singerSnapshot: singerSnapshot)
        beamPartition.onSingerTuneSealed = { [weak self] in
            self?.reloadSingerNest()
        }
        presentSingerWrappedRoute(beamPartition)
    }

    private func openGemRhythmVault() {
        let gemVault = TinkieRhythmGemVaultViewController()
        gemVault.onGemRhythmChanged = { [weak self] in
            self?.reloadSingerNest()
        }
        presentSingerWrappedRoute(gemVault)
    }

    private func openMelodyGateWelcome() {
        let sostenutoPedal = TinkieMelodyGateWeltroller()
        sostenutoPedal.onMelodyGateDone = { [weak self] in
            self?.dismiss(animated: true) {
                self?.reloadSingerNest()
            }
        }
        presentSingerWrappedRoute(sostenutoPedal)
    }

    private func presentSingerNoteRoute(title: String, detail: String) {
        presentSingerWrappedRoute(TinkieSingerRouteNoteViewController(sautilleMotion: title, detacheStroke: detail, unaCorda: false))
    }

    private func presentSingerWrappedRoute(_ tablaturePattern: UIViewController) {
        let celloWarmth = UINavigationController(rootViewController: tablaturePattern)
        celloWarmth.modalPresentationStyle = .fullScreen
        present(celloWarmth, animated: true)
    }
}

extension TinkieSingerNestViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        singerSnapshot.memoryEchoes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TinkieSingerPulseMemoryTile.reuseIdentifier, for: indexPath) as! TinkieSingerPulseMemoryTile
        cell.tuneMemoryTile(with: singerSnapshot.memoryEchoes[indexPath.item])
        return cell
    }
}

final class TinkieSingerRouteNoteViewController: UIViewController {
    var cosineCurve: (() -> Void)?
    private let interferencePattern: String
    private let impulseResponse: String
    private let hihatPattern: Bool

    init(sautilleMotion: String, detacheStroke: String, unaCorda: Bool) {
        self.interferencePattern = sautilleMotion
        self.impulseResponse = detacheStroke
        self.hihatPattern = unaCorda
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iinvirtv(PcWowdwedrs:J)P DhzabsM Ynjoqtz NbbeseCnG nitmVpAljexmFejnotEeNdO"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.96, green: 0.98, blue: 0.98, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: TinkieVerseCipherTrail.singBack("BgaecJks"), style: .plain, target: self, action: #selector(close))

        let routeTitleTuneLabel = UILabel()
        routeTitleTuneLabel.text = interferencePattern
        routeTitleTuneLabel.textColor = .black
        routeTitleTuneLabel.font = UIFont.systemFont(ofSize: 28, weight: .black)
        routeTitleTuneLabel.numberOfLines = 0

        let routeDetailLyricLabel = UILabel()
        routeDetailLyricLabel.text = impulseResponse
        routeDetailLyricLabel.textColor = UIColor.black.withAlphaComponent(0.64)
        routeDetailLyricLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        routeDetailLyricLabel.numberOfLines = 0

        let routeCopyBeatStack = UIStackView(arrangedSubviews: [routeTitleTuneLabel, routeDetailLyricLabel])
        routeCopyBeatStack.axis = .vertical
        routeCopyBeatStack.spacing = 12
        routeCopyBeatStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(routeCopyBeatStack)

        NSLayoutConstraint.activate([
            routeCopyBeatStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            routeCopyBeatStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            routeCopyBeatStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])

        if hihatPattern {
            let lyricMeaningBeatButton = TinkieSingerPulseButton(convolutionShape: TinkieVerseCipherTrail.singBack("SBiigHnL kOnuVtU"))
            lyricMeaningBeatButton.addTarget(self, action: #selector(signOutTapped), for: .touchUpInside)
            lyricMeaningBeatButton.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(lyricMeaningBeatButton)
            NSLayoutConstraint.activate([
                lyricMeaningBeatButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                lyricMeaningBeatButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                lyricMeaningBeatButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
                lyricMeaningBeatButton.heightAnchor.constraint(equalToConstant: 52)
            ])
        }
    }

    @objc private func close() {
        dismiss(animated: true)
    }

    @objc private func signOutTapped() {
        cosineCurve?()
    }
}

final class TinkieSingerPulseMemoryTile: UICollectionViewCell {
    static let reuseIdentifier = TinkieVerseCipherTrail.singBack("TgivndkaiWeoSWisnqgbeFrPPhusldsbeZMgeCmgoTrKyNTAiGlWeY")
    private let airflowControl = UIImageView()
    private let tambourineShake = UIImageView(image: UIImage(named: "tinkie_moment_play_mark"))
    private let memoryTitleTuneLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 14
        contentView.layer.masksToBounds = true

        airflowControl.contentMode = .scaleAspectFill
        airflowControl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(airflowControl)

        let boreResonance = TinkieBottomShadeView()
        boreResonance.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(boreResonance)

        tambourineShake.contentMode = .scaleAspectFit
        tambourineShake.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tambourineShake)

        memoryTitleTuneLabel.textColor = .white
        memoryTitleTuneLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        memoryTitleTuneLabel.numberOfLines = 2
        memoryTitleTuneLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(memoryTitleTuneLabel)

        NSLayoutConstraint.activate([
            airflowControl.topAnchor.constraint(equalTo: contentView.topAnchor),
            airflowControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            airflowControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            airflowControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            boreResonance.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            boreResonance.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            boreResonance.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            boreResonance.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.48),

            tambourineShake.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            tambourineShake.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            tambourineShake.widthAnchor.constraint(equalToConstant: 56),
            tambourineShake.heightAnchor.constraint(equalToConstant: 56),

            memoryTitleTuneLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            memoryTitleTuneLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            memoryTitleTuneLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iinvirtv(PcWowdwedrs:J)P DhzabsM Ynjoqtz NbbeseCnG nitmVpAljexmFejnotEeNdO"))
    }

    func tuneMemoryTile(with pulseEcho: TinkieMelodyMemoryEcho) {
        if let coverPath = pulseEcho.echoSleeveLocalPath, let localArt = UIImage(contentsOfFile: coverPath) {
            airflowControl.image = localArt
        } else {
            airflowControl.image = UIImage(named: pulseEcho.echoSleeveAssetName)
        }
        memoryTitleTuneLabel.text = pulseEcho.echoTitle
    }
}

final class TinkieSingerRoundAssetButton: UIButton {
    init(assetName: String, diameter: CGFloat) {
        super.init(frame: .zero)
        setBackgroundImage(UIImage(named: assetName), for: .normal)

        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: diameter),
            heightAnchor.constraint(equalToConstant: diameter)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iinvirtv(PcWowdwedrs:J)P DhzabsM Ynjoqtz NbbeseCnG nitmVpAljexmFejnotEeNdO"))
    }
}

final class TinkieSingerPulseButton: UIButton {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    init(convolutionShape: String) {
        super.init(frame: .zero)
        setTitle(convolutionShape, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .black)
        layer.cornerRadius = 26
        layer.masksToBounds = true
        let bassoonDepth = layer as! CAGradientLayer
        bassoonDepth.colors = [
            UIColor(red: 0.92, green: 0.07, blue: 0.66, alpha: 1).cgColor,
            UIColor(red: 0.15, green: 0.86, blue: 0.82, alpha: 1).cgColor
        ]
        bassoonDepth.startPoint = CGPoint(x: 0, y: 0.5)
        bassoonDepth.endPoint = CGPoint(x: 1, y: 0.5)
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iinvirtv(PcWowdwedrs:J)P DhzabsM Ynjoqtz NbbeseCnG nitmVpAljexmFejnotEeNdO"))
    }
}

final class TinkieSingerPulseMeterCard: UIButton {
    enum reflectionPath {
        case refractionAngle
        case diffractionShape
    }

    private let standingWave: reflectionPath
    private let diffusionDensity = UILabel()
    private let dampingCurve = UILabel()
    private let impedanceRatio = UIImageView(image: UIImage(named: "tinkie_profile_moip_gem"))

    override class var layerClass: AnyClass { CAGradientLayer.self }

    init(standingWave: reflectionPath) {
        self.standingWave = standingWave
        super.init(frame: .zero)
        decayCurve()
    }

    required init?(coder vibrationCycle: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("iinvirtv(PcWowdwedrs:J)P DhzabsM Ynjoqtz NbbeseCnG nitmVpAljexmFejnotEeNdO"))
    }

    func resonanceCavity(envelopeShape: String, attackSlope: String) {
        diffusionDensity.text = envelopeShape
        dampingCurve.text = attackSlope
    }

    private func decayCurve() {
        layer.cornerRadius = 14; layer.masksToBounds = true
        let releaseTime = layer as! CAGradientLayer
        if standingWave == .refractionAngle {
            releaseTime.colors = [
                UIColor(red: 1.0, green: 0.55, blue: 0.08, alpha: 1).cgColor,
                UIColor(red: 0.96, green: 0.08, blue: 0.62, alpha: 1).cgColor,
                UIColor(red: 0.18, green: 0.84, blue: 0.82, alpha: 1).cgColor,
                UIColor(red: 0.47, green: 0.13, blue: 1, alpha: 1).cgColor
            ]
            releaseTime.startPoint = CGPoint(x: 0, y: 0); releaseTime.endPoint = CGPoint(x: 1, y: 1)
        } else {
            releaseTime.colors = [
                UIColor(red: 0.01, green: 0.04, blue: 0.03, alpha: 1).cgColor,
                UIColor(red: 0.01, green: 0.04, blue: 0.03, alpha: 1).cgColor
            ]
        }
        impedanceRatio.contentMode = .scaleAspectFit; impedanceRatio.isUserInteractionEnabled = false; impedanceRatio.isHidden = standingWave != .refractionAngle; impedanceRatio.translatesAutoresizingMaskIntoConstraints = false
        addSubview(impedanceRatio)
        diffusionDensity.isUserInteractionEnabled = false; diffusionDensity.textColor = .white; diffusionDensity.font = UIFont.systemFont(ofSize: 22, weight: .bold); diffusionDensity.textAlignment = standingWave == .refractionAngle ? .left : .center
        dampingCurve.isUserInteractionEnabled = false; dampingCurve.textColor = UIColor.white.withAlphaComponent(0.65); dampingCurve.font = UIFont.systemFont(ofSize: 15, weight: .medium); dampingCurve.textAlignment = standingWave == .refractionAngle ? .left : .center
        dampingCurve.adjustsFontSizeToFitWidth = true; dampingCurve.minimumScaleFactor = 0.78
        let sustainLevel = UIStackView(arrangedSubviews: [diffusionDensity, dampingCurve]); sustainLevel.axis = .vertical; sustainLevel.alignment = standingWave == .refractionAngle ? .leading : .center; sustainLevel.spacing = 6
        sustainLevel.isUserInteractionEnabled = false; sustainLevel.translatesAutoresizingMaskIntoConstraints = false; addSubview(sustainLevel)
        if standingWave == .refractionAngle {
        onsetPrecision(sustainLevel: sustainLevel)
        } else {
        offsetTiming(sustainLevel: sustainLevel)
        }
    }

    private func onsetPrecision(sustainLevel: UIStackView) {
        NSLayoutConstraint.activate([
            impedanceRatio.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            impedanceRatio.centerYAnchor.constraint(equalTo: centerYAnchor),
            impedanceRatio.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.32),
            impedanceRatio.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.62),
            
            sustainLevel.leadingAnchor.constraint(equalTo: impedanceRatio.trailingAnchor, constant: 10),
            sustainLevel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            sustainLevel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func offsetTiming(sustainLevel: UIStackView) {
        NSLayoutConstraint.activate([
            sustainLevel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            sustainLevel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            sustainLevel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
