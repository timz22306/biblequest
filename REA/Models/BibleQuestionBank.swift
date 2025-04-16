//
//  BibleQuestionBank.swift
//  REA
//
//  Created by Tim Zhao on 4/5/25.
//

import Foundation

struct BibleQuestionBank {
    // Loads all questions from available JSON files (currently only Exodus)
    static var allQuestions: [Question] {
        // Add more books as you add more JSON files
        QuestionsDataLoader.loadQuestions(for: .exodus)
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
