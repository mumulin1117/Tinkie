import UIKit

final class TinkieDrumEchoer: UIViewController {
    var onComplete: (() -> Void)?
    private let agreementView = TinkieAuthAgreementView()
    private var hasShownEula = false
    private var pendingAction: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        agreementView.isChecked = TinkieAcousticDeck.hasAcceptedEula
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !TinkieAcousticDeck.hasAcceptedEula, !hasShownEula else { return }
        hasShownEula = true
        presentEula()
    }

    private func buildLayout() {
        let backdrop = TinkieDrumEcho(imageName: "tinkie_auth_neon_note_backdrop")
        backdrop.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backdrop)

        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        closeButton.backgroundColor = UIColor.black.withAlphaComponent(0.28)
        closeButton.layer.cornerRadius = 15
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)

        let eulaButton = UIButton()
        eulaButton.setTitle("EULA", for: .normal)
        eulaButton.setTitleColor(.white, for: .normal)
        eulaButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .black)
        eulaButton.backgroundColor = UIColor.black.withAlphaComponent(0.30)
        eulaButton.layer.cornerRadius = 15
        eulaButton.addTarget(self, action: #selector(presentEula), for: .touchUpInside)
        eulaButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eulaButton)

        let titleLabel = UILabel()
        titleLabel.text = "Welcome to Tinkie"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .black)
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.78

        let subtitleLabel = UILabel()
        subtitleLabel.text = "Every melody is a new challenge waiting for you to solve."
        subtitleLabel.textColor = UIColor.white.withAlphaComponent(0.78)
        subtitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 2

        let loginButton = UIButton()
        loginButton.setBackgroundImage(UIImage.init(named: "loginFlever"), for: .normal)
        loginButton.addTarget(self, action: #selector(openLogin), for: .touchUpInside)

        let emailButton = UIButton()
        emailButton.setBackgroundImage(UIImage.init(named: "loginFlevereloa"), for: .normal)
        emailButton.addTarget(self, action: #selector(openRegister), for: .touchUpInside)
        emailButton.heightAnchor.constraint(equalToConstant: 52).isActive = true

        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, loginButton, emailButton])
        stack.axis = .vertical
        stack.spacing = 18
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        agreementView.onToggle = { accepted in
            TinkieAcousticDeck.hasAcceptedEula = accepted
        }
        agreementView.onTerms = { [weak self] in self?.openPolicy(title: "Terms of Use", body: TinkieSongStreak.termsBody) }
        agreementView.onPrivacy = { [weak self] in self?.openPolicy(title: "Privacy Policy", body: TinkieSongStreak.privacyBody) }
        agreementView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(agreementView)

        NSLayoutConstraint.activate([
            backdrop.topAnchor.constraint(equalTo: view.topAnchor),
            backdrop.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backdrop.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backdrop.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.widthAnchor.constraint(equalToConstant: 64),
            closeButton.heightAnchor.constraint(equalToConstant: 30),

            eulaButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            eulaButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            eulaButton.widthAnchor.constraint(equalToConstant: 60),
            eulaButton.heightAnchor.constraint(equalToConstant: 30),

            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -31),
            stack.bottomAnchor.constraint(equalTo: agreementView.topAnchor, constant: -30),

            agreementView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38),
            agreementView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            agreementView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            agreementView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func requireAgreement(then action: @escaping () -> Void) {
        guard TinkieAcousticDeck.hasAcceptedEula else {
            pendingAction = action
            presentEula()
            return
        }
        action()
    }

    @objc private func close() {
        dismiss(animated: true)
    }

    @objc private func openLogin() {
        requireAgreement { [weak self] in
            guard let self else { return }
            let login = TinkieAuthLoginViewController()
            login.onSuccess = self.onComplete
            self.navigationController?.pushViewController(login, animated: true)
        }
    }

    @objc private func openRegister() {
        requireAgreement { [weak self] in
            guard let self else { return }
            let register = TiinkieAcousticRadar()
            register.onSuccess = self.onComplete
            self.navigationController?.pushViewController(register, animated: true)
        }
    }

    @objc private func presentEula() {
        let eula = TtinkieSongHintoller()
        eula.onAgree = { [weak self] in
            TinkieAcousticDeck.hasAcceptedEula = true
            self?.agreementView.isChecked = true
            let action = self?.pendingAction
            self?.pendingAction = nil
            action?()
        }
        let navigation = UINavigationController(rootViewController: eula)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    private func openPolicy(title: String, body: String) {
        navigationController?.pushViewController(KieAcousticStreak(titleText: title, bodyText: body), animated: true)
    }
}
