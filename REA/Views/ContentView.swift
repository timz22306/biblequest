import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = QuestionViewModel()
    
    var body: some View {
        NavigationStack {
            if viewModel.isSelectionViewActive {
                SelectionView(viewModel: viewModel)
                    .navigationTitle("Bible Quiz")
            } else if viewModel.showingResults {
                resultsView
            } else {
                questionView
            }
        }
    }
    
    var questionView: some View {
        VStack(spacing: 20) {
            // Progress bar
            ProgressView(value: viewModel.progressValue)
                .tint(Color.blue)
                .padding(.horizontal)
                .scaleEffect(x: 1, y: 1.5, anchor: .center)
            
            // Question counter and book/difficulty
            HStack {
                Text("Q\(viewModel.currentQuestionIndex + 1)/\(viewModel.questions.count)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                // Display book and difficulty
                HStack(spacing: 5) {
                    Text(viewModel.currentQuestion.book.rawValue)
                        .font(.subheadline)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.1))
                        .foregroundColor(.blue)
                        .cornerRadius(8)
                    
                    Text(viewModel.currentQuestion.difficulty.rawValue)
                        .font(.subheadline)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(difficultyColor(viewModel.currentQuestion.difficulty).opacity(0.1))
                        .foregroundColor(difficultyColor(viewModel.currentQuestion.difficulty))
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
            
            // Question text
            Text(viewModel.currentQuestion.text)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
            
            // Verse reference
            Text(viewModel.currentQuestion.verseReference)
                .font(.footnote)
                .italic()
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer(minLength: 10)
            
            // Answer options
            VStack(spacing: 14) {
                ForEach(0..<viewModel.currentQuestion.options.count, id: \.self) { index in
                    Button(action: {
                        if !viewModel.showingFeedback {
                            viewModel.selectAnswer(index)
                        }
                    }) {
                        Text(viewModel.currentQuestion.options[index])
                            .font(.system(size: 16, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(answerBackgroundColor(for: index))
                            )
                            .foregroundColor(answerTextColor(for: index))
                    }
                    .disabled(viewModel.showingFeedback)
                }
            }
            .padding(.horizontal)
            
            if viewModel.showingFeedback {
                // Feedback message
                Text(viewModel.isLastAnswerCorrect ? "Correct!" : "Incorrect!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(viewModel.isLastAnswerCorrect ? .green : .red)
                    .padding()
                
                if !viewModel.isLastAnswerCorrect {
                    Text("The correct answer is: \(viewModel.currentQuestion.options[viewModel.currentQuestion.correctAnswerIndex])")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                // Display the Bible verse text
                VStack(spacing: 8) {
                    Text(viewModel.currentQuestion.verseReference)
                        .font(.headline)
                        .fontWeight(.medium)
                    
                    Text(viewModel.currentQuestion.verseText)
                        .font(.body)
                        .italic()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
                
                // Next button
                Button(action: {
                    viewModel.proceedToNextQuestion()
                }) {
                    Text("Next Question")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
            
            Spacer()
        }
        .navigationTitle("Question")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .toolbar {
            #if os(iOS)
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Menu") {
                    viewModel.returnToSelection()
                }
            }
            #else
            ToolbarItem(placement: .automatic) {
                Button("Menu") {
                    viewModel.returnToSelection()
                }
            }
            #endif
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // New helper functions for answer styling
    func answerBackgroundColor(for index: Int) -> Color {
        if viewModel.showingFeedback {
            if index == viewModel.currentQuestion.correctAnswerIndex {
                return Color.green.opacity(0.2)
            } else if index == viewModel.lastSelectedAnswerIndex {
                return viewModel.isLastAnswerCorrect ? Color.green.opacity(0.2) : Color.red.opacity(0.2)
            }
        }
        return Color.blue.opacity(0.1)
    }
    
    func answerTextColor(for index: Int) -> Color {
        if viewModel.showingFeedback {
            if index == viewModel.currentQuestion.correctAnswerIndex {
                return Color.green
            } else if index == viewModel.lastSelectedAnswerIndex && !viewModel.isLastAnswerCorrect {
                return Color.red
            }
        }
        return .primary
    }
    
    var resultsView: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Header
                VStack(spacing: 16) {
                    Text("Quiz Complete!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    // Book and difficulty
                    if let book = viewModel.selectedBook {
                        HStack {
                            Text(book.rawValue)
                                .font(.subheadline)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color.blue.opacity(0.1))
                                .foregroundColor(.blue)
                                .cornerRadius(10)
                            
                            if let difficulty = viewModel.selectedDifficulty {
                                Text(difficulty.rawValue)
                                    .font(.subheadline)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(difficultyColor(difficulty).opacity(0.1))
                                    .foregroundColor(difficultyColor(difficulty))
                                    .cornerRadius(10)
                            } else {
                                Text("All Levels")
                                    .font(.subheadline)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(Color.purple.opacity(0.1))
                                    .foregroundColor(.purple)
                                    .cornerRadius(10)
                            }
                            
                            if let count = viewModel.selectedQuestionCount {
                                Text("\(count) Questions")
                                    .font(.subheadline)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(Color.teal.opacity(0.1))
                                    .foregroundColor(.teal)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    
                    Text("Your score: \(viewModel.score) out of \(viewModel.questions.count)")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    
                    // Score circle
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.2), lineWidth: 15)
                            .frame(width: 150, height: 150)
                        
                        Circle()
                            .trim(from: 0, to: CGFloat(viewModel.score) / CGFloat(viewModel.questions.count))
                            .stroke(
                                viewModel.score > viewModel.questions.count / 2 ? Color.green : Color.orange,
                                style: StrokeStyle(lineWidth: 15, lineCap: .round)
                            )
                            .frame(width: 150, height: 150)
                            .rotationEffect(.degrees(-90))
                        
                        Text("\(Int((Double(viewModel.score) / Double(viewModel.questions.count)) * 100))%")
                            .font(.system(size: 36, weight: .bold))
                    }
                    .padding(.vertical)
                }
                
                // Question results
                VStack(alignment: .leading, spacing: 16) {
                    Text("Question Summary")
                        .font(.headline)
                        .padding(.leading)
                    
                    ForEach(viewModel.questions) { question in
                        HStack(alignment: .top, spacing: 12) {
                            if question.isAnsweredCorrectly == true {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.system(size: 20))
                            } else {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.red)
                                    .font(.system(size: 20))
                            }
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(question.text)
                                    .fontWeight(.medium)
                                
                                Text(question.verseReference)
                                    .font(.footnote)
                                    .italic()
                                    .foregroundColor(.secondary)
                                
                                if !question.verseText.isEmpty {
                                    Text(question.verseText)
                                        .font(.caption)
                                        .italic()
                                        .foregroundColor(.secondary)
                                        .padding(.top, 2)
                                }
                                
                                Text("Correct answer: \(question.options[question.correctAnswerIndex])")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.1))
                        )
                        .padding(.horizontal)
                    }
                }
                
                HStack(spacing: 20) {
                    // Restart button
                    Button(action: {
                        viewModel.restartQuiz()
                    }) {
                        Text("Restart Quiz")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    // Return to menu button
                    Button(action: {
                        viewModel.returnToSelection()
                    }) {
                        Text("Back to Menu")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.secondary)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 30)
            }
            .padding(.vertical)
        }
        .navigationTitle("Results")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func difficultyColor(_ difficulty: Difficulty) -> Color {
        switch difficulty {
        case .easy: return .green
        case .medium: return .orange
        case .hard: return .red
        }
    }
}

#Preview {
    ContentView()
}
