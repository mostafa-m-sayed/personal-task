//
//  VocabularyRepositoryProtocol.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 03/02/2025.
//

protocol VocabularyRepositoryProtocol {
    func getVocabularies() async throws -> VocabularyResponse
}
