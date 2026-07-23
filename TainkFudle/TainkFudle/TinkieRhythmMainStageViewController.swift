import UIKit

final class TinkieRhythmMainStageViewController: UIViewController {
    private let mainRhythmStageBox = UIView()
    private let rhythmTabBar = UIView()
    private let discoverRhythmTab = TinkieRhythmTabButton(
        title: TinkieVerseCipherTrail.singBack("DFiAsbcMoxvfeuri"),
        idleAssetName: "tinkie_tab_discover_active",
        activeAssetName: "tinkie_tab_discover_idle"
    )
    private let reelRhythmTab = TinkieRhythmTabButton(
        title: TinkieVerseCipherTrail.singBack("RMeWeflisn"),
        idleAssetName: "tinkie_tab_reels_idle",
        activeAssetName: "tinkie_tab_reels_active"
    )
    private let singerRhythmTab = TinkieRhythmTabButton(
        title: TinkieVerseCipherTrail.singBack("MYef"),
        idleAssetName: "tinkie_tab_me_idle",
        activeAssetName: "tinkie_tab_me_active"
    )
    private let discoverController = TinkieSongQuestDiscoverViewController()
    private let pulseController = TinkieRhythmSparkStreamViewController()
    private let singerNestController = TinkieSingerNestViewController()
    private var currentRhythmStageController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 0.98, alpha: 1)
        discoverController.onChallengeCuePicked = { [weak self] challengeCue in
            self?.openMelodyChallengeDetail(challengeCue)
        }
        putRhythmTabsTogether()
        switchRhythmStage(to: discoverController, activeRhythmTab: discoverRhythmTab)
    }

    private func putRhythmTabsTogether() {
        mainRhythmStageBox.translatesAutoresizingMaskIntoConstraints = false
        rhythmTabBar.translatesAutoresizingMaskIntoConstraints = false
        rhythmTabBar.backgroundColor = UIColor(red: 0.02, green: 0.04, blue: 0.04, alpha: 0.98)
        rhythmTabBar.layer.cornerRadius = 28
        rhythmTabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        rhythmTabBar.layer.masksToBounds = true

        view.addSubview(mainRhythmStageBox)
        view.addSubview(rhythmTabBar)

        let rhythmTabStack = UIStackView(arrangedSubviews: [discoverRhythmTab, reelRhythmTab, singerRhythmTab])
        rhythmTabStack.axis = .horizontal
        rhythmTabStack.distribution = .fillEqually
        rhythmTabStack.translatesAutoresizingMaskIntoConstraints = false
        rhythmTabBar.addSubview(rhythmTabStack)

        NSLayoutConstraint.activate([
            mainRhythmStageBox.topAnchor.constraint(equalTo: view.topAnchor),
            mainRhythmStageBox.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainRhythmStageBox.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainRhythmStageBox.bottomAnchor.constraint(equalTo: rhythmTabBar.topAnchor),

            rhythmTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rhythmTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rhythmTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            rhythmTabBar.heightAnchor.constraint(equalToConstant: 86),

            rhythmTabStack.topAnchor.constraint(equalTo: rhythmTabBar.topAnchor, constant: 8),
            rhythmTabStack.leadingAnchor.constraint(equalTo: rhythmTabBar.leadingAnchor, constant: 18),
            rhythmTabStack.trailingAnchor.constraint(equalTo: rhythmTabBar.trailingAnchor, constant: -18),
            rhythmTabStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -4)
        ])

        discoverRhythmTab.addTarget(self, action: #selector(openDiscoverRhythm), for: .touchUpInside)
        reelRhythmTab.addTarget(self, action: #selector(openPulseRhythm), for: .touchUpInside)
        singerRhythmTab.addTarget(self, action: #selector(openSingerNest), for: .touchUpInside)
    }

    @objc private func openDiscoverRhythm() {
        switchRhythmStage(to: discoverController, activeRhythmTab: discoverRhythmTab)
    }

    @objc private func openPulseRhythm() {
        switchRhythmStage(to: pulseController, activeRhythmTab: reelRhythmTab)
    }

    @objc private func openSingerNest() {
        switchRhythmStage(to: singerNestController, activeRhythmTab: singerRhythmTab)
    }

    private func switchRhythmStage(to controller: UIViewController, activeRhythmTab: TinkieRhythmTabButton) {
        guard currentRhythmStageController !== controller else { return }
        currentRhythmStageController?.willMove(toParent: nil)
        currentRhythmStageController?.view.removeFromSuperview()
        currentRhythmStageController?.removeFromParent()

        addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        mainRhythmStageBox.addSubview(controller.view)
        NSLayoutConstraint.activate([
            controller.view.topAnchor.constraint(equalTo: mainRhythmStageBox.topAnchor),
            controller.view.leadingAnchor.constraint(equalTo: mainRhythmStageBox.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: mainRhythmStageBox.trailingAnchor),
            controller.view.bottomAnchor.constraint(equalTo: mainRhythmStageBox.bottomAnchor)
        ])
        controller.didMove(toParent: self)
        currentRhythmStageController = controller

        for rhythmTab in [discoverRhythmTab, reelRhythmTab, singerRhythmTab] {
            rhythmTab.isSelected = (rhythmTab === activeRhythmTab)
        }
    }

    private func openMelodyChallengeDetail(_ challengeCue: TinkieMelodyChallengeCue) {
        let questDetail = TinkieSongQuestDetailViewController(event: challengeCue)
        let navigation = UINavigationController(rootViewController: questDetail)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }
}
