import UIKit

final class TinMainkTuneGuess: UIViewController {
    private let pageContainer = UIView()
    private let bottomBar = UIView()
    private let discoverButton = TinkieTabButton(
        title: "Discover",
        idleAssetName: "tinkie_tab_discover_active",
        activeAssetName: "tinkie_tab_discover_idle"
    )
    private let reelsButton = TinkieTabButton(
        title: "Reels",
        idleAssetName: "tinkie_tab_reels_idle",
        activeAssetName: "tinkie_tab_reels_active"
    )
    private let meButton = TinkieTabButton(
        title: "Me",
        idleAssetName: "tinkie_tab_me_idle",
        activeAssetName: "tinkie_tab_me_active"
    )
    private let discoverController = TinkieBassDeckller()
    private let reelsController = TinkiTRefrainVaulter()
    private let meController = TinkieRefrainWaveller()
    private var selectedController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 0.98, alpha: 1)
        discoverController.onSelectEvent = { [weak self] event in
            self?.openEventDetail(event)
        }
        buildRootLayout()
        select(discoverController, selectedButton: discoverButton)
    }

    private func buildRootLayout() {
        pageContainer.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.backgroundColor = UIColor(red: 0.02, green: 0.04, blue: 0.04, alpha: 0.98)
        bottomBar.layer.cornerRadius = 28
        bottomBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomBar.layer.masksToBounds = true

        view.addSubview(pageContainer)
        view.addSubview(bottomBar)

        let stack = UIStackView(arrangedSubviews: [discoverButton, reelsButton, meButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.addSubview(stack)

        NSLayoutConstraint.activate([
            pageContainer.topAnchor.constraint(equalTo: view.topAnchor),
            pageContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageContainer.bottomAnchor.constraint(equalTo: bottomBar.topAnchor),

            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomBar.heightAnchor.constraint(equalToConstant: 86),

            stack.topAnchor.constraint(equalTo: bottomBar.topAnchor, constant: 8),
            stack.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor, constant: 18),
            stack.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor, constant: -18),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -4)
        ])

        discoverButton.addTarget(self, action: #selector(showDiscover), for: .touchUpInside)
        reelsButton.addTarget(self, action: #selector(showReels), for: .touchUpInside)
        meButton.addTarget(self, action: #selector(showMe), for: .touchUpInside)
    }

    @objc private func showDiscover() {
        select(discoverController, selectedButton: discoverButton)
    }

    @objc private func showReels() {
        select(reelsController, selectedButton: reelsButton)
    }

    @objc private func showMe() {
        select(meController, selectedButton: meButton)
    }

    private func select(_ controller: UIViewController, selectedButton: TinkieTabButton) {
        guard selectedController !== controller else { return }
        selectedController?.willMove(toParent: nil)
        selectedController?.view.removeFromSuperview()
        selectedController?.removeFromParent()

        addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        pageContainer.addSubview(controller.view)
        NSLayoutConstraint.activate([
            controller.view.topAnchor.constraint(equalTo: pageContainer.topAnchor),
            controller.view.leadingAnchor.constraint(equalTo: pageContainer.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: pageContainer.trailingAnchor),
            controller.view.bottomAnchor.constraint(equalTo: pageContainer.bottomAnchor)
        ])
        controller.didMove(toParent: self)
        selectedController = controller

        for button in [discoverButton, reelsButton, meButton] {
            button.isSelected = (button === selectedButton)
        }
    }

    private func openEventDetail(_ event: TinkieLyricFlow) {
        let detail = TinkieHookRadarer(event: event)
        let navigation = UINavigationController(rootViewController: detail)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }
}
