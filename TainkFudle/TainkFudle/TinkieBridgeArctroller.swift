import UIKit

final class TinkieBridgeArctroller: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let emptyImageView = UIImageView(image: UIImage(named: "tinkie_profile_empty_record"))
    private let emptyTitleLabel = UILabel()
    private let emptyDetailLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        buildLayout()
    }

    private func buildLayout() {
        view.backgroundColor = UIColor(red: 0.96, green: 0.98, blue: 0.98, alpha: 1)

        let glow = TinkieTopGlowView()
        glow.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(glow)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.contentHorizontalAlignment = .leading
        backButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backButton)

        let titleLabel = UILabel()
        titleLabel.text = "Message"
        titleLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        let shellView = UIView()
        shellView.backgroundColor = UIColor.white.withAlphaComponent(0.94)
        shellView.layer.cornerRadius = 28
        shellView.layer.masksToBounds = true
        shellView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(shellView)

        emptyImageView.contentMode = .scaleAspectFit
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        shellView.addSubview(emptyImageView)

        emptyTitleLabel.text = "No friend messages yet"
        emptyTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        emptyTitleLabel.textColor = UIColor.black.withAlphaComponent(0.82)
        emptyTitleLabel.textAlignment = .center
        emptyTitleLabel.numberOfLines = 0
        emptyTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        shellView.addSubview(emptyTitleLabel)

        emptyDetailLabel.text = "Mutual follows and Tinkie song rounds will appear here when a friend starts a conversation."
        emptyDetailLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        emptyDetailLabel.textColor = UIColor.black.withAlphaComponent(0.48)
        emptyDetailLabel.textAlignment = .center
        emptyDetailLabel.numberOfLines = 0
        emptyDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        shellView.addSubview(emptyDetailLabel)

        NSLayoutConstraint.activate([
            glow.topAnchor.constraint(equalTo: view.topAnchor),
            glow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            glow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            glow.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.52),

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
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 48),
            backButton.heightAnchor.constraint(equalToConstant: 48),

            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: backButton.trailingAnchor, constant: 12),

            shellView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 48),
            shellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            shellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            shellView.heightAnchor.constraint(greaterThanOrEqualToConstant: 330),
            shellView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -28),

            emptyImageView.centerXAnchor.constraint(equalTo: shellView.centerXAnchor),
            emptyImageView.topAnchor.constraint(equalTo: shellView.topAnchor, constant: 64),
            emptyImageView.widthAnchor.constraint(lessThanOrEqualTo: shellView.widthAnchor, multiplier: 0.64),
            emptyImageView.heightAnchor.constraint(equalToConstant: 132),

            emptyTitleLabel.topAnchor.constraint(equalTo: emptyImageView.bottomAnchor, constant: 22),
            emptyTitleLabel.leadingAnchor.constraint(equalTo: shellView.leadingAnchor, constant: 28),
            emptyTitleLabel.trailingAnchor.constraint(equalTo: shellView.trailingAnchor, constant: -28),

            emptyDetailLabel.topAnchor.constraint(equalTo: emptyTitleLabel.bottomAnchor, constant: 10),
            emptyDetailLabel.leadingAnchor.constraint(equalTo: shellView.leadingAnchor, constant: 30),
            emptyDetailLabel.trailingAnchor.constraint(equalTo: shellView.trailingAnchor, constant: -30),
            emptyDetailLabel.bottomAnchor.constraint(lessThanOrEqualTo: shellView.bottomAnchor, constant: -36)
        ])
    }

    @objc private func closeTapped() {
        dismiss(animated: true)
    }
}
