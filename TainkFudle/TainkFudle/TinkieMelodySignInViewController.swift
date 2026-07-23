import UIKit

class TinkieMelodyGateScrollViewController: UIViewController {
    let melodyGateScrollStage = UIScrollView()
    let melodyGateBoardStage = UIView()
    private var restingKeyboardInsets: UIEdgeInsets = .zero

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(melodyKeyboardRose), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(melodyKeyboardSettled), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func layNeonMelodyGateStage(backgroundName: String, usesSignInGlow: Bool = false) {
        let neonGateWall = TinkieMelodyGateRecordBackdropView(imageName: usesSignInGlow ? "tinkie_auth_neon_note_backdrop" : backgroundName)
        neonGateWall.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(neonGateWall)

        melodyGateScrollStage.translatesAutoresizingMaskIntoConstraints = false
        melodyGateScrollStage.alwaysBounceVertical = true
        melodyGateScrollStage.showsVerticalScrollIndicator = false
        view.addSubview(melodyGateScrollStage)

        melodyGateBoardStage.translatesAutoresizingMaskIntoConstraints = false
        melodyGateScrollStage.addSubview(melodyGateBoardStage)

        NSLayoutConstraint.activate([
            neonGateWall.topAnchor.constraint(equalTo: view.topAnchor),
            neonGateWall.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            neonGateWall.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            neonGateWall.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            melodyGateScrollStage.topAnchor.constraint(equalTo: view.topAnchor),
            melodyGateScrollStage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            melodyGateScrollStage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            melodyGateScrollStage.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            melodyGateBoardStage.topAnchor.constraint(equalTo: melodyGateScrollStage.contentLayoutGuide.topAnchor),
            melodyGateBoardStage.leadingAnchor.constraint(equalTo: melodyGateScrollStage.contentLayoutGuide.leadingAnchor),
            melodyGateBoardStage.trailingAnchor.constraint(equalTo: melodyGateScrollStage.contentLayoutGuide.trailingAnchor),
            melodyGateBoardStage.bottomAnchor.constraint(equalTo: melodyGateScrollStage.contentLayoutGuide.bottomAnchor),
            melodyGateBoardStage.widthAnchor.constraint(equalTo: melodyGateScrollStage.frameLayoutGuide.widthAnchor),
            melodyGateBoardStage.heightAnchor.constraint(greaterThanOrEqualTo: melodyGateScrollStage.frameLayoutGuide.heightAnchor)
        ])
    }

    func dropGateBackBeat() {
        let smallBackTuneButton = UIButton()
        smallBackTuneButton.setBackgroundImage(UIImage(named: "tinkie_auth_back_mark"), for: .normal)
      
        smallBackTuneButton.addTarget(self, action: #selector(goBackOneMelodyBeat), for: .touchUpInside)
        smallBackTuneButton.translatesAutoresizingMaskIntoConstraints = false
        melodyGateBoardStage.addSubview(smallBackTuneButton)
        NSLayoutConstraint.activate([
            smallBackTuneButton.leadingAnchor.constraint(equalTo: melodyGateBoardStage.leadingAnchor, constant: 16),
            smallBackTuneButton.topAnchor.constraint(equalTo: melodyGateBoardStage.safeAreaLayoutGuide.topAnchor, constant: 16),
            smallBackTuneButton.widthAnchor.constraint(equalToConstant: 32),
            smallBackTuneButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    func showMelodyGateHint(_ hintWords: String) {
        tinkieShowTuneNotice(title: TinkieVerseCipherTrail.singBack("TQiYnPkWiseX"), detail: hintWords)
    }

    @objc private func melodyKeyboardRose(_ notification: Notification) {
        guard
            let keyFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }
        restingKeyboardInsets = melodyGateScrollStage.contentInset
        let bottomBeatGap = max(0, view.bounds.maxY - keyFrame.minY)
        melodyGateScrollStage.contentInset.bottom = bottomBeatGap + 24
        melodyGateScrollStage.verticalScrollIndicatorInsets.bottom = bottomBeatGap + 24
    }

    @objc private func melodyKeyboardSettled() {
        melodyGateScrollStage.contentInset = restingKeyboardInsets
        melodyGateScrollStage.verticalScrollIndicatorInsets = restingKeyboardInsets
    }

    @objc private func stopMelodyGateTyping() {
        view.endEditing(true)
    }

    @objc private func goBackOneMelodyBeat() {
        navigationController?.popViewController(animated: true)
    }
}

final class TinkieMelodySignInViewController: TinkieMelodyGateScrollViewController {
    var onMelodyGateUnlocked: (() -> Void)?
    private let mailTuneEntryBox = TinkieMelodyGateEntryBox(iconName: "tinkie_auth_email_mark", placeholder: "Enter your email address")
    private let secretTuneEntryBox = TinkieMelodyGateEntryBox(iconName: "tinkie_auth_lock_mark", placeholder: "Enter your password", secure: true)

    override func viewDidLoad() {
        super.viewDidLoad()

        layNeonMelodyGateStage(backgroundName: "tinkie_auth_signup_neon_backdrop", usesSignInGlow: true)
        putSingerSignInTuneTogether()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func putSingerSignInTuneTogether() {
        dropGateBackBeat()

        let loginBigWords = UILabel()
        loginBigWords.text = TinkieVerseCipherTrail.singBack("LqocgNisnq")
        loginBigWords.textColor = .white
        loginBigWords.font = UIFont.systemFont(ofSize: 34, weight: .black)
        loginBigWords.textAlignment = .center

        mailTuneEntryBox.melodyTextField.keyboardType = .emailAddress
        secretTuneEntryBox.melodyTextField.textContentType = .password

        let continueBeatButton = TinkieMelodyGateBlackBeatButton(title: TinkieVerseCipherTrail.singBack("CVovnutQiQnHuLer"))
        continueBeatButton.addTarget(self, action: #selector(continueMelodyGateTapped), for: .touchUpInside)

        let signInStack = UIStackView(arrangedSubviews: [loginBigWords, mailTuneEntryBox, secretTuneEntryBox, continueBeatButton])
        signInStack.axis = .vertical
        signInStack.spacing = 28
        signInStack.translatesAutoresizingMaskIntoConstraints = false
        melodyGateBoardStage.addSubview(signInStack)

        NSLayoutConstraint.activate([
            signInStack.leadingAnchor.constraint(equalTo: melodyGateBoardStage.leadingAnchor, constant: 20),
            signInStack.trailingAnchor.constraint(equalTo: melodyGateBoardStage.trailingAnchor, constant: -20),
            signInStack.centerYAnchor.constraint(equalTo: melodyGateBoardStage.centerYAnchor, constant: 78),
            loginBigWords.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    @objc private func continueMelodyGateTapped() {
        let melodyGateResult = TinkieMelodyGateScorebook.stepIntoSingerMelody(
            mailText: mailTuneEntryBox.melodyTextField.text ?? "",
            secretText: secretTuneEntryBox.melodyTextField.text ?? ""
        )
        switch melodyGateResult {
        case .melodyOpened:
            onMelodyGateUnlocked?()
        case .melodyBlocked(let whyWords):
            showMelodyGateHint(whyWords)
        }
    }
}
