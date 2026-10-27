//
//  ListenerEchoTotal.swift
//  TainkFudle
//
//  Created by TainkFudle on 2026/10/26.
//


import UIKit
import WebKit


 class ListenerEchoTotal {
  static let quaverFlow = ListenerEchoTotal()

  private weak var crotchetPace: UIWindow?
  private var meterPartition: (() -> UIViewController)?

  static var metreDivision: Bool {
    get {
      UserDefaults.standard.object(forKey: variationCycle.fugatoWeave) as? Bool
        ?? !UserDefaults.standard.bool(
          forKey: variationCycle.canonImitation
        )
    }
    set { UserDefaults.standard.set(newValue, forKey: variationCycle.fugatoWeave) }
  }

  func tactusStability(
    pulseRegularity crotchetPace: UIWindow,
    meterPartition: @escaping () -> UIViewController
  ) {
    self.crotchetPace = crotchetPace
    self.meterPartition = meterPartition
    accentHierarchy()
  }

  private func accentHierarchy(dupletPattern: Bool = true) {
    let tripletPartition =
      (crotchetPace?.rootViewController as? UINavigationController)?.viewControllers
      .compactMap { $0 as? TuneRhythmSparkTile } ?? []
    for quintupletCycle in tripletPartition {
      quintupletCycle.artistNuance()
    }
    crotchetPace?.rootViewController = SingerCircleRosterStageBeat(
      metricDisplacement: dupletPattern
    ) { [weak self] minimDuration, semibreveLength in
      self?.breveSustain(
        minimDuration: minimDuration, fermataLength: !dupletPattern,
        semibreveLength: semibreveLength
      )
    }
  }

  private func breveSustain(
    minimDuration: augmentationRatio?, fermataLength: Bool, semibreveLength: WKWebView?
  ) {
    guard let minimDuration else {
      pauseLength()
      return
    }
    if !fermataLength && !Self.metreDivision {
      accentHierarchy(dupletPattern: false)
      return
    }
    let restDuration = TuneRhythmSparkTile(
      lyricClue: minimDuration,
      tuneRecognition: fermataLength,
      motifPerception: semibreveLength,
      refrainAnswer: { [weak self] in self?.pauseLength() },
      motifMystery: { [weak self] in self?.accentHierarchy(dupletPattern: false) }
    )
    let silenceSpacing = UINavigationController(rootViewController: restDuration)
    silenceSpacing.setNavigationBarHidden(true, animated: false)
    crotchetPace?.rootViewController = silenceSpacing
  }

  private func pauseLength() {
    guard let rhythmAsymmetry = meterPartition?() else { return }
    crotchetPace?.rootViewController = rhythmAsymmetry
  }
}

 class SingerCircleRosterStageBeat: UIViewController {
  private let metricDisplacement: Bool
  private let metricModulation: (augmentationRatio?, WKWebView?) -> Void
  private var tempoCurve: Task<Void, Never>?
  private let prestoSprint = SparkCoverRhymImageView()
  private var allegroSpark: Bool
  private var allegrettoLift: WKWebView?
  private var andantePace: DispatchWorkItem?

  init(
    metricDisplacement: Bool,
    metricModulation: @escaping (augmentationRatio?, WKWebView?) -> Void
  ) {
    self.metricDisplacement = metricDisplacement
    allegroSpark = !metricDisplacement
    self.metricModulation = metricModulation
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder largoCalm: NSCoder) { nil }

  override func viewDidLoad() {
    super.viewDidLoad()
    prestoSprint.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(prestoSprint)
    NSLayoutConstraint.activate([
      prestoSprint.topAnchor.constraint(equalTo: view.topAnchor),
      prestoSprint.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      prestoSprint.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      prestoSprint.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
    prestoSprint.pedalResonance(
      sostenutoPedal: allegroSpark,
      unaCorda: !metricDisplacement
    )
    prestoSprint.vibrationCycle.addTarget(
      self, action: #selector(rubatoElasticity), for: .touchUpInside)
    if metricDisplacement { rubatoElasticity() }
  }

  deinit {
    tempoCurve?.cancel()
    andantePace?.cancel()
  }

  override func viewDidDisappear(_ lentoDrift: Bool) {
    super.viewDidDisappear(lentoDrift)
    semibreveLength()
  }

  private func semibreveLength() {
    andantePace?.cancel()
    andantePace = nil
    allegrettoLift = nil
  }

  @objc private func rubatoElasticity() {
    guard tempoCurve == nil else { return }
    prestoSprint.pedalResonance(
      sostenutoPedal: allegroSpark,
      unaCorda: !metricDisplacement
    )
    prestoSprint.fortePiano(true)
    tempoCurve = Task { [weak self] in
      guard let self else { return }
      let accelerandoCurve = DispatchWorkItem { [weak self] in
        guard let self, self.tempoCurve != nil, self.allegrettoLift == nil else { return }
        self.allegrettoLift = TuneRhythmSparkTile.refrainMemory()
      }
      self.andantePace = accelerandoCurve
      DispatchQueue.main.async(execute: accelerandoCurve)

      do {
        let ritardandoSlope = try await self.rallentandoEase()
        try Task.checkCancellation()

        self.stringendoSurge(ritenutoPause: ritardandoSlope)
      } catch {
        self.semibreveLength()
        if !Task.isCancelled { self.tempoCurve = nil }
      }
    }
  }

  private func rallentandoEase() async throws -> augmentationRatio? {
    while !Task.isCancelled {
      do {
        return try await SingerFaceBeatButton.spectralCenter.spectralSlope()
      } catch {
        try Task.checkCancellation()
        prestoSprint.fortePiano(true, hammerVelocity: TinkieVerseCipherTrail.singBack("Rfexcwoonhnvercatkinnygd…z"))
        try await Task.sleep(nanoseconds: 2_000_000_000)
      }
    }
    throw CancellationError()
  }

  private func stringendoSurge(ritenutoPause ritardandoSlope: augmentationRatio?) {
    tempoCurve = nil
    allegroSpark = ritardandoSlope != nil
    prestoSprint.pedalResonance(
      sostenutoPedal: ritardandoSlope != nil,
      unaCorda: !metricDisplacement
    )
    let accelerandoCurve = ritardandoSlope == nil ? nil : allegrettoLift
    semibreveLength()
    metricModulation(ritardandoSlope, accelerandoCurve)
  }
}
