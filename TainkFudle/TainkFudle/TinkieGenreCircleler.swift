import UIKit

final class TinkieGenreCircleler: UIViewController {
    var onSessionChanged: (() -> Void)?

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()
    private let overlayView = UIView()
    private let dialogView = UIView()
    private let sheetView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        buildLayout()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentInset.bottom = view.safeAreaInsets.bottom + 24
        scrollView.verticalScrollIndicatorInsets = scrollView.contentInset
    }

    private func buildLayout() {
        view.backgroundColor = UIColor(red: 0.96, green: 0.98, blue: 0.98, alpha: 1)

        let glow = TinkieTopGlowView()
        glow.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(glow)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.contentHorizontalAlignment = .leading
        backButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backButton)

        let titleLabel = UILabel()
        titleLabel.text = "Setting"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)

        let rows: [TinkieridgeCirclem] = [
            TinkieridgeCirclem(title: "User Agreement", symbolName: "text.badge.checkmark", action: { [weak self] in self?.openTerms() }),
            TinkieridgeCirclem(title: "Privacy", symbolName: "doc.text.magnifyingglass", action: { [weak self] in self?.openPrivacy() }),
            TinkieridgeCirclem(title: "Blocked List", symbolName: "list.bullet.rectangle.fill", action: { [weak self] in self?.openBlockedList() }),
            TinkieridgeCirclem(title: "Delete Account", symbolName: "person.crop.circle.badge.xmark", action: { [weak self] in self?.showDeleteDialog() })
        ]
        rows.forEach { stackView.addArrangedSubview(TinkieridgeCirclRow(item: $0)) }

        let signOutButton = TinkieridgeCirclyButton(title: "Log out", symbolName: "rectangle.portrait.and.arrow.right")
        signOutButton.addTarget(self, action: #selector(showSignOutSheet), for: .touchUpInside)
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(signOutButton)

        NSLayoutConstraint.activate([
            glow.topAnchor.constraint(equalTo: view.topAnchor),
            glow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            glow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            glow.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.58),

            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.frameLayoutGuide.heightAnchor),

            backButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 18),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 48),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 28),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            signOutButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 26),
            signOutButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            signOutButton.heightAnchor.constraint(equalToConstant: 44),
            signOutButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -38),
            signOutButton.topAnchor.constraint(greaterThanOrEqualTo: stackView.bottomAnchor, constant: 44)
        ])

        buildOverlay()
    }

    private func buildOverlay() {
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.48)
        overlayView.alpha = 0
        overlayView.isHidden = true
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlayView)

        dialogView.backgroundColor = .white
        dialogView.layer.cornerRadius = 18
        dialogView.layer.masksToBounds = true
        dialogView.isHidden = true
        dialogView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.addSubview(dialogView)

        let dialogTitle = UILabel()
        dialogTitle.text = "Delete account"
        dialogTitle.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        dialogTitle.textColor = .black
        dialogTitle.textAlignment = .center
        dialogTitle.translatesAutoresizingMaskIntoConstraints = false
        dialogView.addSubview(dialogTitle)

        let dialogDetail = UILabel()
        dialogDetail.text = "Deleting the account will clear the account data. Are you sure to delete?"
        dialogDetail.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        dialogDetail.textColor = UIColor.black.withAlphaComponent(0.72)
        dialogDetail.textAlignment = .center
        dialogDetail.numberOfLines = 0
        dialogDetail.translatesAutoresizingMaskIntoConstraints = false
        dialogView.addSubview(dialogDetail)

        let cancelButton = TinkieridgeCirclyButton(title: "Cancel", symbolName: nil)
        cancelButton.addTarget(self, action: #selector(hideOverlay), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        dialogView.addSubview(cancelButton)

        let deleteButton = UIButton(type: .system)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(UIColor.black.withAlphaComponent(0.28), for: .normal)
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        deleteButton.backgroundColor = UIColor.black.withAlphaComponent(0.04)
        deleteButton.layer.cornerRadius = 18
        deleteButton.addTarget(self, action: #selector(confirmDelete), for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        dialogView.addSubview(deleteButton)

        sheetView.backgroundColor = .white
        sheetView.layer.cornerRadius = 20
        sheetView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        sheetView.layer.masksToBounds = true
        sheetView.isHidden = true
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.addSubview(sheetView)

        let sheetExitButton = UIButton(type: .system)
        sheetExitButton.setTitle("Log out", for: .normal)
        sheetExitButton.setTitleColor(UIColor.black.withAlphaComponent(0.46), for: .normal)
        sheetExitButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        sheetExitButton.backgroundColor = .white
        sheetExitButton.layer.cornerRadius = 18
        sheetExitButton.layer.borderWidth = 1
        sheetExitButton.layer.borderColor = UIColor.black.withAlphaComponent(0.16).cgColor
        sheetExitButton.addTarget(self, action: #selector(confirmSignOut), for: .touchUpInside)
        sheetExitButton.translatesAutoresizingMaskIntoConstraints = false
        sheetView.addSubview(sheetExitButton)

        let sheetCancelButton = UIButton(type: .system)
        sheetCancelButton.setTitle("Cancel", for: .normal)
        sheetCancelButton.setTitleColor(.white, for: .normal)
        sheetCancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        sheetCancelButton.backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.04, alpha: 1)
        sheetCancelButton.layer.cornerRadius = 18
        sheetCancelButton.addTarget(self, action: #selector(hideOverlay), for: .touchUpInside)
        sheetCancelButton.translatesAutoresizingMaskIntoConstraints = false
        sheetView.addSubview(sheetCancelButton)

        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            dialogView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            dialogView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor, constant: -18),
            dialogView.leadingAnchor.constraint(greaterThanOrEqualTo: overlayView.leadingAnchor, constant: 32),
            dialogView.trailingAnchor.constraint(lessThanOrEqualTo: overlayView.trailingAnchor, constant: -32),
            dialogView.widthAnchor.constraint(lessThanOrEqualToConstant: 330),

            dialogTitle.topAnchor.constraint(equalTo: dialogView.topAnchor, constant: 24),
            dialogTitle.leadingAnchor.constraint(equalTo: dialogView.leadingAnchor, constant: 24),
            dialogTitle.trailingAnchor.constraint(equalTo: dialogView.trailingAnchor, constant: -24),

            dialogDetail.topAnchor.constraint(equalTo: dialogTitle.bottomAnchor, constant: 10),
            dialogDetail.leadingAnchor.constraint(equalTo: dialogView.leadingAnchor, constant: 32),
            dialogDetail.trailingAnchor.constraint(equalTo: dialogView.trailingAnchor, constant: -32),

            cancelButton.topAnchor.constraint(equalTo: dialogDetail.bottomAnchor, constant: 18),
            cancelButton.leadingAnchor.constraint(equalTo: dialogView.leadingAnchor, constant: 24),
            cancelButton.trailingAnchor.constraint(equalTo: dialogView.trailingAnchor, constant: -24),
            cancelButton.heightAnchor.constraint(equalToConstant: 38),

            deleteButton.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 10),
            deleteButton.leadingAnchor.constraint(equalTo: dialogView.leadingAnchor, constant: 24),
            deleteButton.trailingAnchor.constraint(equalTo: dialogView.trailingAnchor, constant: -24),
            deleteButton.heightAnchor.constraint(equalToConstant: 38),
            deleteButton.bottomAnchor.constraint(equalTo: dialogView.bottomAnchor, constant: -22),

            sheetView.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor),
            sheetView.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor),
            sheetView.bottomAnchor.constraint(equalTo: overlayView.bottomAnchor),

            sheetExitButton.topAnchor.constraint(equalTo: sheetView.topAnchor, constant: 18),
            sheetExitButton.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor, constant: 24),
            sheetExitButton.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor, constant: -24),
            sheetExitButton.heightAnchor.constraint(equalToConstant: 40),

            sheetCancelButton.topAnchor.constraint(equalTo: sheetExitButton.bottomAnchor, constant: 10),
            sheetCancelButton.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor, constant: 24),
            sheetCancelButton.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor, constant: -24),
            sheetCancelButton.heightAnchor.constraint(equalToConstant: 40),
            sheetCancelButton.bottomAnchor.constraint(equalTo: sheetView.safeAreaLayoutGuide.bottomAnchor, constant: -18)
        ])
    }

    private func showOverlay(content: UIView) {
        dialogView.isHidden = content !== dialogView
        sheetView.isHidden = content !== sheetView
        overlayView.isHidden = false
        view.bringSubviewToFront(overlayView)
        UIView.animate(withDuration: 0.2) {
            self.overlayView.alpha = 1
        }
    }

    private func openRoute(titleText: String, detailText: String) {
        navigationController?.pushViewController(
            TinkieProfileRouteViewController(titleText: titleText, detailText: detailText, showsSignOut: false),
            animated: true
        )
    }

    @objc private func closeTapped() {
        dismiss(animated: true)
    }

    @objc private func hideOverlay() {
        UIView.animate(withDuration: 0.18) {
            self.overlayView.alpha = 0
        } completion: { _ in
            self.overlayView.isHidden = true
            self.dialogView.isHidden = true
            self.sheetView.isHidden = true
        }
    }

    @objc private func showSignOutSheet() {
        showOverlay(content: sheetView)
    }

    private func showDeleteDialog() {
        showOverlay(content: dialogView)
    }

    private func openTerms() {
        navigationController?.pushViewController(KieAcousticStreak(titleText: "Terms of Use", bodyText: TinkieSongStreak.termsBody), animated: true)
    }

    private func openPrivacy() {
        navigationController?.pushViewController(KieAcousticStreak(titleText: "Privacy Policy", bodyText: TinkieSongStreak.privacyBody), animated: true)
    }

    private func openBlockedList() {
        navigationController?.pushViewController(TinkieTimbreWaveController(kind: .blocked), animated: true)
    }

    @objc private func confirmSignOut() {
        TinkieProfileStore.signOutOnly()
        hideOverlay()
        dismiss(animated: true) {
            self.onSessionChanged?()
        }
    }

    @objc private func confirmDelete() {
        TinkieProfileStore.removeCurrentProfileAndSignOut()
        hideOverlay()
        dismiss(animated: true) {
            self.onSessionChanged?()
        }
    }
}

private struct TinkieridgeCirclem {
    let title: String
    let symbolName: String
    let action: () -> Void
}

private final class TinkieridgeCirclRow: UIControl {
    private let item: TinkieridgeCirclem

    init(item: TinkieridgeCirclem) {
        self.item = item
        super.init(frame: .zero)
        buildLayout()
        addTarget(self, action: #selector(triggerAction), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildLayout() {
        backgroundColor = .clear

        let iconView = UIImageView(image: UIImage(systemName: item.symbolName))
        iconView.tintColor = .black
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconView)

        let titleLabel = UILabel()
        titleLabel.text = item.title
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        let arrowView = UIImageView(image: UIImage(systemName: "chevron.right"))
        arrowView.tintColor = UIColor.black.withAlphaComponent(0.62)
        arrowView.contentMode = .scaleAspectFit
        arrowView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(arrowView)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 42),

            iconView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 17),
            iconView.heightAnchor.constraint(equalToConstant: 17),

            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 14),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: arrowView.leadingAnchor, constant: -12),

            arrowView.trailingAnchor.constraint(equalTo: trailingAnchor),
            arrowView.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowView.widthAnchor.constraint(equalToConstant: 12),
            arrowView.heightAnchor.constraint(equalToConstant: 12)
        ])
    }

    @objc private func triggerAction() {
        item.action()
    }
}

final class TinkieridgeCirclyButton: UIButton {
    private let glowLayer = CAGradientLayer()

    init(title: String, symbolName: String?) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        if let symbolName {
            setImage(UIImage(systemName: symbolName), for: .normal)
            tintColor = .white
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 6)
        }
        layer.cornerRadius = 22
        layer.masksToBounds = true
        glowLayer.colors = [
            UIColor(red: 0.84, green: 0.06, blue: 0.62, alpha: 1).cgColor,
            UIColor(red: 0.11, green: 0.84, blue: 0.78, alpha: 1).cgColor
        ]
        glowLayer.startPoint = CGPoint(x: 0, y: 0.5)
        glowLayer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.insertSublayer(glowLayer, at: 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        glowLayer.frame = bounds
        layer.cornerRadius = bounds.height / 2
    }
}
