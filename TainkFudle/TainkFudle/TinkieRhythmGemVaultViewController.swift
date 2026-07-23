import StoreKit
import UIKit

struct TinkieRhythmGemBundle {
    let gemCount: Int
    let shelfText: String
    let storeTuneKey: String
}

private enum TinkieRhythmGemBundleShelf {
    static let songPacks: [TinkieRhythmGemBundle] = [
        TinkieRhythmGemBundle(gemCount: 375, shelfText: "$0.99", storeTuneKey: "yqfutpqjmjsdlssh"),
        TinkieRhythmGemBundle(gemCount: 750, shelfText: "$1.99", storeTuneKey: "smvlupswuizcprsp"),
        TinkieRhythmGemBundle(gemCount: 2350, shelfText: "$4.99", storeTuneKey: "qiipwmtzuvbizies"),
        TinkieRhythmGemBundle(gemCount: 5050, shelfText: "$9.99", storeTuneKey: "dyhtjsymwaystfzz"),
        TinkieRhythmGemBundle(gemCount: 10750, shelfText: "$19.99", storeTuneKey: "qmbaawbsgmipaoyb"),
        TinkieRhythmGemBundle(gemCount: 28250, shelfText: "$49.99", storeTuneKey: "orzvcboubataxrdk"),
        TinkieRhythmGemBundle(gemCount: 62500, shelfText: "$99.99", storeTuneKey: "woudsinjqydfvpdc")
    ]

    static func storeKeys(from packs: [TinkieRhythmGemBundle]) -> Set<String> {
        Set(packs.map(\.storeTuneKey))
    }
}

private struct TinkieRhythmGemStoreRack {
    private var storeSongs: [String: Product] = [:]

    mutating func holdStoreSongs(_ songs: [Product]) {
        storeSongs = Dictionary(uniqueKeysWithValues: songs.map { ($0.id, $0) })
    }

    mutating func clearStoreSongs() {
        storeSongs = [:]
    }

    func song(for pack: TinkieRhythmGemBundle) -> Product? {
        storeSongs[pack.storeTuneKey]
    }

    func shelfText(for pack: TinkieRhythmGemBundle) -> String {
        song(for: pack)?.displayPrice ?? pack.shelfText
    }
}

final class TinkieRhythmGemVaultViewController: UIViewController {
    var onGemRhythmChanged: (() -> Void)?

    private let gemBalanceLabel = UILabel()
    private let gemPackGrid: UICollectionView
    private var rhythmStoreRack = TinkieRhythmGemStoreRack()

    private let gemPacks = TinkieRhythmGemBundleShelf.songPacks

    init() {
        let gemGridFlow = UICollectionViewFlowLayout()
        gemGridFlow.scrollDirection = .vertical
        gemGridFlow.minimumInteritemSpacing = 10
        gemGridFlow.minimumLineSpacing = 12
        gemPackGrid = UICollectionView(frame: .zero, collectionViewLayout: gemGridFlow)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        putRhythmGemVaultStageTogether()
        reloadGemRhythmBalance()
        Task { await loadGemStoreTunes() }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let gemGridFlow = gemPackGrid.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let rhythmSideInset: CGFloat = view.bounds.width <= 340 ? 14 : 20
        let rhythmPackSpacing: CGFloat = view.bounds.width <= 340 ? 8 : 10
        let rhythmPackWidth = floor((view.bounds.width - rhythmSideInset * 2 - rhythmPackSpacing * 2) / 3)
        gemGridFlow.sectionInset = UIEdgeInsets(top: 0, left: rhythmSideInset, bottom: 28, right: rhythmSideInset)
        gemGridFlow.minimumInteritemSpacing = rhythmPackSpacing
        gemGridFlow.itemSize = CGSize(width: max(92, rhythmPackWidth), height: 126)
    }

    private func putRhythmGemVaultStageTogether() {
        view.backgroundColor = UIColor(red: 0.96, green: 0.98, blue: 0.98, alpha: 1)

        let vaultTopGlow = TinkieRhythmGemVaultGlowView()
        vaultTopGlow.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vaultTopGlow)

        let vaultBackButton = TinkieSongQuestRoundIconButton(symbolName: "chevron.left")
        vaultBackButton.tintColor = .black
        vaultBackButton.addTarget(self, action: #selector(closeGemRhythmVaultTapped), for: .touchUpInside)
        vaultBackButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vaultBackButton)

        let vaultTitleLabel = UILabel()
        vaultTitleLabel.text = "My wallet"
        vaultTitleLabel.textColor = .black
        vaultTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
        vaultTitleLabel.textAlignment = .center
        vaultTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vaultTitleLabel)

        let gemSummaryCard = UIView()
        gemSummaryCard.backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.04, alpha: 1)
        gemSummaryCard.layer.cornerRadius = 30
        gemSummaryCard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gemSummaryCard)

        let gemHeroImageView = UIImageView(image: UIImage(named: "tinkie_profile_balance_gem"))
        gemHeroImageView.contentMode = .scaleAspectFit
        gemHeroImageView.translatesAutoresizingMaskIntoConstraints = false
        gemSummaryCard.addSubview(gemHeroImageView)

        gemBalanceLabel.textColor = .white
        gemBalanceLabel.font = UIFont.systemFont(ofSize: 27, weight: .black)
        gemBalanceLabel.textAlignment = .center
        gemBalanceLabel.adjustsFontSizeToFitWidth = true
        gemBalanceLabel.minimumScaleFactor = 0.72
        gemBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        gemSummaryCard.addSubview(gemBalanceLabel)

        let gemCaptionLabel = UILabel()
        gemCaptionLabel.text = "My Gems"
        gemCaptionLabel.textColor = UIColor.white.withAlphaComponent(0.78)
        gemCaptionLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        gemCaptionLabel.textAlignment = .center
        gemCaptionLabel.translatesAutoresizingMaskIntoConstraints = false
        gemSummaryCard.addSubview(gemCaptionLabel)

        gemPackGrid.backgroundColor = .clear
        gemPackGrid.dataSource = self
        gemPackGrid.delegate = self
        gemPackGrid.alwaysBounceVertical = true
        gemPackGrid.register(TinkieRhythmGemBundleTile.self, forCellWithReuseIdentifier: TinkieRhythmGemBundleTile.reuseIdentifier)
        gemPackGrid.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gemPackGrid)

        NSLayoutConstraint.activate([
            vaultTopGlow.topAnchor.constraint(equalTo: view.topAnchor),
            vaultTopGlow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vaultTopGlow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            vaultTopGlow.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.42),

            vaultBackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            vaultBackButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 44),

            vaultTitleLabel.centerYAnchor.constraint(equalTo: vaultBackButton.centerYAnchor),
            vaultTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            gemSummaryCard.topAnchor.constraint(equalTo: vaultTitleLabel.bottomAnchor, constant: 50),
            gemSummaryCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            gemSummaryCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            gemSummaryCard.heightAnchor.constraint(equalToConstant: 132),

            gemHeroImageView.centerXAnchor.constraint(equalTo: gemSummaryCard.centerXAnchor),
            gemHeroImageView.centerYAnchor.constraint(equalTo: gemSummaryCard.topAnchor, constant: 6),
            gemHeroImageView.widthAnchor.constraint(equalToConstant: 104),
            gemHeroImageView.heightAnchor.constraint(equalToConstant: 78),

            gemBalanceLabel.topAnchor.constraint(equalTo: gemSummaryCard.topAnchor, constant: 66),
            gemBalanceLabel.leadingAnchor.constraint(equalTo: gemSummaryCard.leadingAnchor, constant: 20),
            gemBalanceLabel.trailingAnchor.constraint(equalTo: gemSummaryCard.trailingAnchor, constant: -20),

            gemCaptionLabel.topAnchor.constraint(equalTo: gemBalanceLabel.bottomAnchor, constant: 4),
            gemCaptionLabel.leadingAnchor.constraint(equalTo: gemBalanceLabel.leadingAnchor),
            gemCaptionLabel.trailingAnchor.constraint(equalTo: gemBalanceLabel.trailingAnchor),

            gemPackGrid.topAnchor.constraint(equalTo: gemSummaryCard.bottomAnchor, constant: 22),
            gemPackGrid.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gemPackGrid.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gemPackGrid.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func reloadGemRhythmBalance() {
        gemBalanceLabel.text = "\(TinkieSingerStageScorebook.currentSingerStage().balance)"
    }

    private func loadGemStoreTunes() async {
        do {
            let storeRhythmItems = try await Product.products(for: TinkieRhythmGemBundleShelf.storeKeys(from: gemPacks))
            rhythmStoreRack.holdStoreSongs(storeRhythmItems)
            gemPackGrid.reloadData()
        } catch {
            rhythmStoreRack.clearStoreSongs()
        }
    }

    private func startGemBundleRhythm(for pack: TinkieRhythmGemBundle) {
        guard TinkieSingerStageScorebook.isSingerOnStage else {
            showGemRhythmNotice(title: "Login Required", detailText: "Please log in before adding Gems.")
            return
        }
        guard let storeSong = rhythmStoreRack.song(for: pack) else {
            showGemRhythmNotice(title: "Recharge Unavailable", detailText: "This Gem pack is not available from the App Store right now. Please check your in-app item configuration.")
            return
        }
        Task {
            await runGemBundleStoreVerse(storeSong, pack: pack)
        }
    }

    private func runGemBundleStoreVerse(_ storeSong: Product, pack: TinkieRhythmGemBundle) async {
        do {
            let storeResult = try await storeSong.purchase()
            switch storeResult {
            case .success(let storeProof):
                do {
                    let rhythmTransaction = try unwrapGemStoreProof(storeProof)
                    await rhythmTransaction.finish()
                    addGemBundleToSinger(pack)
                } catch {
                    showGemRhythmNotice(title: "Recharge Failed", detailText: "The App Store could not complete this Gem recharge.")
                }
            case .userCancelled:
                break
            case .pending:
                showGemRhythmNotice(title: "Recharge Pending", detailText: "Your App Store confirmation is still pending.")
            @unknown default:
                showGemRhythmNotice(title: "Recharge Pending", detailText: "Please check your App Store confirmation status.")
            }
        } catch {
            showGemRhythmNotice(title: "Recharge Failed", detailText: "The App Store could not complete this Gem recharge.")
        }
    }

    private func addGemBundleToSinger(_ pack: TinkieRhythmGemBundle) {
        TinkieSingerStageScorebook.addGemRhythm(pack.gemCount)
        reloadGemRhythmBalance()
        onGemRhythmChanged?()
        showGemRhythmNotice(title: "Recharge Complete", detailText: "\(pack.gemCount) Gems have been added to your Tinkie wallet.")
    }

    private func unwrapGemStoreProof(_ result: VerificationResult<StoreKit.Transaction>) throws -> StoreKit.Transaction {
        switch result {
        case .verified(let rhythmTransaction):
            return rhythmTransaction
        case .unverified:
            throw NSError(domain: "TinkieRhythmGemVault", code: 1)
        }
    }

    private func showGemRhythmNotice(title: String, detailText: String) {
        tinkieShowTuneNotice(title: title, detail: detailText)
    }

    @objc private func closeGemRhythmVaultTapped() {
        dismiss(animated: true)
    }
}

extension TinkieRhythmGemVaultViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        gemPacks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TinkieRhythmGemBundleTile.reuseIdentifier, for: indexPath) as! TinkieRhythmGemBundleTile
        let pack = gemPacks[indexPath.item]
        cell.tuneGemBundle(pack, shelfText: rhythmStoreRack.shelfText(for: pack))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        startGemBundleRhythm(for: gemPacks[indexPath.item])
    }
}

final class TinkieRhythmGemBundleTile: UICollectionViewCell {
    static let reuseIdentifier = "TinkieRhythmGemBundleTile"

    private let gemImageView = UIImageView(image: UIImage(named: "tinkie_profile_balance_gem"))
    private let gemCountLabel = UILabel()
    private let shelfLabel = UILabel()
    private let gemActionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        putGemBundleTileTogether()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tuneGemBundle(_ pack: TinkieRhythmGemBundle, shelfText: String) {
        gemCountLabel.text = "\(pack.gemCount)"
        shelfLabel.text = shelfText
    }

    private func putGemBundleTileTogether() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true

        gemImageView.contentMode = .scaleAspectFit
        gemImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(gemImageView)

        gemCountLabel.textColor = .black
        gemCountLabel.font = UIFont.systemFont(ofSize: 16, weight: .black)
        gemCountLabel.textAlignment = .center
        gemCountLabel.adjustsFontSizeToFitWidth = true
        gemCountLabel.minimumScaleFactor = 0.72
        gemCountLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(gemCountLabel)

        shelfLabel.textColor = UIColor.black.withAlphaComponent(0.48)
        shelfLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        shelfLabel.textAlignment = .center
        shelfLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(shelfLabel)

        let gemActionStrip = TinkieRhythmGemRechargeStrip()
        gemActionStrip.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(gemActionStrip)

        gemActionLabel.text = "Recharge"
        gemActionLabel.textColor = .white
        gemActionLabel.font = UIFont.systemFont(ofSize: 13, weight: .black)
        gemActionLabel.textAlignment = .center
        gemActionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(gemActionLabel)

        NSLayoutConstraint.activate([
            gemImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            gemImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            gemImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.48),
            gemImageView.heightAnchor.constraint(equalToConstant: 30),

            gemCountLabel.topAnchor.constraint(equalTo: gemImageView.bottomAnchor, constant: 4),
            gemCountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            gemCountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            shelfLabel.topAnchor.constraint(equalTo: gemCountLabel.bottomAnchor, constant: 4),
            shelfLabel.leadingAnchor.constraint(equalTo: gemCountLabel.leadingAnchor),
            shelfLabel.trailingAnchor.constraint(equalTo: gemCountLabel.trailingAnchor),

            gemActionStrip.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gemActionStrip.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gemActionStrip.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            gemActionStrip.heightAnchor.constraint(equalToConstant: 34),

            gemActionLabel.leadingAnchor.constraint(equalTo: gemActionStrip.leadingAnchor),
            gemActionLabel.trailingAnchor.constraint(equalTo: gemActionStrip.trailingAnchor),
            gemActionLabel.centerYAnchor.constraint(equalTo: gemActionStrip.centerYAnchor)
        ])
    }
}

final class TinkieRhythmGemVaultGlowView: UIView {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let vaultGlowGradient = layer as! CAGradientLayer
        vaultGlowGradient.colors = [
            UIColor(red: 0.93, green: 0.02, blue: 0.61, alpha: 1).cgColor,
            UIColor(red: 0.13, green: 0.84, blue: 0.78, alpha: 1).cgColor,
            UIColor(red: 0.96, green: 0.98, blue: 0.98, alpha: 1).cgColor
        ]
        vaultGlowGradient.locations = [0, 0.54, 1]
        vaultGlowGradient.startPoint = CGPoint(x: 0.5, y: 0)
        vaultGlowGradient.endPoint = CGPoint(x: 0.5, y: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TinkieRhythmGemRechargeStrip: UIView {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let actionBeatGradient = layer as! CAGradientLayer
        actionBeatGradient.colors = [
            UIColor(red: 0.86, green: 0.07, blue: 0.60, alpha: 1).cgColor,
            UIColor(red: 0.11, green: 0.84, blue: 0.78, alpha: 1).cgColor
        ]
        actionBeatGradient.startPoint = CGPoint(x: 0, y: 0.5)
        actionBeatGradient.endPoint = CGPoint(x: 1, y: 0.5)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
