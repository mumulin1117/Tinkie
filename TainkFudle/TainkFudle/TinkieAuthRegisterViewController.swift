import UIKit

final class TinkieAuthRegisterViewController: TinkieAuthFormViewController {
    var onSuccess: (() -> Void)?
    private let nameField = TinkieAuthInputField(iconName: "tinkie_auth_name_mark", placeholder: "Enter your name")
    private let emailField = TinkieAuthInputField(iconName: "tinkie_auth_email_mark", placeholder: "Enter your email address")
    private let passwordField = TinkieAuthInputField(iconName: "tinkie_auth_lock_mark", placeholder: "Enter your password", secure: true)
    private let avatarButton = UIButton()
    private let cameraBadge = UIButton()
    private var selectedAvatarPath: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        installScrollLayout(backgroundName: "tinkie_auth_signup_neon_backdrop")
        buildLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func buildLayout() {
        addBackButton()

        let titleLabel = UILabel()
        titleLabel.text = "Sign up"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .black)
        titleLabel.textAlignment = .center

        avatarButton.setBackgroundImage(UIImage(named: "tinkie_auth_user_placeholder"), for: .normal)
        avatarButton.layer.cornerRadius = 45
        avatarButton.layer.masksToBounds = true
        avatarButton.imageView?.contentMode = .scaleAspectFit
        avatarButton.addTarget(self, action: #selector(avatarTapped), for: .touchUpInside)
        avatarButton.translatesAutoresizingMaskIntoConstraints = false

        cameraBadge.setBackgroundImage(UIImage(named: "tinkie_auth_camera_mark"), for: .normal)
        cameraBadge.addTarget(self, action: #selector(avatarTapped), for: .touchUpInside)
        cameraBadge.isUserInteractionEnabled = true
        cameraBadge.translatesAutoresizingMaskIntoConstraints = false

        let avatarWrap = UIView()
        avatarWrap.translatesAutoresizingMaskIntoConstraints = false
        avatarWrap.addSubview(avatarButton)
        avatarWrap.addSubview(cameraBadge)

        emailField.textField.keyboardType = .emailAddress
        passwordField.textField.textContentType = .newPassword

        let actionButton = TinkieAuthPrimaryButton(title: "Continue")
        actionButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [titleLabel, avatarWrap, nameField, emailField, passwordField, actionButton])
        stack.axis = .vertical
        stack.spacing = 22
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stack.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 112),
            stack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            titleLabel.heightAnchor.constraint(equalToConstant: 52),
            avatarWrap.heightAnchor.constraint(equalToConstant: 126),

            avatarButton.centerXAnchor.constraint(equalTo: avatarWrap.centerXAnchor),
            avatarButton.topAnchor.constraint(equalTo: avatarWrap.topAnchor),
            avatarButton.widthAnchor.constraint(equalToConstant: 90),
            avatarButton.heightAnchor.constraint(equalToConstant: 90),

            cameraBadge.centerXAnchor.constraint(equalTo: avatarButton.centerXAnchor),
            cameraBadge.topAnchor.constraint(equalTo: avatarButton.bottomAnchor, constant: -20),
            cameraBadge.widthAnchor.constraint(equalToConstant: 66),
            cameraBadge.heightAnchor.constraint(equalToConstant: 34)
        ])
    }

    @objc private func avatarTapped() {
        view.endEditing(true)
        let picker = UIAlertController(title: "Profile Avatar", message: "Take a photo or choose one for your local Tinkie profile.", preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.addAction(UIAlertAction(title: "Take Photo", style: .default) { [weak self] _ in
                self?.openImagePicker(source: .camera)
            })
        }
        picker.addAction(UIAlertAction(title: "Choose from Library", style: .default) { [weak self] _ in
            self?.openImagePicker(source: .photoLibrary)
        })
        picker.addAction(UIAlertAction(title: "Use Default Avatar", style: .default) { [weak self] _ in
            self?.selectedAvatarPath = nil
            self?.avatarButton.setBackgroundImage(UIImage(named: "tinkie_auth_user_placeholder"), for: .normal)
        })
        picker.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        picker.popoverPresentationController?.sourceView = avatarButton
        picker.popoverPresentationController?.sourceRect = avatarButton.bounds
        present(picker, animated: true)
    }

    @objc private func continueTapped() {
        let result = TinkieAuthStore.register(
            name: nameField.textField.text ?? "",
            email: emailField.textField.text ?? "",
            password: passwordField.textField.text ?? "",
            heroImagePath: selectedAvatarPath
        )
        switch result {
        case .success:
            onSuccess?()
        case .failure(let message):
            showAlert(message)
        }
    }

    private func openImagePicker(source: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(source) else {
            showAlert("This avatar source is not available on this device.")
            return
        }
        let picker = UIImagePickerController()
        picker.sourceType = source
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    private func saveAvatarImage(_ image: UIImage) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.82) else { return nil }
        let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("tinkie_profile_avatars", isDirectory: true)
        do {
            try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
            let file = folder.appendingPathComponent("tinkie_profile_avatar_\(UUID().uuidString).jpg")
            try data.write(to: file, options: .atomic)
            return file.path
        } catch {
            return nil
        }
    }
}

extension TinkieAuthRegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = (info[.editedImage] as? UIImage) ?? (info[.originalImage] as? UIImage)
        picker.dismiss(animated: true) { [weak self] in
            guard let self, let image else { return }
            guard let path = self.saveAvatarImage(image) else {
                self.showAlert("Avatar upload failed. Please try again.")
                return
            }
            self.selectedAvatarPath = path
            self.avatarButton.setBackgroundImage(image, for: .normal)
            self.showAlert("Avatar uploaded to your local Tinkie profile.")
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
