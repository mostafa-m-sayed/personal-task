//
//  VocabularyRepository.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 03/02/2025.
//

class VocabularyRepository: VocabularyRepositoryProtocol {
    func getVocabularies() async throws -> VocabularyResponse {
        throw APIError.notImplemented
    }
}

enum APIError: Error {
    case notImplemented
    case notFound
    case parseError
}
