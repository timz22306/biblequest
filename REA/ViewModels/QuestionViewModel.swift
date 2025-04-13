//
//  QuestionViewModel.swift
//  REA
//
//  Created by Tim Zhao on 4/5/25.
//
import Foundation
import SwiftUI

class QuestionViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex = 0
    @Published var score = 0
    @Published var showingResults = false
    @Published var selectedBook: BibleBook?
    @Published var selectedDifficulty: Difficulty?
    @Published var isSelectionViewActive = true
    @Published var selectedQuestionCount: Int? // nil means all questions
    
    // New properties for feedback
    @Published var showingFeedback = false
    @Published var lastSelectedAnswerIndex: Int?
    @Published var isLastAnswerCorrect = false
    
    var currentQuestion: Question {
        questions.isEmpty ? Question(
            text: "", 
            options: [], 
            correctAnswerIndex: 0, 
            book: .genesis, 
            difficulty: .easy, 
            verseReference: "",
            verseText: ""
        ) : questions[currentQuestionIndex]
    }
    
    var progressValue: Float {
        questions.isEmpty ? 0 : Float(currentQuestionIndex) / Float(questions.count)
    }
    
    var availableBooks: [BibleBook] {
        BibleQuestionBank.getBookList()
    }
    
    var questionCount: Int {
        BibleQuestionBank.getQuestions(for: selectedBook, difficulty: selectedDifficulty).count
    }
    
    // New method to get available question count options
    var availableQuestionCounts: [Int] {
        let totalQuestions = questionCount
        
        if totalQuestions == 0 {
            return []
        } else if totalQuestions <= 5 {
            return [totalQuestions]
        } else if totalQuestions <= 10 {
            return [5, totalQuestions]
        } else if totalQuestions <= 20 {
            return [5, 10, totalQuestions]
        } else {
            return [5, 10, 20, totalQuestions]
        }
    }
    
    init() {
        // Initialize empty for selection screen
    }
    
    func loadQuestions(book: BibleBook? = nil, difficulty: Difficulty? = nil, count: Int? = nil) {
        self.selectedBook = book
        self.selectedDifficulty = difficulty
        self.selectedQuestionCount = count
        
        // Get all matching questions
        var allQuestions = BibleQuestionBank.getQuestions(for: book, difficulty: difficulty)
        
        // Limit to selected count if specified
        if let count = count, count < allQuestions.count {
            allQuestions.shuffle() // Randomize before limiting
            allQuestions = Array(allQuestions.prefix(count))
        }
        
        self.questions = allQuestions
        
        // Reset quiz state
        currentQuestionIndex = 0
        score = 0
        showingResults = false
        isSelectionViewActive = false
        showingFeedback = false
        lastSelectedAnswerIndex = nil
    }
    
    func selectAnswer(_ selectedIndex: Int) {
        let isCorrect = selectedIndex == currentQuestion.correctAnswerIndex
        
        // Update the question's answer status
        questions[currentQuestionIndex].isAnsweredCorrectly = isCorrect
        
        // Update score
        if isCorrect {
            score += 1
        }
        
        // Set feedback state
        lastSelectedAnswerIndex = selectedIndex
        isLastAnswerCorrect = isCorrect
        showingFeedback = true
    }
    
    func proceedToNextQuestion() {
        showingFeedback = false
        lastSelectedAnswerIndex = nil
        
        // Move to next question or show results
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            showingResults = true
        }
    }
    
    func restartQuiz() {
        currentQuestionIndex = 0
        score = 0
        showingResults = false
        showingFeedback = false
        lastSelectedAnswerIndex = nil
        
        // Reset answers
        for i in 0..<questions.count {
            questions[i].isAnsweredCorrectly = nil
        }
    }
    
    func returnToSelection() {
        questions = []
        selectedBook = nil
        selectedDifficulty = nil
        selectedQuestionCount = nil
        showingResults = false
        isSelectionViewActive = true
        showingFeedback = false
        lastSelectedAnswerIndex = nil
    }
}
