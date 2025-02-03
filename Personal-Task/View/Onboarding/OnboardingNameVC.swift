//
//  OnboardingNameVC.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 03/02/2025.
//

import UIKit

final class OnboardingNameVC: UIViewController {
    
    @IBOutlet private weak var continueButton: SubmitButton!
    @IBOutlet private weak var nameText: UITextField!
    
    var onboardingVM: OnboardingVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNameText()
    }
    
    private func configureNameText() {
        nameText.attributedPlaceholder = NSAttributedString(
            string: "Your name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "placeholder-color") ?? .white]
        )
        nameText.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
    }
    
    @IBAction private func continueButtonTapped(_ sender: Any) {
        onboardingVM?.name = nameText.text
        
        if let nextVC = UIStoryboard.main.instantiateViewController(withIdentifier: "OnboardingCustomizationVC") as? OnboardingCustomizationVC {
            nextVC.onboardingVM = onboardingVM
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        continueButton.isEnabled = !(textField.text?.isEmpty ?? true)
    }
}
