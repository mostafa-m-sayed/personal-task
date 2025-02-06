//
//  QuizCollectionCell.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 04/02/2025.
//

import UIKit
protocol QuizCollectionCellDelegate: AnyObject {
    func didSelectAnswer(isCorrect: Bool)
}

final class QuizCollectionCell: UICollectionViewCell {
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var answersStackView: UIStackView!
    
    weak var delegate: QuizCollectionCellDelegate?

    func configure(with quizItem: Quiz) {
        questionLabel.text = quizItem.question
        let answersTheme = SelectionOptionTheme(themeBackgroundColor: "app-dark-gray", selectionType: .singleSelection)
        if let firstView = answersStackView.arrangedSubviews.first {
            answersStackView.removeArrangedSubview(firstView)
        }
        for (index, answer) in quizItem.answers.enumerated() {
            let optionView = AnswerOptionView()
            answer.didTap = { [weak self] isSelected in
                guard let self = self else { return }
                
                if quizItem.answers.contains(where: {$0.isSelected}) {
                    return
                }
                answer.isSelected = true
                if index == quizItem.correctAnswerIndex {
                    HapticManager.shared.performHapticFeedback(.success)
                    optionView.setAnswerState(true)
                    self.delegate?.didSelectAnswer(isCorrect: true)
                } else {
                    HapticManager.shared.performHapticFeedback(.error)
                    optionView.setAnswerState(false)
                    self.delegate?.didSelectAnswer(isCorrect: false)
                    (answersStackView.arrangedSubviews[quizItem.correctAnswerIndex] as? AnswerOptionView)?.setAnswerState(true)
                }
            }
            optionView.configureView(with: answer, selectionTheme: answersTheme)
            optionView.translatesAutoresizingMaskIntoConstraints = false
            optionView.heightAnchor.constraint(equalToConstant: 60).isActive = true

            answersStackView.addArrangedSubview(optionView)
        }
    }
}
