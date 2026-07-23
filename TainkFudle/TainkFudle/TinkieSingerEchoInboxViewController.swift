import UIKit

final class TinkieSingerEchoInboxViewController: UIViewController {
    private let echoScrollStage = UIScrollView()
    private let echoCanvasView = UIView()
    private let emptyEchoImageView = UIImageView(image: UIImage(named: "tinkie_profile_empty_record"))
    private let emptyEchoTitleLabel = UILabel()
    private let emptyEchoDetailLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        putSingerEchoQuietStageTogether()
    }

    private func putSingerEchoQuietStageTogether() {
        view.backgroundColor = UIColor(red: 0.96, green: 0.98, blue: 0.98, alpha: 1)
        let glow = TinkieTopGlowView(); glow.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(glow); echoScrollStage.contentInsetAdjustmentBehavior = .never
        echoScrollStage.translatesAutoresizingMaskIntoConstraints = false; echoScrollStage.alwaysBounceVertical = true; echoScrollStage.showsVerticalScrollIndicator = false; view.addSubview(echoScrollStage)
        echoCanvasView.translatesAutoresizingMaskIntoConstraints = false; echoScrollStage.addSubview(echoCanvasView)
        let backTuneButton = UIButton(type: .system); backTuneButton.setImage(UIImage(systemName: "chevron.left"), for: .normal); backTuneButton.tintColor = .black; backTuneButton.contentHorizontalAlignment = .leading
        backTuneButton.addTarget(self, action: #selector(closeSingerEchoTapped), for: .touchUpInside); backTuneButton.translatesAutoresizingMaskIntoConstraints = false; echoCanvasView.addSubview(backTuneButton)
        let inboxTitleTuneLabel = UILabel(); inboxTitleTuneLabel.text = TinkieVerseCipherTrail.singBack("MneAsmsLadgWes"); inboxTitleTuneLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold); inboxTitleTuneLabel.textColor = .black
        inboxTitleTuneLabel.textAlignment = .center; inboxTitleTuneLabel.translatesAutoresizingMaskIntoConstraints = false; echoCanvasView.addSubview(inboxTitleTuneLabel)
        let echoShellView = UIView(); echoShellView.backgroundColor = UIColor.white.withAlphaComponent(0.94); echoShellView.layer.cornerRadius = 28; echoShellView.layer.masksToBounds = true
        echoShellView.translatesAutoresizingMaskIntoConstraints = false; echoCanvasView.addSubview(echoShellView)
        emptyEchoImageView.contentMode = .scaleAspectFit; emptyEchoImageView.translatesAutoresizingMaskIntoConstraints = false; echoShellView.addSubview(emptyEchoImageView)
        emptyEchoTitleLabel.text = TinkieVerseCipherTrail.singBack("NToP RfurUiOegnmdN emfeJsjsZaxgKeasX QyCedtd"); emptyEchoTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold); emptyEchoTitleLabel.textColor = UIColor.black.withAlphaComponent(0.82); emptyEchoTitleLabel.textAlignment = .center
        emptyEchoTitleLabel.numberOfLines = 0; emptyEchoTitleLabel.translatesAutoresizingMaskIntoConstraints = false; echoShellView.addSubview(emptyEchoTitleLabel)
        emptyEchoDetailLabel.text = TinkieVerseCipherTrail.singBack("MkuKtZuFabln DfgoslllToJwosJ NaVnZdx GTqitnbkyiFex hseoPnVgQ KrpohuRnIdoss jwsiLlPlt XaJpKpreraNrP zhNeUrTeZ PwHhPeXnF nav afCrcibeTnBdn LsItVaDrHtrsd kaj fcfoSnCvhemrtszaPtHiHopnj.H"); emptyEchoDetailLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular); emptyEchoDetailLabel.textColor = UIColor.black.withAlphaComponent(0.48); emptyEchoDetailLabel.textAlignment = .center
        emptyEchoDetailLabel.numberOfLines = 0; emptyEchoDetailLabel.translatesAutoresizingMaskIntoConstraints = false; echoShellView.addSubview(emptyEchoDetailLabel)
        pinSingerEchoQuietStageBeat1(glow: glow, backTuneButton: backTuneButton); pinSingerEchoQuietStageBeat2(backTuneButton: backTuneButton, inboxTitleTuneLabel: inboxTitleTuneLabel, echoShellView: echoShellView); pinSingerEchoQuietStageBeat3(echoShellView: echoShellView)
    }

    private func pinSingerEchoQuietStageBeat1(glow: TinkieTopGlowView, backTuneButton: UIButton) {
        NSLayoutConstraint.activate([
            glow.topAnchor.constraint(equalTo: view.topAnchor),
            glow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            glow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            glow.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.52),
            
            echoScrollStage.topAnchor.constraint(equalTo: view.topAnchor),
            echoScrollStage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            echoScrollStage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            echoScrollStage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            echoCanvasView.topAnchor.constraint(equalTo: echoScrollStage.contentLayoutGuide.topAnchor),
            echoCanvasView.leadingAnchor.constraint(equalTo: echoScrollStage.contentLayoutGuide.leadingAnchor),
            echoCanvasView.trailingAnchor.constraint(equalTo: echoScrollStage.contentLayoutGuide.trailingAnchor),
            echoCanvasView.bottomAnchor.constraint(equalTo: echoScrollStage.contentLayoutGuide.bottomAnchor),
            echoCanvasView.widthAnchor.constraint(equalTo: echoScrollStage.frameLayoutGuide.widthAnchor),
            echoCanvasView.heightAnchor.constraint(greaterThanOrEqualTo: echoScrollStage.frameLayoutGuide.heightAnchor),
            
            backTuneButton.topAnchor.constraint(equalTo: echoCanvasView.safeAreaLayoutGuide.topAnchor, constant: 38),
            backTuneButton.leadingAnchor.constraint(equalTo: echoCanvasView.leadingAnchor, constant: 24),
            backTuneButton.widthAnchor.constraint(equalToConstant: 48),
            backTuneButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    private func pinSingerEchoQuietStageBeat2(backTuneButton: UIButton, inboxTitleTuneLabel: UILabel, echoShellView: UIView) {
        NSLayoutConstraint.activate([
            
            inboxTitleTuneLabel.centerYAnchor.constraint(equalTo: backTuneButton.centerYAnchor),
            inboxTitleTuneLabel.centerXAnchor.constraint(equalTo: echoCanvasView.centerXAnchor),
            inboxTitleTuneLabel.leadingAnchor.constraint(greaterThanOrEqualTo: backTuneButton.trailingAnchor, constant: 12),
            
            echoShellView.topAnchor.constraint(equalTo: inboxTitleTuneLabel.bottomAnchor, constant: 48),
            echoShellView.leadingAnchor.constraint(equalTo: echoCanvasView.leadingAnchor, constant: 24),
            echoShellView.trailingAnchor.constraint(equalTo: echoCanvasView.trailingAnchor, constant: -24),
            echoShellView.heightAnchor.constraint(greaterThanOrEqualToConstant: 330),
            echoShellView.bottomAnchor.constraint(lessThanOrEqualTo: echoCanvasView.safeAreaLayoutGuide.bottomAnchor, constant: -28),
            
            emptyEchoImageView.centerXAnchor.constraint(equalTo: echoShellView.centerXAnchor),
            emptyEchoImageView.topAnchor.constraint(equalTo: echoShellView.topAnchor, constant: 64),
            emptyEchoImageView.widthAnchor.constraint(lessThanOrEqualTo: echoShellView.widthAnchor, multiplier: 0.64),
            emptyEchoImageView.heightAnchor.constraint(equalToConstant: 132),
            
            emptyEchoTitleLabel.topAnchor.constraint(equalTo: emptyEchoImageView.bottomAnchor, constant: 22),
            emptyEchoTitleLabel.leadingAnchor.constraint(equalTo: echoShellView.leadingAnchor, constant: 28),
            emptyEchoTitleLabel.trailingAnchor.constraint(equalTo: echoShellView.trailingAnchor, constant: -28),
            
            emptyEchoDetailLabel.topAnchor.constraint(equalTo: emptyEchoTitleLabel.bottomAnchor, constant: 10),
            emptyEchoDetailLabel.leadingAnchor.constraint(equalTo: echoShellView.leadingAnchor, constant: 30),
            emptyEchoDetailLabel.trailingAnchor.constraint(equalTo: echoShellView.trailingAnchor, constant: -30)
        ])
    }

    private func pinSingerEchoQuietStageBeat3(echoShellView: UIView) {
        NSLayoutConstraint.activate([
            emptyEchoDetailLabel.bottomAnchor.constraint(lessThanOrEqualTo: echoShellView.bottomAnchor, constant: -36)
        ])
    }

    @objc private func closeSingerEchoTapped() {
        dismiss(animated: true)
    }
}
