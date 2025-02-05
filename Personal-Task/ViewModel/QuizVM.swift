//
//  QuizVM.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 04/02/2025.
//

class QuizVM {
    var quiz: [Quiz]?

    init() {
        quiz = formulateQuestions()
    }
    
    private func formulateQuestions() -> [Quiz] {
        
        let question1 = Quiz(question: "Fame is often ___, one day you're trending, the next day you're forgotten.", answers: ["small", "ephemeral", "short", "fun"], correctAnswerIndex: 1)

        let question2 = Quiz(question: "I ran into an old friend at the airport, it was pure ___!", answers: ["good", "ephemeral", "evil", "serendipity"], correctAnswerIndex: 3)

        let question3 = Quiz(question: "That café is the ___ Parisian experience—charming, cozy, and full of great coffee.", answers: ["quintessential", "ephemeral", "great", "fun"], correctAnswerIndex: 0)

        return [question1, question2, question3]
    }
}
