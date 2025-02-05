//
//  Onboarding.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 31/01/2025.
//
import Foundation

class Onboarding {
    internal init(title: String, pageType: OnboardingPageType, pageOptions: [SelectionOptionViewDataModel], selectionOptionTheme: SelectionOptionTheme, hasSkip: Bool, subtitle: String) {
        self.title = title
        self.pageType = pageType
        self.pageOptions = pageOptions
        self.hasSkip = hasSkip
        self.subtitle = subtitle
        self.selectionOptionTheme = selectionOptionTheme
    }
    
    let title: String
    let subtitle: String
    let pageType: OnboardingPageType
    let pageOptions: [SelectionOptionViewDataModel]
    let hasSkip: Bool
    let selectionOptionTheme: SelectionOptionTheme
}

enum OnboardingPageType {
    case howDidYouHear
    case age
    case genderSelection
    case name
    case wordsCount
    case level
    case appIcon
    case goal
}

struct SelectionOptionTheme {
    let themeBackgroundColor: String
    let containerCornerRadius: CGFloat = 28
    let selectionType: SelectionType
}
