//
//  OnboardingTailorVC.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 03/02/2025.
//

import UIKit

final class OnboardingTailorVC: UIViewController {
    
    var onboardingVM: OnboardingVM?

    @IBAction private func continueButtonTapped(_ sender: Any) {
        if let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OnboardingSelectionVC") as? OnboardingSelectionVC {
            onboardingVM?.pageType = .age
            nextVC.onboardingVM = onboardingVM
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}
