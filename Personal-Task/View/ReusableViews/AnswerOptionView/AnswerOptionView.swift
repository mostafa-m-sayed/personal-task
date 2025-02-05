//
//  AnswerOptionView.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 04/02/2025.
//

import UIKit

final class AnswerOptionView: SelectionOptionView {
    
    func setAnswerState(_ correct: Bool) {
        self.setSelectionStatus(as: true, for: .singleSelection)
        containerView.layer.borderColor = correct ?  UIColor.green.cgColor : UIColor.red.cgColor
    }
}
