import UIKit

final class TinkieBassDeckller: UIViewController {
    var onSelectEvent: ((TinkieLyricFlow) -> Void)?
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let eventsCollection: UICollectionView
    private let clipsCollection: UICollectionView
    private var events: [TinkieLyricFlow] {
        (TinkieSongQuestDraftStore.allEvents() + TinkieDemoLibrary.events).filter { TinkieBassTrailre.allowsEvent($0) }
    }
    private var popularClips: [TinkieReelClip] = []

    init() {
        let eventLayout = TinkieScalingFlowLayout()
        eventLayout.scrollDirection = .horizontal
        eventLayout.minimumLineSpacing = -18
        eventsCollection = UICollectionView(frame: .zero, collectionViewLayout: eventLayout)

        let clipLayout = UICollectionViewFlowLayout()
        clipLayout.scrollDirection = .horizontal
        clipLayout.minimumLineSpacing = 12
        clipsCollection = UICollectionView(frame: .zero, collectionViewLayout: clipLayout)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 0.98, alpha: 1)
        reloadPopularClips()
        buildLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadPopularClips()
        eventsCollection.reloadData()
        clipsCollection.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let layout = eventsCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = max(245, min(282, view.bounds.width * 0.72))
            layout.itemSize = CGSize(width: width, height: 333)
            let inset = max(20, (view.bounds.width - width) / 2)
            layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        }
        if let layout = clipsCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            let cardWidth = max(142, min(162, (view.bounds.width - 44) / 2))
            layout.itemSize = CGSize(width: cardWidth, height: 186)
            layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }

    private func buildLayout() {
        let gradient = TinkieTopGlowView()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gradient)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        let title = UILabel()
        title.text = "Tinkie"
        title.font = UIFont.systemFont(ofSize: 24, weight: .black)
        title.textColor = .black

        let alertButton = TinkieALyricRevea(assetName: "tinkie_discover_notice_bell", size: CGSize(width: 38, height: 38))
        alertButton.addTarget(self, action: #selector(openFriendInbox), for: .touchUpInside)
        let createButton = TinkieALyricRevea(assetName: "tinkie_discover_create_capsule", size: CGSize(width: 100, height: 38))
        createButton.addTarget(self, action: #selector(openCreateQuest), for: .touchUpInside)
        let header = UIStackView(arrangedSubviews: [title, UIView(), alertButton, createButton])
        header.axis = .horizontal
        header.alignment = .center
        header.spacing = 10
        header.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(header)

        eventsCollection.backgroundColor = .clear
        eventsCollection.showsHorizontalScrollIndicator = false
        eventsCollection.decelerationRate = .fast
        eventsCollection.dataSource = self
        eventsCollection.delegate = self
        eventsCollection.register(tinkiTuneEchoCell.self, forCellWithReuseIdentifier: tinkiTuneEchoCell.reuseIdentifier)
        eventsCollection.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(eventsCollection)

        let popularBadge = TinkieAssetBadgeView(assetName: "tinkie_discover_popular_badge")
        popularBadge.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(popularBadge)

        clipsCollection.backgroundColor = .clear
        clipsCollection.showsHorizontalScrollIndicator = false
        clipsCollection.dataSource = self
        clipsCollection.delegate = self
        clipsCollection.register(tinkiTSingerHint.self, forCellWithReuseIdentifier: tinkiTSingerHint.reuseIdentifier)
        clipsCollection.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(clipsCollection)

        NSLayoutConstraint.activate([
            gradient.topAnchor.constraint(equalTo: view.topAnchor),
            gradient.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradient.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradient.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.28),

            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            header.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 18),
            header.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            header.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            alertButton.widthAnchor.constraint(equalToConstant: 38),
            alertButton.heightAnchor.constraint(equalToConstant: 38),
            createButton.widthAnchor.constraint(equalToConstant: 100),
            createButton.heightAnchor.constraint(equalToConstant: 38),

            eventsCollection.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 18),
            eventsCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            eventsCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            eventsCollection.heightAnchor.constraint(equalToConstant: 333),

            popularBadge.topAnchor.constraint(equalTo: eventsCollection.bottomAnchor, constant: 18),
            popularBadge.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            popularBadge.widthAnchor.constraint(equalToConstant: 144),
            popularBadge.heightAnchor.constraint(equalToConstant: 30),

            clipsCollection.topAnchor.constraint(equalTo: popularBadge.bottomAnchor, constant: 14),
            clipsCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            clipsCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            clipsCollection.heightAnchor.constraint(equalToConstant: 196),
            clipsCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
}

extension TinkieBassDeckller: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView === eventsCollection ? events.count : popularClips.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === eventsCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tinkiTuneEchoCell.reuseIdentifier, for: indexPath) as! tinkiTuneEchoCell
            let event = events[indexPath.item]
            cell.configure(with: event)
            cell.onMoreTapped = { [weak self] in
                self?.openEventOptions(for: event)
            }
            return cell
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tinkiTSingerHint.reuseIdentifier, for: indexPath) as! tinkiTSingerHint
        let clip = popularClips[indexPath.item]
        cell.configure(with: clip)
        cell.onMoreTapped = { [weak self] in
            self?.openClipOptions(for: clip)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView === eventsCollection {
            onSelectEvent?(events[indexPath.item])
        } else {
            openRhythmDetail(for: popularClips[indexPath.item])
        }
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard scrollView === eventsCollection, let layout = eventsCollection.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let cellWidth = layout.itemSize.width + layout.minimumLineSpacing
        guard cellWidth > 0 else { return }
        let proposedCenter = targetContentOffset.pointee.x + eventsCollection.bounds.width / 2
        let targetIndex = round((proposedCenter - layout.sectionInset.left - layout.itemSize.width / 2) / cellWidth)
        let clamped = max(0, min(CGFloat(events.count - 1), targetIndex))
        targetContentOffset.pointee.x = clamped * cellWidth + layout.sectionInset.left + layout.itemSize.width / 2 - eventsCollection.bounds.width / 2
    }
}

private extension TinkieBassDeckller {
    func openEventOptions(for event: TinkieLyricFlow) {
        tinkiePresentSafetyOptions(
            targetTitle: event.title,
            targetKey: TinkieBassTrailre.activityKey(for: event),
            targetKind: "activity",
            onBlock: { [weak self] in
                self?.eventsCollection.reloadData()
            }
        )
    }

    func openClipOptions(for clip: TinkieReelClip) {
        tinkiePresentSafetyOptions(
            targetTitle: clip.performer,
            targetKey: TinkieBassTrailre.pulseKey(for: clip),
            targetKind: "clip",
            onBlock: { [weak self] in
                self?.reloadPopularClips()
                self?.clipsCollection.reloadData()
            }
        )
    }

    func reloadPopularClips() {
        popularClips = Array(TinkieDemoLibrary.clips.filter { TinkieBassTrailre.allowsClip($0) }.shuffled().prefix(3))
    }

    func openRhythmDetail(for clip: TinkieReelClip) {
        let key = [clip.performer, clip.coverName, clip.clipFileName].joined(separator: "::")
        let detail = RefrainCircleController(
            clip: clip,
            bonded: TinkieRhythmBondStore.hasBond(for: key)
        )
        detail.modalPresentationStyle = .fullScreen
        present(detail, animated: true)
    }

    func handleGuardedOption(title: String, detail: String) {
        guard TinkieProfileStore.isSignedIn else {
            openWelcome()
            return
        }
        let route = TinkieProfileRouteViewController(titleText: title, detailText: detail, showsSignOut: false)
        let navigation = UINavigationController(rootViewController: route)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    func openWelcome() {
        let welcome = TinkieDrumEchoer()
        welcome.onComplete = { [weak self] in
            self?.dismiss(animated: true)
        }
        let navigation = UINavigationController(rootViewController: welcome)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    @objc func openCreateQuest() {
        guard TinkieProfileStore.isSignedIn else {
            openWelcome()
            return
        }
        let create = TinkieSongQuestCreateViewController()
        create.onQuestReady = { [weak self] in
            self?.eventsCollection.reloadData()
            self?.eventsCollection.setContentOffset(.zero, animated: false)
        }
        let navigation = UINavigationController(rootViewController: create)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    @objc func openFriendInbox() {
        guard TinkieProfileStore.isSignedIn else {
            openWelcome()
            return
        }
        let inbox = TinkieBridgeArctroller()
        let navigation = UINavigationController(rootViewController: inbox)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }
}
