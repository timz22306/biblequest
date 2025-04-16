import SwiftUI

// Temporary helper until the full AppTheme is recognized by Xcode
extension Color {
    static let appPrimary = Color("PrimaryColor")
    static let appSecondary = Color("SecondaryColor") 
    static let appAccent = Color("AccentColor")
    static let appBackground = Color("BackgroundColor")
    static let appCardBackground = Color("CardBackgroundColor")
    
    static func difficultyColor(_ difficulty: Difficulty) -> Color {
        switch difficulty {
        case .easy: return .green
        case .medium: return .orange
        case .hard: return .red
        }
    }
}

struct ContentView: View {
    @StateObject private var viewModel = QuestionViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            if viewModel.isSelectionViewActive {
                SelectionView(viewModel: viewModel)
                    .background(Color.appBackground)
            } else if viewModel.showingResults {
                resultsView
            } else if viewModel.isReviewingQuestions {
                reviewView
            } else {
                questionView
            }
        }
    }
    
    var questionView: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: AppLayout.standardSpacing) {
                    // Progress bar
                    ProgressView(value: viewModel.progressValue)
                        .tint(AppColors.primary)
                        .padding(.horizontal)
                        .scaleEffect(x: 1, y: 1.5, anchor: .center)
                    
                    // Question counter and book/difficulty
                    HStack {
                        Text("Q\(viewModel.currentQuestionIndex + 1)/\(viewModel.questions.count)")
                            .font(AppFonts.subheadline)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        // Display book and difficulty
                        HStack(spacing: 5) {
                            Text(viewModel.currentQuestion.book.rawValue)
                                .tagStyle(color: AppColors.info)
                            
                            Text(viewModel.currentQuestion.difficulty.rawValue)
                                .tagStyle(color: AppColors.difficultyColor(viewModel.currentQuestion.difficulty))
                        }
                    }
                    .padding(.horizontal)
                    
                    // Question text
                    Text(viewModel.currentQuestion.text)
                        .font(AppFonts.questionTitle)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                    
                    // Verse reference
                    Text(viewModel.currentQuestion.verseReference)
                        .font(AppFonts.caption)
                        .italic()
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    
                    Spacer(minLength: AppLayout.standardSpacing)
                    
                    // Answer options
                    VStack(spacing: AppLayout.tightSpacing) {
                        ForEach(0..<viewModel.currentQuestion.options.count, id: \.self) { index in
                            Button(action: {
                                if !viewModel.showingFeedback {
                                    withAnimation(AppAnimation.quick) {
                                        viewModel.selectAnswer(index)
                                    }
                                }
                            }) {
                                Text(viewModel.currentQuestion.options[index])
                            }
                            .primaryButtonStyle()
                            .disabled(viewModel.showingFeedback)
                            .animation(AppAnimation.quick, value: viewModel.showingFeedback)
                        }
                    }
                    .padding(.horizontal)
                    
                    if viewModel.showingFeedback {
                        feedbackView
                    }
                    
                    Spacer()
                }
                .padding()
                .frame(minHeight: geometry.size.height)
            }
            .navigationTitle("Question")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                #if os(iOS)
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        withAnimation(AppAnimation.standard) {
                            viewModel.returnToSelection()
                        }
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Menu")
                        }
                    }
                    .primaryButtonStyle()
                }
                #else
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        withAnimation(AppAnimation.standard) {
                            viewModel.returnToSelection()
                        }
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Menu")
                        }
                    }
                    .primaryButtonStyle()
                }
                #endif
            }
            .background(AppColors.background.edgesIgnoringSafeArea(.all))
        }
    }
    
    var feedbackView: some View {
        VStack(spacing: AppLayout.wideSpacing) {
            // Feedback content
            VStack(spacing: AppLayout.standardSpacing) {
                // Feedback header
                if viewModel.isLastAnswerCorrect {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .scaleEffect(1.5)
                        Text("Correct!")
                            .font(AppFonts.headline)
                            .foregroundColor(.green)
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(AppLayout.cornerRadius)
                    .transition(.scale.combined(with: .opacity))
                } else {
                    HStack {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                            .scaleEffect(1.5)
                        Text("Incorrect")
                            .font(AppFonts.headline)
                            .foregroundColor(.red)
                    }
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(AppLayout.cornerRadius)
                    .transition(.scale.combined(with: .opacity))
                }
                
                // Verse reference
                Text(viewModel.currentQuestion.verseReference)
                    .font(AppFonts.headline)
                    .transition(.asymmetric(
                        insertion: .scale.combined(with: .opacity),
                        removal: .opacity
                    ))
                    .animation(.easeInOut(duration: 0.5).delay(0.1), value: viewModel.showingFeedback)
                
                Text(viewModel.currentQuestion.verseText)
                    .font(AppFonts.body)
                    .italic()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                    .transition(.asymmetric(
                        insertion: .scale.combined(with: .opacity),
                        removal: .opacity
                    ))
                    .animation(.easeInOut(duration: 0.5).delay(0.2), value: viewModel.showingFeedback)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
                    .fill(colorScheme == .dark ? Color.black.opacity(0.3) : Color.black.opacity(0.05))
                    .shadow(radius: 5)
            )
            .padding(.horizontal)
            
            // Next button
            Button(action: {
                withAnimation(AppAnimation.standard) {
                    viewModel.proceedToNextQuestion()
                }
            }) {
                HStack {
                    Text("Next Question")
                    Image(systemName: "arrow.right")
                }
            }
            .primaryButtonStyle()
            .padding(.horizontal)
            .padding(.top, 10)
            .transition(.asymmetric(
                insertion: .move(edge: .bottom).combined(with: .opacity),
                removal: .opacity
            ))
            .animation(.easeInOut(duration: 0.5).delay(0.3), value: viewModel.showingFeedback)
        }
    }
    
    var resultsView: some View {
        ScrollView {
            VStack(spacing: AppLayout.wideSpacing) {
                // Header
                VStack(spacing: AppLayout.standardSpacing) {
                    Text("Quiz Complete!")
                        .font(AppFonts.largeTitle)
                        .transition(.scale.combined(with: .opacity))
                        .id("quiz-complete-title") // Force animation
                    
                    // Book and difficulty
                    if let book = viewModel.selectedBook {
                        HStack {
                            Text(book.rawValue)
                                .tagStyle(color: AppColors.info)
                                .transition(.asymmetric(
                                    insertion: .scale.combined(with: .opacity),
                                    removal: .opacity
                                ))
                                .animation(.easeInOut(duration: 0.5).delay(0.2), value: viewModel.showingResults)
                            
                            if let difficulty = viewModel.selectedDifficulty {
                                Text(difficulty.rawValue)
                                    .tagStyle(color: AppColors.difficultyColor(difficulty))
                                    .transition(.asymmetric(
                                        insertion: .scale.combined(with: .opacity),
                                        removal: .opacity
                                    ))
                                    .animation(.easeInOut(duration: 0.5).delay(0.3), value: viewModel.showingResults)
                            } else {
                                Text("All Levels")
                                    .tagStyle(color: Color.purple)
                                    .transition(.asymmetric(
                                        insertion: .scale.combined(with: .opacity),
                                        removal: .opacity
                                    ))
                                    .animation(.easeInOut(duration: 0.5).delay(0.3), value: viewModel.showingResults)
                            }
                            
                            if let count = viewModel.selectedQuestionCount {
                                Text("\(count) Questions")
                                    .tagStyle(color: Color.teal)
                                    .transition(.asymmetric(
                                        insertion: .scale.combined(with: .opacity),
                                        removal: .opacity
                                    ))
                                    .animation(.easeInOut(duration: 0.5).delay(0.4), value: viewModel.showingResults)
                            }
                        }
                    }
                    
                    Text("Your score: \(viewModel.score) out of \(viewModel.questions.count)")
                        .font(AppFonts.headline)
                        .foregroundColor(.secondary)
                        .transition(.scale.combined(with: .opacity))
                        .id("score-text") // Force animation
                    
                    // Score circle with animation
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.2), lineWidth: 15)
                            .frame(width: 150, height: 150)
                        
                        Circle()
                            .trim(from: 0, to: CGFloat(viewModel.score) / CGFloat(max(1, viewModel.questions.count)))
                            .stroke(scoreColor, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                            .frame(width: 150, height: 150)
                            .rotationEffect(.degrees(-90))
                            .animation(.easeInOut(duration: 1.5).delay(0.5), value: viewModel.score)
                        
                        Text("\(Int(Double(viewModel.score) / Double(max(1, viewModel.questions.count)) * 100))%")
                            .font(AppFonts.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(scoreColor)
                            .transition(.scale)
                            .animation(.spring().delay(1.0), value: viewModel.score)
                    }
                    .padding()
                }
                
                // Buttons
                VStack(spacing: AppLayout.standardSpacing) {
                    Button(action: {
                        withAnimation(AppAnimation.standard) {
                            viewModel.returnToSelection()
                        }
                    }) {
                        HStack {
                            Image(systemName: "arrow.left")
                            Text("New Quiz")
                        }
                    }
                    .primaryButtonStyle()
                    .appearWithBounce(delay: 0.7)
                    
                    Button(action: {
                        withAnimation(AppAnimation.standard) {
                            viewModel.reviewQuestions()
                        }
                    }) {
                        HStack {
                            Image(systemName: "list.bullet")
                            Text("Review Questions")
                        }
                    }
                    .primaryButtonStyle(backgroundColor: AppColors.secondary)
                    .appearWithBounce(delay: 0.9)
                }
                .padding()
            }
            .padding()
            .transition(.asymmetric(
                insertion: .move(edge: .bottom).combined(with: .opacity),
                removal: .move(edge: .bottom).combined(with: .opacity)
            ))
        }
    }
    
    var reviewView: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Review Your Answers")
                    .font(AppFonts.largeTitle)
                    .padding()
                
                // Display each question and whether it was answered correctly
                ForEach(0..<viewModel.questions.count, id: \.self) { index in
                    let question = viewModel.questions[index]
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Question \(index + 1):")
                            .font(AppFonts.headline)
                        
                        Text(question.text)
                            .font(AppFonts.body)
                            .padding(.bottom, 5)
                        
                        if let isCorrect = question.isAnsweredCorrectly {
                            HStack {
                                Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    .foregroundColor(isCorrect ? .green : .red)
                                
                                Text(isCorrect ? "Correct" : "Incorrect")
                                    .foregroundColor(isCorrect ? .green : .red)
                            }
                        }
                        
                        Text("Correct answer: \(question.options[question.correctAnswerIndex])")
                            .font(AppFonts.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
                            .fill(colorScheme == .dark ? Color.black.opacity(0.3) : Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
                    )
                    .padding(.horizontal)
                }
                
                Button(action: {
                    withAnimation(AppAnimation.standard) {
                        viewModel.showingResults = true
                        viewModel.isReviewingQuestions = false
                    }
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                        Text("Back to Results")
                    }
                }
                .primaryButtonStyle()
                .padding()
            }
            .padding(.vertical)
        }
    }
    
    // MARK: - Helper Properties
    
    var scoreGradient: AngularGradient {
        let score = Double(viewModel.score) / Double(viewModel.questions.count)
        
        if score >= 0.8 {
            return AngularGradient(
                gradient: Gradient(colors: [AppColors.success, AppColors.success.opacity(0.8)]),
                center: .center
            )
        } else if score >= 0.5 {
            return AngularGradient(
                gradient: Gradient(colors: [AppColors.warning, AppColors.warning.opacity(0.8)]),
                center: .center
            )
        } else {
            return AngularGradient(
                gradient: Gradient(colors: [AppColors.error, AppColors.error.opacity(0.8)]),
                center: .center
            )
        }
    }
    
    var scoreColor: Color {
        let score = Double(viewModel.score) / Double(viewModel.questions.count)
        
        if score >= 0.8 {
            return AppColors.success
        } else if score >= 0.5 {
            return AppColors.warning
        } else {
            return AppColors.error
        }
    }
}

#Preview {
    ContentView()
}
