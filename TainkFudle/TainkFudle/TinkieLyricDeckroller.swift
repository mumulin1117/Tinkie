import StoreKit
import UIKit

struct TinkieGemBundle {
    let gemAmount: Int
    let amountText: String
    let appleItemID: String
}

final class TinkieLyricDeckroller: UIViewController {
    var onBalanceChanged: (() -> Void)?

    private let balanceLabel = UILabel()
    private let collectionView: UICollectionView
    private var storeItems: [String: Product] = [:]

    private let bundles: [TinkieGemBundle] = [
        TinkieGemBundle(gemAmount: 62500, amountText: "$99.99", appleItemID: "woudsinjqydfvpdc"),
        TinkieGemBundle(gemAmount: 28250, amountText: "$49.99", appleItemID: "orzvcboubataxrdk"),
        TinkieGemBundle(gemAmount: 10750, amountText: "$19.99", appleItemID: "qmbaawbsgmipaoyb"),
        TinkieGemBundle(gemAmount: 5050, amountText: "$9.99", appleItemID: "dyhtjsymwaystfzz"),
        TinkieGemBundle(gemAmount: 2350, amountText: "$4.99", appleItemID: "qiipwmtzuvbizies"),
        TinkieGemBundle(gemAmount: 750, amountText: "$1.99", appleItemID: "smvlupswuizcprsp"),
        TinkieGemBundle(gemAmount: 375, amountText: "$0.99", appleItemID: "yqfutpqjmjsdlssh")
    ]

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 12
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        reloadBalance()
        Task { await loadStoreItems() }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let sideInset: CGFloat = view.bounds.width <= 340 ? 14 : 20
        let spacing: CGFloat = view.bounds.width <= 340 ? 8 : 10
        let width = floor((view.bounds.width - sideInset * 2 - spacing * 2) / 3)
        layout.sectionInset = UIEdgeInsets(top: 0, left: sideInset, bottom: 28, right: sideInset)
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSize(width: max(92, width), height: 126)
    }

    private func buildLayout() {
        view.backgroundColor = UIColor(red: 0.96, green: 0.98, blue: 0.98, alpha: 1)

        let topGlow = TinkieWalletGlowView()
        topGlow.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topGlow)

        let backButton = TinkieGrooveStage(symbolName: "chevron.left")
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)

        let titleLabel = UILabel()
        titleLabel.text = "My wallet"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        let summaryCard = UIView()
        summaryCard.backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.04, alpha: 1)
        summaryCard.layer.cornerRadius = 30
        summaryCard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(summaryCard)

        let gemImageView = UIImageView(image: UIImage(named: "tinkie_profile_balance_gem"))
        gemImageView.contentMode = .scaleAspectFit
        gemImageView.translatesAutoresizingMaskIntoConstraints = false
        summaryCard.addSubview(gemImageView)

        balanceLabel.textColor = .white
        balanceLabel.font = UIFont.systemFont(ofSize: 27, weight: .black)
        balanceLabel.textAlignment = .center
        balanceLabel.adjustsFontSizeToFitWidth = true
        balanceLabel.minimumScaleFactor = 0.72
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryCard.addSubview(balanceLabel)

        let captionLabel = UILabel()
        captionLabel.text = "My Gems"
        captionLabel.textColor = UIColor.white.withAlphaComponent(0.78)
        captionLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        captionLabel.textAlignment = .center
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryCard.addSubview(captionLabel)

        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(TinkieGemBundleCell.self, forCellWithReuseIdentifier: TinkieGemBundleCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            topGlow.topAnchor.constraint(equalTo: view.topAnchor),
            topGlow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topGlow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topGlow.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.42),

            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 34),

            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            summaryCard.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            summaryCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            summaryCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            summaryCard.heightAnchor.constraint(equalToConstant: 132),

            gemImageView.centerXAnchor.constraint(equalTo: summaryCard.centerXAnchor),
            gemImageView.centerYAnchor.constraint(equalTo: summaryCard.topAnchor, constant: 6),
            gemImageView.widthAnchor.constraint(equalToConstant: 104),
            gemImageView.heightAnchor.constraint(equalToConstant: 78),

            balanceLabel.topAnchor.constraint(equalTo: summaryCard.topAnchor, constant: 66),
            balanceLabel.leadingAnchor.constraint(equalTo: summaryCard.leadingAnchor, constant: 20),
            balanceLabel.trailingAnchor.constraint(equalTo: summaryCard.trailingAnchor, constant: -20),

            captionLabel.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 4),
            captionLabel.leadingAnchor.constraint(equalTo: balanceLabel.leadingAnchor),
            captionLabel.trailingAnchor.constraint(equalTo: balanceLabel.trailingAnchor),

            collectionView.topAnchor.constraint(equalTo: summaryCard.bottomAnchor, constant: 22),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func reloadBalance() {
        balanceLabel.text = "\(TinkieProfileStore.currentSnapshot().balance)"
    }

    private func loadStoreItems() async {
        do {
            let ids = Set(bundles.map(\.appleItemID))
            let items = try await Product.products(for: ids)
            storeItems = Dictionary(uniqueKeysWithValues: items.map { ($0.id, $0) })
            collectionView.reloadData()
        } catch {
            storeItems = [:]
        }
    }

    private func startExchange(for bundle: TinkieGemBundle) {
        guard TinkieProfileStore.isSignedIn else {
            showWalletAlert(title: "Login Required", message: "Please log in before adding Gems.")
            return
        }
        guard let item = storeItems[bundle.appleItemID] else {
            showWalletAlert(title: "Recharge Unavailable", message: "This Gem pack is not available from the App Store right now. Please check your in-app item configuration.")
            return
        }
        Task {
            do {
                let result = try await item.purchase()
                switch result {
                case .success(let verification):
                    let transaction = try verifiedTransaction(from: verification)
                    await transaction.finish()
                    TinkieProfileStore.addGems(bundle.gemAmount)
                    reloadBalance()
                    onBalanceChanged?()
                    showWalletAlert(title: "Recharge Complete", message: "\(bundle.gemAmount) Gems have been added to your Tinkie wallet.")
                case .userCancelled:
                    break
                case .pending:
                    showWalletAlert(title: "Recharge Pending", message: "Your App Store confirmation is still pending.")
                @unknown default:
                    showWalletAlert(title: "Recharge Pending", message: "Please check your App Store confirmation status.")
                }
            } catch {
                showWalletAlert(title: "Recharge Failed", message: "The App Store could not complete this Gem recharge.")
            }
        }
    }

    private func verifiedTransaction(from result: VerificationResult<StoreKit.Transaction>) throws -> StoreKit.Transaction {
        switch result {
        case .verified(let transaction):
            return transaction
        case .unverified:
            throw NSError(domain: "TinkieWallet", code: 1)
        }
    }

    private func showWalletAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    @objc private func close() {
        dismiss(animated: true)
    }
}

extension TinkieLyricDeckroller: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bundles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TinkieGemBundleCell.reuseIdentifier, for: indexPath) as! TinkieGemBundleCell
        let bundle = bundles[indexPath.item]
        cell.configure(bundle: bundle, amountText: storeItems[bundle.appleItemID]?.displayPrice ?? bundle.amountText)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        startExchange(for: bundles[indexPath.item])
    }
}

final class TinkieGemBundleCell: UICollectionViewCell {
    static let reuseIdentifier = "TinkieGemBundleCell"

    private let gemImageView = UIImageView(image: UIImage(named: "tinkie_profile_balance_gem"))
    private let amountLabel = UILabel()
    private let currencyLabel = UILabel()
    private let actionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(bundle: TinkieGemBundle, amountText: String) {
        amountLabel.text = "\(bundle.gemAmount)"
        currencyLabel.text = amountText
    }

    private func buildLayout() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true

        gemImageView.contentMode = .scaleAspectFit
        gemImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(gemImageView)

        amountLabel.textColor = .black
        amountLabel.font = UIFont.systemFont(ofSize: 16, weight: .black)
        amountLabel.textAlignment = .center
        amountLabel.adjustsFontSizeToFitWidth = true
        amountLabel.minimumScaleFactor = 0.72
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(amountLabel)

        currencyLabel.textColor = UIColor.black.withAlphaComponent(0.48)
        currencyLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        currencyLabel.textAlignment = .center
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(currencyLabel)

        let actionBackground = TinkieWalletActionStrip()
        actionBackground.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(actionBackground)

        actionLabel.text = "Recharge"
        actionLabel.textColor = .white
        actionLabel.font = UIFont.systemFont(ofSize: 13, weight: .black)
        actionLabel.textAlignment = .center
        actionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(actionLabel)

        NSLayoutConstraint.activate([
            gemImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            gemImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            gemImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.48),
            gemImageView.heightAnchor.constraint(equalToConstant: 30),

            amountLabel.topAnchor.constraint(equalTo: gemImageView.bottomAnchor, constant: 4),
            amountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            amountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            currencyLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 4),
            currencyLabel.leadingAnchor.constraint(equalTo: amountLabel.leadingAnchor),
            currencyLabel.trailingAnchor.constraint(equalTo: amountLabel.trailingAnchor),

            actionBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            actionBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            actionBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            actionBackground.heightAnchor.constraint(equalToConstant: 34),

            actionLabel.leadingAnchor.constraint(equalTo: actionBackground.leadingAnchor),
            actionLabel.trailingAnchor.constraint(equalTo: actionBackground.trailingAnchor),
            actionLabel.centerYAnchor.constraint(equalTo: actionBackground.centerYAnchor)
        ])
    }
}

final class TinkieWalletGlowView: UIView {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let gradient = layer as! CAGradientLayer
        gradient.colors = [
            UIColor(red: 0.93, green: 0.02, blue: 0.61, alpha: 1).cgColor,
            UIColor(red: 0.13, green: 0.84, blue: 0.78, alpha: 1).cgColor,
            UIColor(red: 0.96, green: 0.98, blue: 0.98, alpha: 1).cgColor
        ]
        gradient.locations = [0, 0.54, 1]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TinkieWalletActionStrip: UIView {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let gradient = layer as! CAGradientLayer
        gradient.colors = [
            UIColor(red: 0.86, green: 0.07, blue: 0.60, alpha: 1).cgColor,
            UIColor(red: 0.11, green: 0.84, blue: 0.78, alpha: 1).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
