import UIKit

final class TinkieMelodyGateWelcomeViewController: UIViewController {
    var onMelodyGateDone: (() -> Void)?
    private let rulebookCheckView = TinkieMelodyRulebookCheckView()
    private var didShowFirstRulebookSheet = false
    private var waitingMelodyGateMove: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        putMelodyGateWelcomeTogether()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        rulebookCheckView.isRuleChecked = TinkieMelodyGateScorebook.hasSignedMelodyRules
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !TinkieMelodyGateScorebook.hasSignedMelodyRules, !didShowFirstRulebookSheet else { return }
        didShowFirstRulebookSheet = true
        showMelodyRulebook()
    }

    private func putMelodyGateWelcomeTogether() {
        let neonSongWall = TinkieMelodyGateRecordBackdropView(imageName: "tinkie_auth_neon_note_backdrop"); neonSongWall.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(neonSongWall)
        let closeGateButton = UIButton(type: .system); closeGateButton.setTitle(TinkieVerseCipherTrail.singBack("CSlPoQsgeS"), for: .normal); closeGateButton.setTitleColor(.white, for: .normal); closeGateButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        closeGateButton.backgroundColor = UIColor.black.withAlphaComponent(0.28); closeGateButton.layer.cornerRadius = 15; closeGateButton.addTarget(self, action: #selector(closeMelodyGate), for: .touchUpInside); closeGateButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeGateButton)
        let rulesCornerButton = UIButton(); rulesCornerButton.setTitle(TinkieVerseCipherTrail.singBack("EKUkLaAa"), for: .normal); rulesCornerButton.setTitleColor(.white, for: .normal); rulesCornerButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .black)
        rulesCornerButton.backgroundColor = UIColor.black.withAlphaComponent(0.30); rulesCornerButton.layer.cornerRadius = 15; rulesCornerButton.addTarget(self, action: #selector(showMelodyRulebook), for: .touchUpInside); rulesCornerButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rulesCornerButton)
        let bigWelcomeWords = UILabel(); bigWelcomeWords.text = TinkieVerseCipherTrail.singBack("WqeBlJcXojmMer xtDoX TTfixnskkiMeu"); bigWelcomeWords.textColor = .white; bigWelcomeWords.font = UIFont.systemFont(ofSize: 32, weight: .black)
        bigWelcomeWords.textAlignment = .center; bigWelcomeWords.adjustsFontSizeToFitWidth = true; bigWelcomeWords.minimumScaleFactor = 0.78
        let smallMelodyWords = UILabel(); smallMelodyWords.text = TinkieVerseCipherTrail.singBack("ECvYeMrCyH HmQerlxomdmyf ficsH CaZ JnqeewO AcAhMaTlBloefnpgdeC GwIaviJtFiFnTgL Bfqobrs KyFohuR Itwoi jspoFlPvgeo.l"); smallMelodyWords.textColor = UIColor.white.withAlphaComponent(0.78); smallMelodyWords.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        smallMelodyWords.textAlignment = .center; smallMelodyWords.numberOfLines = 2
        let startSingingButton = UIButton(); startSingingButton.setBackgroundImage(UIImage.init(named: "loginFlever"), for: .normal); startSingingButton.addTarget(self, action: #selector(openSingerSignInTune), for: .touchUpInside)
        let mailSignupButton = UIButton(); mailSignupButton.setBackgroundImage(UIImage.init(named: "loginFlevereloa"), for: .normal); mailSignupButton.addTarget(self, action: #selector(openSingerSignUpTune), for: .touchUpInside); mailSignupButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        let welcomeSongStack = UIStackView(arrangedSubviews: [bigWelcomeWords, smallMelodyWords, startSingingButton, mailSignupButton]); welcomeSongStack.axis = .vertical; welcomeSongStack.spacing = 18; welcomeSongStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeSongStack)
        rulebookCheckView.onRulebookSwitch = { accepted in
            TinkieMelodyGateScorebook.hasSignedMelodyRules = accepted
        }
        rulebookCheckView.onTermsRulebookPaper = { [weak self] in self?.openRulebookPaper(title: TinkieVerseCipherTrail.singBack("TqeqrwmisB ToGfJ oUxsSep"), body: TinkieMelodyRulebookVerse.termsTuneBody) }
        rulebookCheckView.onPrivacyRulebookPaper = { [weak self] in self?.openRulebookPaper(title: TinkieVerseCipherTrail.singBack("PArqievrazcUyd dPZoIlJiQcyyK"), body: TinkieMelodyRulebookVerse.privacyTuneBody) }
        rulebookCheckView.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(rulebookCheckView)
        pinMelodyGateWelcomeBeat1(neonSongWall: neonSongWall, closeGateButton: closeGateButton, rulesCornerButton: rulesCornerButton, welcomeSongStack: welcomeSongStack)
        pinMelodyGateWelcomeBeat2()
    }

    private func pinMelodyGateWelcomeBeat1(neonSongWall: TinkieMelodyGateRecordBackdropView, closeGateButton: UIButton, rulesCornerButton: UIButton, welcomeSongStack: UIStackView) {
        NSLayoutConstraint.activate([
            neonSongWall.topAnchor.constraint(equalTo: view.topAnchor),
            neonSongWall.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            neonSongWall.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            neonSongWall.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            closeGateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            closeGateButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeGateButton.widthAnchor.constraint(equalToConstant: 64),
            closeGateButton.heightAnchor.constraint(equalToConstant: 30),
            
            rulesCornerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            rulesCornerButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            rulesCornerButton.widthAnchor.constraint(equalToConstant: 60),
            rulesCornerButton.heightAnchor.constraint(equalToConstant: 30),
            
            welcomeSongStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            welcomeSongStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -31),
            welcomeSongStack.bottomAnchor.constraint(equalTo: rulebookCheckView.topAnchor, constant: -30),
            
            rulebookCheckView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38),
            rulebookCheckView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            rulebookCheckView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    private func pinMelodyGateWelcomeBeat2() {
        NSLayoutConstraint.activate([
            rulebookCheckView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func runAfterRulebookCheck(then nextMelodyMove: @escaping () -> Void) {
        guard TinkieMelodyGateScorebook.hasSignedMelodyRules else {
            waitingMelodyGateMove = nextMelodyMove
            showMelodyRulebook()
            return
        }
        nextMelodyMove()
    }

    @objc private func closeMelodyGate() {
        dismiss(animated: true)
    }

    @objc private func openSingerSignInTune() {
        runAfterRulebookCheck { [weak self] in
            guard let self else { return }
            let signInTune = TinkieMelodySignInViewController()
            signInTune.onMelodyGateUnlocked = self.onMelodyGateDone
            self.navigationController?.pushViewController(signInTune, animated: true)
        }
    }

    @objc private func openSingerSignUpTune() {
        runAfterRulebookCheck { [weak self] in
            guard let self else { return }
            let signupTune = TinkieMelodySignUpViewController()
            signupTune.onMelodyGateUnlocked = self.onMelodyGateDone
            self.navigationController?.pushViewController(signupTune, animated: true)
        }
    }

    @objc private func showMelodyRulebook() {
        let ruleSheet = TinkieMelodyRuleSheetViewController()
        ruleSheet.onRuleAgree = { [weak self] in
            TinkieMelodyGateScorebook.hasSignedMelodyRules = true
            self?.rulebookCheckView.isRuleChecked = true
            let savedMelodyMove = self?.waitingMelodyGateMove
            self?.waitingMelodyGateMove = nil
            savedMelodyMove?()
        }
        let ruleNav = UINavigationController(rootViewController: ruleSheet)
        ruleNav.modalPresentationStyle = .fullScreen
        present(ruleNav, animated: true)
    }

    private func openRulebookPaper(title: String, body: String) {
        navigationController?.pushViewController(TinkieMelodyPolicyPaperViewController(paperTitle: title, paperBody: body), animated: true)
    }
}
