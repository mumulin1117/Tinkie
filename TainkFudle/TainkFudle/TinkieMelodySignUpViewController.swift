import UIKit

final class TinkieMelodySignUpViewController: TinkieMelodyGateScrollViewController {
    var onMelodyGateUnlocked: (() -> Void)?
    private let singerNameTuneBox = TinkieMelodyGateEntryBox(iconName: "tinkie_auth_name_mark", placeholder: "Enter your name")
    private let mailTuneEntryBox = TinkieMelodyGateEntryBox(iconName: "tinkie_auth_email_mark", placeholder: "Enter your email address")
    private let secretTuneEntryBox = TinkieMelodyGateEntryBox(iconName: "tinkie_auth_lock_mark", placeholder: "Enter your password", secure: true)
    private let singerFaceBeatButton = UIButton()
    private let faceCameraBeatButton = UIButton()
    private var pickedSingerFacePath: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        layNeonMelodyGateStage(backgroundName: "tinkie_auth_signup_neon_backdrop")
        putSingerSignUpTuneTogether()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func putSingerSignUpTuneTogether() {
        dropGateBackBeat()

        let signupBigWords = UILabel()
        signupBigWords.text = "Sign up"
        signupBigWords.textColor = .white
        signupBigWords.font = UIFont.systemFont(ofSize: 34, weight: .black)
        signupBigWords.textAlignment = .center

        singerFaceBeatButton.setBackgroundImage(UIImage(named: "tinkie_auth_user_placeholder"), for: .normal)
        singerFaceBeatButton.layer.cornerRadius = 45
        singerFaceBeatButton.layer.masksToBounds = true
        singerFaceBeatButton.imageView?.contentMode = .scaleAspectFit
        singerFaceBeatButton.addTarget(self, action: #selector(singerFaceBeatTapped), for: .touchUpInside)
        singerFaceBeatButton.translatesAutoresizingMaskIntoConstraints = false

        faceCameraBeatButton.setBackgroundImage(UIImage(named: "tinkie_auth_camera_mark"), for: .normal)
        faceCameraBeatButton.addTarget(self, action: #selector(singerFaceBeatTapped), for: .touchUpInside)
        faceCameraBeatButton.isUserInteractionEnabled = true
        faceCameraBeatButton.translatesAutoresizingMaskIntoConstraints = false

        let faceCircleSpot = UIView()
        faceCircleSpot.translatesAutoresizingMaskIntoConstraints = false
        faceCircleSpot.addSubview(singerFaceBeatButton)
        faceCircleSpot.addSubview(faceCameraBeatButton)

        mailTuneEntryBox.melodyTextField.keyboardType = .emailAddress
        secretTuneEntryBox.melodyTextField.textContentType = .newPassword

        let joinTuneButton = TinkieMelodyGateBlackBeatButton(title: "Continue")
        joinTuneButton.addTarget(self, action: #selector(continueMelodyGateTapped), for: .touchUpInside)

        let signupTuneStack = UIStackView(arrangedSubviews: [signupBigWords, faceCircleSpot, singerNameTuneBox, mailTuneEntryBox, secretTuneEntryBox, joinTuneButton])
        signupTuneStack.axis = .vertical
        signupTuneStack.spacing = 22
        signupTuneStack.translatesAutoresizingMaskIntoConstraints = false
        melodyGateBoardStage.addSubview(signupTuneStack)

        NSLayoutConstraint.activate([
            signupTuneStack.leadingAnchor.constraint(equalTo: melodyGateBoardStage.leadingAnchor, constant: 20),
            signupTuneStack.trailingAnchor.constraint(equalTo: melodyGateBoardStage.trailingAnchor, constant: -20),
            signupTuneStack.topAnchor.constraint(equalTo: melodyGateBoardStage.safeAreaLayoutGuide.topAnchor, constant: 112),
            signupTuneStack.bottomAnchor.constraint(lessThanOrEqualTo: melodyGateBoardStage.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            signupBigWords.heightAnchor.constraint(equalToConstant: 52),
            faceCircleSpot.heightAnchor.constraint(equalToConstant: 126),

            singerFaceBeatButton.centerXAnchor.constraint(equalTo: faceCircleSpot.centerXAnchor),
            singerFaceBeatButton.topAnchor.constraint(equalTo: faceCircleSpot.topAnchor),
            singerFaceBeatButton.widthAnchor.constraint(equalToConstant: 90),
            singerFaceBeatButton.heightAnchor.constraint(equalToConstant: 90),

            faceCameraBeatButton.centerXAnchor.constraint(equalTo: singerFaceBeatButton.centerXAnchor),
            faceCameraBeatButton.topAnchor.constraint(equalTo: singerFaceBeatButton.bottomAnchor, constant: -20),
            faceCameraBeatButton.widthAnchor.constraint(equalToConstant: 66),
            faceCameraBeatButton.heightAnchor.constraint(equalToConstant: 34)
        ])
    }

    @objc private func singerFaceBeatTapped() {
        view.endEditing(true)
        let faceChoiceSheet = UIAlertController(title: "Profile Avatar", message: "Take a photo or choose one for your local Tinkie profile.", preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            faceChoiceSheet.addAction(UIAlertAction(title: "Take Photo", style: .default) { [weak self] _ in
                self?.openSingerFacePicker(source: .camera)
            })
        }
        faceChoiceSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default) { [weak self] _ in
            self?.openSingerFacePicker(source: .photoLibrary)
        })
        faceChoiceSheet.addAction(UIAlertAction(title: "Use Default Avatar", style: .default) { [weak self] _ in
            self?.pickedSingerFacePath = nil
            self?.singerFaceBeatButton.setBackgroundImage(UIImage(named: "tinkie_auth_user_placeholder"), for: .normal)
        })
        faceChoiceSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        faceChoiceSheet.popoverPresentationController?.sourceView = singerFaceBeatButton
        faceChoiceSheet.popoverPresentationController?.sourceRect = singerFaceBeatButton.bounds
        present(faceChoiceSheet, animated: true)
    }

    @objc private func continueMelodyGateTapped() {
        let signupResult = TinkieMelodyGateScorebook.makeFreshSingerCard(
            singerName: singerNameTuneBox.melodyTextField.text ?? "",
            mailText: mailTuneEntryBox.melodyTextField.text ?? "",
            secretText: secretTuneEntryBox.melodyTextField.text ?? "",
            facePath: pickedSingerFacePath
        )
        switch signupResult {
        case .melodyOpened:
            onMelodyGateUnlocked?()
        case .melodyBlocked(let hintWords):
            showMelodyGateHint(hintWords)
        }
    }

    private func openSingerFacePicker(source: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(source) else {
            showMelodyGateHint("This avatar source is not available on this device.")
            return
        }
        let facePicker = UIImagePickerController()
        facePicker.sourceType = source
        facePicker.allowsEditing = true
        facePicker.delegate = self
        present(facePicker, animated: true)
    }

    private func saveSingerFaceArtwork(_ image: UIImage) -> String? {
        guard let faceJpegPack = image.jpegData(compressionQuality: 0.82) else { return nil }
        let faceFolder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("tinkie_profile_avatars", isDirectory: true)
        do {
            try FileManager.default.createDirectory(at: faceFolder, withIntermediateDirectories: true)
            let faceFile = faceFolder.appendingPathComponent("tinkie_profile_avatar_\(UUID().uuidString).jpg")
            try faceJpegPack.write(to: faceFile, options: .atomic)
            return faceFile.path
        } catch {
            return nil
        }
    }
}

extension TinkieMelodySignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ facePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let pickedFace = (info[.editedImage] as? UIImage) ?? (info[.originalImage] as? UIImage)
        facePicker.dismiss(animated: true) { [weak self] in
            guard let self, let pickedFace else { return }
            guard let facePath = self.saveSingerFaceArtwork(pickedFace) else {
                self.showMelodyGateHint("Avatar upload failed. Please try again.")
                return
            }
            self.pickedSingerFacePath = facePath
            self.singerFaceBeatButton.setBackgroundImage(pickedFace, for: .normal)
            self.showMelodyGateHint("Avatar uploaded to your local Tinkie profile.")
        }
    }

    func imagePickerControllerDidCancel(_ facePicker: UIImagePickerController) {
        facePicker.dismiss(animated: true)
    }
}
