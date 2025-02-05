//
//  OnboardingLandingVC.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 31/01/2025.
//

import UIKit

final class OnboardingLandingVC: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var getStartedButton: UIButton!

    var onboardingVM: OnboardingVM?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        onboardingVM = OnboardingVM()
        
        setTitle()

    }
    
    @IBAction private func getStartedButtonTapped(_ sender: Any) {
        if let nextVC = UIStoryboard.main.instantiateViewController(withIdentifier: "OnboardingSelectionVC") as? OnboardingSelectionVC {
            nextVC.onboardingVM = onboardingVM
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }

    private func setTitle() {
        let backgroundColor = UIColor.shadeBlue
        let foregroundColor = UIColor.shadeWhiteText
        let attribute: NSAttributedString = {
            let attributedString = NSMutableAttributedString()
            attributedString.append(NSAttributedString(string: "Expand your Vocabulary in", attributes: [
                NSAttributedString.Key.backgroundColor: backgroundColor,
                NSAttributedString.Key.foregroundColor: foregroundColor
            ]))
            return attributedString
        }()

        titleLabel.attributedText = attribute

        let attribute2: NSAttributedString = {
            let attributedString = NSMutableAttributedString()
            attributedString.append(NSAttributedString(string: "1 minute a ", attributes: [
                NSAttributedString.Key.backgroundColor: backgroundColor,
                NSAttributedString.Key.foregroundColor: foregroundColor
            ]))
            
            attributedString.append(NSAttributedString(string: "day", attributes: [
                NSAttributedString.Key.backgroundColor: UIColor.clear,
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]))
            return attributedString
        }()
        subtitleLabel.attributedText = attribute2
    }
}
