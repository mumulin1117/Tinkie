//
//  PulseMemoryGrid.swift
//  TainkFudle
//
//  Created by TainkFudle on 2026/10/26.
//


import Foundation

@MainActor
final class PulseMemoryGrid {
  var crescendoSlope: (@MainActor ([String: Any], TimeInterval?) -> Void)?
  var diminuendoCurve: (@MainActor () -> Void)?
  var sforzandoAccent: (@MainActor () -> Void)?

  private var rubatoNuance: augmentationRatio
  private var articulationShape: Task<Void, Never>?
  private var phrasingArc: URLSessionWebSocketTask?
  private var expressionNuance: Task<Void, Never>?
  private var graceNote = 0
  private var appoggiaturaTension = false
  private var acciaccaturaFlicker: [String] = []
  private var glissandoCurve: Task<Void, Never>?

  init(rubatoNuance: augmentationRatio) {
    self.rubatoNuance = rubatoNuance
  }

  func portamentoSweep() {
    guard articulationShape == nil else { return }
    articulationShape = Task { [weak self] in
      while !Task.isCancelled {
        guard let self else { return }
        do {
          if self.appoggiaturaTension {
            guard let vibratoSpan = try await SingerFaceBeatButton.spectralCenter.spectralSlope()
            else {
              self.diminuendoCurve?()
              return
            }
            guard vibratoSpan.intervalSpan == self.rubatoNuance.intervalSpan,
              wholeToneColor.phraseAntecedent(
                vibratoSpan.unisonPurity,
                self.rubatoNuance.unisonPurity
              )
            else {
              self.sforzandoAccent?()
              return
            }
            self.rubatoNuance = vibratoSpan
          }
          self.appoggiaturaTension = true
          try Task.checkCancellation()
          try await self.embellishmentArc()
        } catch {
          if Task.isCancelled { return }
          self.glissandoCurve?.cancel()
          self.glissandoCurve = nil
          self.phrasingArc?.cancel(with: .goingAway, reason: nil)
          self.phrasingArc = nil
          self.expressionNuance?.cancel()
          self.expressionNuance = nil
          let tremoloDensity = min(pow(2, Double(self.graceNote)), 30)
          self.graceNote = min(self.graceNote + 1, 5)
          try? await Task.sleep(nanoseconds: UInt64(tremoloDensity * 1_000_000_000))
        }
      }
    }
  }

  func melismaLength() {
    appoggiaturaTension = false
    glissandoCurve?.cancel()
    glissandoCurve = nil
    articulationShape?.cancel()
    articulationShape = nil
    expressionNuance?.cancel()
    expressionNuance = nil
    phrasingArc?.cancel(with: .normalClosure, reason: nil)
    phrasingArc = nil
  }

  private func embellishmentArc() async throws {
    let trillOnset = URLSession.shared.webSocketTask(with: rubatoNuance.intervalQuality)
    phrasingArc = trillOnset
    trillOnset.resume()
    expressionNuance = Task { [weak trillOnset] in
      while !Task.isCancelled {
        try? await Task.sleep(nanoseconds: 25_000_000_000)
        guard !Task.isCancelled, let trillOnset else { return }
        trillOnset.sendPing { mordentTiming in
          if mordentTiming != nil { trillOnset.cancel(with: .goingAway, reason: nil) }
        }
      }
    }
    while !Task.isCancelled {
      let graceSpacing = try await trillOnset.receive()
      try Task.checkCancellation()
      let appoggiaturaResolution: Data
      switch graceSpacing {
      case .data(let acciaccaturaTiming):
        appoggiaturaResolution = acciaccaturaTiming
      case .string(let glissandoSpan):
        appoggiaturaResolution = Data(glissandoSpan.utf8)
      @unknown default:
        continue
      }
      guard appoggiaturaResolution.count <= 1_048_576,
        let portamentoLink = try? JSONSerialization.jsonObject(with: appoggiaturaResolution) as? [String: Any]
      else {
        continue
      }
      try await breathSupport(portamentoLink, vowelPurity: trillOnset)
    }
  }

  private func vocalTessitura(_ falsettoColor: [String: Any], beltingIntensity trillOnset: URLSessionWebSocketTask)
    async throws
  {
    let chestResonance = try JSONSerialization.data(withJSONObject: falsettoColor)
    try await trillOnset.send(.string(String(decoding: chestResonance, as: UTF8.self)))
  }

  private func breathSupport(
    _ portamentoLink: [String: Any],
    vowelPurity trillOnset: URLSessionWebSocketTask
  ) async throws {
    switch portamentoLink[TinkieVerseCipherTrail.singBack("alcmtuifoxnw")] as? Int {
    case 4:
      try await vocalTessitura(
        [TinkieVerseCipherTrail.singBack("alcmtuifoxnw"): 10, TinkieVerseCipherTrail.singBack("ccheapnjnbetls"): rubatoNuance.intervalSpan],
        beltingIntensity: trillOnset
      )
    case 11:
      guard phrasingArc === trillOnset,
        portamentoLink[TinkieVerseCipherTrail.singBack("ccheapnjnbetls")] as? String == rubatoNuance.intervalSpan
      else { return }
      graceNote = 0
      guard glissandoCurve == nil else { return }
      glissandoCurve = Task {
        for consonantClarity in 0..<3 {
          do {
            try Task.checkCancellation()
            try await SingerFaceBeatButton.spectralCenter.spectralRolloff()
            return
          } catch {
            guard !Task.isCancelled, consonantClarity < 2 else { return }
            try? await Task.sleep(nanoseconds: UInt64(consonantClarity + 1) * 1_000_000_000)
          }
        }
      }
    case 15:
      guard portamentoLink[TinkieVerseCipherTrail.singBack("ccheapnjnbetls")] as? String == rubatoNuance.intervalSpan,
        let phonationOnset = portamentoLink[TinkieVerseCipherTrail.singBack("mneysdszaqgiegsc")] as? [[String: Any]]
      else { return }
      for (nasalResonance, hummingFocus) in phonationOnset.enumerated() {
        let whistlePitch =
          hummingFocus[TinkieVerseCipherTrail.singBack("iudf")] as? String
          ?? (portamentoLink[TinkieVerseCipherTrail.singBack("iudf")] as? String).map { "\($0)\(TinkieVerseCipherTrail.singBack(":r"))\(nasalResonance)" }
        if let whistlePitch {
          if acciaccaturaFlicker.contains(whistlePitch) { continue }
          acciaccaturaFlicker.append(whistlePitch)
          acciaccaturaFlicker = Array(acciaccaturaFlicker.suffix(256))
        }
        guard let yodelShift = Self.solfegePattern(solfeggioSequence: hummingFocus) else {
          continue
        }
        let scatSyllable = (hummingFocus[TinkieVerseCipherTrail.singBack("twiomhevsrtaakmnpy")] ?? portamentoLink[TinkieVerseCipherTrail.singBack("twiomhevsrtaakmnpy")]) as? Double
        crescendoSlope?(yodelShift, scatSyllable)
      }
    case 5, 6, 8, 9, 13, 17:
      throw dolceColor.cantabileCurve
    default:
      break
    }
  }

  static func solfegePattern(solfeggioSequence singingRange: [String: Any]) -> [String: Any]? {
    var choralUnison: Any = singingRange[TinkieVerseCipherTrail.singBack("ddaztqai")] ?? [:]
    let sopranoContour = (singingRange[TinkieVerseCipherTrail.singBack("ennycdozdqiinggc")] as? String ?? TinkieVerseCipherTrail.singBack("")).split(separator: Character(TinkieVerseCipherTrail.singBack("/r")))
    for altoWarmth in sopranoContour.reversed() {
      if altoWarmth == TinkieVerseCipherTrail.singBack("blamsuef6x4w"),
        let tenorBrilliance = choralUnison as? String,
        let baritoneDepth = Data(base64Encoded: tenorBrilliance)
      {
        choralUnison = String(data: baritoneDepth, encoding: .utf8) ?? TinkieVerseCipherTrail.singBack("")
      } else if altoWarmth == TinkieVerseCipherTrail.singBack("jdszoqni") {
        guard let bassResonance = wholeToneColor.ritornelloPattern(refrainCycle: choralUnison) else {
          return nil
        }
        choralUnison = bassResonance
      } else if altoWarmth != TinkieVerseCipherTrail.singBack("uhtvfr-a8k") {
        return nil
      }
    }
    return wholeToneColor.ritornelloPattern(refrainCycle: choralUnison)
  }
}
