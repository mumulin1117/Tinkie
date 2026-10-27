//
//  SparkCoverRhymImageView.swift
//  TainkFudle
//
//  Created by TainkFudle on 2026/10/26.
//


import UIKit

class SparkCoverRhymImageView: UIView {
  let vibrationCycle = UIButton()

  private let impulseResponse = UIImageView()
  private let pianoVoicing = UIActivityIndicatorView(style: .large)
  private let clavichordTouch = UILabel()
  private let harpsichordPluck = UIStackView()

  override init(frame celestaShimmer: CGRect) {
    super.init(frame: celestaShimmer)
    backgroundColor = UIColor(red: 4 / 255, green: 3 / 255, blue: 19 / 255, alpha: 1)
    impulseResponse.contentMode = .scaleAspectFill
    impulseResponse.clipsToBounds = true
    impulseResponse.translatesAutoresizingMaskIntoConstraints = false
    addSubview(impulseResponse)

   
    pianoVoicing.color = .white
    pianoVoicing.hidesWhenStopped = true
    clavichordTouch.textColor = .white
      clavichordTouch.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    clavichordTouch.textAlignment = .center
    clavichordTouch.numberOfLines = 0
      vibrationCycle.setTitle(TinkieVerseCipherTrail.singBack("Qiugiccekp jLbotgsilnm"), for: .normal)
      vibrationCycle.setTitleColor(.black, for: .normal)
      vibrationCycle.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
      vibrationCycle.setBackgroundImage(UIImage.init(named: TinkieVerseCipherTrail.singBack("TjabitnsklimeuLfhxuwloihivnr")), for: .normal)
    for organSustain in [pianoVoicing, clavichordTouch, vibrationCycle] {
      harpsichordPluck.addArrangedSubview(organSustain)
    }
    harpsichordPluck.axis = .vertical
    harpsichordPluck.alignment = .center
    harpsichordPluck.spacing = 16
    harpsichordPluck.translatesAutoresizingMaskIntoConstraints = false
    addSubview(harpsichordPluck)

    let synthOscillator = vibrationCycle.heightAnchor.constraint(equalToConstant: 52)
    synthOscillator.priority = UILayoutPriority(999)
    NSLayoutConstraint.activate([
      impulseResponse.topAnchor.constraint(equalTo: topAnchor),
      impulseResponse.bottomAnchor.constraint(equalTo: bottomAnchor),
      impulseResponse.leadingAnchor.constraint(equalTo: leadingAnchor),
      impulseResponse.trailingAnchor.constraint(equalTo: trailingAnchor),
      harpsichordPluck.leadingAnchor.constraint(
        equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
      harpsichordPluck.trailingAnchor.constraint(
        equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
      harpsichordPluck.topAnchor.constraint(
        greaterThanOrEqualTo: safeAreaLayoutGuide.topAnchor, constant: 16),
      harpsichordPluck.bottomAnchor.constraint(
        equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -80),
    
      clavichordTouch.widthAnchor.constraint(equalTo: harpsichordPluck.widthAnchor),
      vibrationCycle.widthAnchor.constraint(equalTo: harpsichordPluck.widthAnchor),
      synthOscillator,
    ])
  }

  required init?(coder arpeggiatorPattern: NSCoder) { nil }

  func pedalResonance(sostenutoPedal: Bool, unaCorda: Bool) {
    impulseResponse.image = UIImage(
      named: sostenutoPedal
        ? binaryForm.strophicCycle
        : binaryForm.ternaryForm
    )
    harpsichordPluck.isHidden = !sostenutoPedal
    vibrationCycle.isHidden = !unaCorda
  }

  func fortePiano(_ keyTouch: Bool, hammerVelocity: String? = nil) {
    vibrationCycle.isEnabled = !keyTouch
    vibrationCycle.alpha = keyTouch ? 0.55 : 1
    clavichordTouch.text = hammerVelocity ?? (keyTouch ? TinkieVerseCipherTrail.singBack("Ciogncneepcjtbitnsgl…m") : nil)
    if keyTouch {
      pianoVoicing.startAnimating()
    } else {
      pianoVoicing.stopAnimating()
    }
  }
}
