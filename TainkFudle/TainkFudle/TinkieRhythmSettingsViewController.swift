import UIKit

final class TinkieRhythmSettingsViewController: UIViewController {
    var onSettingsRhythmChanged: (() -> Void)?

    private let settingsScrollStage = UIScrollView()
    private let settingsContentStage = UIView()
    private let settingsOptionStack = UIStackView()
    private let settingsVeilStage = UIView()
    private let deleteAccountCard = UIView()
    private let signOutSheetStage = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        putRhythmSettingsScreenTogether()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        settingsScrollStage.contentInset.bottom = view.safeAreaInsets.bottom + 24
        settingsScrollStage.verticalScrollIndicatorInsets = settingsScrollStage.contentInset
    }

    private func putRhythmSettingsScreenTogether() {
        view.backgroundColor = UIColor(red: 0.96, green: 0.98, blue: 0.98, alpha: 1)
        let glow = TinkieTopGlowView(); glow.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(glow)
        settingsScrollStage.translatesAutoresizingMaskIntoConstraints = false; settingsScrollStage.alwaysBounceVertical = true; settingsScrollStage.showsVerticalScrollIndicator = false; view.addSubview(settingsScrollStage)
        settingsContentStage.translatesAutoresizingMaskIntoConstraints = false; settingsScrollStage.addSubview(settingsContentStage)
        let settingsBackBeatButton = UIButton(type: .system); settingsBackBeatButton.setImage(UIImage(systemName: "chevron.left"), for: .normal); settingsBackBeatButton.tintColor = .black; settingsBackBeatButton.contentHorizontalAlignment = .leading
        settingsBackBeatButton.addTarget(self, action: #selector(closeRhythmSettingsTapped), for: .touchUpInside); settingsBackBeatButton.translatesAutoresizingMaskIntoConstraints = false; settingsContentStage.addSubview(settingsBackBeatButton)
        let settingsTitleTuneLabel = UILabel(); settingsTitleTuneLabel.text = TinkieVerseCipherTrail.singBack("SceBtCtuiunmgr"); settingsTitleTuneLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold); settingsTitleTuneLabel.textColor = .black
        settingsTitleTuneLabel.textAlignment = .center; settingsTitleTuneLabel.translatesAutoresizingMaskIntoConstraints = false; settingsContentStage.addSubview(settingsTitleTuneLabel)
        settingsOptionStack.axis = .vertical; settingsOptionStack.spacing = 0; settingsOptionStack.translatesAutoresizingMaskIntoConstraints = false; settingsContentStage.addSubview(settingsOptionStack)
        let settingsTuneRows: [TinkieRhythmSettingsVerseOption] = [
            TinkieRhythmSettingsVerseOption(tuneTitle: "User Agreement", tuneSymbolName: "text.badge.checkmark", playSettingTune: { [weak self] in self?.openTermsSongPaper() }),
            TinkieRhythmSettingsVerseOption(tuneTitle: "Privacy", tuneSymbolName: "doc.text.magnifyingglass", playSettingTune: { [weak self] in self?.openPrivacySongPaper() }),
            TinkieRhythmSettingsVerseOption(tuneTitle: "Blocked List", tuneSymbolName: "list.bullet.rectangle.fill", playSettingTune: { [weak self] in self?.openBlockedSingerCircle() }),
            TinkieRhythmSettingsVerseOption(tuneTitle: "Delete Account", tuneSymbolName: "person.crop.circle.badge.xmark", playSettingTune: { [weak self] in self?.showRhythmDeleteAccountCard() })
        ]
        settingsTuneRows.forEach { settingsOptionStack.addArrangedSubview(TinkieRhythmSettingsVerseRow(tuneOption: $0)) }
        let signOutButton = TinkieRhythmSettingsBeatButton(tuneTitle: "Log out", tuneSymbolName: "rectangle.portrait.and.arrow.right"); signOutButton.addTarget(self, action: #selector(showRhythmSignOutSheet), for: .touchUpInside); signOutButton.translatesAutoresizingMaskIntoConstraints = false; settingsContentStage.addSubview(signOutButton)
        pinRhythmSettingsScreenBeat1(glow: glow, settingsBackBeatButton: settingsBackBeatButton)
        pinRhythmSettingsScreenBeat2(settingsBackBeatButton: settingsBackBeatButton, settingsTitleTuneLabel: settingsTitleTuneLabel, signOutButton: signOutButton)
        putRhythmExitChoicesTogether()
    }

    private func pinRhythmSettingsScreenBeat1(glow: TinkieTopGlowView, settingsBackBeatButton: UIButton) {
        NSLayoutConstraint.activate([
            glow.topAnchor.constraint(equalTo: view.topAnchor),
            glow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            glow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            glow.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.58),
            
            settingsScrollStage.topAnchor.constraint(equalTo: view.topAnchor),
            settingsScrollStage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsScrollStage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsScrollStage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            settingsContentStage.topAnchor.constraint(equalTo: settingsScrollStage.contentLayoutGuide.topAnchor),
            settingsContentStage.leadingAnchor.constraint(equalTo: settingsScrollStage.contentLayoutGuide.leadingAnchor),
            settingsContentStage.trailingAnchor.constraint(equalTo: settingsScrollStage.contentLayoutGuide.trailingAnchor),
            settingsContentStage.bottomAnchor.constraint(equalTo: settingsScrollStage.contentLayoutGuide.bottomAnchor),
            settingsContentStage.widthAnchor.constraint(equalTo: settingsScrollStage.frameLayoutGuide.widthAnchor),
            settingsContentStage.heightAnchor.constraint(greaterThanOrEqualTo: settingsScrollStage.frameLayoutGuide.heightAnchor),
            
            settingsBackBeatButton.topAnchor.constraint(equalTo: settingsContentStage.safeAreaLayoutGuide.topAnchor, constant: 18),
            settingsBackBeatButton.leadingAnchor.constraint(equalTo: settingsContentStage.leadingAnchor, constant: 24),
            settingsBackBeatButton.widthAnchor.constraint(equalToConstant: 48),
            settingsBackBeatButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func pinRhythmSettingsScreenBeat2(settingsBackBeatButton: UIButton, settingsTitleTuneLabel: UILabel, signOutButton: TinkieRhythmSettingsBeatButton) {
        NSLayoutConstraint.activate([
            
            settingsTitleTuneLabel.centerYAnchor.constraint(equalTo: settingsBackBeatButton.centerYAnchor),
            settingsTitleTuneLabel.centerXAnchor.constraint(equalTo: settingsContentStage.centerXAnchor),
            
            settingsOptionStack.topAnchor.constraint(equalTo: settingsTitleTuneLabel.bottomAnchor, constant: 28),
            settingsOptionStack.leadingAnchor.constraint(equalTo: settingsContentStage.leadingAnchor, constant: 24),
            settingsOptionStack.trailingAnchor.constraint(equalTo: settingsContentStage.trailingAnchor, constant: -24),
            
            signOutButton.leadingAnchor.constraint(equalTo: settingsContentStage.leadingAnchor, constant: 26),
            signOutButton.trailingAnchor.constraint(equalTo: settingsContentStage.trailingAnchor, constant: -26),
            signOutButton.heightAnchor.constraint(equalToConstant: 44),
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            signOutButton.topAnchor.constraint(greaterThanOrEqualTo: settingsOptionStack.bottomAnchor, constant: 44)
        ])
    }

    private func putRhythmExitChoicesTogether() {
        settingsVeilStage.backgroundColor = UIColor.black.withAlphaComponent(0.48); settingsVeilStage.alpha = 0; settingsVeilStage.isHidden = true; settingsVeilStage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingsVeilStage)
        deleteAccountCard.backgroundColor = .white; deleteAccountCard.layer.cornerRadius = 18; deleteAccountCard.layer.masksToBounds = true; deleteAccountCard.isHidden = true
        deleteAccountCard.translatesAutoresizingMaskIntoConstraints = false; settingsVeilStage.addSubview(deleteAccountCard)
        let deleteTuneTitle = UILabel(); deleteTuneTitle.text = TinkieVerseCipherTrail.singBack("DHeYlQeTtTeM LaJcecHoduTnLtv"); deleteTuneTitle.font = UIFont.systemFont(ofSize: 17, weight: .bold); deleteTuneTitle.textColor = .black
        deleteTuneTitle.textAlignment = .center; deleteTuneTitle.translatesAutoresizingMaskIntoConstraints = false; deleteAccountCard.addSubview(deleteTuneTitle)
        let deleteTuneDetail = UILabel(); deleteTuneDetail.text = TinkieVerseCipherTrail.singBack("DOeBlJeVtCiCnKgG YtmhNeU MaBcscPozuAnFtb NwWinlflQ dcdlpesaJrX wtKhjen kajcWcfoSurnptC qdWaPtHaO.L jAprgef pyboYux nsguTrSeA Ttaon odPeNlHeZtLeG?g"); deleteTuneDetail.font = UIFont.systemFont(ofSize: 13, weight: .regular); deleteTuneDetail.textColor = UIColor.black.withAlphaComponent(0.72)
        deleteTuneDetail.textAlignment = .center; deleteTuneDetail.numberOfLines = 0; deleteTuneDetail.translatesAutoresizingMaskIntoConstraints = false; deleteAccountCard.addSubview(deleteTuneDetail)
        let keepSingerButton = TinkieRhythmSettingsBeatButton(tuneTitle: "Cancel", tuneSymbolName: nil); keepSingerButton.addTarget(self, action: #selector(hideRhythmSettingsVeil), for: .touchUpInside); keepSingerButton.translatesAutoresizingMaskIntoConstraints = false; deleteAccountCard.addSubview(keepSingerButton)
        let deleteSingerButton = UIButton(type: .system); deleteSingerButton.setTitle(TinkieVerseCipherTrail.singBack("DNeElZeBtCeL"), for: .normal); deleteSingerButton.setTitleColor(UIColor.black.withAlphaComponent(0.28), for: .normal); deleteSingerButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        deleteSingerButton.backgroundColor = UIColor.black.withAlphaComponent(0.04); deleteSingerButton.layer.cornerRadius = 18; deleteSingerButton.addTarget(self, action: #selector(confirmRhythmDeleteAccount), for: .touchUpInside); deleteSingerButton.translatesAutoresizingMaskIntoConstraints = false
        deleteAccountCard.addSubview(deleteSingerButton)
        signOutSheetStage.backgroundColor = .white; signOutSheetStage.layer.cornerRadius = 20; signOutSheetStage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]; signOutSheetStage.layer.masksToBounds = true
        signOutSheetStage.isHidden = true; signOutSheetStage.translatesAutoresizingMaskIntoConstraints = false; settingsVeilStage.addSubview(signOutSheetStage)
        let signOutTuneButton = UIButton(type: .system); signOutTuneButton.setTitle(TinkieVerseCipherTrail.singBack("LFoOgs rohuRtH"), for: .normal); signOutTuneButton.setTitleColor(UIColor.black.withAlphaComponent(0.46), for: .normal); signOutTuneButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        signOutTuneButton.backgroundColor = .white; signOutTuneButton.layer.cornerRadius = 18; signOutTuneButton.layer.borderWidth = 1; signOutTuneButton.layer.borderColor = UIColor.black.withAlphaComponent(0.16).cgColor
        signOutTuneButton.addTarget(self, action: #selector(confirmRhythmSignOut), for: .touchUpInside); signOutTuneButton.translatesAutoresizingMaskIntoConstraints = false; signOutSheetStage.addSubview(signOutTuneButton)
        let stayTuneButton = UIButton(type: .system); stayTuneButton.setTitle(TinkieVerseCipherTrail.singBack("CgaYnWcWeglp"), for: .normal); stayTuneButton.setTitleColor(.white, for: .normal); stayTuneButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        stayTuneButton.backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.04, alpha: 1); stayTuneButton.layer.cornerRadius = 18; stayTuneButton.addTarget(self, action: #selector(hideRhythmSettingsVeil), for: .touchUpInside); stayTuneButton.translatesAutoresizingMaskIntoConstraints = false
        signOutSheetStage.addSubview(stayTuneButton)
        pinRhythmExitChoicesBeat3(deleteTuneTitle: deleteTuneTitle, deleteTuneDetail: deleteTuneDetail, keepSingerButton: keepSingerButton)
        pinRhythmExitChoicesBeat4(keepSingerButton: keepSingerButton, deleteSingerButton: deleteSingerButton, signOutTuneButton: signOutTuneButton, stayTuneButton: stayTuneButton)
    }

    private func pinRhythmExitChoicesBeat3(deleteTuneTitle: UILabel, deleteTuneDetail: UILabel, keepSingerButton: TinkieRhythmSettingsBeatButton) {
        NSLayoutConstraint.activate([
            settingsVeilStage.topAnchor.constraint(equalTo: view.topAnchor),
            settingsVeilStage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsVeilStage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsVeilStage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            deleteAccountCard.centerXAnchor.constraint(equalTo: settingsVeilStage.centerXAnchor),
            deleteAccountCard.centerYAnchor.constraint(equalTo: settingsVeilStage.centerYAnchor, constant: -18),
            deleteAccountCard.leadingAnchor.constraint(greaterThanOrEqualTo: settingsVeilStage.leadingAnchor, constant: 32),
            deleteAccountCard.trailingAnchor.constraint(lessThanOrEqualTo: settingsVeilStage.trailingAnchor, constant: -32),
            deleteAccountCard.widthAnchor.constraint(lessThanOrEqualToConstant: 330),
            
            deleteTuneTitle.topAnchor.constraint(equalTo: deleteAccountCard.topAnchor, constant: 24),
            deleteTuneTitle.leadingAnchor.constraint(equalTo: deleteAccountCard.leadingAnchor, constant: 24),
            deleteTuneTitle.trailingAnchor.constraint(equalTo: deleteAccountCard.trailingAnchor, constant: -24),
            
            deleteTuneDetail.topAnchor.constraint(equalTo: deleteTuneTitle.bottomAnchor, constant: 10),
            deleteTuneDetail.leadingAnchor.constraint(equalTo: deleteAccountCard.leadingAnchor, constant: 32),
            deleteTuneDetail.trailingAnchor.constraint(equalTo: deleteAccountCard.trailingAnchor, constant: -32),
            
            keepSingerButton.topAnchor.constraint(equalTo: deleteTuneDetail.bottomAnchor, constant: 18),
            keepSingerButton.leadingAnchor.constraint(equalTo: deleteAccountCard.leadingAnchor, constant: 24),
            keepSingerButton.trailingAnchor.constraint(equalTo: deleteAccountCard.trailingAnchor, constant: -24)
        ])
    }

    private func pinRhythmExitChoicesBeat4(keepSingerButton: TinkieRhythmSettingsBeatButton, deleteSingerButton: UIButton, signOutTuneButton: UIButton, stayTuneButton: UIButton) {
        NSLayoutConstraint.activate([
            keepSingerButton.heightAnchor.constraint(equalToConstant: 38),
            
            deleteSingerButton.topAnchor.constraint(equalTo: keepSingerButton.bottomAnchor, constant: 10),
            deleteSingerButton.leadingAnchor.constraint(equalTo: deleteAccountCard.leadingAnchor, constant: 24),
            deleteSingerButton.trailingAnchor.constraint(equalTo: deleteAccountCard.trailingAnchor, constant: -24),
            deleteSingerButton.heightAnchor.constraint(equalToConstant: 38),
            deleteSingerButton.bottomAnchor.constraint(equalTo: deleteAccountCard.bottomAnchor, constant: -22),
            
            signOutSheetStage.leadingAnchor.constraint(equalTo: settingsVeilStage.leadingAnchor),
            signOutSheetStage.trailingAnchor.constraint(equalTo: settingsVeilStage.trailingAnchor),
            signOutSheetStage.bottomAnchor.constraint(equalTo: settingsVeilStage.bottomAnchor),
            
            signOutTuneButton.topAnchor.constraint(equalTo: signOutSheetStage.topAnchor, constant: 18),
            signOutTuneButton.leadingAnchor.constraint(equalTo: signOutSheetStage.leadingAnchor, constant: 24),
            signOutTuneButton.trailingAnchor.constraint(equalTo: signOutSheetStage.trailingAnchor, constant: -24),
            signOutTuneButton.heightAnchor.constraint(equalToConstant: 40),
            
            stayTuneButton.topAnchor.constraint(equalTo: signOutTuneButton.bottomAnchor, constant: 10),
            stayTuneButton.leadingAnchor.constraint(equalTo: signOutSheetStage.leadingAnchor, constant: 24),
            stayTuneButton.trailingAnchor.constraint(equalTo: signOutSheetStage.trailingAnchor, constant: -24),
            stayTuneButton.heightAnchor.constraint(equalToConstant: 40),
            stayTuneButton.bottomAnchor.constraint(equalTo: signOutSheetStage.safeAreaLayoutGuide.bottomAnchor, constant: -18)
        ])
    }

    private func showRhythmSettingsVeil(content: UIView) {
        deleteAccountCard.isHidden = content !== deleteAccountCard
        signOutSheetStage.isHidden = content !== signOutSheetStage
        settingsVeilStage.isHidden = false
        settingsVeilStage.alpha = 1
        view.bringSubviewToFront(settingsVeilStage)
    }

    private func openRhythmSettingsTuneRoute(titleText: String, detailText: String) {
        navigationController?.pushViewController(
            TinkieSingerRouteNoteViewController(titleText: titleText, detailText: detailText, showsSignOut: false),
            animated: true
        )
    }

    @objc private func closeRhythmSettingsTapped() {
        dismiss(animated: true)
    }

    @objc private func hideRhythmSettingsVeil() {
        UIView.animate(withDuration: 0.18) {
            self.settingsVeilStage.alpha = 0
        } completion: { _ in
            self.settingsVeilStage.isHidden = true
            self.deleteAccountCard.isHidden = true
            self.signOutSheetStage.isHidden = true
        }
    }

    @objc private func showRhythmSignOutSheet() {
        showRhythmSettingsVeil(content: signOutSheetStage)
    }

    private func showRhythmDeleteAccountCard() {
        showRhythmSettingsVeil(content: deleteAccountCard)
    }

    private func openTermsSongPaper() {
        navigationController?.pushViewController(TinkieMelodyPolicyPaperViewController(paperTitle: TinkieVerseCipherTrail.singBack("TzexrkmvsH VoOfA rUgsWen"), paperBody: TinkieMelodyRulebookVerse.termsTuneBody), animated: true)
    }

    private func openPrivacySongPaper() {
        navigationController?.pushViewController(TinkieMelodyPolicyPaperViewController(paperTitle: TinkieVerseCipherTrail.singBack("PMrxivvaascCyy yPPoZlNiJcxyT"), paperBody: TinkieMelodyRulebookVerse.privacyTuneBody), animated: true)
    }

    private func openBlockedSingerCircle() {
        navigationController?.pushViewController(TinkieSingerCircleRosterViewController(rosterCircle: .blocked), animated: true)
    }

    @objc private func confirmRhythmSignOut() {
        TinkieSingerStageScorebook.dimSingerStageOnly()
        hideRhythmSettingsVeil()
        dismiss(animated: true) {
            self.onSettingsRhythmChanged?()
        }
    }

    @objc private func confirmRhythmDeleteAccount() {
        TinkieSingerStageScorebook.eraseCurrentSingerAndDimStage()
        hideRhythmSettingsVeil()
        dismiss(animated: true) {
            self.onSettingsRhythmChanged?()
        }
    }
}

private struct TinkieRhythmSettingsVerseOption {
    let tuneTitle: String
    let tuneSymbolName: String
    let playSettingTune: () -> Void
}

private final class TinkieRhythmSettingsVerseRow: UIControl {
    private let tuneOption: TinkieRhythmSettingsVerseOption

    init(tuneOption: TinkieRhythmSettingsVerseOption) {
        self.tuneOption = tuneOption
        super.init(frame: .zero)
        putSettingsVerseMarksTogether()
        addTarget(self, action: #selector(playSettingsVerseAction), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("ibndilth(McLogdgerrq:Y)M WhuassH Cnpoktu DbseweSnY jixmPpQliesmTepnntJeDdN"))
    }

    private func putSettingsVerseMarksTogether() {
        backgroundColor = .clear

        let tuneMarkImageView = UIImageView(image: UIImage(systemName: tuneOption.tuneSymbolName))
        tuneMarkImageView.tintColor = .black
        tuneMarkImageView.contentMode = .scaleAspectFit
        tuneMarkImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tuneMarkImageView)

        let tuneTitleLabel = UILabel()
        tuneTitleLabel.text = tuneOption.tuneTitle
        tuneTitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        tuneTitleLabel.textColor = .black
        tuneTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tuneTitleLabel)

        let tuneArrowView = UIImageView(image: UIImage(systemName: "chevron.right"))
        tuneArrowView.tintColor = UIColor.black.withAlphaComponent(0.62)
        tuneArrowView.contentMode = .scaleAspectFit
        tuneArrowView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tuneArrowView)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 42),

            tuneMarkImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tuneMarkImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            tuneMarkImageView.widthAnchor.constraint(equalToConstant: 17),
            tuneMarkImageView.heightAnchor.constraint(equalToConstant: 17),

            tuneTitleLabel.leadingAnchor.constraint(equalTo: tuneMarkImageView.trailingAnchor, constant: 14),
            tuneTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            tuneTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: tuneArrowView.leadingAnchor, constant: -12),

            tuneArrowView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tuneArrowView.centerYAnchor.constraint(equalTo: centerYAnchor),
            tuneArrowView.widthAnchor.constraint(equalToConstant: 12),
            tuneArrowView.heightAnchor.constraint(equalToConstant: 12)
        ])
    }

    @objc private func playSettingsVerseAction() {
        tuneOption.playSettingTune()
    }
}

final class TinkieRhythmSettingsBeatButton: UIButton {
    private let glowLayer = CAGradientLayer()

    init(tuneTitle: String, tuneSymbolName: String?) {
        super.init(frame: .zero)
        setTitle(tuneTitle, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        if let tuneSymbolName {
            setImage(UIImage(systemName: tuneSymbolName), for: .normal)
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
        fatalError(TinkieVerseCipherTrail.singBack("ibndilth(McLogdgerrq:Y)M WhuassH Cnpoktu DbseweSnY jixmPpQliesmTepnntJeDdN"))
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        glowLayer.frame = bounds
        layer.cornerRadius = bounds.height / 2
    }
}
