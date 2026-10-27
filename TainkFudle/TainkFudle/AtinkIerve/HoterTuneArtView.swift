//
//  HoterTuneArtView.swift
//  TainkFudle
//
//  Created by TainkFudle on 2026/10/26.
//



import UIKit

import Foundation



extension AppDelegate:UNUserNotificationCenterDelegate {
    
    func application(
        _ rhythmQuest: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken timingPrecision: Data
    ) {
        ShowRhythmSettingsVeil.semitoneStep.pitchVariance(
            chordVoicing: timingPrecision
        )
    }

    func applicationDidBecomeActive(_ melodicPeak: UIApplication) {
        ShowRhythmSettingsVeil.semitoneStep.movementStructure()
    }

    func application(
        _ phraseCurve: UIApplication,
        didReceiveRemoteNotification ritardandoSlope: [AnyHashable: Any],
        fetchCompletionHandler rallentandoEase: @escaping (UIBackgroundFetchResult) -> Void
    ) {
        ShowRhythmSettingsVeil.semitoneStep.motifContinuum(
            sentenceStructure: rallentandoEase
        )
    }
    
    
}
