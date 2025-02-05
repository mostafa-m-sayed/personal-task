//
//  Vocabulary.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 03/02/2025.
//


import Foundation

// MARK: - Vocabulary Model
struct VocabularyResponse: Codable {
    let vocabularies: [Vocabulary]
}

struct Vocabulary: Codable, Hashable {
//    var id: UUID = UUID()
    let word: String
    let pronunciation: String
    let type: String
    let meaning: String
    let example: String
}
