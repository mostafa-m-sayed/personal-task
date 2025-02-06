//
//  VocabularyVM.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 03/02/2025.
//

class VocabularyVM {
    var vocabularyRepository: VocabularyRepositoryProtocol
    var vocabularies: [Vocabulary]?

    init(repository: VocabularyRepositoryProtocol) {
        self.vocabularyRepository = repository
    }
    
    func getVocabulary() async throws -> [Vocabulary] {
        do {
            let vocabularyList = try await vocabularyRepository.getVocabularies()
            self.vocabularies = vocabularyList.vocabularies
            return vocabularyList.vocabularies
        } catch {
            throw error
        }
        
    }
}
