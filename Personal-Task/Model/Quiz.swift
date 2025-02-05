//
//  Quiz.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 04/02/2025.
//
import Foundation
struct Quiz: Hashable {
    let question: String
    let answers: [SelectionOptionViewDataModel]
    let correctAnswerIndex: Int
    
    init(question: String, answers: [String], correctAnswerIndex: Int) {
        self.question = question
        self.answers = answers.map {SelectionOptionViewDataModel(title: $0, isSelected: false)}
        self.correctAnswerIndex = correctAnswerIndex
    }
}
