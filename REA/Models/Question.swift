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
    var options: [String]
    var correctAnswerIndex: Int
    let book: BibleBook
    let difficulty: Difficulty
    let verseReference: String // Reference like "Exodus 3:10"
    let verseText: String      // The actual ESV Bible verse text
    
    var isAnsweredCorrectly: Bool?
    
    // New method to create a shuffled copy of this question
    func withShuffledOptions() -> Question {
        // Get the correct answer text before shuffling
        let correctAnswer = options[correctAnswerIndex]
        
        // Create a shuffled copy of options
        var shuffledOptions = options
        shuffledOptions.shuffle()
        
        // Find the new index of the correct answer
        let newCorrectIndex = shuffledOptions.firstIndex(of: correctAnswer) ?? correctAnswerIndex
        
        // Create a new question with shuffled options
        var newQuestion = self
        newQuestion.options = shuffledOptions
        newQuestion.correctAnswerIndex = newCorrectIndex
        return newQuestion
    }
}