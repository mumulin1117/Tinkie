import UIKit

final class TinkieSingerTuneEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var onSingerTuneSealed: (() -> Void)?

    private let singerSnapshot: TinkieSingerSnapshot
    private let editScrollStage = UIScrollView()
    private let editContentStage = UIView()
    private let heroPortraitBackdropView = UIImageView()
    private let avatarPortraitView = UIButton()
    private let singerNameTuneBox = UITextField()
    private let signatureTuneField = UITextField()
    private var confirmBottomTether: NSLayoutConstraint?
    private var chosenPortraitPath: String?

    init(singerSnapshot: TinkieSingerSnapshot) {
        self.singerSnapshot = singerSnapshot
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        putSingerTuneEditStageTogether()
        listenForSingerEditKeyboard()
    }

    private func putSingerTuneEditStageTogether() {
        view.backgroundColor = .white
        editScrollStage.contentInsetAdjustmentBehavior = .never
        editScrollStage.translatesAutoresizingMaskIntoConstraints = false
        editScrollStage.alwaysBounceVertical = true
        editScrollStage.keyboardDismissMode = .interactive
        view.addSubview(editScrollStage)
        self.avatarPortraitView.setBackgroundImage(UIImage(named: "takeimageimge"), for: .normal)
        editContentStage.translatesAutoresizingMaskIntoConstraints = false
        editScrollStage.addSubview(editContentStage)

        chosenPortraitPath = singerSnapshot.heroImagePath

        heroPortraitBackdropView.image = singerPortraitArtwork()
        heroPortraitBackdropView.contentMode = .scaleAspectFill
        heroPortraitBackdropView.clipsToBounds = true
        heroPortraitBackdropView.translatesAutoresizingMaskIntoConstraints = false
        editContentStage.addSubview(heroPortraitBackdropView)

        let shadeView = TinkieBottomShadeView()
        shadeView.translatesAutoresizingMaskIntoConstraints = false
        heroPortraitBackdropView.addSubview(shadeView)

        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.contentHorizontalAlignment = .leading
        backButton.addTarget(self, action: #selector(closeRhythmSettingsTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        editContentStage.addSubview(backButton)

        let titleLabel = UILabel()
        titleLabel.text = "Edit profile"
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        editContentStage.addSubview(titleLabel)

        let editTuneCard = UIView()
        editTuneCard.backgroundColor = .white
        editTuneCard.layer.cornerRadius = 24
        editTuneCard.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        editTuneCard.layer.masksToBounds = true
        editTuneCard.translatesAutoresizingMaskIntoConstraints = false
        editContentStage.addSubview(editTuneCard)

//        avatarPortraitView.image = singerPortraitArtwork()
//        avatarPortraitView.contentMode = .scaleAspectFill
//        avatarPortraitView.layer.cornerRadius = 38
//        avatarPortraitView.layer.borderWidth = 4
//        avatarPortraitView.layer.borderColor = UIColor.white.cgColor
//        avatarPortraitView.layer.masksToBounds = true
        avatarPortraitView.translatesAutoresizingMaskIntoConstraints = false
//        editTuneCard.addSubview(avatarPortraitView)
        editContentStage.addSubview(avatarPortraitView)
//        let portraitButton = UIButton(type: .custom)
        avatarPortraitView.accessibilityLabel = "Update Tinkie profile portrait"
        avatarPortraitView.addTarget(self, action: #selector(portraitTuneBeatTapped), for: .touchUpInside)
        avatarPortraitView.translatesAutoresizingMaskIntoConstraints = false
//        editTuneCard.addSubview(portraitButton)

        let nameLabel = makeSingerTuneFieldMark("Nickname")
        editTuneCard.addSubview(nameLabel)
        tuneSingerEditField(singerNameTuneBox, text: singerSnapshot.nickname, placeholder: "Miko")
        editTuneCard.addSubview(singerNameTuneBox)

        let signatureLabel = makeSingerTuneFieldMark("Character Bio")
        editTuneCard.addSubview(signatureLabel)
        tuneSingerEditField(signatureTuneField, text: singerSnapshot.signature, placeholder: "Write a brief backstory or character intro.")
        editTuneCard.addSubview(signatureTuneField)

        let confirmButton = TinkieRhythmSettingsBeatButton(tuneTitle: "Confirm", tuneSymbolName: nil)
        confirmButton.addTarget(self, action: #selector(confirmSingerTuneBeat), for: .touchUpInside)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        editTuneCard.addSubview(confirmButton)

        NSLayoutConstraint.activate([
            editScrollStage.topAnchor.constraint(equalTo: view.topAnchor),
            editScrollStage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            editScrollStage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            editScrollStage.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            editContentStage.topAnchor.constraint(equalTo: editScrollStage.contentLayoutGuide.topAnchor),
            editContentStage.leadingAnchor.constraint(equalTo: editScrollStage.contentLayoutGuide.leadingAnchor),
            editContentStage.trailingAnchor.constraint(equalTo: editScrollStage.contentLayoutGuide.trailingAnchor),
            editContentStage.bottomAnchor.constraint(equalTo: editScrollStage.contentLayoutGuide.bottomAnchor),
            editContentStage.widthAnchor.constraint(equalTo: editScrollStage.frameLayoutGuide.widthAnchor),
            editContentStage.heightAnchor.constraint(greaterThanOrEqualTo: editScrollStage.frameLayoutGuide.heightAnchor),

            heroPortraitBackdropView.topAnchor.constraint(equalTo: editContentStage.topAnchor),
            heroPortraitBackdropView.leadingAnchor.constraint(equalTo: editContentStage.leadingAnchor),
            heroPortraitBackdropView.trailingAnchor.constraint(equalTo: editContentStage.trailingAnchor),
            heroPortraitBackdropView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.39),

            shadeView.leadingAnchor.constraint(equalTo: heroPortraitBackdropView.leadingAnchor),
            shadeView.trailingAnchor.constraint(equalTo: heroPortraitBackdropView.trailingAnchor),
            shadeView.bottomAnchor.constraint(equalTo: heroPortraitBackdropView.bottomAnchor),
            shadeView.heightAnchor.constraint(equalTo: heroPortraitBackdropView.heightAnchor, multiplier: 0.52),

            backButton.topAnchor.constraint(equalTo: editContentStage.safeAreaLayoutGuide.topAnchor, constant: 18),
            backButton.leadingAnchor.constraint(equalTo: editContentStage.leadingAnchor, constant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 48),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: editContentStage.centerXAnchor),

            editTuneCard.topAnchor.constraint(equalTo: heroPortraitBackdropView.bottomAnchor, constant: -24),
            editTuneCard.leadingAnchor.constraint(equalTo: editContentStage.leadingAnchor),
            editTuneCard.trailingAnchor.constraint(equalTo: editContentStage.trailingAnchor),
            editTuneCard.bottomAnchor.constraint(equalTo: editContentStage.bottomAnchor),

            avatarPortraitView.centerXAnchor.constraint(equalTo: editTuneCard.centerXAnchor),
            avatarPortraitView.topAnchor.constraint(equalTo: editTuneCard.topAnchor, constant: -40),
            avatarPortraitView.widthAnchor.constraint(equalToConstant: 66),
            avatarPortraitView.heightAnchor.constraint(equalToConstant: 34),

//            portraitButton.centerXAnchor.constraint(equalTo: avatarPortraitView.centerXAnchor),
//            portraitButton.centerYAnchor.constraint(equalTo: avatarPortraitView.centerYAnchor),
//            portraitButton.widthAnchor.constraint(equalToConstant: 92),
//            portraitButton.heightAnchor.constraint(equalToConstant: 92),

            nameLabel.topAnchor.constraint(equalTo: avatarPortraitView.bottomAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: editTuneCard.leadingAnchor, constant: 26),
            nameLabel.trailingAnchor.constraint(equalTo: editTuneCard.trailingAnchor, constant: -26),

            singerNameTuneBox.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            singerNameTuneBox.leadingAnchor.constraint(equalTo: editTuneCard.leadingAnchor, constant: 26),
            singerNameTuneBox.trailingAnchor.constraint(equalTo: editTuneCard.trailingAnchor, constant: -26),
            singerNameTuneBox.heightAnchor.constraint(equalToConstant: 48),

            signatureLabel.topAnchor.constraint(equalTo: singerNameTuneBox.bottomAnchor, constant: 22),
            signatureLabel.leadingAnchor.constraint(equalTo: singerNameTuneBox.leadingAnchor),
            signatureLabel.trailingAnchor.constraint(equalTo: singerNameTuneBox.trailingAnchor),

            signatureTuneField.topAnchor.constraint(equalTo: signatureLabel.bottomAnchor, constant: 10),
            signatureTuneField.leadingAnchor.constraint(equalTo: singerNameTuneBox.leadingAnchor),
            signatureTuneField.trailingAnchor.constraint(equalTo: singerNameTuneBox.trailingAnchor),
            signatureTuneField.heightAnchor.constraint(equalToConstant: 48),

            confirmButton.leadingAnchor.constraint(equalTo: editTuneCard.leadingAnchor, constant: 26),
            confirmButton.trailingAnchor.constraint(equalTo: editTuneCard.trailingAnchor, constant: -26),
            confirmButton.heightAnchor.constraint(equalToConstant: 46),
            confirmButton.topAnchor.constraint(greaterThanOrEqualTo: signatureTuneField.bottomAnchor, constant: 52)
        ])
        confirmBottomTether = confirmButton.bottomAnchor.constraint(equalTo: editTuneCard.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        confirmBottomTether?.isActive = true
    }

    private func makeSingerTuneFieldMark(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func tuneSingerEditField(_ field: UITextField, text: String, placeholder: String) {
        field.text = text
        field.placeholder = placeholder
        field.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        field.textColor = UIColor.black.withAlphaComponent(0.76)
        field.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        field.layer.cornerRadius = 9
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 1))
        field.leftViewMode = .always
        field.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        field.rightViewMode = .always
        field.clearButtonMode = .whileEditing
        field.translatesAutoresizingMaskIntoConstraints = false
    }

    private func singerPortraitArtwork() -> UIImage? {
        if let path = singerSnapshot.heroImagePath, let image = UIImage(contentsOfFile: path) {
            return image
        }
        return UIImage(named: singerSnapshot.heroImageName)
    }

    private func listenForSingerEditKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(endSingerTuneTyping))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func confirmSingerTuneBeat() {
        guard TinkieSingerStageScorebook.retuneCurrentSinger(nickname: singerNameTuneBox.text ?? "", signature: signatureTuneField.text ?? "", heroImagePath: chosenPortraitPath) else {
            tinkieShowTuneNotice(title: "Tinkie", detail: "Please enter a nickname.")
            return
        }
        onSingerTuneSealed?()
        dismiss(animated: true)
    }

    @objc private func closeRhythmSettingsTapped() {
        dismiss(animated: true)
    }

    @objc private func portraitTuneBeatTapped() {
        let sheet = UIAlertController(title: "Profile Portrait", message: "Refresh your Tinkie stage look.", preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            sheet.addAction(UIAlertAction(title: "Take Photo", style: .default) { [weak self] _ in
                self?.openPortraitTuneSource(source: .camera)
            })
        }
        sheet.addAction(UIAlertAction(title: "Choose From Library", style: .default) { [weak self] _ in
            self?.openPortraitTuneSource(source: .photoLibrary)
        })
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        sheet.popoverPresentationController?.sourceView = avatarPortraitView
        sheet.popoverPresentationController?.sourceRect = avatarPortraitView.bounds
        present(sheet, animated: true)
    }

    private func openPortraitTuneSource(source: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(source) else { return }
        let picker = UIImagePickerController()
        picker.sourceType = source
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    private func storeSingerPortraitArtwork(_ image: UIImage) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.84) else { return nil }
        let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("tinkie_profile_avatars", isDirectory: true)
        do {
            try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
            let file = folder.appendingPathComponent("tinkie_profile_portrait_\(UUID().uuidString).jpg")
            try data.write(to: file)
            return file.path
        } catch {
            return nil
        }
    }

    @objc private func endSingerTuneTyping() {
        view.endEditing(true)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let bottom = frame.height - view.safeAreaInsets.bottom + 16
        editScrollStage.contentInset.bottom = bottom
        editScrollStage.verticalScrollIndicatorInsets.bottom = bottom
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        editScrollStage.contentInset.bottom = view.safeAreaInsets.bottom + 20
        editScrollStage.verticalScrollIndicatorInsets.bottom = editScrollStage.contentInset.bottom
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let pickedImage = (info[.editedImage] ?? info[.originalImage]) as? UIImage
        picker.dismiss(animated: true) { [weak self] in
            guard let self, let pickedImage else { return }
            self.heroPortraitBackdropView.image = pickedImage
//            self.avatarPortraitView.image = pickedImage
            self.chosenPortraitPath = self.storeSingerPortraitArtwork(pickedImage)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
