//
//  VocabularyRepositoryMock.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 03/02/2025.
//

import Foundation

class VocabularyRepositoryMock: VocabularyRepositoryProtocol {
    func getVocabularies() async throws -> VocabularyResponse {
        guard let url = Bundle.main.url(forResource: "Vocabularies", withExtension: "json") else {
            print("Failed to locate mockData.json in bundle.")
            throw APIError.notFound
        }

        do {
            let data = try Data(contentsOf: url)
            
            if let jsonString = String(data: data, encoding: .utf8) {
                   print("JSON String from URL:\n\(jsonString)")
               } else {
                   print("Failed to convert data to string.")
               }

            let decoder = JSONDecoder()
            let mockData = try decoder.decode(VocabularyResponse.self, from: data)
            
            return mockData
        } catch {
            print("Failed to load or parse mockData.json: \(error)")
            throw APIError.parseError
        }
    }
}
