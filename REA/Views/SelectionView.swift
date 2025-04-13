//
//  SelectionView.swift
//  REA
//
//  Created by Tim Zhao on 4/5/25.
//
import SwiftUI

struct SelectionView: View {
    @ObservedObject var viewModel: QuestionViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Bible Quiz")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            // Bible Book Selection
            VStack(alignment: .leading, spacing: 8) {
                Text("Select a Book:")
                    .font(.headline)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(viewModel.availableBooks, id: \.self) { book in
                            Button(action: {
                                viewModel.selectedBook = book
                            }) {
                                Text(book.rawValue)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .background(
                                        viewModel.selectedBook == book ?
                                        Color.blue : Color.blue.opacity(0.1)
                                    )
                                    .foregroundColor(
                                        viewModel.selectedBook == book ?
                                        Color.white : Color.blue
                                    )
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding(.horizontal, 5)
                }
            }
            .padding(.horizontal)
            
            // Difficulty Selection
            if viewModel.selectedBook != nil {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Select Difficulty:")
                        .font(.headline)
                    
                    HStack(spacing: 12) {
                        ForEach(Difficulty.allCases, id: \.self) { difficulty in
                            Button(action: {
                                viewModel.selectedDifficulty = difficulty
                            }) {
                                Text(difficulty.rawValue)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .background(
                                        viewModel.selectedDifficulty == difficulty ?
                                        difficultyColor(difficulty) : difficultyColor(difficulty).opacity(0.1)
                                    )
                                    .foregroundColor(
                                        viewModel.selectedDifficulty == difficulty ?
                                        Color.white : difficultyColor(difficulty)
                                    )
                                    .cornerRadius(20)
                            }
                        }
                        
                        Button(action: {
                            viewModel.selectedDifficulty = nil
                        }) {
                            Text("All")
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(
                                    viewModel.selectedDifficulty == nil && viewModel.selectedBook != nil ?
                                    Color.purple : Color.purple.opacity(0.1)
                                )
                                .foregroundColor(
                                    viewModel.selectedDifficulty == nil && viewModel.selectedBook != nil ?
                                    Color.white : Color.purple
                                )
                                .cornerRadius(20)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            Spacer()
            
            // Info display (question count)
            if viewModel.selectedBook != nil {
                Text("\(viewModel.questionCount) Questions Available")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 5)
            }
            
            // Start Button
            if viewModel.selectedBook != nil {
                Button(action: {
                    viewModel.loadQuestions(
                        book: viewModel.selectedBook,
                        difficulty: viewModel.selectedDifficulty
                    )
                }) {
                    Text("Start Quiz")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom)
                .disabled(viewModel.questionCount == 0)
            }
        }
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
    SelectionView(viewModel: QuestionViewModel())
}
