//
//  OnboardingSelectionVC.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 02/02/2025.
//

import UIKit

class OnboardingSelectionVC: UIViewController {
    
    @IBOutlet private weak var continueButton: SubmitButton!
    @IBOutlet private weak var optionsStackView: UIStackView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!

    var onboardingVM: OnboardingVM?

    override func viewDidLoad() {
        super.viewDidLoad()

        configurePage()
        continueButton.isEnabled = false
    }
    private func configurePage() {
        guard let pageType = onboardingVM?.pageType,
              let items = onboardingVM?.onboardingItems,
              let currentItem = items.first(where: { $0.pageType == pageType }) else { return }
        
        titleLabel.text = currentItem.title
        subtitleLabel.text = currentItem.subtitle
        
        setOptions(currentItem.pageOptions, theme: currentItem.selectionOptionTheme)
    }

    func setOptions(_ options: [SelectionOptionViewDataModel], theme: SelectionOptionTheme) {
        if let firstView = optionsStackView.arrangedSubviews.first {
            optionsStackView.removeArrangedSubview(firstView)
        }
        
        for option in options {
            let optionView = SelectionOptionView()
            option.didTap = { [weak self] isSelected in
                guard let self = self else { return }
                if theme.selectionType == .singleSelection {
                    unselectAllOptions(options)
                }
                handleOptionTap(option: option, optionView: optionView, selectionType: theme.selectionType)
                setButtonStateFor(options)
            }
            optionView.configureView(with: option, selectionTheme: theme)
            optionView.translatesAutoresizingMaskIntoConstraints = false
            optionView.heightAnchor.constraint(equalToConstant: 60).isActive = true

            optionsStackView.addArrangedSubview(optionView)
        }
    }

    private func unselectAllOptions(_ options: [SelectionOptionViewDataModel]) {
        for (index, _) in options.enumerated() {
            options[index].isSelected = false
        }
        for optionView in optionsStackView.arrangedSubviews {
            (optionView as? SelectionOptionView)?.setSelectionStatus(as: false, for: .singleSelection)
        }
    }
    private func handleOptionTap(option: SelectionOptionViewDataModel, optionView: SelectionOptionView, selectionType: SelectionType) {
        option.isSelected.toggle()
        optionView.setSelectionStatus(as: option.isSelected, for: selectionType)
        
    }
    private func setButtonStateFor(_ options: [SelectionOptionViewDataModel]) {
        continueButton.isEnabled = options.contains(where: {$0.isSelected})
    }

    @IBAction private func continueButtonTapped(_ sender: Any) {
        guard let pageType = onboardingVM?.pageType else { return }
        switch pageType {
        case .howDidYouHear:
            goToTailor()
        case .age:
            goToGender()
        case .genderSelection:
            goToName()
        case .wordsCount:
            goToLevel()
        case .level:
            goToAppIcon()
        case .goal:
            goToHome()
        default:
            return
        }
    }
    
}

// Mark: Navigation
extension OnboardingSelectionVC {
    func goToTailor() {
        if let nextVC = UIStoryboard.main.instantiateViewController(withIdentifier: "OnboardingTailorVC") as? OnboardingTailorVC {
            nextVC.onboardingVM = onboardingVM
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }

    func goToGender() {
        if let nextVC = UIStoryboard.main.instantiateViewController(withIdentifier: "OnboardingSelectionVC") as? OnboardingSelectionVC {
            onboardingVM?.pageType = .genderSelection
            nextVC.onboardingVM = onboardingVM
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }

    func goToName() {
        if let nextVC = UIStoryboard.main.instantiateViewController(withIdentifier: "OnboardingNameVC") as? OnboardingNameVC {
            onboardingVM?.pageType = .name
            nextVC.onboardingVM = onboardingVM
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }

    func goToLevel() {
        if let nextVC = UIStoryboard.main.instantiateViewController(withIdentifier: "OnboardingSelectionVC") as? OnboardingSelectionVC {
            onboardingVM?.pageType = .level
            nextVC.onboardingVM = onboardingVM
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }

    func goToAppIcon() {
        if let nextVC = UIStoryboard.main.instantiateViewController(withIdentifier: "OnboardingAppIconVC") as? OnboardingAppIconVC {
            onboardingVM?.pageType = .appIcon
            nextVC.onboardingVM = onboardingVM
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }

    func goToHome() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first {
            
            let viewController = UIStoryboard.home.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            let navController = UINavigationController(rootViewController: viewController)
            window.rootViewController = navController
            window.makeKeyAndVisible()
        }
    }
}
