import UIKit

final class TinkieteChorusCuetroller: UIViewController {
    var onProfileSaved: (() -> Void)?

    private let snapshot: TinkieMelodyScoreot
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let nameField = UITextField()
    private let signatureField = UITextField()
    private var bottomConstraint: NSLayoutConstraint?

    init(snapshot: TinkieMelodyScoreot) {
        self.snapshot = snapshot
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        buildLayout()
        bindKeyboard()
    }

    private func buildLayout() {
        view.backgroundColor = .white

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .interactive
        view.addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        let heroView = UIImageView(image: profileImage())
        heroView.contentMode = .scaleAspectFill
        heroView.clipsToBounds = true
        heroView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(heroView)

        let shadeView = TinkieBottomShadeView()
        shadeView.translatesAutoresizingMaskIntoConstraints = false
        heroView.addSubview(shadeView)

        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.contentHorizontalAlignment = .leading
        backButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backButton)

        let titleLabel = UILabel()
        titleLabel.text = "Edit profile"
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 24
        cardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cardView.layer.masksToBounds = true
        cardView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardView)

        let avatarView = UIImageView(image: profileImage())
        avatarView.contentMode = .scaleAspectFill
        avatarView.layer.cornerRadius = 34
        avatarView.layer.borderWidth = 3
        avatarView.layer.borderColor = UIColor.white.cgColor
        avatarView.layer.masksToBounds = true
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(avatarView)

        let nameLabel = makeFieldLabel("Nickname")
        cardView.addSubview(nameLabel)
        configureField(nameField, text: snapshot.nickname, placeholder: "Miko")
        cardView.addSubview(nameField)

        let signatureLabel = makeFieldLabel("Character Bio")
        cardView.addSubview(signatureLabel)
        configureField(signatureField, text: snapshot.signature, placeholder: "Write a brief backstory or character intro.")
        cardView.addSubview(signatureField)

        let confirmButton = TinkieridgeCirclyButton(title: "Confirm", symbolName: nil)
        confirmButton.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(confirmButton)

        NSLayoutConstraint.activate([
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

            heroView.topAnchor.constraint(equalTo: contentView.topAnchor),
            heroView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            heroView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            heroView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.38),

            shadeView.leadingAnchor.constraint(equalTo: heroView.leadingAnchor),
            shadeView.trailingAnchor.constraint(equalTo: heroView.trailingAnchor),
            shadeView.bottomAnchor.constraint(equalTo: heroView.bottomAnchor),
            shadeView.heightAnchor.constraint(equalTo: heroView.heightAnchor, multiplier: 0.52),

            backButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 18),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 48),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            cardView.topAnchor.constraint(equalTo: heroView.bottomAnchor, constant: -24),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            avatarView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            avatarView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: -36),
            avatarView.widthAnchor.constraint(equalToConstant: 68),
            avatarView.heightAnchor.constraint(equalToConstant: 68),

            nameLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 26),
            nameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -26),

            nameField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            nameField.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 26),
            nameField.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -26),
            nameField.heightAnchor.constraint(equalToConstant: 48),

            signatureLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 22),
            signatureLabel.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            signatureLabel.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),

            signatureField.topAnchor.constraint(equalTo: signatureLabel.bottomAnchor, constant: 10),
            signatureField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            signatureField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            signatureField.heightAnchor.constraint(equalToConstant: 48),

            confirmButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 26),
            confirmButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -26),
            confirmButton.heightAnchor.constraint(equalToConstant: 44),
            confirmButton.topAnchor.constraint(greaterThanOrEqualTo: signatureField.bottomAnchor, constant: 52)
        ])
        bottomConstraint = confirmButton.bottomAnchor.constraint(equalTo: cardView.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        bottomConstraint?.isActive = true
    }

    private func makeFieldLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func configureField(_ field: UITextField, text: String, placeholder: String) {
        field.text = text
        field.placeholder = placeholder
        field.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        field.textColor = UIColor.black.withAlphaComponent(0.76)
        field.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        field.layer.cornerRadius = 9
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 1))
        field.leftViewMode = .always
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        field.rightViewMode = .always
        field.clearButtonMode = .whileEditing
        field.translatesAutoresizingMaskIntoConstraints = false
    }

    private func profileImage() -> UIImage? {
        if let path = snapshot.heroImagePath, let image = UIImage(contentsOfFile: path) {
            return image
        }
        return UIImage(named: snapshot.heroImageName)
    }

    private func bindKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(endTyping))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func confirmTapped() {
        guard TinkieProfileStore.updateCurrentProfile(nickname: nameField.text ?? "", signature: signatureField.text ?? "") else {
            let alert = UIAlertController(title: "Tinkie", message: "Please enter a nickname.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        onProfileSaved?()
        dismiss(animated: true)
    }

    @objc private func closeTapped() {
        dismiss(animated: true)
    }

    @objc private func endTyping() {
        view.endEditing(true)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let bottom = frame.height - view.safeAreaInsets.bottom + 16
        scrollView.contentInset.bottom = bottom
        scrollView.verticalScrollIndicatorInsets.bottom = bottom
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = view.safeAreaInsets.bottom + 20
        scrollView.verticalScrollIndicatorInsets.bottom = scrollView.contentInset.bottom
    }
}
