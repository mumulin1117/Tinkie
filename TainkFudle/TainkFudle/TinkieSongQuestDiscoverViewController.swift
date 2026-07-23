import UIKit

final class TinkieSongQuestDiscoverViewController: UIViewController {
    var onChallengeCuePicked: ((TinkieMelodyChallengeCue) -> Void)?
    private let questScrollStage = UIScrollView()
    private let questContentStage = UIView()
    private let questCarousel: UICollectionView
    private let pulseSparkCollection: UICollectionView
    private var questCarouselBeatTimer: Timer?
    private var visibleChallengeCues: [TinkieMelodyChallengeCue] {
        (TinkieMelodyChallengeForgeScorebook.allForgedMelodyChallenges() + TinkieSongSeedSongbook.melodyChallengeSongbook).filter { TinkieSongShieldLedger.keepsMelodyChallengeVisible($0) }
    }
    private var popularPulseSparks: [TinkieSongPulseSpark] = []

    init() {
        let questCarouselFlow = TinkieScalingFlowLayout()
        questCarouselFlow.scrollDirection = .horizontal
        questCarouselFlow.minimumLineSpacing = -18
        questCarousel = UICollectionView(frame: .zero, collectionViewLayout: questCarouselFlow)

        let pulseSparkLayout = UICollectionViewFlowLayout()
        pulseSparkLayout.scrollDirection = .horizontal
        pulseSparkLayout.minimumLineSpacing = 12
        pulseSparkCollection = UICollectionView(frame: .zero, collectionViewLayout: pulseSparkLayout)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("ibnaintb(AcEondnesru:H)A ShjaxsC Wnfowtj CbxemeLnD miymZpLlhekmPefnptMeCdY"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 0.98, alpha: 1)
        refreshPopularPulseSparks()
        putSongQuestDiscoverTogether()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshPopularPulseSparks()
        questCarousel.reloadData()
        pulseSparkCollection.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startQuestCarouselBeat()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopQuestCarouselBeat()
    }

    deinit {
        stopQuestCarouselBeat()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let questCarouselFlow = questCarousel.collectionViewLayout as? UICollectionViewFlowLayout {
            let questCardWidth = max(245, min(282, view.bounds.width * 0.72))
            questCarouselFlow.itemSize = CGSize(width: questCardWidth, height: 333)
            let questSideInset = max(20, (view.bounds.width - questCardWidth) / 2)
            questCarouselFlow.sectionInset = UIEdgeInsets(top: 0, left: questSideInset, bottom: 0, right: questSideInset)
        }
        if let layout = pulseSparkCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            let cardWidth = max(142, min(162, (view.bounds.width - 44) / 2))
            layout.itemSize = CGSize(width: cardWidth, height: 186)
            layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }

    private func putSongQuestDiscoverTogether() {
        let discoverGlow = TinkieTopGlowView(); discoverGlow.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(discoverGlow)
        questScrollStage.translatesAutoresizingMaskIntoConstraints = false; questScrollStage.alwaysBounceVertical = true; questScrollStage.showsVerticalScrollIndicator = false; view.addSubview(questScrollStage)
        questContentStage.translatesAutoresizingMaskIntoConstraints = false; questScrollStage.addSubview(questContentStage)
        let brandTuneLabel = UILabel(); brandTuneLabel.text = TinkieVerseCipherTrail.singBack("TiidnqkoiXew"); brandTuneLabel.font = UIFont.systemFont(ofSize: 24, weight: .black); brandTuneLabel.textColor = .black
        let alertButton = TinkieTuneArtworkButton(assetName: "tinkie_discover_notice_bell", size: CGSize(width: 38, height: 38)); alertButton.addTarget(self, action: #selector(openSingerEchoInbox), for: .touchUpInside); let questForgeButton = TinkieTuneArtworkButton(assetName: "tinkie_discover_create_capsule", size: CGSize(width: 100, height: 38)); questForgeButton.addTarget(self, action: #selector(openQuestForge), for: .touchUpInside)
        let discoverHeaderBand = UIStackView(arrangedSubviews: [brandTuneLabel, UIView(), alertButton, questForgeButton]); discoverHeaderBand.axis = .horizontal; discoverHeaderBand.alignment = .center; discoverHeaderBand.spacing = 10
        discoverHeaderBand.translatesAutoresizingMaskIntoConstraints = false; questContentStage.addSubview(discoverHeaderBand)
        questCarousel.backgroundColor = .clear; questCarousel.showsHorizontalScrollIndicator = false; questCarousel.decelerationRate = .fast; questCarousel.dataSource = self
        questCarousel.delegate = self; questCarousel.register(TinkieSongQuestCarouselCard.self, forCellWithReuseIdentifier: TinkieSongQuestCarouselCard.reuseIdentifier); questCarousel.translatesAutoresizingMaskIntoConstraints = false; questContentStage.addSubview(questCarousel)
        let popularBadge = TinkieAssetBadgeView(assetName: "tinkie_discover_popular_badge"); popularBadge.translatesAutoresizingMaskIntoConstraints = false; questContentStage.addSubview(popularBadge)
        pulseSparkCollection.backgroundColor = .clear; pulseSparkCollection.showsHorizontalScrollIndicator = false; pulseSparkCollection.dataSource = self; pulseSparkCollection.delegate = self
        pulseSparkCollection.register(TinkieSongPulsePopularTile.self, forCellWithReuseIdentifier: TinkieSongPulsePopularTile.reuseIdentifier); pulseSparkCollection.translatesAutoresizingMaskIntoConstraints = false; questContentStage.addSubview(pulseSparkCollection)
        pinSongQuestDiscoverBeat1(discoverGlow: discoverGlow, alertButton: alertButton, discoverHeaderBand: discoverHeaderBand); pinSongQuestDiscoverBeat2(questForgeButton: questForgeButton, discoverHeaderBand: discoverHeaderBand, popularBadge: popularBadge)
    }

    private func pinSongQuestDiscoverBeat1(discoverGlow: TinkieTopGlowView, alertButton: TinkieTuneArtworkButton, discoverHeaderBand: UIStackView) {
        NSLayoutConstraint.activate([
            discoverGlow.topAnchor.constraint(equalTo: view.topAnchor),
            discoverGlow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            discoverGlow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            discoverGlow.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.28),
            
            questScrollStage.topAnchor.constraint(equalTo: view.topAnchor),
            questScrollStage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            questScrollStage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            questScrollStage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            questContentStage.topAnchor.constraint(equalTo: questScrollStage.contentLayoutGuide.topAnchor),
            questContentStage.leadingAnchor.constraint(equalTo: questScrollStage.contentLayoutGuide.leadingAnchor),
            questContentStage.trailingAnchor.constraint(equalTo: questScrollStage.contentLayoutGuide.trailingAnchor),
            questContentStage.bottomAnchor.constraint(equalTo: questScrollStage.contentLayoutGuide.bottomAnchor),
            questContentStage.widthAnchor.constraint(equalTo: questScrollStage.frameLayoutGuide.widthAnchor),
            
            discoverHeaderBand.topAnchor.constraint(equalTo: questContentStage.safeAreaLayoutGuide.topAnchor, constant: 18),
            discoverHeaderBand.leadingAnchor.constraint(equalTo: questContentStage.leadingAnchor, constant: 20),
            discoverHeaderBand.trailingAnchor.constraint(equalTo: questContentStage.trailingAnchor, constant: -20),
            
            alertButton.widthAnchor.constraint(equalToConstant: 38),
            alertButton.heightAnchor.constraint(equalToConstant: 38)
        ])
    }

    private func pinSongQuestDiscoverBeat2(questForgeButton: TinkieTuneArtworkButton, discoverHeaderBand: UIStackView, popularBadge: TinkieAssetBadgeView) {
        NSLayoutConstraint.activate([
            questForgeButton.widthAnchor.constraint(equalToConstant: 100),
            questForgeButton.heightAnchor.constraint(equalToConstant: 38),
            
            questCarousel.topAnchor.constraint(equalTo: discoverHeaderBand.bottomAnchor, constant: 18),
            questCarousel.leadingAnchor.constraint(equalTo: questContentStage.leadingAnchor),
            questCarousel.trailingAnchor.constraint(equalTo: questContentStage.trailingAnchor),
            questCarousel.heightAnchor.constraint(equalToConstant: 333),
            
            popularBadge.topAnchor.constraint(equalTo: questCarousel.bottomAnchor, constant: 18),
            popularBadge.leadingAnchor.constraint(equalTo: questContentStage.leadingAnchor, constant: 22),
            popularBadge.widthAnchor.constraint(equalToConstant: 144),
            popularBadge.heightAnchor.constraint(equalToConstant: 30),
            
            pulseSparkCollection.topAnchor.constraint(equalTo: popularBadge.bottomAnchor, constant: 14),
            pulseSparkCollection.leadingAnchor.constraint(equalTo: questContentStage.leadingAnchor),
            pulseSparkCollection.trailingAnchor.constraint(equalTo: questContentStage.trailingAnchor),
            pulseSparkCollection.heightAnchor.constraint(equalToConstant: 196),
            pulseSparkCollection.bottomAnchor.constraint(equalTo: questContentStage.bottomAnchor, constant: -24)
        ])
    }
}

extension TinkieSongQuestDiscoverViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView === questCarousel ? visibleChallengeCues.count : popularPulseSparks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === questCarousel {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TinkieSongQuestCarouselCard.reuseIdentifier, for: indexPath) as! TinkieSongQuestCarouselCard
            let challengeCue = visibleChallengeCues[indexPath.item]
            cell.tuneQuestCard(with: challengeCue)
            cell.onQuestMoreTapped = { [weak self] in
                self?.openChallengeCueOptions(for: challengeCue)
            }
            return cell
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TinkieSongPulsePopularTile.reuseIdentifier, for: indexPath) as! TinkieSongPulsePopularTile
        let popularPulseSpark = popularPulseSparks[indexPath.item]
        cell.tunePopularPulseTile(with: popularPulseSpark)
        cell.onPulseMoreTapped = { [weak self] in
            self?.openPulseSparkOptions(for: popularPulseSpark)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView === questCarousel {
            onChallengeCuePicked?(visibleChallengeCues[indexPath.item])
        } else {
            openPulseSparkDetail(for: popularPulseSparks[indexPath.item])
        }
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard scrollView === questCarousel, let questCarouselFlow = questCarousel.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let questStepWidth = questCarouselFlow.itemSize.width + questCarouselFlow.minimumLineSpacing
        guard questStepWidth > 0 else { return }
        let proposedCenter = targetContentOffset.pointee.x + questCarousel.bounds.width / 2
        let targetIndex = round((proposedCenter - questCarouselFlow.sectionInset.left - questCarouselFlow.itemSize.width / 2) / questStepWidth)
        let clamped = max(0, min(CGFloat(visibleChallengeCues.count - 1), targetIndex))
        targetContentOffset.pointee.x = clamped * questStepWidth + questCarouselFlow.sectionInset.left + questCarouselFlow.itemSize.width / 2 - questCarousel.bounds.width / 2
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard scrollView === questCarousel else { return }
        stopQuestCarouselBeat()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView === questCarousel else { return }
        startQuestCarouselBeat()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard scrollView === questCarousel, !decelerate else { return }
        startQuestCarouselBeat()
    }
}

private extension TinkieSongQuestDiscoverViewController {
    func startQuestCarouselBeat() {
        stopQuestCarouselBeat()
        guard visibleChallengeCues.count > 1 else { return }
        let beatTimer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(playNextQuestCarouselBeat),
            userInfo: nil,
            repeats: true
        )
        RunLoop.main.add(beatTimer, forMode: .common)
        questCarouselBeatTimer = beatTimer
    }

    func stopQuestCarouselBeat() {
        questCarouselBeatTimer?.invalidate()
        questCarouselBeatTimer = nil
    }

    @objc func playNextQuestCarouselBeat() {
        let questCount = visibleChallengeCues.count
        guard questCount > 1, view.window != nil else {
            stopQuestCarouselBeat()
            return
        }
        questCarousel.layoutIfNeeded()
        let currentIndex = centeredQuestCarouselIndex() ?? 0
        let nextIndex = (currentIndex + 1) % questCount
        questCarousel.scrollToItem(
            at: IndexPath(item: nextIndex, section: 0),
            at: .centeredHorizontally,
            animated: true
        )
    }

    func centeredQuestCarouselIndex() -> Int? {
        let questCenter = questCarousel.convert(CGPoint(x: questCarousel.bounds.midX, y: questCarousel.bounds.midY), to: questCarousel)
        return questCarousel.indexPathsForVisibleItems.min { leftPath, rightPath in
            guard
                let leftAttributes = questCarousel.layoutAttributesForItem(at: leftPath),
                let rightAttributes = questCarousel.layoutAttributesForItem(at: rightPath)
            else { return leftPath.item < rightPath.item }
            return abs(leftAttributes.center.x - questCenter.x) < abs(rightAttributes.center.x - questCenter.x)
        }?.item
    }

    func openChallengeCueOptions(for challengeCue: TinkieMelodyChallengeCue) {
        tinkiePresentRhythmShield(
            tuneTitle: challengeCue.challengeTitle,
            tuneKey: TinkieSongShieldLedger.melodyChallengeKey(for: challengeCue),
            tuneKind: TinkieVerseCipherTrail.singBack("akcRtOiOvYiTtByH"),
            onShieldDone: { [weak self] in
                self?.questCarousel.reloadData()
            }
        )
    }

    func openPulseSparkOptions(for popularPulseSpark: TinkieSongPulseSpark) {
        tinkiePresentRhythmShield(
            tuneTitle: popularPulseSpark.performer,
            tuneKey: TinkieSongShieldLedger.pulseKey(for: popularPulseSpark),
            tuneKind: TinkieVerseCipherTrail.singBack("cMlLiMpX"),
            onShieldDone: { [weak self] in
                self?.refreshPopularPulseSparks()
                self?.pulseSparkCollection.reloadData()
            }
        )
    }

    func refreshPopularPulseSparks() {
        popularPulseSparks = Array(TinkieSongSeedSongbook.seedPulseSparkTunes.filter { TinkieSongShieldLedger.keepsPulseVisible($0) }.shuffled().prefix(3))
    }

    func openPulseSparkDetail(for popularPulseSpark: TinkieSongPulseSpark) {
        let key = [popularPulseSpark.performer, popularPulseSpark.coverName, popularPulseSpark.pulseFileName].joined(separator: "::")
        let detail = TinkieRhythmSparkDetailViewController(
            pulseSpark: popularPulseSpark,
            bonded: TinkieRhythmBondScorebook.hasRhythmBond(for: key)
        )
        detail.modalPresentationStyle = .fullScreen
        present(detail, animated: true)
    }

    func handleGuardedQuestNote(tuneTitle: String, tuneDetail: String) {
        guard TinkieSingerStageScorebook.isSingerOnStage else {
            openWelcome()
            return
        }
        let route = TinkieSingerRouteNoteViewController(titleText: tuneTitle, detailText: tuneDetail, showsSignOut: false)
        let navigation = UINavigationController(rootViewController: route)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    func openWelcome() {
        let welcome = TinkieMelodyGateWelcomeViewController()
        welcome.onMelodyGateDone = { [weak self] in
            self?.dismiss(animated: true)
        }
        let navigation = UINavigationController(rootViewController: welcome)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    @objc func openQuestForge() {
        guard TinkieSingerStageScorebook.isSingerOnStage else {
            openWelcome()
            return
        }
        let create = TinkieSongQuestForgeViewController()
        create.onQuestReady = { [weak self] in
            self?.questCarousel.reloadData()
            self?.questCarousel.setContentOffset(.zero, animated: false)
            self?.startQuestCarouselBeat()
        }
        let navigation = UINavigationController(rootViewController: create)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    @objc func openSingerEchoInbox() {
        guard TinkieSingerStageScorebook.isSingerOnStage else {
            openWelcome()
            return
        }
        let inbox = TinkieSingerEchoInboxViewController()
        let navigation = UINavigationController(rootViewController: inbox)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }
}
