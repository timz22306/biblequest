//
//  BibleQuestionBank.swift
//  REA
//
//  Created by Tim Zhao on 4/5/25.
//

import Foundation

struct BibleQuestionBank {
    private static var cachedQuestions: [BibleBook: [Question]] = [:]

    // MARK: - Helper Methods
    
    static func getQuestions(for book: BibleBook? = nil, difficulty: Difficulty? = nil) -> [Question] {
        var filteredQuestions: [Question] = []

        if let book = book {
            // Load questions for the specific book if not already cached
            if cachedQuestions[book] == nil {
                cachedQuestions[book] = QuestionsDataLoader.loadQuestions(for: book)
            }
            filteredQuestions = cachedQuestions[book] ?? []
        } else {
            // Load all questions if no specific book is provided
            for book in BibleBook.allCases {
                if cachedQuestions[book] == nil {
                    cachedQuestions[book] = QuestionsDataLoader.loadQuestions(for: book)
                }
                filteredQuestions.append(contentsOf: cachedQuestions[book] ?? [])
            }
        }

        // Filter by difficulty if specified
        if let difficulty = difficulty {
            filteredQuestions = filteredQuestions.filter { $0.difficulty == difficulty }
        }

        return filteredQuestions
    }

    static func getBookList() -> [BibleBook] {
        // Return unique books that have questions
        let books = BibleBook.allCases.filter { 
            if cachedQuestions[$0] == nil {
                cachedQuestions[$0] = QuestionsDataLoader.loadQuestions(for: $0)
            }
            return !(cachedQuestions[$0]?.isEmpty ?? true)
        }
        return books.sorted { $0.rawValue < $1.rawValue }
    }
}
