import AVFoundation
import UIKit
import UniformTypeIdentifiers

final class TinkieSongPulseForgeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    var onPulseReady: (() -> Void)?
    private let pulseScrollStage = UIScrollView()
    private let pulseContentStage = UIView()
    private let pulseDropStage = UIButton(type: .custom)
    private let pulseCoverFrameView = UIImageView()
    private let pulseAddCueView = UIImageView(image: UIImage(systemName: "plus.circle"))
    private let pulseClearDraftButton = UIButton(type: .system)
    private let pulsePreviewBeatButton = UIButton(type: .system)
    private let pulseCaptionLyricPad = UITextView()
    private let pulseCaptionCueLabel = UILabel()
    private let pulseSealButton = TinkiePulseForgeConfirmButton()
    private var pulseDraftPath: String?
    private var pulseCoverDraftPath: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        putPulseForgeStageTogether()
        listenForPulseKeyboardRise()
        paintPulsePreviewState()
        paintPulseForgeReadyState()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func putPulseForgeStageTogether() {
        view.backgroundColor = .white
        let backdrop = TinkiePulseForgeBackdropView(); backdrop.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(backdrop)
        pulseScrollStage.alwaysBounceVertical = true; pulseScrollStage.keyboardDismissMode = .interactive; pulseScrollStage.showsVerticalScrollIndicator = false; pulseScrollStage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pulseScrollStage)
        pulseContentStage.translatesAutoresizingMaskIntoConstraints = false; pulseScrollStage.addSubview(pulseContentStage)
        let pulseBackBeatButton = UIButton(type: .system); pulseBackBeatButton.setImage(UIImage(systemName: "chevron.left"), for: .normal); pulseBackBeatButton.tintColor = .black; pulseBackBeatButton.addTarget(self, action: #selector(leavePulseForge), for: .touchUpInside)
        pulseBackBeatButton.translatesAutoresizingMaskIntoConstraints = false; pulseContentStage.addSubview(pulseBackBeatButton)
        let pulseForgeTitleLabel = UILabel(); pulseForgeTitleLabel.text = TinkieVerseCipherTrail.singBack("PKoYsbtp FCYlLiGpY"); pulseForgeTitleLabel.textColor = .black; pulseForgeTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .black)
        pulseForgeTitleLabel.textAlignment = .center; pulseForgeTitleLabel.translatesAutoresizingMaskIntoConstraints = false; pulseContentStage.addSubview(pulseForgeTitleLabel)
        pulseDropStage.backgroundColor = .white; pulseDropStage.layer.cornerRadius = 8; pulseDropStage.layer.masksToBounds = true; pulseDropStage.addTarget(self, action: #selector(choosePulseSparkSource), for: .touchUpInside)
        pulseDropStage.translatesAutoresizingMaskIntoConstraints = false; pulseContentStage.addSubview(pulseDropStage)
        pulseCoverFrameView.contentMode = .scaleAspectFill; pulseCoverFrameView.translatesAutoresizingMaskIntoConstraints = false; pulseDropStage.addSubview(pulseCoverFrameView)
        pulseAddCueView.tintColor = UIColor(red: 0.70, green: 0.66, blue: 0.90, alpha: 0.32); pulseAddCueView.contentMode = .scaleAspectFit; pulseAddCueView.translatesAutoresizingMaskIntoConstraints = false; pulseDropStage.addSubview(pulseAddCueView)
        pulseClearDraftButton.setImage(UIImage(systemName: "xmark"), for: .normal); pulseClearDraftButton.tintColor = .white; pulseClearDraftButton.backgroundColor = .black; pulseClearDraftButton.layer.cornerRadius = 14
        pulseClearDraftButton.addTarget(self, action: #selector(clearPulseDraft), for: .touchUpInside); pulseClearDraftButton.translatesAutoresizingMaskIntoConstraints = false; pulseDropStage.addSubview(pulseClearDraftButton)
        pulsePreviewBeatButton.setImage(UIImage(systemName: "play.fill"), for: .normal); pulsePreviewBeatButton.tintColor = .white; pulsePreviewBeatButton.layer.cornerRadius = 27; pulsePreviewBeatButton.layer.borderWidth = 2.5
        pulsePreviewBeatButton.layer.borderColor = UIColor.white.cgColor; pulsePreviewBeatButton.backgroundColor = UIColor.white.withAlphaComponent(0.10); pulsePreviewBeatButton.addTarget(self, action: #selector(tapPulsePreview), for: .touchUpInside); pulsePreviewBeatButton.translatesAutoresizingMaskIntoConstraints = false
        pulseDropStage.addSubview(pulsePreviewBeatButton)
        let captionLabel = UILabel(); captionLabel.text = TinkieVerseCipherTrail.singBack("CNodnvtFeNnWtc"); captionLabel.textColor = .black; captionLabel.font = UIFont.systemFont(ofSize: 13, weight: .black)
        captionLabel.translatesAutoresizingMaskIntoConstraints = false; pulseContentStage.addSubview(captionLabel)
        pulseCaptionLyricPad.backgroundColor = .white; pulseCaptionLyricPad.layer.cornerRadius = 8; pulseCaptionLyricPad.font = UIFont.systemFont(ofSize: 12, weight: .regular); pulseCaptionLyricPad.textColor = .black
        pulseCaptionLyricPad.textContainerInset = UIEdgeInsets(top: 14, left: 18, bottom: 14, right: 18); pulseCaptionLyricPad.delegate = self; pulseCaptionLyricPad.translatesAutoresizingMaskIntoConstraints = false; pulseContentStage.addSubview(pulseCaptionLyricPad)
        pulseCaptionCueLabel.text = TinkieVerseCipherTrail.singBack("SJajyB BSNobmUeptmhLiLnIgD"); pulseCaptionCueLabel.textColor = UIColor.black.withAlphaComponent(0.20); pulseCaptionCueLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium); pulseCaptionCueLabel.translatesAutoresizingMaskIntoConstraints = false
        pulseCaptionLyricPad.addSubview(pulseCaptionCueLabel)
        pulseSealButton.setTitle(TinkieVerseCipherTrail.singBack("CnoTnFfjiermmy"), for: .normal); pulseSealButton.addTarget(self, action: #selector(sealPulseForge), for: .touchUpInside); pulseSealButton.translatesAutoresizingMaskIntoConstraints = false; pulseContentStage.addSubview(pulseSealButton)
        pinPulseForgeStageBeat1(backdrop: backdrop, pulseBackBeatButton: pulseBackBeatButton); pinPulseForgeStageBeat2(pulseBackBeatButton: pulseBackBeatButton, pulseForgeTitleLabel: pulseForgeTitleLabel); pinPulseForgeStageBeat3(captionLabel: captionLabel); pinPulseForgeStageBeat4()
    }

    private func pinPulseForgeStageBeat1(backdrop: TinkiePulseForgeBackdropView, pulseBackBeatButton: UIButton) {
        NSLayoutConstraint.activate([
            backdrop.topAnchor.constraint(equalTo: view.topAnchor),
            backdrop.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backdrop.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backdrop.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pulseScrollStage.topAnchor.constraint(equalTo: view.topAnchor),
            pulseScrollStage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pulseScrollStage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pulseScrollStage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pulseContentStage.topAnchor.constraint(equalTo: pulseScrollStage.contentLayoutGuide.topAnchor),
            pulseContentStage.leadingAnchor.constraint(equalTo: pulseScrollStage.contentLayoutGuide.leadingAnchor),
            pulseContentStage.trailingAnchor.constraint(equalTo: pulseScrollStage.contentLayoutGuide.trailingAnchor),
            pulseContentStage.bottomAnchor.constraint(equalTo: pulseScrollStage.contentLayoutGuide.bottomAnchor),
            pulseContentStage.widthAnchor.constraint(equalTo: pulseScrollStage.frameLayoutGuide.widthAnchor),
            pulseContentStage.heightAnchor.constraint(greaterThanOrEqualTo: pulseScrollStage.frameLayoutGuide.heightAnchor),
            
            pulseBackBeatButton.topAnchor.constraint(equalTo: pulseContentStage.safeAreaLayoutGuide.topAnchor, constant: 18),
            pulseBackBeatButton.leadingAnchor.constraint(equalTo: pulseContentStage.leadingAnchor, constant: 22),
            pulseBackBeatButton.widthAnchor.constraint(equalToConstant: 40),
            pulseBackBeatButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func pinPulseForgeStageBeat2(pulseBackBeatButton: UIButton, pulseForgeTitleLabel: UILabel) {
        NSLayoutConstraint.activate([
            
            pulseForgeTitleLabel.centerXAnchor.constraint(equalTo: pulseContentStage.centerXAnchor),
            pulseForgeTitleLabel.centerYAnchor.constraint(equalTo: pulseBackBeatButton.centerYAnchor),
            
            pulseDropStage.topAnchor.constraint(equalTo: pulseBackBeatButton.bottomAnchor, constant: 16),
            pulseDropStage.leadingAnchor.constraint(equalTo: pulseContentStage.leadingAnchor, constant: 30),
            pulseDropStage.trailingAnchor.constraint(equalTo: pulseContentStage.trailingAnchor, constant: -30),
            pulseDropStage.heightAnchor.constraint(equalTo: pulseDropStage.widthAnchor, multiplier: 1.24),
            
            pulseCoverFrameView.topAnchor.constraint(equalTo: pulseDropStage.topAnchor),
            pulseCoverFrameView.leadingAnchor.constraint(equalTo: pulseDropStage.leadingAnchor),
            pulseCoverFrameView.trailingAnchor.constraint(equalTo: pulseDropStage.trailingAnchor),
            pulseCoverFrameView.bottomAnchor.constraint(equalTo: pulseDropStage.bottomAnchor),
            
            pulseAddCueView.centerXAnchor.constraint(equalTo: pulseDropStage.centerXAnchor),
            pulseAddCueView.centerYAnchor.constraint(equalTo: pulseDropStage.centerYAnchor),
            pulseAddCueView.widthAnchor.constraint(equalToConstant: 58),
            pulseAddCueView.heightAnchor.constraint(equalToConstant: 58),
            
            pulseClearDraftButton.topAnchor.constraint(equalTo: pulseDropStage.topAnchor, constant: 12),
            pulseClearDraftButton.trailingAnchor.constraint(equalTo: pulseDropStage.trailingAnchor, constant: -12),
            pulseClearDraftButton.widthAnchor.constraint(equalToConstant: 28),
            pulseClearDraftButton.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    private func pinPulseForgeStageBeat3(captionLabel: UILabel) {
        NSLayoutConstraint.activate([
            
            pulsePreviewBeatButton.centerXAnchor.constraint(equalTo: pulseDropStage.centerXAnchor),
            pulsePreviewBeatButton.centerYAnchor.constraint(equalTo: pulseDropStage.centerYAnchor),
            pulsePreviewBeatButton.widthAnchor.constraint(equalToConstant: 54),
            pulsePreviewBeatButton.heightAnchor.constraint(equalToConstant: 54),
            
            captionLabel.topAnchor.constraint(equalTo: pulseDropStage.bottomAnchor, constant: 16),
            captionLabel.leadingAnchor.constraint(equalTo: pulseDropStage.leadingAnchor),
            captionLabel.trailingAnchor.constraint(equalTo: pulseDropStage.trailingAnchor),
            
            pulseCaptionLyricPad.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 10),
            pulseCaptionLyricPad.leadingAnchor.constraint(equalTo: pulseDropStage.leadingAnchor),
            pulseCaptionLyricPad.trailingAnchor.constraint(equalTo: pulseDropStage.trailingAnchor),
            pulseCaptionLyricPad.heightAnchor.constraint(equalToConstant: 108),
            
            pulseCaptionCueLabel.topAnchor.constraint(equalTo: pulseCaptionLyricPad.topAnchor, constant: 16),
            pulseCaptionCueLabel.leadingAnchor.constraint(equalTo: pulseCaptionLyricPad.leadingAnchor, constant: 22),
            pulseCaptionCueLabel.trailingAnchor.constraint(equalTo: pulseCaptionLyricPad.trailingAnchor, constant: -22),
            
            pulseSealButton.topAnchor.constraint(equalTo: pulseCaptionLyricPad.bottomAnchor, constant: 30),
            pulseSealButton.leadingAnchor.constraint(equalTo: pulseDropStage.leadingAnchor),
            pulseSealButton.trailingAnchor.constraint(equalTo: pulseDropStage.trailingAnchor),
            pulseSealButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func pinPulseForgeStageBeat4() {
        NSLayoutConstraint.activate([
            pulseSealButton.bottomAnchor.constraint(lessThanOrEqualTo: pulseContentStage.safeAreaLayoutGuide.bottomAnchor, constant: -22)
        ])
    }

    @objc private func choosePulseSparkSource() {
        let sheet = UIAlertController(title: TinkieVerseCipherTrail.singBack("PmomsFtM bCmlvitpm"), message: TinkieVerseCipherTrail.singBack("CHhPoTogsTeq aak gsihionrdtB eTGiVnSkZireN WsXownsgg pmjoWmseHnAtq.L"), preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: TinkieVerseCipherTrail.singBack("CthroaoRsceJ SfgrKoLmq fLJiUbArsabrtym"), style: .default) { [weak self] _ in
            self?.presentPulseSparkLibrary()
        })
        sheet.addAction(UIAlertAction(title: TinkieVerseCipherTrail.singBack("UMsfeP UTgivndkaiWeo ySfaFmspvlReI"), style: .default) { [weak self] _ in
            self?.useSamplePulse()
        })
        sheet.addAction(UIAlertAction(title: TinkieVerseCipherTrail.singBack("CgaYnWcWeglp"), style: .cancel))
        sheet.popoverPresentationController?.sourceView = pulseDropStage
        sheet.popoverPresentationController?.sourceRect = pulseDropStage.bounds
        present(sheet, animated: true)
    }

    private func presentPulseSparkLibrary() {
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
            self.carryPulseSparkIntoForge(from: pickedURL)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    private func carryPulseSparkIntoForge(from sourceURL: URL) {
        guard let storedURL = stashPulseSparkFile(from: sourceURL) else {
            showPulseForgeHint(TinkieVerseCipherTrail.singBack("UXnTaZbFlues itBoT FiLmupboirxtL dtWhqifsA HcHlNiJpI.i"))
            return
        }
        pulseDraftPath = storedURL.path
        let cover = carvePulsePreviewFrame(from: storedURL) ?? UIImage(named: "tinkie_event_cover_friday_pop_hits")
        pulseCoverFrameView.image = cover
        pulseCoverDraftPath = cover.flatMap { stashPulseCoverFrame($0) }
        paintPulsePreviewState()
        paintPulseForgeReadyState()
    }

    private func useSamplePulse() {
        pulseDraftPath = "tinkie_song_room_clip_vocal_hook.mp4"
        pulseCoverFrameView.image = UIImage(named: "tinkie_event_cover_classic_throwback")
        pulseCoverDraftPath = nil
        paintPulsePreviewState()
        paintPulseForgeReadyState()
    }

    private func stashPulseSparkFile(from sourceURL: URL) -> URL? {
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

    private func carvePulsePreviewFrame(from sourceURL: URL) -> UIImage? {
        let asset = AVURLAsset(url: sourceURL)
        let maker = AVAssetImageGenerator(asset: asset)
        maker.appliesPreferredTrackTransform = true
        guard let imageRef = try? maker.copyCGImage(at: CMTime(seconds: 0.2, preferredTimescale: 600), actualTime: nil) else {
            return nil
        }
        return UIImage(cgImage: imageRef)
    }

    private func stashPulseCoverFrame(_ image: UIImage) -> String? {
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

    @objc private func clearPulseDraft() {
        pulseDraftPath = nil
        pulseCoverDraftPath = nil
        pulseCoverFrameView.image = nil
        paintPulsePreviewState()
        paintPulseForgeReadyState()
    }

    @objc private func tapPulsePreview() {
        showPulseForgeHint(TinkieVerseCipherTrail.singBack("PjrIeYvAiOegwJ LiBsc wrHeFaxdmyf.r QYHovuFrP qszeHlOeScxtxekdq NcNlKiMpJ nwciJlUlj TaZpMpsesaXrC raqte ItwhQeO Ztkovpo XoUfO qRAeFevlgsp gadfrtMeCrV rcroMnNfdinrcmwaQtTiToane.T"))
    }

    @objc private func sealPulseForge() {
        let captionText = pulseCaptionLyricPad.text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let pulseDraftPath else {
            showPulseForgeHint(TinkieVerseCipherTrail.singBack("PslNeEapsKem qcqhzosoCsseL MaB NcNlKiMpJ nfWiJrSsBtN.q"))
            return
        }
        guard !captionText.isEmpty else {
            showPulseForgeHint(TinkieVerseCipherTrail.singBack("PjlTeOagsJeh uatdcdU qcqoCnYtmecngtY.v"))
            return
        }
        let profile = TinkieSingerStageScorebook.currentSingerStage()
        TinkiePulseSparkScorebook.save(
            TinkieSongPulseSparkDraft(
                caption: captionText,
                coverPath: pulseCoverDraftPath,
                clipPath: pulseDraftPath,
                performer: profile.singerAlias,
                avatarName: profile.portraitAssetName,
                avatarPath: profile.portraitLocalPath
            )
        )
        tinkieShowTuneNotice(title: TinkieVerseCipherTrail.singBack("PEoJsttzefdm"), detail: TinkieVerseCipherTrail.singBack("YcoZukrn YTkimngkviYed tsboTnFgK NcNlWiPpT dilsF LneogwA SsZaxvneade QlpovcCablnlPyA.B"), onPrimary: { [weak self] in
            self?.onPulseReady?()
            self?.dismiss(animated: true)
        })
    }

    private func paintPulsePreviewState() {
        let hasPulse = pulseDraftPath != nil
        pulseAddCueView.isHidden = hasPulse
        pulseClearDraftButton.isHidden = !hasPulse
        pulsePreviewBeatButton.isHidden = !hasPulse
        pulseCoverFrameView.isHidden = !hasPulse
    }

    private func paintPulseForgeReadyState() {
        let captionText = pulseCaptionLyricPad.text.trimmingCharacters(in: .whitespacesAndNewlines)
        pulseSealButton.isEnabled = pulseDraftPath != nil && !captionText.isEmpty
        pulseSealButton.alpha = pulseSealButton.isEnabled ? 1 : 0.72
    }

    func textViewDidChange(_ textView: UITextView) {
        pulseCaptionCueLabel.isHidden = !textView.text.isEmpty
        paintPulseForgeReadyState()
    }

    private func showPulseForgeHint(_ text: String) {
        tinkieShowTuneNotice(title: TinkieVerseCipherTrail.singBack("TviynxkriKek"), detail: text)
    }

    private func listenForPulseKeyboardRise() {
        NotificationCenter.default.addObserver(self, selector: #selector(pulseKeyboardRose), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pulseKeyboardSettled), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(hushPulseTyping))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func pulseKeyboardRose(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let overlap = max(0, view.bounds.maxY - view.convert(frame, from: nil).minY)
        pulseScrollStage.contentInset.bottom = overlap + 24
        pulseScrollStage.scrollIndicatorInsets.bottom = overlap + 24
    }

    @objc private func pulseKeyboardSettled() {
        pulseScrollStage.contentInset.bottom = 0
        pulseScrollStage.scrollIndicatorInsets.bottom = 0
    }

    @objc private func hushPulseTyping() {
        view.endEditing(true)
    }

    @objc private func leavePulseForge() {
        dismiss(animated: true)
    }
}

final class TinkiePulseForgeConfirmButton: UIButton {
    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .black)
        setTitleColor(.white, for: .normal)
        setTitleColor(UIColor.white.withAlphaComponent(0.82), for: .disabled)
        layer.cornerRadius = 22
        layer.masksToBounds = true
        paintPulseForgeGradient()
    }

    required init?(coder: NSCoder) {
        fatalError(TinkieVerseCipherTrail.singBack("ibndilth(McLogdgerrq:Y)M WhuassH Cnpoktu DbseweSnY jixmPpQliesmTepnntJeDdN"))
    }

    override var isEnabled: Bool {
        didSet { paintPulseForgeGradient() }
    }

    private func paintPulseForgeGradient() {
        let gradient = layer as! CAGradientLayer
        gradient.colors = [
            UIColor(red: 0.88, green: 0.05, blue: 0.62, alpha: isEnabled ? 1 : 0.46).cgColor,
            UIColor(red: 0.12, green: 0.86, blue: 0.78, alpha: isEnabled ? 1 : 0.46).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
    }
}

final class TinkiePulseForgeBackdropView: UIView {
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
        fatalError(TinkieVerseCipherTrail.singBack("ibndilth(McLogdgerrq:Y)M WhuassH Cnpoktu DbseweSnY jixmPpQliesmTepnntJeDdN"))
    }
}
