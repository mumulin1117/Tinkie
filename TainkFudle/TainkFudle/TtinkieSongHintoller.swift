import UIKit

final class TtinkieSongHintoller: UIViewController {
    var onAgree: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        buildLayout()
    }

    private func buildLayout() {
        let backdrop = TinkieDrumEcho(imageName: "tinkie_auth_neon_note_backdrop")
        backdrop.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backdrop)

        let dim = UIView()
        dim.backgroundColor = UIColor.black.withAlphaComponent(0.46)
        dim.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dim)

        let panel = UIView()
        panel.backgroundColor = .white
        panel.layer.cornerRadius = 24
        panel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        panel.layer.masksToBounds = true
        panel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(panel)

        let titleLabel = UILabel()
        titleLabel.text = "EULA"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .black)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        panel.addSubview(titleLabel)

        let bodyLabel = UILabel()
        bodyLabel.text = TinkieSongStreak.eulaBody
        bodyLabel.textColor = .black
        bodyLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        bodyLabel.numberOfLines = 0
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        panel.addSubview(bodyLabel)

        let termsButton = UIButton(type: .system)
        termsButton.setTitle("<Terms of Use>", for: .normal)
        termsButton.setTitleColor(.black, for: .normal)
        termsButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .black)
        termsButton.addTarget(self, action: #selector(openTerms), for: .touchUpInside)

        let privacyButton = UIButton(type: .system)
        privacyButton.setTitle("<Privacy Policy>", for: .normal)
        privacyButton.setTitleColor(.black, for: .normal)
        privacyButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .black)
        privacyButton.addTarget(self, action: #selector(openPrivacy), for: .touchUpInside)

        let linkStack = UIStackView(arrangedSubviews: [termsButton, privacyButton])
        linkStack.axis = .horizontal
        linkStack.distribution = .fillEqually
        linkStack.spacing = 12
        linkStack.translatesAutoresizingMaskIntoConstraints = false
        panel.addSubview(linkStack)

        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor.black.withAlphaComponent(0.28), for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        cancelButton.layer.cornerRadius = 26
        cancelButton.layer.borderColor = UIColor.black.withAlphaComponent(0.12).cgColor
        cancelButton.layer.borderWidth = 1
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)

        let agreeButton = IinkieSynthCircle(title: "I agree")
        agreeButton.addTarget(self, action: #selector(agree), for: .touchUpInside)

        let buttonStack = UIStackView(arrangedSubviews: [cancelButton, agreeButton])
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 14
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        panel.addSubview(buttonStack)

        NSLayoutConstraint.activate([
            backdrop.topAnchor.constraint(equalTo: view.topAnchor),
            backdrop.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backdrop.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backdrop.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dim.topAnchor.constraint(equalTo: view.topAnchor),
            dim.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dim.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dim.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            panel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            panel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            panel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            panel.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor, multiplier: 0.60),

            titleLabel.topAnchor.constraint(equalTo: panel.topAnchor, constant: 26),
            titleLabel.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: -24),

            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 22),
            bodyLabel.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 24),
            bodyLabel.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: -24),

            linkStack.topAnchor.constraint(greaterThanOrEqualTo: bodyLabel.bottomAnchor, constant: 18),
            linkStack.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 28),
            linkStack.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: -28),
            linkStack.heightAnchor.constraint(equalToConstant: 34),

            buttonStack.topAnchor.constraint(equalTo: linkStack.bottomAnchor, constant: 18),
            buttonStack.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 31),
            buttonStack.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: -31),
            buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            buttonStack.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    @objc private func cancel() {
        dismiss(animated: true)
    }

    @objc private func agree() {
        dismiss(animated: true) { [weak self] in
            self?.onAgree?()
        }
    }

    @objc private func openTerms() {
        navigationController?.pushViewController(KieAcousticStreak(titleText: "Terms of Use", bodyText: TinkieSongStreak.termsBody), animated: true)
    }

    @objc private func openPrivacy() {
        navigationController?.pushViewController(KieAcousticStreak(titleText: "Privacy Policy", bodyText: TinkieSongStreak.privacyBody), animated: true)
    }
}
