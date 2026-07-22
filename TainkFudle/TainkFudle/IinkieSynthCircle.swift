import UIKit

final class TinkieDrumEcho: UIView {
    private let imageView = UIImageView()
//    private let washView = TinkieAuthWashView()

    init(imageName: String) {
        super.init(frame: .zero)
//        backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.08, alpha: 1)
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
//        washView.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(washView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),

//            washView.topAnchor.constraint(equalTo: topAnchor),
//            washView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            washView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            washView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TnkieDrumRush: UIView {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let gradient = layer as! CAGradientLayer
        gradient.colors = [
            UIColor.black.withAlphaComponent(0.02).cgColor,
            UIColor(red: 0.84, green: 0.12, blue: 0.61, alpha: 0.68).cgColor,
            UIColor(red: 0.08, green: 0.84, blue: 0.80, alpha: 0.88).cgColor,
            UIColor.white.withAlphaComponent(0.96).cgColor
        ]
        gradient.locations = [0, 0.42, 0.66, 1]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TinkieAuthPrimaryButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.italicSystemFont(ofSize: 18)
        backgroundColor = .black
        layer.cornerRadius = 26
        layer.masksToBounds = true
        heightAnchor.constraint(equalToConstant: 52).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class IinkieSynthCircle: UIButton {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .black)
        layer.cornerRadius = 26
        layer.masksToBounds = true
        let gradient = layer as! CAGradientLayer
        gradient.colors = [
            UIColor(red: 0.82, green: 0.08, blue: 0.60, alpha: 1).cgColor,
            UIColor(red: 0.11, green: 0.85, blue: 0.80, alpha: 1).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        heightAnchor.constraint(equalToConstant: 52).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TinkieAuthInputField: UIView, UITextFieldDelegate {
    let textField = UITextField()
    private let iconView = UIImageView()
    private let revealButton = UIButton(type: .system)

    init(iconName: String, placeholder: String, secure: Bool = false) {
        super.init(frame: .zero)
        backgroundColor = UIColor(red: 0.12, green: 0.13, blue: 0.14, alpha: 0.20)
        layer.cornerRadius = 26
        layer.masksToBounds = true
        heightAnchor.constraint(equalToConstant: 52).isActive = true

        iconView.image = UIImage(named: iconName)
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconView)

        let divider = UIView()
        divider.backgroundColor = UIColor.white.withAlphaComponent(0.22)
        divider.translatesAutoresizingMaskIntoConstraints = false
        addSubview(divider)

        textField.placeholder = placeholder
        textField.textColor = .white
        textField.tintColor = .white
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = secure
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.92)]
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)

        revealButton.setImage(UIImage(named: "tinkie_auth_eye_mark"), for: .normal)
        revealButton.tintColor = .white
        revealButton.isHidden = !secure
        revealButton.addTarget(self, action: #selector(toggleReveal), for: .touchUpInside)
        revealButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(revealButton)

        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 26),
            iconView.heightAnchor.constraint(equalToConstant: 26),

            divider.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            divider.centerYAnchor.constraint(equalTo: centerYAnchor),
            divider.widthAnchor.constraint(equalToConstant: 1),
            divider.heightAnchor.constraint(equalToConstant: 16),

            textField.leadingAnchor.constraint(equalTo: divider.trailingAnchor, constant: 18),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: secure ? revealButton.leadingAnchor : trailingAnchor, constant: secure ? -10 : -18),

            revealButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            revealButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            revealButton.widthAnchor.constraint(equalToConstant: 32),
            revealButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func toggleReveal() {
        textField.isSecureTextEntry.toggle()
    }
}

final class TinkieAuthAgreementView: UIView {
    var onToggle: ((Bool) -> Void)?
    var onTerms: (() -> Void)?
    var onPrivacy: (() -> Void)?
    private let checkButton = UIButton(type: .system)

    var isChecked: Bool = false {
        didSet { updateState() }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        checkButton.layer.borderWidth = 2
        checkButton.layer.borderColor = UIColor.black.cgColor
        checkButton.layer.cornerRadius = 11
        checkButton.addTarget(self, action: #selector(toggle), for: .touchUpInside)
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(checkButton)

        let text = UILabel()
        text.numberOfLines = 2
        text.textAlignment = .left
        text.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        text.textColor = UIColor.black.withAlphaComponent(0.56)
        text.text = "By registering, you agree to the"
        text.translatesAutoresizingMaskIntoConstraints = false
        addSubview(text)

        let terms = UIButton()
        terms.setTitle("Terms of Use", for: .normal)
        terms.setTitleColor(.black, for: .normal)
        terms.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        terms.addTarget(self, action: #selector(openTerms), for: .touchUpInside)
        terms.translatesAutoresizingMaskIntoConstraints = false
        addSubview(terms)

        let privacy = UIButton(type: .system)
        privacy.setTitle("Privacy Policy", for: .normal)
        privacy.setTitleColor(.black, for: .normal)
        privacy.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        privacy.addTarget(self, action: #selector(openPrivacy), for: .touchUpInside)
        privacy.translatesAutoresizingMaskIntoConstraints = false
        addSubview(privacy)

        NSLayoutConstraint.activate([
            checkButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkButton.widthAnchor.constraint(equalToConstant: 22),
            checkButton.heightAnchor.constraint(equalToConstant: 22),

            text.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: 12),
            text.topAnchor.constraint(equalTo: topAnchor),
          

            terms.leadingAnchor.constraint(equalTo: text.trailingAnchor, constant: 1),
            terms.centerYAnchor.constraint(equalTo: text.centerYAnchor, constant: 0),

            privacy.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 5),
            privacy.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0)
        ])
        updateState()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateState() {
        checkButton.backgroundColor = isChecked ? UIColor(red: 0.06, green: 0.06, blue: 0.07, alpha: 1) : .clear
        checkButton.setTitle(isChecked ? "✓" : "", for: .normal)
        checkButton.setTitleColor(.white, for: .normal)
    }

    @objc private func toggle() {
        isChecked.toggle()
        onToggle?(isChecked)
    }

    @objc private func openTerms() {
        onTerms?()
    }

    @objc private func openPrivacy() {
        onPrivacy?()
    }
}
