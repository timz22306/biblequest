//
//  Question.swift
//  REA
//
//  Created by Tim Zhao on 4/5/25.
//
import Foundation

enum BibleBook: String, CaseIterable {
    case genesis = "Genesis"
    case exodus = "Exodus"
    case leviticus = "Leviticus"
    case numbers = "Numbers"
    case deuteronomy = "Deuteronomy"
    // Add more books as needed
}

enum Difficulty: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium" 
    case hard = "Hard"
}

struct Question: Identifiable {
    let id = UUID()
    let text: String
    let options: [String]
    let correctAnswerIndex: Int
    let book: BibleBook
    let difficulty: Difficulty
    let verseReference: String // Reference like "Exodus 3:10"
    let verseText: String      // The actual ESV Bible verse text
    
    var isAnsweredCorrectly: Bool?
}