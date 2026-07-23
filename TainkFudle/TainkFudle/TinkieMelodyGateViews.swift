import UIKit

final class TinkieMelodyGateRecordBackdropView: UIView {
    private let neonRecordBackImage = UIImageView()

    init(imageName: String) {
        super.init(frame: .zero)
        neonRecordBackImage.image = UIImage(named: imageName)
        neonRecordBackImage.contentMode = .scaleAspectFill
        neonRecordBackImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(neonRecordBackImage)
        NSLayoutConstraint.activate([
            neonRecordBackImage.topAnchor.constraint(equalTo: topAnchor),
            neonRecordBackImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            neonRecordBackImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            neonRecordBackImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TinkieMelodyGateGlowStageView: UIView {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let stageLightLayer = layer as! CAGradientLayer
        stageLightLayer.colors = [
            UIColor.black.withAlphaComponent(0.02).cgColor,
            UIColor(red: 0.84, green: 0.12, blue: 0.61, alpha: 0.68).cgColor,
            UIColor(red: 0.08, green: 0.84, blue: 0.80, alpha: 0.88).cgColor,
            UIColor.white.withAlphaComponent(0.96).cgColor
        ]
        stageLightLayer.locations = [0, 0.42, 0.66, 1]
        stageLightLayer.startPoint = CGPoint(x: 0.5, y: 0)
        stageLightLayer.endPoint = CGPoint(x: 0.5, y: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TinkieMelodyGateBlackBeatButton: UIButton {
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

final class TinkieMelodyGateNeonBeatButton: UIButton {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .black)
        layer.cornerRadius = 26
        layer.masksToBounds = true
        let neonButtonLayer = layer as! CAGradientLayer
        neonButtonLayer.colors = [
            UIColor(red: 0.82, green: 0.08, blue: 0.60, alpha: 1).cgColor,
            UIColor(red: 0.11, green: 0.85, blue: 0.80, alpha: 1).cgColor
        ]
        neonButtonLayer.startPoint = CGPoint(x: 0, y: 0.5)
        neonButtonLayer.endPoint = CGPoint(x: 1, y: 0.5)
        heightAnchor.constraint(equalToConstant: 52).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TinkieMelodyGateEntryBox: UIView, UITextFieldDelegate {
    let melodyTextField = UITextField()
    private let entryTuneMarkView = UIImageView()
    private let secretEyeBeatButton = UIButton(type: .system)

    init(iconName: String, placeholder: String, secure: Bool = false) {
        super.init(frame: .zero)
        backgroundColor = UIColor(red: 0.12, green: 0.13, blue: 0.14, alpha: 0.20)
        layer.cornerRadius = 26
        layer.masksToBounds = true
        heightAnchor.constraint(equalToConstant: 52).isActive = true

        entryTuneMarkView.image = UIImage(named: iconName)
        entryTuneMarkView.contentMode = .scaleAspectFit
        entryTuneMarkView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(entryTuneMarkView)

        let littleWhiteLine = UIView()
        littleWhiteLine.backgroundColor = UIColor.white.withAlphaComponent(0.22)
        littleWhiteLine.translatesAutoresizingMaskIntoConstraints = false
        addSubview(littleWhiteLine)

        melodyTextField.placeholder = placeholder
        melodyTextField.textColor = .white
        melodyTextField.tintColor = .white
        melodyTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        melodyTextField.autocapitalizationType = .none
        melodyTextField.autocorrectionType = .no
        melodyTextField.isSecureTextEntry = secure
        melodyTextField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.92)]
        )
        melodyTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(melodyTextField)

        secretEyeBeatButton.setImage(UIImage(named: "tinkie_auth_eye_mark"), for: .normal)
        secretEyeBeatButton.tintColor = .white
        secretEyeBeatButton.isHidden = !secure
        secretEyeBeatButton.addTarget(self, action: #selector(flipSecretTuneText), for: .touchUpInside)
        secretEyeBeatButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(secretEyeBeatButton)

        NSLayoutConstraint.activate([
            entryTuneMarkView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            entryTuneMarkView.centerYAnchor.constraint(equalTo: centerYAnchor),
            entryTuneMarkView.widthAnchor.constraint(equalToConstant: 26),
            entryTuneMarkView.heightAnchor.constraint(equalToConstant: 26),

            littleWhiteLine.leadingAnchor.constraint(equalTo: entryTuneMarkView.trailingAnchor, constant: 12),
            littleWhiteLine.centerYAnchor.constraint(equalTo: centerYAnchor),
            littleWhiteLine.widthAnchor.constraint(equalToConstant: 1),
            littleWhiteLine.heightAnchor.constraint(equalToConstant: 16),

            melodyTextField.leadingAnchor.constraint(equalTo: littleWhiteLine.trailingAnchor, constant: 18),
            melodyTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            melodyTextField.trailingAnchor.constraint(equalTo: secure ? secretEyeBeatButton.leadingAnchor : trailingAnchor, constant: secure ? -10 : -18),

            secretEyeBeatButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            secretEyeBeatButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            secretEyeBeatButton.widthAnchor.constraint(equalToConstant: 32),
            secretEyeBeatButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func flipSecretTuneText() {
        melodyTextField.isSecureTextEntry.toggle()
    }
}

final class TinkieMelodyRulebookCheckView: UIView {
    var onRulebookSwitch: ((Bool) -> Void)?
    var onTermsRulebookPaper: (() -> Void)?
    var onPrivacyRulebookPaper: (() -> Void)?
    private let rulebookCheckButton = UIButton(type: .system)

    var isRuleChecked: Bool = false {
        didSet { paintRulebookCheckState() }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        rulebookCheckButton.layer.borderWidth = 2
        rulebookCheckButton.layer.borderColor = UIColor.black.cgColor
        rulebookCheckButton.layer.cornerRadius = 11
        rulebookCheckButton.addTarget(self, action: #selector(tapRulebookCheck), for: .touchUpInside)
        rulebookCheckButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rulebookCheckButton)

        let ruleSmallWords = UILabel()
        ruleSmallWords.numberOfLines = 2
        ruleSmallWords.textAlignment = .left
        ruleSmallWords.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        ruleSmallWords.textColor = UIColor.black.withAlphaComponent(0.56)
        ruleSmallWords.text = "By registering, you agree to the"
        ruleSmallWords.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ruleSmallWords)

        let termsPaperButton = UIButton()
        termsPaperButton.setTitle("Terms of Use", for: .normal)
        termsPaperButton.setTitleColor(.black, for: .normal)
        termsPaperButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        termsPaperButton.addTarget(self, action: #selector(tapTermsRulebookPaper), for: .touchUpInside)
        termsPaperButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(termsPaperButton)

        let privacyPaperButton = UIButton(type: .system)
        privacyPaperButton.setTitle("Privacy Policy", for: .normal)
        privacyPaperButton.setTitleColor(.black, for: .normal)
        privacyPaperButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        privacyPaperButton.addTarget(self, action: #selector(tapPrivacyRulebookPaper), for: .touchUpInside)
        privacyPaperButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(privacyPaperButton)

        NSLayoutConstraint.activate([
            rulebookCheckButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            rulebookCheckButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            rulebookCheckButton.widthAnchor.constraint(equalToConstant: 22),
            rulebookCheckButton.heightAnchor.constraint(equalToConstant: 22),

            ruleSmallWords.leadingAnchor.constraint(equalTo: rulebookCheckButton.trailingAnchor, constant: 12),
            ruleSmallWords.topAnchor.constraint(equalTo: topAnchor),
          

            termsPaperButton.leadingAnchor.constraint(equalTo: ruleSmallWords.trailingAnchor, constant: 1),
            termsPaperButton.centerYAnchor.constraint(equalTo: ruleSmallWords.centerYAnchor, constant: 0),

            privacyPaperButton.topAnchor.constraint(equalTo: ruleSmallWords.bottomAnchor, constant: 5),
            privacyPaperButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0)
        ])
        paintRulebookCheckState()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func paintRulebookCheckState() {
        rulebookCheckButton.backgroundColor = isRuleChecked ? UIColor(red: 0.06, green: 0.06, blue: 0.07, alpha: 1) : .clear
        rulebookCheckButton.setTitle(isRuleChecked ? "✓" : "", for: .normal)
        rulebookCheckButton.setTitleColor(.white, for: .normal)
    }

    @objc private func tapRulebookCheck() {
        isRuleChecked.toggle()
        onRulebookSwitch?(isRuleChecked)
    }

    @objc private func tapTermsRulebookPaper() {
        onTermsRulebookPaper?()
    }

    @objc private func tapPrivacyRulebookPaper() {
        onPrivacyRulebookPaper?()
    }
}
