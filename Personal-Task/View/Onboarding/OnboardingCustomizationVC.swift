//
//  OnboardingCustomizationVC.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 03/02/2025.
//

import UIKit

final class OnboardingCustomizationVC: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    var onboardingVM: OnboardingVM?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTitle()
    }
    private func configureTitle() {
        titleLabel.text = "Let's make Vocabulary your's \(onboardingVM?.name ?? "")"
    }
    @IBAction private func continueButtonTapped(_ sender: Any) {
        if let nextVC = UIStoryboard.main.instantiateViewController(withIdentifier: "OnboardingSelectionVC") as? OnboardingSelectionVC {
            onboardingVM?.pageType = .wordsCount
            nextVC.onboardingVM = onboardingVM
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}
