import UIKit

enum TinkieSafetyStore {
    private static let reportKey = "tinkie_safety_report_records"
    private static let blockKey = "tinkie_safety_block_records"

    static func saveReport(targetKey: String, targetKind: String, reason: String, note: String) {
        var records = stringArray(for: reportKey)
        let stamp = "\(targetKind)|\(targetKey)|\(reason)|\(note)"
        records.append(stamp)
        UserDefaults.standard.set(records, forKey: reportKey)
    }

    static func blockTarget(targetKey: String, targetKind: String) {
        var records = Set(stringArray(for: blockKey))
        records.insert("\(targetKind)|\(targetKey)")
        UserDefaults.standard.set(Array(records), forKey: blockKey)
    }

    private static func stringArray(for key: String) -> [String] {
        UserDefaults.standard.stringArray(forKey: key) ?? []
    }
}

extension UIViewController {
    func tinkiePresentSafetyOptions(targetTitle: String, targetKey: String, targetKind: String) {
        guard TinkieProfileStore.isSignedIn else {
            let welcome = TinkieAuthWelcomeViewController()
            welcome.onComplete = { [weak self] in
                self?.dismiss(animated: true) {
                    self?.tinkiePresentSafetyOptions(targetTitle: targetTitle, targetKey: targetKey, targetKind: targetKind)
                }
            }
            let navigation = UINavigationController(rootViewController: welcome)
            navigation.modalPresentationStyle = .fullScreen
            present(navigation, animated: true)
            return
        }

        let options = TinkieSafetyOptionViewController(targetTitle: targetTitle)
        options.onReport = { [weak self] in
            let controller = TinkieSafetyReportViewController(targetTitle: targetTitle, targetKey: targetKey, targetKind: targetKind)
            let navigation = UINavigationController(rootViewController: controller)
            navigation.modalPresentationStyle = .fullScreen
            self?.present(navigation, animated: true)
        }
        options.onBlock = { [weak self] in
            TinkieSafetyStore.blockTarget(targetKey: targetKey, targetKind: targetKind)
            self?.tinkieShowSafetyNotice(title: "Blocked", detail: "This \(targetKind) is hidden from your local Tinkie experience.")
        }
        options.modalPresentationStyle = .overFullScreen
        options.modalTransitionStyle = .crossDissolve
        present(options, animated: true)
    }

    func tinkieShowSafetyNotice(title: String, detail: String) {
        let alert = UIAlertController(title: title, message: detail, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

final class TinkieSafetyOptionViewController: UIViewController {
    var onReport: (() -> Void)?
    var onBlock: (() -> Void)?
    private let targetTitle: String
    private let dimView = UIView()
    private let panelStack = UIStackView()

    init(targetTitle: String) {
        self.targetTitle = targetTitle
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }

    private func buildLayout() {
        view.backgroundColor = .clear
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.46)
        dimView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dimView)

        panelStack.axis = .vertical
        panelStack.spacing = 10
        panelStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(panelStack)

        let report = TinkieSafetySheetButton(title: "Report", style: .light)
        report.addTarget(self, action: #selector(reportTapped), for: .touchUpInside)
        let block = TinkieSafetySheetButton(title: "Block", style: .light)
        block.addTarget(self, action: #selector(blockTapped), for: .touchUpInside)
        let cancel = TinkieSafetySheetButton(title: "Cancel", style: .dark)
        cancel.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)

        [report, block, cancel].forEach { panelStack.addArrangedSubview($0) }

        NSLayoutConstraint.activate([
            dimView.topAnchor.constraint(equalTo: view.topAnchor),
            dimView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            panelStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            panelStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            panelStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -28),

            report.heightAnchor.constraint(equalToConstant: 48),
            block.heightAnchor.constraint(equalToConstant: 48),
            cancel.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    @objc private func reportTapped() {
        dismiss(animated: true) { [onReport] in onReport?() }
    }

    @objc private func blockTapped() {
        dismiss(animated: true) { [onBlock] in onBlock?() }
    }

    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
}

final class TinkieSafetyReportViewController: UIViewController, UITextViewDelegate {
    private let targetTitle: String
    private let targetKey: String
    private let targetKind: String
    private let reasons = ["Fake photo", "Scam or commercial", "Not interested", "Other"]
    private var selectedReason: String?
    private let scrollView = UIScrollView()
    private let reasonStack = UIStackView()
    private let noteView = UITextView()
    private let confirmButton = TinkieSafetyConfirmButton()

    init(targetTitle: String, targetKey: String, targetKind: String) {
        self.targetTitle = targetTitle
        self.targetKey = targetKey
        self.targetKind = targetKind
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        buildLayout()
        registerKeyboardObservers()
        updateConfirmState()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func buildLayout() {
        view.backgroundColor = .white
        let gradient = TinkieSafetyReportBackdropView()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gradient)

        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.keyboardDismissMode = .interactive
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(content)

        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(backButton)

        let title = UILabel()
        title.text = "Report"
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 16, weight: .black)
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(title)

        let prompt = UILabel()
        prompt.text = "Please select the reason for reporting this \(targetKind):"
        prompt.textColor = UIColor.black.withAlphaComponent(0.52)
        prompt.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        prompt.numberOfLines = 0
        prompt.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(prompt)

        reasonStack.axis = .vertical
        reasonStack.spacing = 20
        reasonStack.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(reasonStack)
        reasons.forEach { reason in
            let row = TinkieSafetyReasonRow(title: reason)
            row.addTarget(self, action: #selector(reasonTapped(_:)), for: .touchUpInside)
            reasonStack.addArrangedSubview(row)
        }

        noteView.backgroundColor = .white
        noteView.layer.cornerRadius = 8
        noteView.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        noteView.textColor = .black
        noteView.textContainerInset = UIEdgeInsets(top: 14, left: 12, bottom: 14, right: 12)
        noteView.delegate = self
        noteView.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(noteView)

        let placeholder = UILabel()
        placeholder.text = "Enter your reason here..."
        placeholder.textColor = UIColor.black.withAlphaComponent(0.18)
        placeholder.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        placeholder.tag = 101
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        noteView.addSubview(placeholder)

        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        content.addSubview(confirmButton)

        NSLayoutConstraint.activate([
            gradient.topAnchor.constraint(equalTo: view.topAnchor),
            gradient.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradient.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradient.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            content.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            content.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            content.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            content.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            content.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.frameLayoutGuide.heightAnchor),

            backButton.topAnchor.constraint(equalTo: content.safeAreaLayoutGuide.topAnchor, constant: 18),
            backButton.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 22),
            backButton.widthAnchor.constraint(equalToConstant: 36),
            backButton.heightAnchor.constraint(equalToConstant: 36),

            title.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            title.centerXAnchor.constraint(equalTo: content.centerXAnchor),

            prompt.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 28),
            prompt.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 28),
            prompt.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -28),

            reasonStack.topAnchor.constraint(equalTo: prompt.bottomAnchor, constant: 22),
            reasonStack.leadingAnchor.constraint(equalTo: prompt.leadingAnchor),
            reasonStack.trailingAnchor.constraint(equalTo: prompt.trailingAnchor),

            noteView.topAnchor.constraint(equalTo: reasonStack.bottomAnchor, constant: 20),
            noteView.leadingAnchor.constraint(equalTo: prompt.leadingAnchor),
            noteView.trailingAnchor.constraint(equalTo: prompt.trailingAnchor),
            noteView.heightAnchor.constraint(equalToConstant: 96),

            placeholder.topAnchor.constraint(equalTo: noteView.topAnchor, constant: 16),
            placeholder.leadingAnchor.constraint(equalTo: noteView.leadingAnchor, constant: 16),
            placeholder.trailingAnchor.constraint(equalTo: noteView.trailingAnchor, constant: -16),

            confirmButton.topAnchor.constraint(equalTo: noteView.bottomAnchor, constant: 34),
            confirmButton.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 22),
            confirmButton.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -22),
            confirmButton.heightAnchor.constraint(equalToConstant: 48),
            confirmButton.bottomAnchor.constraint(lessThanOrEqualTo: content.bottomAnchor, constant: -32)
        ])
    }

    @objc private func reasonTapped(_ sender: TinkieSafetyReasonRow) {
        selectedReason = sender.titleText
        reasonStack.arrangedSubviews.compactMap { $0 as? TinkieSafetyReasonRow }.forEach { row in
            row.isPicked = row === sender
        }
        updateConfirmState()
    }

    private func updateConfirmState() {
        confirmButton.isEnabled = selectedReason != nil
        confirmButton.alpha = selectedReason == nil ? 0.72 : 1
    }

    func textViewDidChange(_ textView: UITextView) {
        textView.viewWithTag(101)?.isHidden = !textView.text.isEmpty
    }

    @objc private func confirmTapped() {
        guard let selectedReason else { return }
        let note = noteView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        TinkieSafetyStore.saveReport(targetKey: targetKey, targetKind: targetKind, reason: selectedReason, note: note)
        let alert = UIAlertController(
            title: "Report Submitted",
            message: "Thanks for helping Tinkie keep song guessing spaces safe and respectful.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.dismiss(animated: true)
        })
        present(alert, animated: true)
    }

    private func registerKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditingNow))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let overlap = max(0, view.bounds.maxY - view.convert(frame, from: nil).minY)
        scrollView.contentInset.bottom = overlap + 20
        scrollView.scrollIndicatorInsets.bottom = overlap + 20
    }

    @objc private func keyboardWillHide() {
        scrollView.contentInset.bottom = 0
        scrollView.scrollIndicatorInsets.bottom = 0
    }

    @objc private func endEditingNow() {
        view.endEditing(true)
    }

    @objc private func close() {
        dismiss(animated: true)
    }
}

final class TinkieSafetySheetButton: UIButton {
    enum Style {
        case light
        case dark
    }

    init(title: String, style: Style) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .black)
        layer.cornerRadius = 24
        switch style {
        case .light:
            backgroundColor = .white
            setTitleColor(UIColor.black.withAlphaComponent(0.38), for: .normal)
        case .dark:
            backgroundColor = UIColor(red: 0.01, green: 0.04, blue: 0.03, alpha: 1)
            setTitleColor(.white, for: .normal)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TinkieSafetyReasonRow: UIControl {
    let titleText: String
    var isPicked: Bool = false {
        didSet { updateState() }
    }
    private let circleView = UIView()
    private let dotView = UIView()
    private let titleLabel = UILabel()

    init(title: String) {
        self.titleText = title
        super.init(frame: .zero)
        buildLayout()
        updateState()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildLayout() {
        circleView.layer.cornerRadius = 7
        circleView.layer.borderWidth = 1.2
        circleView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(circleView)

        dotView.layer.cornerRadius = 4
        dotView.translatesAutoresizingMaskIntoConstraints = false
        circleView.addSubview(dotView)

        titleLabel.text = titleText
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 24),
            circleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            circleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 14),
            circleView.heightAnchor.constraint(equalToConstant: 14),

            dotView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            dotView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            dotView.widthAnchor.constraint(equalToConstant: 8),
            dotView.heightAnchor.constraint(equalToConstant: 8),

            titleLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 14),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func updateState() {
        circleView.layer.borderColor = isPicked ? UIColor.black.cgColor : UIColor.black.withAlphaComponent(0.24).cgColor
        circleView.backgroundColor = isPicked ? .black : .clear
        dotView.backgroundColor = isPicked ? .white : .clear
    }
}

final class TinkieSafetyConfirmButton: UIButton {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .black)
        setTitleColor(.white, for: .normal)
        setTitleColor(UIColor.black.withAlphaComponent(0.28), for: .disabled)
        layer.cornerRadius = 24
        layer.masksToBounds = true
        updateGradient()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

final class TinkieSafetyReportBackdropView: UIView {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let gradient = layer as! CAGradientLayer
        gradient.colors = [
            UIColor(red: 0.94, green: 0.03, blue: 0.58, alpha: 1).cgColor,
            UIColor(red: 0.14, green: 0.79, blue: 0.78, alpha: 1).cgColor,
            UIColor.white.cgColor
        ]
        gradient.locations = [0, 0.46, 1]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
