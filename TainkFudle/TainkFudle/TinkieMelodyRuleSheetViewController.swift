import UIKit

final class TinkieMelodyRuleSheetViewController: UIViewController {
    var onRuleAgree: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        putRulebookSheetTogether()
    }

    private func putRulebookSheetTogether() {
        let neonRuleWall = TinkieMelodyGateRecordBackdropView(imageName: "tinkie_auth_neon_note_backdrop")
        neonRuleWall.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(neonRuleWall)

        let darkRuleShade = UIView()
        darkRuleShade.backgroundColor = UIColor.black.withAlphaComponent(0.46)
        darkRuleShade.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(darkRuleShade)

        let whiteRuleCard = UIView()
        whiteRuleCard.backgroundColor = .white
        whiteRuleCard.layer.cornerRadius = 24
        whiteRuleCard.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        whiteRuleCard.layer.masksToBounds = true
        whiteRuleCard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(whiteRuleCard)

        let ruleTitleWords = UILabel()
        ruleTitleWords.text = "EULA"
        ruleTitleWords.textColor = .black
        ruleTitleWords.font = UIFont.systemFont(ofSize: 25, weight: .black)
        ruleTitleWords.textAlignment = .center
        ruleTitleWords.translatesAutoresizingMaskIntoConstraints = false
        whiteRuleCard.addSubview(ruleTitleWords)

        let ruleLongWords = UILabel()
        ruleLongWords.text = TinkieMelodyRulebookVerse.eulaTuneBody
        ruleLongWords.textColor = .black
        ruleLongWords.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        ruleLongWords.numberOfLines = 0
        ruleLongWords.translatesAutoresizingMaskIntoConstraints = false
        whiteRuleCard.addSubview(ruleLongWords)

        let termsPaperButton = UIButton(type: .system)
        termsPaperButton.setTitle("<Terms of Use>", for: .normal)
        termsPaperButton.setTitleColor(.black, for: .normal)
        termsPaperButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .black)
        termsPaperButton.addTarget(self, action: #selector(openTermsRulebookPaper), for: .touchUpInside)

        let privacyPaperButton = UIButton(type: .system)
        privacyPaperButton.setTitle("<Privacy Policy>", for: .normal)
        privacyPaperButton.setTitleColor(.black, for: .normal)
        privacyPaperButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .black)
        privacyPaperButton.addTarget(self, action: #selector(openPrivacyRulebookPaper), for: .touchUpInside)

        let ruleLinkRow = UIStackView(arrangedSubviews: [termsPaperButton, privacyPaperButton])
        ruleLinkRow.axis = .horizontal
        ruleLinkRow.distribution = .fillEqually
        ruleLinkRow.spacing = 12
        ruleLinkRow.translatesAutoresizingMaskIntoConstraints = false
        whiteRuleCard.addSubview(ruleLinkRow)

        let laterButton = UIButton(type: .system)
        laterButton.setTitle("Cancel", for: .normal)
        laterButton.setTitleColor(UIColor.black.withAlphaComponent(0.28), for: .normal)
        laterButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        laterButton.layer.cornerRadius = 26
        laterButton.layer.borderColor = UIColor.black.withAlphaComponent(0.12).cgColor
        laterButton.layer.borderWidth = 1
        laterButton.addTarget(self, action: #selector(cancelRulebookSheet), for: .touchUpInside)

        let agreePulseButton = TinkieMelodyGateNeonBeatButton(title: "I agree")
        agreePulseButton.addTarget(self, action: #selector(agreeRulebookSheet), for: .touchUpInside)

        let ruleButtonRow = UIStackView(arrangedSubviews: [laterButton, agreePulseButton])
        ruleButtonRow.axis = .horizontal
        ruleButtonRow.distribution = .fillEqually
        ruleButtonRow.spacing = 14
        ruleButtonRow.translatesAutoresizingMaskIntoConstraints = false
        whiteRuleCard.addSubview(ruleButtonRow)

        NSLayoutConstraint.activate([
            neonRuleWall.topAnchor.constraint(equalTo: view.topAnchor),
            neonRuleWall.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            neonRuleWall.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            neonRuleWall.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            darkRuleShade.topAnchor.constraint(equalTo: view.topAnchor),
            darkRuleShade.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            darkRuleShade.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            darkRuleShade.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            whiteRuleCard.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whiteRuleCard.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            whiteRuleCard.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            whiteRuleCard.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor, multiplier: 0.60),

            ruleTitleWords.topAnchor.constraint(equalTo: whiteRuleCard.topAnchor, constant: 26),
            ruleTitleWords.leadingAnchor.constraint(equalTo: whiteRuleCard.leadingAnchor, constant: 24),
            ruleTitleWords.trailingAnchor.constraint(equalTo: whiteRuleCard.trailingAnchor, constant: -24),

            ruleLongWords.topAnchor.constraint(equalTo: ruleTitleWords.bottomAnchor, constant: 22),
            ruleLongWords.leadingAnchor.constraint(equalTo: whiteRuleCard.leadingAnchor, constant: 24),
            ruleLongWords.trailingAnchor.constraint(equalTo: whiteRuleCard.trailingAnchor, constant: -24),

            ruleLinkRow.topAnchor.constraint(greaterThanOrEqualTo: ruleLongWords.bottomAnchor, constant: 18),
            ruleLinkRow.leadingAnchor.constraint(equalTo: whiteRuleCard.leadingAnchor, constant: 28),
            ruleLinkRow.trailingAnchor.constraint(equalTo: whiteRuleCard.trailingAnchor, constant: -28),
            ruleLinkRow.heightAnchor.constraint(equalToConstant: 34),

            ruleButtonRow.topAnchor.constraint(equalTo: ruleLinkRow.bottomAnchor, constant: 18),
            ruleButtonRow.leadingAnchor.constraint(equalTo: whiteRuleCard.leadingAnchor, constant: 31),
            ruleButtonRow.trailingAnchor.constraint(equalTo: whiteRuleCard.trailingAnchor, constant: -31),
            ruleButtonRow.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            ruleButtonRow.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    @objc private func cancelRulebookSheet() {
        dismiss(animated: true)
    }

    @objc private func agreeRulebookSheet() {
        dismiss(animated: true) { [weak self] in
            self?.onRuleAgree?()
        }
    }

    @objc private func openTermsRulebookPaper() {
        navigationController?.pushViewController(TinkieMelodyPolicyPaperViewController(paperTitle: "Terms of Use", paperBody: TinkieMelodyRulebookVerse.termsTuneBody), animated: true)
    }

    @objc private func openPrivacyRulebookPaper() {
        navigationController?.pushViewController(TinkieMelodyPolicyPaperViewController(paperTitle: "Privacy Policy", paperBody: TinkieMelodyRulebookVerse.privacyTuneBody), animated: true)
    }
}
