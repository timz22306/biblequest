//
//  QuestionViewModel.swift
//  REA
//
//  Created by Tim Zhao on 4/5/25.
//

import Foundation
import SwiftUI

class QuestionViewModel: ObservableObject {
    @Published var questions: [Question]
    @Published var currentQuestionIndex = 0
    @Published var score = 0
    @Published var showingResults = false
    
    var currentQuestion: Question {
        questions[currentQuestionIndex]
    }
    
    var progressValue: Float {
        Float(currentQuestionIndex) / Float(questions.count)
    }
    
    init(questions: [Question] = QuestionBank.sampleQuestions) {
        self.questions = questions
    }
    
    func selectAnswer(_ selectedIndex: Int) {
        let isCorrect = selectedIndex == currentQuestion.correctAnswerIndex
        
        // Update the question's answer status
        questions[currentQuestionIndex].isAnsweredCorrectly = isCorrect
        
        // Update score
        if isCorrect {
            score += 1
        }
        
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
        
        // Reset answers
        for i in 0..<questions.count {
            questions[i].isAnsweredCorrectly = nil
        }
    }
}
