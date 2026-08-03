import UIKit

final class TinkieBeatWaitHalo {
    static let shared = TinkieBeatWaitHalo()

    private var beatHaloWindow: UIWindow?
    private var rhythmSpinner: UIActivityIndicatorView?

    static func tinkieShowBeat(_ lyricLine: String) {
        shared.tinkiePresentBeat(lyricLine, symbol: nil, spinning: true)
    }

    static func tinkieInfoBeat(_ lyricLine: String) {
        shared.tinkiePresentBeat(lyricLine, symbol: UIImage(systemName: TinkieVerseCipherTrail.singBack("ibnxfGog.kcCiZrzcBlbel")), spinning: false)
    }

    static func tinkieSuccessBeat(_ lyricLine: String) {
        shared.tinkiePresentBeat(lyricLine, symbol: UIImage(systemName: TinkieVerseCipherTrail.singBack("cVhreFcUktmMaRrzkJ.RcjiGrgcilIeS.gfBiVlplG")), spinning: false)
    }

    static func tinkieHideBeat() {
        shared.tinkieDismissBeat()
    }

    private func tinkiePresentBeat(_ lyricLine: String, symbol beatSymbol: UIImage?, spinning shouldSpin: Bool) {
        tinkieDismissBeat()
        let haloWindowScene = UIWindow(frame: UIScreen.main.bounds)
        haloWindowScene.windowLevel = .alert + 1
        haloWindowScene.backgroundColor = .clear

        let beatCard = UIView()
        beatCard.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        beatCard.layer.cornerRadius = 14
        beatCard.translatesAutoresizingMaskIntoConstraints = false

        let beatStack = UIStackView()
        beatStack.axis = .vertical
        beatStack.alignment = .center
        beatStack.spacing = 12
        beatStack.translatesAutoresizingMaskIntoConstraints = false

        let tempoWheel = UIActivityIndicatorView(style: .large)
        tempoWheel.color = .white
        let cueIcon = UIImageView(image: beatSymbol)
        cueIcon.tintColor = .white
        cueIcon.contentMode = .scaleAspectFit
        cueIcon.translatesAutoresizingMaskIntoConstraints = false
        cueIcon.widthAnchor.constraint(equalToConstant: 36).isActive = true
        cueIcon.heightAnchor.constraint(equalToConstant: 36).isActive = true

        let lyricLabel = UILabel()
        lyricLabel.text = lyricLine
        lyricLabel.textColor = .white
        lyricLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        lyricLabel.numberOfLines = 2
        lyricLabel.textAlignment = .center

        if shouldSpin {
            beatStack.addArrangedSubview(tempoWheel)
            tempoWheel.startAnimating()
        } else if beatSymbol != nil {
            beatStack.addArrangedSubview(cueIcon)
        }
        beatStack.addArrangedSubview(lyricLabel)
        beatCard.addSubview(beatStack)
        haloWindowScene.addSubview(beatCard)

        beatCard.centerXAnchor.constraint(equalTo: haloWindowScene.centerXAnchor).isActive = true
        beatCard.centerYAnchor.constraint(equalTo: haloWindowScene.centerYAnchor).isActive = true
        beatCard.widthAnchor.constraint(lessThanOrEqualToConstant: 210).isActive = true
        beatStack.topAnchor.constraint(equalTo: beatCard.topAnchor, constant: 20).isActive = true
        beatStack.bottomAnchor.constraint(equalTo: beatCard.bottomAnchor, constant: -20).isActive = true
        beatStack.leadingAnchor.constraint(equalTo: beatCard.leadingAnchor, constant: 16).isActive = true
        beatStack.trailingAnchor.constraint(equalTo: beatCard.trailingAnchor, constant: -16).isActive = true

        haloWindowScene.makeKeyAndVisible()
        beatHaloWindow = haloWindowScene
        rhythmSpinner = tempoWheel
        beatCard.alpha = 0
        beatCard.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.18) {
            beatCard.alpha = 1
            beatCard.transform = .identity
        }
        if !shouldSpin {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                self?.tinkieDismissBeat()
            }
        }
    }

    private func tinkieDismissBeat() {
        beatHaloWindow?.isHidden = true
        beatHaloWindow = nil
        rhythmSpinner?.stopAnimating()
        rhythmSpinner = nil
    }
}
