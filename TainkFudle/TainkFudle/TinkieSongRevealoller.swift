import UIKit

class TinkieSongRevealoller: UIViewController {
    let scrollView = UIScrollView()
    let contentView = UIView()
    private var baseInset: UIEdgeInsets = .zero

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func installScrollLayout(backgroundName: String,islogin:Bool = false) {
        let backdrop = TinkieDrumEcho(imageName:islogin ? "tinkie_auth_neon_note_backdrop" : backgroundName)
        backdrop.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backdrop)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            backdrop.topAnchor.constraint(equalTo: view.topAnchor),
            backdrop.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backdrop.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backdrop.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.frameLayoutGuide.heightAnchor)
        ])
    }

    func addBackButton() {
        let backButton = UIButton()
        backButton.setBackgroundImage(UIImage(named: "tinkie_auth_back_mark"), for: .normal)
      
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 32),
            backButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Tinkie", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard
            let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }
        baseInset = scrollView.contentInset
        let overlap = max(0, view.bounds.maxY - frame.minY)
        scrollView.contentInset.bottom = overlap + 24
        scrollView.verticalScrollIndicatorInsets.bottom = overlap + 24
    }

    @objc private func keyboardWillHide() {
        scrollView.contentInset = baseInset
        scrollView.verticalScrollIndicatorInsets = baseInset
    }

    @objc private func endEditing() {
        view.endEditing(true)
    }

    @objc private func back() {
        navigationController?.popViewController(animated: true)
    }
}

final class TinkieAuthLoginViewController: TinkieSongRevealoller {
    var onSuccess: (() -> Void)?
    private let emailField = TinkieAuthInputField(iconName: "tinkie_auth_email_mark", placeholder: "Enter your email address")
    private let passwordField = TinkieAuthInputField(iconName: "tinkie_auth_lock_mark", placeholder: "Enter your password", secure: true)

    override func viewDidLoad() {
        super.viewDidLoad()

        installScrollLayout(backgroundName: "tinkie_auth_signup_neon_backdrop",islogin: true)
        buildLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func buildLayout() {
        addBackButton()

        let titleLabel = UILabel()
        titleLabel.text = "Login"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .black)
        titleLabel.textAlignment = .center

        emailField.textField.keyboardType = .emailAddress
        passwordField.textField.textContentType = .password

        let actionButton = TinkieAuthPrimaryButton(title: "Continue")
        actionButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [titleLabel, emailField, passwordField, actionButton])
        stack.axis = .vertical
        stack.spacing = 28
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 78),
            titleLabel.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    @objc private func continueTapped() {
        let result = TinkieAcousticDeck.signIn(
            email: emailField.textField.text ?? "",
            password: passwordField.textField.text ?? ""
        )
        switch result {
        case .success:
            onSuccess?()
        case .failure(let message):
            showAlert(message)
        }
    }
}
