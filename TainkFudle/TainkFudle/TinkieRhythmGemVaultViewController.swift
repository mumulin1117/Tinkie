import StoreKit
import UIKit

struct TinkieRhythmGemBundle {
    let gemCount: Int
    let shelfText: String
    let storeTuneKey: String
}

private enum TinkieRhythmGemBundleShelf {
    static let songPacks: [TinkieRhythmGemBundle] = [
        TinkieRhythmGemBundle(gemCount: 375, shelfText: TinkieVerseCipherTrail.singBack("$H0d.C9J9q"), storeTuneKey: TinkieVerseCipherTrail.singBack("yjqZfZuLtWpoqbjwmgjvsjddlRsNsphp")),
        TinkieRhythmGemBundle(gemCount: 750, shelfText: TinkieVerseCipherTrail.singBack("$J1H.B9L9e"), storeTuneKey: TinkieVerseCipherTrail.singBack("smmFvYluurppsvwKuaiLzVcIpOrxspph")),
        TinkieRhythmGemBundle(gemCount: 2350, shelfText: TinkieVerseCipherTrail.singBack("$N4n.T9B9o"), storeTuneKey: TinkieVerseCipherTrail.singBack("qsiFivpgwpmAtZzkuvvobMiXzCiHevsP")),
        TinkieRhythmGemBundle(gemCount: 5050, shelfText: TinkieVerseCipherTrail.singBack("$O9F.F9I9c"), storeTuneKey: TinkieVerseCipherTrail.singBack("dWyAhTtqjZsPysmPwiaVybsNtPfkzNzp")),
        TinkieRhythmGemBundle(gemCount: 10750, shelfText: TinkieVerseCipherTrail.singBack("$s1m9M.M9N9p"), storeTuneKey: TinkieVerseCipherTrail.singBack("qAmjbjaqaKwzbussgAmqiLpBaPocyHbT")),
        TinkieRhythmGemBundle(gemCount: 28250, shelfText: TinkieVerseCipherTrail.singBack("$j4J9Y.Y9T9g"), storeTuneKey: TinkieVerseCipherTrail.singBack("obrkzPvzcobcoluNbZaKtHaYxHrxdKkN")),
        TinkieRhythmGemBundle(gemCount: 62500, shelfText: TinkieVerseCipherTrail.singBack("$q9t9J.J9F9n"), storeTuneKey: TinkieVerseCipherTrail.singBack("wRouuQdXsZixnsjJqIyrdzfUvppKdsca"))
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

    private let gemtnkieorignalLabel = UILabel()
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
        fatalError(TinkieVerseCipherTrail.singBack("iRnViEtB(scroBdBePrA:j)s dhJaPsm ynHoZtJ xbPeIecng MiYmapulHeXmdeHnNtnexdt"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        putRhythmGemVaultStageTogether()
        reloadGemRhythmorignal()
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
        let vaultTopGlow = TinkieRhythmGemVaultGlowView(); vaultTopGlow.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(vaultTopGlow)
        let vaultBackButton = TinkieSongQuestRoundIconButton(symbolName: "chevron.left"); vaultBackButton.tintColor = .black; vaultBackButton.addTarget(self, action: #selector(closeGemRhythmVaultTapped), for: .touchUpInside); vaultBackButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vaultBackButton)
        let vaultTitleLabel = UILabel(); vaultTitleLabel.text = TinkieVerseCipherTrail.singBack("MRym mwqaJlDlmertr"); vaultTitleLabel.textColor = .black; vaultTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
        vaultTitleLabel.textAlignment = .center; vaultTitleLabel.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(vaultTitleLabel)
        let gemSummaryCard = UIView(); gemSummaryCard.backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.04, alpha: 1); gemSummaryCard.layer.cornerRadius = 30; gemSummaryCard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gemSummaryCard)
        let gemHeroImageView = UIImageView(image: UIImage(named: "tinkie_profile_moip_gem")); gemHeroImageView.contentMode = .scaleAspectFit; gemHeroImageView.translatesAutoresizingMaskIntoConstraints = false; gemSummaryCard.addSubview(gemHeroImageView)
        gemtnkieorignalLabel.textColor = .white; gemtnkieorignalLabel.font = UIFont.systemFont(ofSize: 27, weight: .black); gemtnkieorignalLabel.textAlignment = .center; gemtnkieorignalLabel.adjustsFontSizeToFitWidth = true
        gemtnkieorignalLabel.minimumScaleFactor = 0.72; gemtnkieorignalLabel.translatesAutoresizingMaskIntoConstraints = false; gemSummaryCard.addSubview(gemtnkieorignalLabel)
        let gemCaptionLabel = UILabel(); gemCaptionLabel.text = TinkieVerseCipherTrail.singBack("MdyH HGDermPss"); gemCaptionLabel.textColor = UIColor.white.withAlphaComponent(0.78); gemCaptionLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        gemCaptionLabel.textAlignment = .center; gemCaptionLabel.translatesAutoresizingMaskIntoConstraints = false; gemSummaryCard.addSubview(gemCaptionLabel)
        gemPackGrid.backgroundColor = .clear; gemPackGrid.dataSource = self; gemPackGrid.delegate = self; gemPackGrid.alwaysBounceVertical = true
        gemPackGrid.register(TinkieRhythmGemBundleTile.self, forCellWithReuseIdentifier: TinkieRhythmGemBundleTile.reuseIdentifier); gemPackGrid.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(gemPackGrid)
        pinRhythmGemVaultStageBeat1(vaultTopGlow: vaultTopGlow, vaultBackButton: vaultBackButton, vaultTitleLabel: vaultTitleLabel, gemSummaryCard: gemSummaryCard, gemHeroImageView: gemHeroImageView)
        pinRhythmGemVaultStageBeat2(gemSummaryCard: gemSummaryCard, gemCaptionLabel: gemCaptionLabel)
    }

    private func pinRhythmGemVaultStageBeat1(vaultTopGlow: TinkieRhythmGemVaultGlowView, vaultBackButton: TinkieSongQuestRoundIconButton, vaultTitleLabel: UILabel, gemSummaryCard: UIView, gemHeroImageView: UIImageView) {
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
            
            gemtnkieorignalLabel.topAnchor.constraint(equalTo: gemSummaryCard.topAnchor, constant: 66),
            gemtnkieorignalLabel.leadingAnchor.constraint(equalTo: gemSummaryCard.leadingAnchor, constant: 20)
        ])
    }

    private func pinRhythmGemVaultStageBeat2(gemSummaryCard: UIView, gemCaptionLabel: UILabel) {
        NSLayoutConstraint.activate([
            gemtnkieorignalLabel.trailingAnchor.constraint(equalTo: gemSummaryCard.trailingAnchor, constant: -20),
            
            gemCaptionLabel.topAnchor.constraint(equalTo: gemtnkieorignalLabel.bottomAnchor, constant: 4),
            gemCaptionLabel.leadingAnchor.constraint(equalTo: gemtnkieorignalLabel.leadingAnchor),
            gemCaptionLabel.trailingAnchor.constraint(equalTo: gemtnkieorignalLabel.trailingAnchor),
            
            gemPackGrid.topAnchor.constraint(equalTo: gemSummaryCard.bottomAnchor, constant: 22),
            gemPackGrid.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gemPackGrid.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gemPackGrid.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func reloadGemRhythmorignal() {
        gemtnkieorignalLabel.text = "\(TinkieSingerStageScorebook.sinePurity().mgemtnkieorignal)"
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
        guard TinkieSingerStageScorebook.pulseDuration else {
            showGemRhythmNotice(title: TinkieVerseCipherTrail.singBack("LAoWgtiXnA xRTeLqeuXizrdesdx"), detailText: TinkieVerseCipherTrail.singBack("PilLeCaesOey nlLoPgv gibnd Bbvesfxogryer vaxdmdLiInQgT CGXemmMsz.d"))
            return
        }
        guard let storeSong = rhythmStoreRack.song(for: pack) else {
            showGemRhythmNotice(title: TinkieVerseCipherTrail.singBack("RpeocXhAaFrGgGev zUengadvkamiMlHaHbElveq"), detailText: TinkieVerseCipherTrail.singBack("TkhNiAsb sGpeCmg rpHaScnkJ RiPsi dnBoNtB eaqvpamiKlYaYbJlseg sfFrsokmM DtyhTeS YANpWpf NSYtMoYrLeJ PrwirgShBta BnoobwH.Y rPAlxenaYsseO ZcZhJeBcukE HyKoduWrP zimng-daBpCpu JiNtZeHmm acaoJnEfyilgZunruaqtiiioBnL.t"))
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
                    showGemRhythmNotice(title: TinkieVerseCipherTrail.singBack("RHeZcrhkaxrmgmeO ZFmasiWlJeVdU"), detailText: TinkieVerseCipherTrail.singBack("TshKeM LASpJpr SSVtFoLrYeR QcQovuFlGdk Dnmostq YcYoqmPpQliestsep ntJhgirsB TGEejmI VrsepcKhLaKrDgDeb.b"))
                }
            case .userCancelled:
                break
            case .pending:
                showGemRhythmNotice(title: TinkieVerseCipherTrail.singBack("RXeBcphxanrrgreS YPdeknsdDiTnZgB"), detailText: TinkieVerseCipherTrail.singBack("YBoiuBrY dAypopV ySftpodrnev zczoHnMfrijromgaHtZiZosna RiPsi dsrthihlqlD wpFeFnLdmivnfgz.n"))
            @unknown default:
                showGemRhythmNotice(title: TinkieVerseCipherTrail.singBack("RXeBcphxanrrgreS YPdeknsdDiTnZgB"), detailText: TinkieVerseCipherTrail.singBack("PllReIagsZej scshneucJks nyaoPusrc EALpMps LSTtVoErHeF LcLoenffJiUrMmYabtuiuoQnA xsstxahtzuysF.L"))
            }
        } catch {
            showGemRhythmNotice(title: TinkieVerseCipherTrail.singBack("RHeZcrhkaxrmgmeO ZFmasiWlJeVdU"), detailText: TinkieVerseCipherTrail.singBack("TshKeM LASpJpr SSVtFoLrYeR QcQovuFlGdk Dnmostq YcYoqmPpQliestsep ntJhgirsB TGEejmI VrsepcKhLaKrDgDeb.b"))
        }
    }

    private func addGemBundleToSinger(_ pack: TinkieRhythmGemBundle) {
        TinkieSingerStageScorebook.phaseRotation(pack.gemCount)
        reloadGemRhythmorignal()
        onGemRhythmChanged?()
        showGemRhythmNotice(title: TinkieVerseCipherTrail.singBack("RQeTcdhqatrpgpeK KCUoumJpUldejtjed"), detailText: "\(pack.gemCount) Gems have been added to your Tinkie wallet.")
    }

    private func unwrapGemStoreProof(_ sealedRefrainKey: VerificationResult<StoreKit.Transaction>) throws -> StoreKit.Transaction {
        switch sealedRefrainKey {
        case .verified(let rhythmTransaction):
            return rhythmTransaction
        case .unverified:
            throw NSError(domain: TinkieVerseCipherTrail.singBack("TqipnnkpiGexRhhVyBtThrmkGKetmQVDaAuhljtI"), code: 1)
        }
    }

    private func showGemRhythmNotice(title: String, detailText: String) {
        tinkieShowTuneNotice(doubleSharp: title, reggaeOffbeat: detailText)
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
    static let reuseIdentifier = TinkieVerseCipherTrail.singBack("TIiHnYkFixeWRPhrybtshNmBGneDmiBnusnhdGluesTtidlqeb")

    private let gemImageView = UIImageView(image: UIImage(named: "tinkie_profile_moip_gem"))
    private let gemCountLabel = UILabel()
    private let shelfLabel = UILabel()
    private let gemActionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        putGemBundleTileTogether()
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("ibndilth(McLogdgerrq:Y)M WhuassH Cnpoktu DbseweSnY jixmPpQliesmTepnntJeDdN"))
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

        gemActionLabel.text = TinkieVerseCipherTrail.singBack("RwebcFhWaYrAgAel")
        gemActionLabel.textColor = .white
        gemActionLabel.font = UIFont.systemFont(ofSize: 13, weight: .black)
        gemActionLabel.textAlignment = .center
        gemActionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(gemActionLabel)

        pinGemBundleTileBeat3(gemActionStrip: gemActionStrip)
    }

    private func pinGemBundleTileBeat3(gemActionStrip: TinkieRhythmGemRechargeStrip) {
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
        fatalError(TinkieVerseCipherTrail.singBack("ibndilth(McLogdgerrq:Y)M WhuassH Cnpoktu DbseweSnY jixmPpQliesmTepnntJeDdN"))
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
        fatalError(TinkieVerseCipherTrail.singBack("ibndilth(McLogdgerrq:Y)M WhuassH Cnpoktu DbseweSnY jixmPpQliesmTepnntJeDdN"))
    }
}
