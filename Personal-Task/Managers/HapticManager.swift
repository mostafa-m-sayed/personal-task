//
//  HapticManager.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 06/02/2025.
//
import UIKit
final class HapticManager {
    static let shared = HapticManager()
    
    private var notificationGenerator: UINotificationFeedbackGenerator?
    private var impactGenerator: UIImpactFeedbackGenerator?

    func performHapticFeedback(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        if notificationGenerator == nil {
            notificationGenerator = UINotificationFeedbackGenerator()
        }
        notificationGenerator?.notificationOccurred(type)
    }

    func performImpactFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        impactGenerator = UIImpactFeedbackGenerator(style: style)
        impactGenerator?.impactOccurred()
    }
}
