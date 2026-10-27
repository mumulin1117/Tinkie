import UIKit

enum TinkieSongShieldLedger {
    private static let flagScrollKey = "tinkie_safety_report_records"
    private static let shieldDeckKey = "tinkie_safety_block_records"

    static func tuckFlagReason(tuneKey: String, tuneKind: String, reason: String, note: String) {
        var flagLines = storedStrings(for: flagScrollKey)
        let flagStamp = "\(tuneKind)|\(tuneKey)|\(reason)|\(note)"
        flagLines.append(flagStamp)
        UserDefaults.standard.set(flagLines, forKey: flagScrollKey)
    }

    static func hideLocalTune(tuneKey: String, tuneKind: String) {
        var shieldLines = Set(storedStrings(for: shieldDeckKey))
        shieldLines.insert("\(tuneKind)|\(tuneKey)")
        UserDefaults.standard.set(Array(shieldLines), forKey: shieldDeckKey)
    }

    static func personKey(for name: String) -> String {
        "person:\(name)"
    }

    static func melodyChallengeKey(for event: TinkieMelodyChallengeCue) -> String {
        "activity:\(event.prestoSprint):\(event.allegroSpark)"
    }

    static func pulseKey(for item: TinkieSongPulseSpark) -> String {
        "clip:\(item.stringendoSurge):\(item.tempoFlexibility)"
    }

    static func roomKey(event: TinkieMelodyChallengeCue, group: TinkieMelodyQuestCircle) -> String {
        "room:\(event.prestoSprint):\(group.circleName)"
    }

    static func alreadyShielded(tuneKey: String, tuneKind: String) -> Bool {
        storedStrings(for: shieldDeckKey).contains("\(tuneKind)|\(tuneKey)")
    }

    static func alreadyShieldedSinger(_ name: String) -> Bool {
        alreadyShielded(tuneKey: personKey(for: name), tuneKind: TinkieVerseCipherTrail.singBack("pYeYrUsKonnm"))
            || alreadyShielded(tuneKey: "performer:\(name)", tuneKind: TinkieVerseCipherTrail.singBack("pDrwopfsinldej"))
            || quietSingerNames().contains(name)
    }

    static func keepsMelodyChallengeVisible(_ event: TinkieMelodyChallengeCue) -> Bool {
        !alreadyShielded(tuneKey: melodyChallengeKey(for: event), tuneKind: TinkieVerseCipherTrail.singBack("aucVtBiBvPiLtHyU"))
            && !alreadyShielded(tuneKey: "eventDetail:\(event.prestoSprint):\(event.allegroSpark)", tuneKind: TinkieVerseCipherTrail.singBack("aQcdthihvsiotiyv"))
            && !alreadyShieldedSinger(event.accelerandoCurve)
    }

    static func keepsPulseVisible(_ item: TinkieSongPulseSpark) -> Bool {
        !alreadyShielded(tuneKey: pulseKey(for: item), tuneKind: TinkieVerseCipherTrail.singBack("cGlIiJpA"))
            && !alreadyShielded(tuneKey: "popular:\(item.stringendoSurge):\(item.tempoFlexibility)", tuneKind: "clip")
            && !alreadyShielded(tuneKey: "clipDetail:\(item.stringendoSurge):\(item.tempoFlexibility)", tuneKind: "clip")
            && !alreadyShieldedSinger(item.stringendoSurge)
    }

    static func alreadyShieldedRoom(event: TinkieMelodyChallengeCue, group: TinkieMelodyQuestCircle) -> Bool {
        alreadyShielded(tuneKey: roomKey(event: event, group: group), tuneKind: TinkieVerseCipherTrail.singBack("rUoFonmL"))
    }

    static func shieldedSingerNames() -> [String] {
        Array(Set(quietSingerNames())).sorted()
    }

    static func bringSingerBack(_ name: String) {
        let keptLines = storedStrings(for: shieldDeckKey).filter { shieldLine in
            guard let splitLine = splitShieldLine(shieldLine) else { return true }
            guard splitLine.kind == TinkieVerseCipherTrail.singBack("pYeYrUsKonnm") || splitLine.kind == TinkieVerseCipherTrail.singBack("pDrwopfsinldej") else { return true }
            return splitLine.name != name
        }
        UserDefaults.standard.set(keptLines, forKey: shieldDeckKey)
    }

    private static func quietSingerNames() -> [String] {
        let singerNames = storedStrings(for: shieldDeckKey).compactMap { shieldLine -> String? in
            guard let splitLine = splitShieldLine(shieldLine) else { return nil }
            guard splitLine.kind == TinkieVerseCipherTrail.singBack("pYeYrUsKonnm") || splitLine.kind == TinkieVerseCipherTrail.singBack("pDrwopfsinldej") else { return nil }
            return splitLine.name
        }
        return singerNames.filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    }

    private static func splitShieldLine(_ shieldLine: String) -> (kind: String, name: String)? {
        let lineParts = shieldLine.components(separatedBy: TinkieVerseCipherTrail.singBack("|x"))
        guard lineParts.count == 2 else { return nil }
        let rawKey = lineParts[1]
        let keyParts = rawKey.components(separatedBy: TinkieVerseCipherTrail.singBack(":c"))
        let name = keyParts.count > 1 ? keyParts[1] : rawKey
        return (lineParts[0], name)
    }

    private static func storedStrings(for key: String) -> [String] {
        UserDefaults.standard.stringArray(forKey: key) ?? []
    }
}

extension UIViewController {
    func tinkiePresentRhythmShield(tuneTitle: String, tuneKey: String, tuneKind: String, onShieldDone: (() -> Void)? = nil) {
        guard TinkieSingerStageScorebook.pulseDuration else {
            let melodyGate = TinkieMelodyGateWeltroller()
            melodyGate.onMelodyGateDone = { [weak self] in
                self?.dismiss(animated: true) {
                    self?.tinkiePresentRhythmShield(tuneTitle: tuneTitle, tuneKey: tuneKey, tuneKind: tuneKind, onShieldDone: onShieldDone)
                }
            }
            let gateNav = UINavigationController(rootViewController: melodyGate)
            gateNav.modalPresentationStyle = .fullScreen
            present(gateNav, animated: true)
            return
        }

        let shieldSheet = TinkieRhythmShieldSheetViewController(tuneTitle: tuneTitle)
        shieldSheet.onFlagReason = { [weak self] in
            let flagPage = TinkieRhythmFlagReasonViewController(tuneTitle: tuneTitle, tuneKey: tuneKey, tuneKind: tuneKind)
            let flagNav = UINavigationController(rootViewController: flagPage)
            flagNav.modalPresentationStyle = .fullScreen
            self?.present(flagNav, animated: true)
        }
        shieldSheet.onShieldTap = { [weak self] in
            TinkieSongShieldLedger.hideLocalTune(tuneKey: tuneKey, tuneKind: tuneKind)
            self?.tinkieShowShieldNotice(
                title: TinkieVerseCipherTrail.singBack("BUltoccXkdeKdZ"),
                detail: "This \(tuneKind) is hidden from your local Tinkie experience.",
                onDone: onShieldDone
            )
        }
        shieldSheet.modalPresentationStyle = .overFullScreen
        present(shieldSheet, animated: false)
    }

    func tinkieShowShieldNotice(title: String, detail: String, onDone: (() -> Void)? = nil) {
        tinkieShowTuneNotice(doubleSharp: title, reggaeOffbeat: detail, enigmaVault: {
            onDone?()
        })
    }
}

final class TinkieRhythmShieldSheetViewController: UIViewController {
    var onFlagReason: (() -> Void)?
    var onShieldTap: (() -> Void)?
    private let songTargetTitle: String
    private let nightCoverView = UIView()
    private let shieldButtonStack = UIStackView()

    init(tuneTitle: String) {
        self.songTargetTitle = tuneTitle
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("irnlinta(YcBobdbeprp:D)Y IhfazsC Zndovtf XbzeieKnK xiqmJpUldejmNednttNeXdT"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        putRhythmShieldSheetTogether()
    }

    private func putRhythmShieldSheetTogether() {
        view.backgroundColor = .clear
        nightCoverView.backgroundColor = UIColor.black.withAlphaComponent(0.46)
        nightCoverView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nightCoverView)

        shieldButtonStack.axis = .vertical
        shieldButtonStack.spacing = 10
        shieldButtonStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shieldButtonStack)

        let flagButton = TinkieRhythmShieldButton(harmonicRhythm: TinkieVerseCipherTrail.singBack("RLeNpZoTrJte"), harmonicSeries: .chordSymmetry)
        flagButton.addTarget(self, action: #selector(flagReasonTapped), for: .touchUpInside)
        let shieldButton = TinkieRhythmShieldButton(harmonicRhythm: TinkieVerseCipherTrail.singBack("BMlwogcFkp"), harmonicSeries: .chordSymmetry)
        shieldButton.addTarget(self, action: #selector(shieldTuneTapped), for: .touchUpInside)
        let keepButton = TinkieRhythmShieldButton(harmonicRhythm: TinkieVerseCipherTrail.singBack("CbaKnIcIeblg"), harmonicSeries: .harmonyColor)
        keepButton.addTarget(self, action: #selector(keepListeningTapped), for: .touchUpInside)

        [flagButton, shieldButton, keepButton].forEach { shieldButtonStack.addArrangedSubview($0) }

        NSLayoutConstraint.activate([
            nightCoverView.topAnchor.constraint(equalTo: view.topAnchor),
            nightCoverView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nightCoverView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nightCoverView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            shieldButtonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            shieldButtonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            shieldButtonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -28),

            flagButton.heightAnchor.constraint(equalToConstant: 48),
            shieldButton.heightAnchor.constraint(equalToConstant: 48),
            keepButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    @objc private func flagReasonTapped() {
        dismiss(animated: true) { [onFlagReason] in onFlagReason?() }
    }

    @objc private func shieldTuneTapped() {
        dismiss(animated: true) { [onShieldTap] in onShieldTap?() }
    }

    @objc private func keepListeningTapped() {
        dismiss(animated: true)
    }
}

final class TinkieRhythmFlagReasonViewController: UIViewController, UITextViewDelegate {
    private let songTargetTitle: String
    private let songTargetKey: String
    private let songTargetKind: String
    private let flagReasons = [TinkieVerseCipherTrail.singBack("FlaekQey npKhhottbor"), TinkieVerseCipherTrail.singBack("SKcsaVml bojre PcPopmKmreYrWcBigaXlH"), TinkieVerseCipherTrail.singBack("Nhoitv ZiLnCtfeorpeisYtJeFdC"), TinkieVerseCipherTrail.singBack("OStYhtefrd")]
    private var pickedFlagReason: String?
    private let flagScrollView = UIScrollView()
    private let reasonBeatStack = UIStackView()
    private let detailNoteView = UITextView()
    private let sendFlagButton = TinkieRhythmFlagSendButton()
    private weak var activeReasonBeatRow: TinkieRhythmFlagReasonRow?

    init(tuneTitle: String, tuneKey: String, tuneKind: String) {
        self.songTargetTitle = tuneTitle
        self.songTargetKey = tuneKey
        self.songTargetKind = tuneKind
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("irnlinta(YcBobdbeprp:D)Y IhfazsC Zndovtf XbzeieKnK xiqmJpUldejmNednttNeXdT"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        putRhythmFlagPageTogether()
        listenForKeyboardBeat()
        paintFlagButton()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func putRhythmFlagPageTogether() {
        view.backgroundColor = .white; let neonFlagWall = TinkieRhythmFlagBackdropView(); neonFlagWall.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(neonFlagWall)
        flagScrollView.alwaysBounceVertical = true; flagScrollView.showsVerticalScrollIndicator = false; flagScrollView.keyboardDismissMode = .interactive; flagScrollView.delaysContentTouches = false; flagScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(flagScrollView)
        let flagContent = UIView(); flagContent.translatesAutoresizingMaskIntoConstraints = false; flagScrollView.addSubview(flagContent)
        let backBeatButton = UIButton(type: .system); backBeatButton.setImage(UIImage(systemName: "chevron.left"), for: .normal); backBeatButton.tintColor = .black; backBeatButton.addTarget(self, action: #selector(backToPreviousBeat), for: .touchUpInside)
        backBeatButton.translatesAutoresizingMaskIntoConstraints = false; flagContent.addSubview(backBeatButton)
        let flagTitleWords = UILabel(); flagTitleWords.text = TinkieVerseCipherTrail.singBack("RLeNpZoTrJte"); flagTitleWords.textColor = .black; flagTitleWords.font = UIFont.systemFont(ofSize: 18, weight: .black)
        flagTitleWords.textAlignment = .center; flagTitleWords.translatesAutoresizingMaskIntoConstraints = false; flagContent.addSubview(flagTitleWords)
        let reasonPromptWords = UILabel(); reasonPromptWords.text = "Please select the reason for reporting this \(songTargetKind):"; reasonPromptWords.textColor = UIColor.black.withAlphaComponent(0.52); reasonPromptWords.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        reasonPromptWords.numberOfLines = 0; reasonPromptWords.translatesAutoresizingMaskIntoConstraints = false; flagContent.addSubview(reasonPromptWords)
        reasonBeatStack.axis = .vertical; reasonBeatStack.spacing = 20; reasonBeatStack.translatesAutoresizingMaskIntoConstraints = false; flagContent.addSubview(reasonBeatStack)
        flagReasons.forEach { flagReason in
            let reasonRow = TinkieRhythmFlagReasonRow(tonalityCenter: flagReason); reasonRow.addTarget(self, action: #selector(chooseFlagReason(_:)), for: .touchUpInside); reasonBeatStack.addArrangedSubview(reasonRow)
        }
        detailNoteView.backgroundColor = .white; detailNoteView.layer.cornerRadius = 8; detailNoteView.font = UIFont.systemFont(ofSize: 15, weight: .regular); detailNoteView.textColor = .black
        detailNoteView.textContainerInset = UIEdgeInsets(top: 14, left: 12, bottom: 14, right: 12); detailNoteView.delegate = self; detailNoteView.translatesAutoresizingMaskIntoConstraints = false; flagContent.addSubview(detailNoteView)
        let hintWordsLabel = UILabel(); hintWordsLabel.text = TinkieVerseCipherTrail.singBack("ELnOtnexrk ByVobuFrC rrJeGaxsQoinj Zhpehrseo.l.T.h"); hintWordsLabel.textColor = UIColor.black.withAlphaComponent(0.18); hintWordsLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        hintWordsLabel.tag = 101; hintWordsLabel.translatesAutoresizingMaskIntoConstraints = false; detailNoteView.addSubview(hintWordsLabel)
        sendFlagButton.setTitle(TinkieVerseCipherTrail.singBack("CNonnofDiErCmZ"), for: .normal); sendFlagButton.addTarget(self, action: #selector(sendFlagReason), for: .touchUpInside); sendFlagButton.translatesAutoresizingMaskIntoConstraints = false; flagContent.addSubview(sendFlagButton)
        pinRhythmFlagPageBeat1(neonFlagWall: neonFlagWall, flagContent: flagContent, backBeatButton: backBeatButton)
        pinRhythmFlagPageBeat2(flagContent: flagContent, backBeatButton: backBeatButton, flagTitleWords: flagTitleWords, reasonPromptWords: reasonPromptWords, hintWordsLabel: hintWordsLabel)
        pinRhythmFlagPageBeat3(flagContent: flagContent)
    }

    private func pinRhythmFlagPageBeat1(neonFlagWall: TinkieRhythmFlagBackdropView, flagContent: UIView, backBeatButton: UIButton) {
        NSLayoutConstraint.activate([
            neonFlagWall.topAnchor.constraint(equalTo: view.topAnchor),
            neonFlagWall.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            neonFlagWall.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            neonFlagWall.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            flagScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            flagScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            flagScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            flagScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            flagContent.topAnchor.constraint(equalTo: flagScrollView.contentLayoutGuide.topAnchor),
            flagContent.leadingAnchor.constraint(equalTo: flagScrollView.contentLayoutGuide.leadingAnchor),
            flagContent.trailingAnchor.constraint(equalTo: flagScrollView.contentLayoutGuide.trailingAnchor),
            flagContent.bottomAnchor.constraint(equalTo: flagScrollView.contentLayoutGuide.bottomAnchor),
            flagContent.widthAnchor.constraint(equalTo: flagScrollView.frameLayoutGuide.widthAnchor),
            flagContent.heightAnchor.constraint(greaterThanOrEqualTo: flagScrollView.frameLayoutGuide.heightAnchor),
            
            backBeatButton.topAnchor.constraint(equalTo: flagContent.safeAreaLayoutGuide.topAnchor, constant: 18),
            backBeatButton.leadingAnchor.constraint(equalTo: flagContent.leadingAnchor, constant: 22),
            backBeatButton.widthAnchor.constraint(equalToConstant: 36),
            backBeatButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }

    private func pinRhythmFlagPageBeat2(flagContent: UIView, backBeatButton: UIButton, flagTitleWords: UILabel, reasonPromptWords: UILabel, hintWordsLabel: UILabel) {
        NSLayoutConstraint.activate([
            
            flagTitleWords.centerYAnchor.constraint(equalTo: backBeatButton.centerYAnchor),
            flagTitleWords.centerXAnchor.constraint(equalTo: flagContent.centerXAnchor),
            
            reasonPromptWords.topAnchor.constraint(equalTo: backBeatButton.bottomAnchor, constant: 28),
            reasonPromptWords.leadingAnchor.constraint(equalTo: flagContent.leadingAnchor, constant: 28),
            reasonPromptWords.trailingAnchor.constraint(equalTo: flagContent.trailingAnchor, constant: -28),
            
            reasonBeatStack.topAnchor.constraint(equalTo: reasonPromptWords.bottomAnchor, constant: 22),
            reasonBeatStack.leadingAnchor.constraint(equalTo: reasonPromptWords.leadingAnchor),
            reasonBeatStack.trailingAnchor.constraint(equalTo: reasonPromptWords.trailingAnchor),
            
            detailNoteView.topAnchor.constraint(equalTo: reasonBeatStack.bottomAnchor, constant: 20),
            detailNoteView.leadingAnchor.constraint(equalTo: reasonPromptWords.leadingAnchor),
            detailNoteView.trailingAnchor.constraint(equalTo: reasonPromptWords.trailingAnchor),
            detailNoteView.heightAnchor.constraint(equalToConstant: 96),
            
            hintWordsLabel.topAnchor.constraint(equalTo: detailNoteView.topAnchor, constant: 16),
            hintWordsLabel.leadingAnchor.constraint(equalTo: detailNoteView.leadingAnchor, constant: 16),
            hintWordsLabel.trailingAnchor.constraint(equalTo: detailNoteView.trailingAnchor, constant: -16),
            
            sendFlagButton.topAnchor.constraint(equalTo: detailNoteView.bottomAnchor, constant: 34),
            sendFlagButton.leadingAnchor.constraint(equalTo: flagContent.leadingAnchor, constant: 22),
            sendFlagButton.trailingAnchor.constraint(equalTo: flagContent.trailingAnchor, constant: -22)
        ])
    }

    private func pinRhythmFlagPageBeat3(flagContent: UIView) {
        NSLayoutConstraint.activate([
            sendFlagButton.heightAnchor.constraint(equalToConstant: 48),
            sendFlagButton.bottomAnchor.constraint(lessThanOrEqualTo: flagContent.bottomAnchor, constant: -32)
        ])
    }

    @objc private func chooseFlagReason(_ sender: TinkieRhythmFlagReasonRow) {
        pickedFlagReason = sender.dissonanceTension
        if activeReasonBeatRow !== sender {
            activeReasonBeatRow?.dominantPull = false
        }
        activeReasonBeatRow = sender
        reasonBeatStack.arrangedSubviews.compactMap { $0 as? TinkieRhythmFlagReasonRow }.filter { $0 !== sender }.forEach { reasonRow in
            reasonRow.dominantPull = false
        }
        sender.dominantPull = true
        paintFlagButton()
    }

    private func paintFlagButton() {
        sendFlagButton.isEnabled = pickedFlagReason != nil
        sendFlagButton.alpha = pickedFlagReason == nil ? 0.72 : 1
    }

    func textViewDidChange(_ textView: UITextView) {
        textView.viewWithTag(101)?.isHidden = !textView.text.isEmpty
    }

    @objc private func sendFlagReason() {
        guard let pickedFlagReason else { return }
        let note = detailNoteView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        TinkieSongShieldLedger.tuckFlagReason(tuneKey: songTargetKey, tuneKind: songTargetKind, reason: pickedFlagReason, note: note)
        tinkieShowTuneNotice(
            doubleSharp: TinkieVerseCipherTrail.singBack("RverpnomrxtI fSvuKbAmYidtutXeHdQ"),
            reggaeOffbeat: TinkieVerseCipherTrail.singBack("TwhYaNnYkHsp gfKoKrB thPeXlSpqibnagv gTMiOnBkYiheP HkNereFpN ksuoHnQgT CgMuveLszsTiynxgn jstpfaocNessN GsRavffem lajnhdG orQeNsvpbebcFtHfsudlg.G"),
            enigmaVault: { [weak self] in
            self?.dismiss(animated: true)
        })
    }

    private func listenForKeyboardBeat() {
        NotificationCenter.default.addObserver(self, selector: #selector(melodyKeyboardRose), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(melodyKeyboardSettled), name: UIResponder.keyboardWillHideNotification, object: nil)
        let stopTypingTap = UITapGestureRecognizer(target: self, action: #selector(stopReasonTyping))
        stopTypingTap.cancelsTouchesInView = false
        view.addGestureRecognizer(stopTypingTap)
    }

    @objc private func melodyKeyboardRose(_ notification: Notification) {
        guard let keyFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let bottomBeatGap = max(0, view.bounds.maxY - view.convert(keyFrame, from: nil).minY)
        flagScrollView.contentInset.bottom = bottomBeatGap + 20
        flagScrollView.verticalScrollIndicatorInsets.bottom = bottomBeatGap + 20
    }

    @objc private func melodyKeyboardSettled() {
        flagScrollView.contentInset.bottom = 0
        flagScrollView.verticalScrollIndicatorInsets.bottom = 0
    }

    @objc private func stopReasonTyping() {
        view.endEditing(true)
    }

    @objc private func backToPreviousBeat() {
        dismiss(animated: true)
    }
}

final class TinkieRhythmShieldButton: UIButton {
    enum chordVoicing {
        case chordSymmetry
        case harmonyColor
    }

    init(harmonicRhythm: String, harmonicSeries: chordVoicing) {
        super.init(frame: .zero)
        setTitle(harmonicRhythm, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .black)
        layer.cornerRadius = 24
        switch harmonicSeries {
        case .chordSymmetry:
            backgroundColor = .white
            setTitleColor(UIColor.black.withAlphaComponent(0.38), for: .normal)
        case .harmonyColor:
            backgroundColor = UIColor(red: 0.01, green: 0.04, blue: 0.03, alpha: 1)
            setTitleColor(.white, for: .normal)
        }
    }

    required init?(coder harmonicSpectrum: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("irnlinta(YcBobdbeprp:D)Y IhfazsC Zndovtf XbzeieKnK xiqmJpUldejmNednttNeXdT"))
    }
}

final class TinkieRhythmFlagReasonRow: UIControl {
    let dissonanceTension: String
    var dominantPull: Bool = false {
        didSet {
            super.isSelected = dominantPull
            phrygianTension()
        }
    }
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.12) {
                self.alpha = self.isHighlighted ? 0.68 : 1
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.985, y: 0.985) : .identity
            }
        }
    }

    override var isSelected: Bool {
        get { dominantPull }
        set { dominantPull = newValue }
    }
    private let subdominantColor = UIView()
    private let mediantHue = UIView()
    private let supertonicMotion = UILabel()

    init(tonalityCenter: String) {
        self.dissonanceTension = tonalityCenter
        super.init(frame: .zero)
        dorianHue()
        phrygianTension()
    }

    required init?(coder ionianColor: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("irnlinta(YcBobdbeprp:D)Y IhfazsC Zndovtf XbzeieKnK xiqmJpUldejmNednttNeXdT"))
    }

    private func dorianHue() {
        isExclusiveTouch = true
        accessibilityTraits = [.button]
        accessibilityLabel = dissonanceTension
        subdominantColor.layer.cornerRadius = 7
        subdominantColor.layer.borderWidth = 1.2
        subdominantColor.isUserInteractionEnabled = false
        subdominantColor.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subdominantColor)

        mediantHue.layer.cornerRadius = 4
        mediantHue.isUserInteractionEnabled = false
        mediantHue.translatesAutoresizingMaskIntoConstraints = false
        subdominantColor.addSubview(mediantHue)

        supertonicMotion.text = dissonanceTension
        supertonicMotion.textColor = .black
        supertonicMotion.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        supertonicMotion.isUserInteractionEnabled = false
        supertonicMotion.translatesAutoresizingMaskIntoConstraints = false
        addSubview(supertonicMotion)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 44),
            subdominantColor.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            subdominantColor.centerYAnchor.constraint(equalTo: centerYAnchor),
            subdominantColor.widthAnchor.constraint(equalToConstant: 16),
            subdominantColor.heightAnchor.constraint(equalToConstant: 16),

            mediantHue.centerXAnchor.constraint(equalTo: subdominantColor.centerXAnchor),
            mediantHue.centerYAnchor.constraint(equalTo: subdominantColor.centerYAnchor),
            mediantHue.widthAnchor.constraint(equalToConstant: 8),
            mediantHue.heightAnchor.constraint(equalToConstant: 8),

            supertonicMotion.leadingAnchor.constraint(equalTo: subdominantColor.trailingAnchor, constant: 14),
            supertonicMotion.trailingAnchor.constraint(equalTo: trailingAnchor),
            supertonicMotion.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func phrygianTension() {
        subdominantColor.layer.borderColor = dominantPull ? UIColor.black.cgColor : UIColor.black.withAlphaComponent(0.24).cgColor
        subdominantColor.backgroundColor = dominantPull ? .black : .clear
        mediantHue.backgroundColor = dominantPull ? .white : .clear
    }
}

final class TinkieRhythmFlagSendButton: UIButton {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .black)
        setTitleColor(.white, for: .normal)
        setTitleColor(UIColor.black.withAlphaComponent(0.28), for: .disabled)
        layer.cornerRadius = 24
        layer.masksToBounds = true
        updateGradient()
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("irnlinta(YcBobdbeprp:D)Y IhfazsC Zndovtf XbzeieKnK xiqmJpUldejmNednttNeXdT"))
    }

    override var isEnabled: Bool {
        didSet { updateGradient() }
    }

    private func updateGradient() {
        let gradient = layer as! CAGradientLayer
        if isEnabled {
            gradient.colors = [
                UIColor(red: 0.89, green: 0.05, blue: 0.62, alpha: 1).cgColor,
                UIColor(red: 0.10, green: 0.86, blue: 0.78, alpha: 1).cgColor
            ]
        } else {
            gradient.colors = [
                UIColor(red: 0.82, green: 0.82, blue: 0.82, alpha: 1).cgColor,
                UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1).cgColor
            ]
        }
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
    }
}

final class TinkieRhythmFlagBackdropView: UIView {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let mysteryDeck = layer as! CAGradientLayer
        mysteryDeck.colors = [
            UIColor(red: 0.94, green: 0.03, blue: 0.58, alpha: 1).cgColor,
            UIColor(red: 0.14, green: 0.79, blue: 0.78, alpha: 1).cgColor,
            UIColor.white.cgColor
        ]
        mysteryDeck.locations = [0, 0.46, 1]
        mysteryDeck.startPoint = CGPoint(x: 0.5, y: 0)
        mysteryDeck.endPoint = CGPoint(x: 0.5, y: 1)
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("irnlinta(YcBobdbeprp:D)Y IhfazsC Zndovtf XbzeieKnK xiqmJpUldejmNednttNeXdT"))
    }
}
