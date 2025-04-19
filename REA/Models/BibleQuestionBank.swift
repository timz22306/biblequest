//
//  BibleQuestionBank.swift
//  REA
//
//  Created by Tim Zhao on 4/5/25.
//

import Foundation

struct BibleQuestionBank {
    // Loads all questions from available JSON files dynamically for all books
    static var allQuestions: [Question] {
        BibleBook.allCases.flatMap { QuestionsDataLoader.loadQuestions(for: $0) }
    }
    
    // MARK: - Helper Methods
    
    static func getQuestions(for book: BibleBook? = nil, difficulty: Difficulty? = nil) -> [Question] {
        var filteredQuestions = allQuestions
        
        // Filter by book if specified
        if let book = book {
            filteredQuestions = filteredQuestions.filter { $0.book == book }
        }
        
        // Filter by difficulty if specified
        if let difficulty = difficulty {
            filteredQuestions = filteredQuestions.filter { $0.difficulty == difficulty }
        }
        
        return filteredQuestions
    }
    
    static func getBookList() -> [BibleBook] {
        // Return unique books that have questions
        let books = Set(allQuestions.map { $0.book })
        return Array(books).sorted { $0.rawValue < $1.rawValue }
    }
}
