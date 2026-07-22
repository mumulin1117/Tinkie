import AVFoundation
import UIKit
import UniformTypeIdentifiers

final class TinkieSongPulsePostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    var onPulseReady: (() -> Void)?
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let pickPanel = UIButton(type: .custom)
    private let previewImageView = UIImageView()
    private let plusView = UIImageView(image: UIImage(systemName: "plus.circle"))
    private let removeButton = UIButton(type: .system)
    private let playButton = UIButton(type: .system)
    private let captionView = UITextView()
    private let captionPlaceLabel = UILabel()
    private let confirmButton = TinkiePulseConfirmButton()
    private var chosenClipPath: String?
    private var chosenCoverPath: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        buildLayout()
        registerKeyboardObservers()
        refreshPreviewState()
        refreshConfirmState()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func buildLayout() {
        view.backgroundColor = .white

        let backdrop = TinkiePulsePostBackdropView()
        backdrop.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backdrop)

        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .interactive
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backButton)

        let titleLabel = UILabel()
        titleLabel.text = "Post Clip"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .black)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        pickPanel.backgroundColor = .white
        pickPanel.layer.cornerRadius = 8
        pickPanel.layer.masksToBounds = true
        pickPanel.addTarget(self, action: #selector(openPulsePicker), for: .touchUpInside)
        pickPanel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pickPanel)

        previewImageView.contentMode = .scaleAspectFill
        previewImageView.translatesAutoresizingMaskIntoConstraints = false
        pickPanel.addSubview(previewImageView)

        plusView.tintColor = UIColor(red: 0.70, green: 0.66, blue: 0.90, alpha: 0.32)
        plusView.contentMode = .scaleAspectFit
        plusView.translatesAutoresizingMaskIntoConstraints = false
        pickPanel.addSubview(plusView)

        removeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        removeButton.tintColor = .white
        removeButton.backgroundColor = .black
        removeButton.layer.cornerRadius = 14
        removeButton.addTarget(self, action: #selector(clearPulse), for: .touchUpInside)
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        pickPanel.addSubview(removeButton)

        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playButton.tintColor = .white
        playButton.layer.cornerRadius = 27
        playButton.layer.borderWidth = 2.5
        playButton.layer.borderColor = UIColor.white.cgColor
        playButton.backgroundColor = UIColor.white.withAlphaComponent(0.10)
        playButton.addTarget(self, action: #selector(previewPulse), for: .touchUpInside)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        pickPanel.addSubview(playButton)

        let captionLabel = UILabel()
        captionLabel.text = "Content"
        captionLabel.textColor = .black
        captionLabel.font = UIFont.systemFont(ofSize: 13, weight: .black)
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(captionLabel)

        captionView.backgroundColor = .white
        captionView.layer.cornerRadius = 8
        captionView.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        captionView.textColor = .black
        captionView.textContainerInset = UIEdgeInsets(top: 14, left: 18, bottom: 14, right: 18)
        captionView.delegate = self
        captionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(captionView)

        captionPlaceLabel.text = "Say Something"
        captionPlaceLabel.textColor = UIColor.black.withAlphaComponent(0.20)
        captionPlaceLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        captionPlaceLabel.translatesAutoresizingMaskIntoConstraints = false
        captionView.addSubview(captionPlaceLabel)

        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.addTarget(self, action: #selector(commitPulse), for: .touchUpInside)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(confirmButton)

        NSLayoutConstraint.activate([
            backdrop.topAnchor.constraint(equalTo: view.topAnchor),
            backdrop.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backdrop.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backdrop.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.frameLayoutGuide.heightAnchor),

            backButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 18),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),

            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),

            pickPanel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 16),
            pickPanel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            pickPanel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            pickPanel.heightAnchor.constraint(equalTo: pickPanel.widthAnchor, multiplier: 1.24),

            previewImageView.topAnchor.constraint(equalTo: pickPanel.topAnchor),
            previewImageView.leadingAnchor.constraint(equalTo: pickPanel.leadingAnchor),
            previewImageView.trailingAnchor.constraint(equalTo: pickPanel.trailingAnchor),
            previewImageView.bottomAnchor.constraint(equalTo: pickPanel.bottomAnchor),

            plusView.centerXAnchor.constraint(equalTo: pickPanel.centerXAnchor),
            plusView.centerYAnchor.constraint(equalTo: pickPanel.centerYAnchor),
            plusView.widthAnchor.constraint(equalToConstant: 58),
            plusView.heightAnchor.constraint(equalToConstant: 58),

            removeButton.topAnchor.constraint(equalTo: pickPanel.topAnchor, constant: 12),
            removeButton.trailingAnchor.constraint(equalTo: pickPanel.trailingAnchor, constant: -12),
            removeButton.widthAnchor.constraint(equalToConstant: 28),
            removeButton.heightAnchor.constraint(equalToConstant: 28),

            playButton.centerXAnchor.constraint(equalTo: pickPanel.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: pickPanel.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 54),
            playButton.heightAnchor.constraint(equalToConstant: 54),

            captionLabel.topAnchor.constraint(equalTo: pickPanel.bottomAnchor, constant: 16),
            captionLabel.leadingAnchor.constraint(equalTo: pickPanel.leadingAnchor),
            captionLabel.trailingAnchor.constraint(equalTo: pickPanel.trailingAnchor),

            captionView.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 10),
            captionView.leadingAnchor.constraint(equalTo: pickPanel.leadingAnchor),
            captionView.trailingAnchor.constraint(equalTo: pickPanel.trailingAnchor),
            captionView.heightAnchor.constraint(equalToConstant: 108),

            captionPlaceLabel.topAnchor.constraint(equalTo: captionView.topAnchor, constant: 16),
            captionPlaceLabel.leadingAnchor.constraint(equalTo: captionView.leadingAnchor, constant: 22),
            captionPlaceLabel.trailingAnchor.constraint(equalTo: captionView.trailingAnchor, constant: -22),

            confirmButton.topAnchor.constraint(equalTo: captionView.bottomAnchor, constant: 30),
            confirmButton.leadingAnchor.constraint(equalTo: pickPanel.leadingAnchor),
            confirmButton.trailingAnchor.constraint(equalTo: pickPanel.trailingAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: 44),
            confirmButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -22)
        ])
    }

    @objc private func openPulsePicker() {
        let sheet = UIAlertController(title: "Post Clip", message: "Choose a short Tinkie song moment.", preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Choose from Library", style: .default) { [weak self] _ in
            self?.presentPicker()
        })
        sheet.addAction(UIAlertAction(title: "Use Tinkie Sample", style: .default) { [weak self] _ in
            self?.useSamplePulse()
        })
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        sheet.popoverPresentationController?.sourceView = pickPanel
        sheet.popoverPresentationController?.sourceRect = pickPanel.bounds
        present(sheet, animated: true)
    }

    private func presentPicker() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            useSamplePulse()
            return
        }
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.mediaTypes = [UTType.movie.identifier]
        picker.delegate = self
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let pickedURL = info[.mediaURL] as? URL
        picker.dismiss(animated: true) { [weak self] in
            guard let self, let pickedURL else { return }
            self.importPulse(from: pickedURL)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    private func importPulse(from sourceURL: URL) {
        guard let storedURL = copyPulse(from: sourceURL) else {
            showAlert("Unable to import this clip.")
            return
        }
        chosenClipPath = storedURL.path
        let cover = makePreviewArt(from: storedURL) ?? UIImage(named: "tinkie_event_cover_friday_pop_hits")
        previewImageView.image = cover
        chosenCoverPath = cover.flatMap { saveCover($0) }
        refreshPreviewState()
        refreshConfirmState()
    }

    private func useSamplePulse() {
        chosenClipPath = "tinkie_song_room_clip_vocal_hook.mp4"
        previewImageView.image = UIImage(named: "tinkie_event_cover_classic_throwback")
        chosenCoverPath = nil
        refreshPreviewState()
        refreshConfirmState()
    }

    private func copyPulse(from sourceURL: URL) -> URL? {
        let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("tinkie_songpulse_picks", isDirectory: true)
        do {
            try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
            let name = "tinkie_songpulse_pick_\(UUID().uuidString).mov"
            let targetURL = folder.appendingPathComponent(name)
            if FileManager.default.fileExists(atPath: targetURL.path) {
                try FileManager.default.removeItem(at: targetURL)
            }
            try FileManager.default.copyItem(at: sourceURL, to: targetURL)
            return targetURL
        } catch {
            return nil
        }
    }

    private func makePreviewArt(from sourceURL: URL) -> UIImage? {
        let asset = AVURLAsset(url: sourceURL)
        let maker = AVAssetImageGenerator(asset: asset)
        maker.appliesPreferredTrackTransform = true
        guard let imageRef = try? maker.copyCGImage(at: CMTime(seconds: 0.2, preferredTimescale: 600), actualTime: nil) else {
            return nil
        }
        return UIImage(cgImage: imageRef)
    }

    private func saveCover(_ image: UIImage) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.82) else { return nil }
        let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("tinkie_songpulse_art", isDirectory: true)
        do {
            try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
            let targetURL = folder.appendingPathComponent("tinkie_songpulse_cover_\(UUID().uuidString).jpg")
            try data.write(to: targetURL, options: .atomic)
            return targetURL.path
        } catch {
            return nil
        }
    }

    @objc private func clearPulse() {
        chosenClipPath = nil
        chosenCoverPath = nil
        previewImageView.image = nil
        refreshPreviewState()
        refreshConfirmState()
    }

    @objc private func previewPulse() {
        showAlert("Preview is ready. Your selected clip will appear at the top of Reels after confirmation.")
    }

    @objc private func commitPulse() {
        let captionText = captionView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let chosenClipPath else {
            showAlert("Please choose a clip first.")
            return
        }
        guard !captionText.isEmpty else {
            showAlert("Please add content.")
            return
        }
        let profile = TinkieProfileStore.currentSnapshot()
        TinkieSongPulsePostStore.save(
            TinkieSongPulsePostRecord(
                caption: captionText,
                coverPath: chosenCoverPath,
                clipPath: chosenClipPath,
                performer: profile.nickname,
                avatarName: profile.heroImageName,
                avatarPath: profile.heroImagePath
            )
        )
        let alert = UIAlertController(title: "Posted", message: "Your Tinkie song clip is now saved locally.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.onPulseReady?()
            self?.dismiss(animated: true)
        })
        present(alert, animated: true)
    }

    private func refreshPreviewState() {
        let hasPulse = chosenClipPath != nil
        plusView.isHidden = hasPulse
        removeButton.isHidden = !hasPulse
        playButton.isHidden = !hasPulse
        previewImageView.isHidden = !hasPulse
    }

    private func refreshConfirmState() {
        let captionText = captionView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        confirmButton.isEnabled = chosenClipPath != nil && !captionText.isEmpty
        confirmButton.alpha = confirmButton.isEnabled ? 1 : 0.72
    }

    func textViewDidChange(_ textView: UITextView) {
        captionPlaceLabel.isHidden = !textView.text.isEmpty
        refreshConfirmState()
    }

    private func showAlert(_ text: String) {
        let alert = UIAlertController(title: "Tinkie", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
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
        scrollView.contentInset.bottom = overlap + 24
        scrollView.scrollIndicatorInsets.bottom = overlap + 24
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

final class TinkiePulseConfirmButton: UIButton {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .black)
        setTitleColor(.white, for: .normal)
        setTitleColor(UIColor.white.withAlphaComponent(0.82), for: .disabled)
        layer.cornerRadius = 22
        layer.masksToBounds = true
        refreshGradient()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isEnabled: Bool {
        didSet { refreshGradient() }
    }

    private func refreshGradient() {
        let gradient = layer as! CAGradientLayer
        gradient.colors = [
            UIColor(red: 0.88, green: 0.05, blue: 0.62, alpha: isEnabled ? 1 : 0.46).cgColor,
            UIColor(red: 0.12, green: 0.86, blue: 0.78, alpha: isEnabled ? 1 : 0.46).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
    }
}

final class TinkiePulsePostBackdropView: UIView {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let gradient = layer as! CAGradientLayer
        gradient.colors = [
            UIColor(red: 0.93, green: 0.03, blue: 0.57, alpha: 1).cgColor,
            UIColor(red: 0.10, green: 0.75, blue: 0.72, alpha: 1).cgColor,
            UIColor.white.cgColor
        ]
        gradient.locations = [0, 0.58, 1]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
