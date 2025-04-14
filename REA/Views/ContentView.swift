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

// MARK: - Temporary View Modifiers

// Temporary Tag Style
struct TagStyle: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(color.opacity(0.15))
            .foregroundColor(color)
            .cornerRadius(8)
    }
}

// Add extension for the tagStyle modifier
extension View {
    func tagStyle(color: Color) -> some View {
        self.modifier(TagStyle(color: color))
    }
    
    func optionButtonStyle(isSelected: Bool, isCorrect: Bool? = nil) -> some View {
        self
            .font(.body.weight(.medium))
            .frame(maxWidth: .infinity)
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? color(isCorrect: isCorrect) : Color.white)
                    .shadow(color: shadowColor(isSelected: isSelected, isCorrect: isCorrect), 
                            radius: isSelected ? 5 : 2,
                            x: 0, y: isSelected ? 2 : 1)
            )
            .foregroundColor(textColor(isSelected: isSelected, isCorrect: isCorrect))
    }
    
    func primaryButtonStyle() -> some View {
        self
            .font(.headline.weight(.semibold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color("PrimaryColor"), Color("PrimaryColor").opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .cornerRadius(12)
                .shadow(color: Color("PrimaryColor").opacity(0.3), radius: 5, x: 0, y: 2)
            )
            .contentShape(Rectangle())
    }
    
    func secondaryButtonStyle() -> some View {
        self
            .font(.headline.weight(.semibold))
            .foregroundColor(Color("PrimaryColor"))
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color("PrimaryColor"), lineWidth: 1.5)
                    )
            )
            .contentShape(Rectangle())
    }
    
    private func color(isCorrect: Bool?) -> Color {
        if let isCorrect = isCorrect {
            return isCorrect ? Color.green.opacity(0.15) : Color.red.opacity(0.15)
        }
        return Color("AccentColor").opacity(0.2)
    }
    
    private func textColor(isSelected: Bool, isCorrect: Bool?) -> Color {
        if let isCorrect = isCorrect, isSelected {
            return isCorrect ? .green : .red
        }
        return isSelected ? Color("AccentColor") : .primary
    }
    
    private func shadowColor(isSelected: Bool, isCorrect: Bool?) -> Color {
        if let isCorrect = isCorrect, isSelected {
            return (isCorrect ? Color.green : Color.red).opacity(0.2)
        }
        return Color.black.opacity(0.05)
    }
}

struct ContentView: View {
    @StateObject private var viewModel = QuestionViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            if viewModel.isSelectionViewActive {
                SelectionView(viewModel: viewModel)
                    .navigationTitle("Bible Quiz")
                    .background(Color.appBackground)
            } else if viewModel.showingResults {
                resultsView
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
                                    .optionButtonStyle(
                                        isSelected: viewModel.lastSelectedAnswerIndex == index,
                                        isCorrect: viewModel.showingFeedback ? 
                                            (index == viewModel.currentQuestion.correctAnswerIndex) ||
                                            (index == viewModel.lastSelectedAnswerIndex && viewModel.isLastAnswerCorrect) : nil
                                    )
                            }
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
                }
                #endif
            }
            .background(AppColors.background.edgesIgnoringSafeArea(.all))
        }
    }
    
    var feedbackView: some View {
        VStack(spacing: AppLayout.standardSpacing) {
            // Feedback message with icon
            HStack(spacing: AppLayout.tightSpacing) {
                Image(systemName: viewModel.isLastAnswerCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(viewModel.isLastAnswerCorrect ? AppColors.success : AppColors.error)
                
                Text(viewModel.isLastAnswerCorrect ? "Correct!" : "Incorrect!")
                    .font(AppFonts.title)
                    .foregroundColor(viewModel.isLastAnswerCorrect ? AppColors.success : AppColors.error)
            }
            .padding(.top)
            
            if !viewModel.isLastAnswerCorrect {
                Text("The correct answer is:")
                    .font(AppFonts.subheadline)
                    .foregroundColor(.secondary)
                
                Text(viewModel.currentQuestion.options[viewModel.currentQuestion.correctAnswerIndex])
                    .font(AppFonts.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            // Display the Bible verse text
            VStack(spacing: 8) {
                Text(viewModel.currentQuestion.verseReference)
                    .font(AppFonts.headline)
                
                Text(viewModel.currentQuestion.verseText)
                    .font(AppFonts.body)
                    .italic()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
                    .fill(colorScheme == .dark ? Color.black.opacity(0.3) : Color.black.opacity(0.05))
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
                .primaryButtonStyle()
            }
            .padding(.horizontal)
            .padding(.top, 10)
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
    
    var resultsView: some View {
        ScrollView {
            VStack(spacing: AppLayout.wideSpacing) {
                // Header
                VStack(spacing: AppLayout.standardSpacing) {
                    Text("Quiz Complete!")
                        .font(AppFonts.largeTitle)
                    
                    // Book and difficulty
                    if let book = viewModel.selectedBook {
                        HStack {
                            Text(book.rawValue)
                                .tagStyle(color: AppColors.info)
                            
                            if let difficulty = viewModel.selectedDifficulty {
                                Text(difficulty.rawValue)
                                    .tagStyle(color: AppColors.difficultyColor(difficulty))
                            } else {
                                Text("All Levels")
                                    .tagStyle(color: Color.purple)
                            }
                            
                            if let count = viewModel.selectedQuestionCount {
                                Text("\(count) Questions")
                                    .tagStyle(color: Color.teal)
                            }
                        }
                    }
                    
                    Text("Your score: \(viewModel.score) out of \(viewModel.questions.count)")
                        .font(AppFonts.headline)
                        .foregroundColor(.secondary)
                    
                    // Score circle
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.2), lineWidth: 15)
                            .frame(width: 150, height: 150)
                        
                        Circle()
                            .trim(from: 0, to: CGFloat(viewModel.score) / CGFloat(viewModel.questions.count))
                            .stroke(
                                scoreGradient,
                                style: StrokeStyle(lineWidth: 15, lineCap: .round)
                            )
                            .frame(width: 150, height: 150)
                            .rotationEffect(.degrees(-90))
                            .animation(AppAnimation.standard, value: viewModel.score)
                        
                        VStack(spacing: 4) {
                            Text("\(Int((Double(viewModel.score) / Double(viewModel.questions.count)) * 100))%")
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(scoreColor)
                            
                            Text("Score")
                                .font(AppFonts.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical)
                }
                
                // Question results
                VStack(alignment: .leading, spacing: AppLayout.standardSpacing) {
                    Text("Question Summary")
                        .font(AppFonts.headline)
                        .padding(.leading)
                    
                    ForEach(viewModel.questions) { question in
                        HStack(alignment: .top, spacing: AppLayout.standardSpacing) {
                            if question.isAnsweredCorrectly == true {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(AppColors.success)
                                    .font(.system(size: 20))
                            } else {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(AppColors.error)
                                    .font(.system(size: 20))
                            }
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(question.text)
                                    .font(AppFonts.subheadline)
                                
                                Text(question.verseReference)
                                    .font(AppFonts.caption)
                                    .italic()
                                    .foregroundColor(.secondary)
                                
                                if !question.verseText.isEmpty {
                                    Text(question.verseText)
                                        .font(AppFonts.caption)
                                        .italic()
                                        .foregroundColor(.secondary)
                                        .padding(.top, 2)
                                }
                                
                                Text("Correct answer: \(question.options[question.correctAnswerIndex])")
                                    .font(AppFonts.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
                                .fill(colorScheme == .dark ? Color.black.opacity(0.2) : Color.black.opacity(0.03))
                        )
                        .padding(.horizontal)
                    }
                }
                
                HStack(spacing: AppLayout.standardSpacing) {
                    // Restart button
                    Button(action: {
                        withAnimation(AppAnimation.standard) {
                            viewModel.restartQuiz()
                        }
                    }) {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                            Text("Restart Quiz")
                        }
                        .primaryButtonStyle()
                    }
                    
                    // Return to menu button
                    Button(action: {
                        withAnimation(AppAnimation.standard) {
                            viewModel.returnToSelection()
                        }
                    }) {
                        HStack {
                            Image(systemName: "house")
                            Text("Back to Menu")
                        }
                        .secondaryButtonStyle()
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
        .background(AppColors.background.edgesIgnoringSafeArea(.all))
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
