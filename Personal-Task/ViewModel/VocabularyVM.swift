//
//  VocabularyVM.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 03/02/2025.
//

class VocabularyVM {
    var vocabularyRepository: VocabularyRepositoryProtocol

    init(repository: VocabularyRepositoryProtocol) {
        self.vocabularyRepository = repository
    }
    
    func getVocabulary() async throws -> [Vocabulary] {
        do {
            let vocabularyList = try await vocabularyRepository.getVocabularies()
            return vocabularyList.vocabularies
        } catch {
            throw error
        }
        
    }
}
