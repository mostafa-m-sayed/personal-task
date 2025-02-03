//
//  OnboardingVM.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 02/02/2025.
//

class OnboardingVM {
    var onboardingItems: [Onboarding]?
    var pageType: OnboardingPageType = .howDidYouHear
    var name: String?

    init() {
        onboardingItems = formulateOnboardingItems()
    }
    
    private func formulateOnboardingItems() -> [Onboarding] {
        return [howDidYouHear(),
                ageRange(),
                gender(),
                wordsCount(),
                level()
        ]
    }

    private func howDidYouHear() -> Onboarding {
        let options: [SelectionOptionViewDataModel] = [
            SelectionOptionViewDataModel(title: "Tiktok", isSelected: false),
            SelectionOptionViewDataModel(title: "Instagram", isSelected: false),
            SelectionOptionViewDataModel(title: "Facebook", isSelected: false),
            SelectionOptionViewDataModel(title: "App Store", isSelected: false),
            SelectionOptionViewDataModel(title: "Web search", isSelected: false),
            SelectionOptionViewDataModel(title: "Friend", isSelected: false),
            SelectionOptionViewDataModel(title: "Other", isSelected: false),
        ]
        let onboarding = Onboarding(title: "How did you hear about Vocabulary?",
                                    pageType: .howDidYouHear, pageOptions: options, selectionOptionTheme: SelectionOptionTheme(themeBackgroundColor: Constants.themeColor, selectionType: .singleSelection), hasSkip: false, subtitle: "Selection an option to continue")
        return onboarding
    }

    private func ageRange() -> Onboarding {
        let options: [SelectionOptionViewDataModel] = [
            SelectionOptionViewDataModel(title: "13 to 17", isSelected: false),
            SelectionOptionViewDataModel(title: "18 to 24", isSelected: false),
            SelectionOptionViewDataModel(title: "25 to 34", isSelected: false),
            SelectionOptionViewDataModel(title: "35 to 44", isSelected: false),
            SelectionOptionViewDataModel(title: "45 to 54", isSelected: false),
            SelectionOptionViewDataModel(title: "55+", isSelected: false)
        ]
        let onboarding = Onboarding(title: "How old are you ?",
                                    pageType: .age, pageOptions: options, selectionOptionTheme: SelectionOptionTheme(themeBackgroundColor: Constants.themeColor, selectionType: .singleSelection), hasSkip: false, subtitle: "Your age is used to personalize your content")
        return onboarding
    }

    private func gender() -> Onboarding {
        let options: [SelectionOptionViewDataModel] = [
            SelectionOptionViewDataModel(title: "Female", isSelected: false),
            SelectionOptionViewDataModel(title: "Male", isSelected: false),
            SelectionOptionViewDataModel(title: "Other", isSelected: false),
            SelectionOptionViewDataModel(title: "Prefer not to say", isSelected: false)
        ]
        let onboarding = Onboarding(title: "Which option represents you best?",
                                    pageType: .genderSelection, pageOptions: options, selectionOptionTheme: SelectionOptionTheme(themeBackgroundColor: Constants.themeColor, selectionType: .singleSelection), hasSkip: false, subtitle: "Select an option to continue")
        return onboarding
    }

    private func wordsCount() -> Onboarding {
        let options: [SelectionOptionViewDataModel] = [
            SelectionOptionViewDataModel(title: "5 words a week", isSelected: false),
            SelectionOptionViewDataModel(title: "10 words a week", isSelected: false),
            SelectionOptionViewDataModel(title: "30 words a week", isSelected: false)
        ]
        let onboarding = Onboarding(title: "How many words you want to learn per week?",
                                    pageType: .wordsCount, pageOptions: options, selectionOptionTheme: SelectionOptionTheme(themeBackgroundColor: Constants.themeColor, selectionType: .singleSelection), hasSkip: false, subtitle: "You can always change your goal later")
        return onboarding
    }

    private func level() -> Onboarding {
        let options: [SelectionOptionViewDataModel] = VocabLevel.allCases.map {SelectionOptionViewDataModel(title: $0.title, isSelected: false)}

        let onboarding = Onboarding(title: "What's your vocabulary level?",
                                    pageType: .level, pageOptions: options, selectionOptionTheme: SelectionOptionTheme(themeBackgroundColor: Constants.themeColor, selectionType: .singleSelection), hasSkip: false, subtitle: "Select an option to continue")
        return onboarding
    }


    private enum Constants {
        static let themeColor = "app-dark-gray"
    }
}
enum VocabLevel: String, CaseIterable {
    case beginner
    case intermediate
    case advanced
    
    var title: String {
        switch self {
        case .beginner:
            return "Beginner"
        case .intermediate:
            return "Intermediate"
        case .advanced:
            return "Advanced"
        }
    }
}
