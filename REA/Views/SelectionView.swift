//
//  SelectionView.swift
//  REA
//
//  Created by Tim Zhao on 4/5/25.
//
import SwiftUI

// Temporary AppColors struct until the real one is recognized by Xcode
struct AppColors {
    // Primary colors
    static let primary = Color("PrimaryColor")
    static let secondary = Color("SecondaryColor")
    static let accent = Color("AccentColor")
    
    // Semantic colors
    static let success = Color.green
    static let warning = Color.orange
    static let error = Color.red
    static let info = Color.blue
    
    // Background colors
    static let background = Color("BackgroundColor")
    static let cardBackground = Color("CardBackgroundColor")
    
    // Difficulty colors
    static func difficultyColor(_ difficulty: Difficulty) -> Color {
        switch difficulty {
        case .easy: return success
        case .medium: return warning
        case .hard: return error
        }
    }
    
    // Gradient presets
    static let primaryGradient = LinearGradient(
        gradient: Gradient(colors: [primary, primary.opacity(0.8)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let accentGradient = LinearGradient(
        gradient: Gradient(colors: [accent, accent.opacity(0.8)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

// Temporary AppFonts struct until the real one is recognized by Xcode
struct AppFonts {
    // Size and weight combinations
    static let largeTitle = Font.largeTitle.weight(.bold)
    static let title = Font.title.weight(.semibold)
    static let headline = Font.headline.weight(.semibold)
    static let subheadline = Font.subheadline.weight(.medium)
    static let body = Font.body
    static let caption = Font.caption
    
    // Special text styles
    static let questionTitle = Font.title2.weight(.bold)
    static let optionText = Font.body.weight(.medium)
    static let buttonLabel = Font.headline.weight(.semibold)
}

// Temporary Animation struct until the real one is recognized by Xcode
struct AppAnimation {
    static let standard = Animation.easeInOut(duration: 0.3)
    static let quick = Animation.easeOut(duration: 0.2)
    static let bounce = Animation.spring(response: 0.4, dampingFraction: 0.6)
}

// Remove this extension once AppTheme is properly linked
extension Font {
    static let appLargeTitle = Font.largeTitle.weight(.bold)
    static let appTitle = Font.title.weight(.semibold)
    static let appHeadline = Font.headline.weight(.semibold)
    static let appSubheadline = Font.subheadline.weight(.medium)
    static let appCaption = Font.caption
}

// Remove this once AppLayout is properly linked
enum AppLayout {
    static let standardSpacing: CGFloat = 16
    static let tightSpacing: CGFloat = 8
    static let wideSpacing: CGFloat = 24
    static let cornerRadius: CGFloat = 12
    static let largeCornerRadius: CGFloat = 16
    static let buttonHeight: CGFloat = 50
    static let standardPadding: CGFloat = 16
}

struct SelectionView: View {
    @ObservedObject var viewModel: QuestionViewModel
    @Environment(\.colorScheme) var colorScheme
    @State private var animateButtons = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: AppLayout.wideSpacing) {
                    // App title with icon
                    VStack(spacing: AppLayout.tightSpacing) {
                        Image(systemName: "book.fill")
                            .font(.system(size: 50))
                            .foregroundColor(AppColors.primary)
                            .padding()
                            .background(
                                Circle()
                                    .fill(AppColors.primary.opacity(0.1))
                            )
                            .overlay(
                                Circle()
                                    .stroke(AppColors.primary.opacity(0.2), lineWidth: 2)
                            )
                        
                        Text("Bible Quiz")
                            .font(AppFonts.largeTitle)
                            .padding(.bottom, 5)
                        
                        Text("Test your knowledge of the Bible")
                            .font(AppFonts.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top)
                    
                    // Bible Book Selection
                    selectionGroup(title: "Select a Book:", icon: "book") {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: AppLayout.standardSpacing) {
                                ForEach(viewModel.availableBooks, id: \.self) { book in
                                    Button(action: {
                                        withAnimation(AppAnimation.quick) {
                                            viewModel.selectedBook = book
                                            // Reset subsequent selections when book changes
                                            viewModel.selectedDifficulty = nil
                                            viewModel.selectedQuestionCount = nil
                                        }
                                    }) {
                                        Text(book.rawValue)
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 16)
                                            .background(
                                                RoundedRectangle(cornerRadius: AppLayout.largeCornerRadius)
                                                    .fill(viewModel.selectedBook == book ? 
                                                         AppColors.primary : 
                                                         (colorScheme == .dark ? Color.black.opacity(0.3) : Color.white))
                                                    .shadow(
                                                        color: viewModel.selectedBook == book ? 
                                                            AppColors.primary.opacity(0.3) : Color.black.opacity(0.05),
                                                        radius: viewModel.selectedBook == book ? 5 : 2,
                                                        x: 0, y: 2
                                                    )
                                            )
                                            .foregroundColor(
                                                viewModel.selectedBook == book ?
                                                Color.white : AppColors.primary
                                            )
                                            .overlay(
                                                RoundedRectangle(cornerRadius: AppLayout.largeCornerRadius)
                                                    .stroke(
                                                        viewModel.selectedBook == book ? Color.clear : AppColors.primary.opacity(0.5),
                                                        lineWidth: 1
                                                    )
                                            )
                                    }
                                    .offset(y: animateButtons ? -5 : 0)
                                    .animation(
                                        AppAnimation.bounce.delay(Double(viewModel.availableBooks.firstIndex(of: book) ?? 0) * 0.05),
                                        value: animateButtons
                                    )
                                }
                            }
                            .padding(.horizontal, 5)
                        }
                    }
                    
                    // Difficulty Selection
                    if viewModel.selectedBook != nil {
                        selectionGroup(title: "Select Difficulty:", icon: "speedometer") {
                            HStack(spacing: AppLayout.standardSpacing) {
                                ForEach(Difficulty.allCases, id: \.self) { difficulty in
                                    Button(action: {
                                        withAnimation(AppAnimation.quick) {
                                            viewModel.selectedDifficulty = difficulty
                                            viewModel.selectedQuestionCount = nil
                                        }
                                    }) {
                                        HStack {
                                            Image(systemName: difficultyIcon(difficulty))
                                                .font(.caption)
                                            Text(difficulty.rawValue)
                                        }
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 16)
                                        .background(
                                            RoundedRectangle(cornerRadius: AppLayout.largeCornerRadius)
                                                .fill(viewModel.selectedDifficulty == difficulty ? 
                                                     AppColors.difficultyColor(difficulty) : 
                                                     (colorScheme == .dark ? Color.black.opacity(0.3) : Color.white))
                                                .shadow(
                                                    color: viewModel.selectedDifficulty == difficulty ? 
                                                        AppColors.difficultyColor(difficulty).opacity(0.3) : Color.black.opacity(0.05),
                                                    radius: viewModel.selectedDifficulty == difficulty ? 5 : 2,
                                                    x: 0, y: 2
                                                )
                                        )
                                        .foregroundColor(
                                            viewModel.selectedDifficulty == difficulty ?
                                            Color.white : AppColors.difficultyColor(difficulty)
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: AppLayout.largeCornerRadius)
                                                .stroke(
                                                    viewModel.selectedDifficulty == difficulty ? Color.clear : AppColors.difficultyColor(difficulty).opacity(0.5),
                                                    lineWidth: 1
                                                )
                                        )
                                    }
                                }
                                
                                Button(action: {
                                    withAnimation(AppAnimation.quick) {
                                        viewModel.selectedDifficulty = nil
                                        viewModel.selectedQuestionCount = nil
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: "arrow.up.and.down")
                                            .font(.caption)
                                        Text("All")
                                    }
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .background(
                                        RoundedRectangle(cornerRadius: AppLayout.largeCornerRadius)
                                            .fill(viewModel.selectedDifficulty == nil && viewModel.selectedBook != nil ? 
                                                 Color.purple : 
                                                 (colorScheme == .dark ? Color.black.opacity(0.3) : Color.white))
                                            .shadow(
                                                color: viewModel.selectedDifficulty == nil && viewModel.selectedBook != nil ? 
                                                    Color.purple.opacity(0.3) : Color.black.opacity(0.05),
                                                radius: viewModel.selectedDifficulty == nil && viewModel.selectedBook != nil ? 5 : 2,
                                                x: 0, y: 2
                                            )
                                    )
                                    .foregroundColor(
                                        viewModel.selectedDifficulty == nil && viewModel.selectedBook != nil ?
                                        Color.white : Color.purple
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: AppLayout.largeCornerRadius)
                                            .stroke(
                                                viewModel.selectedDifficulty == nil && viewModel.selectedBook != nil ? Color.clear : Color.purple.opacity(0.5),
                                                lineWidth: 1
                                            )
                                    )
                                }
                            }
                        }
                        .transition(.move(edge: .leading).combined(with: .opacity))
                    }
                    
                    // Question Count Selection
                    if viewModel.selectedBook != nil && viewModel.availableQuestionCounts.count > 0 {
                        selectionGroup(title: "How many questions?", icon: "number.circle") {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: AppLayout.standardSpacing) {
                                    ForEach(viewModel.availableQuestionCounts, id: \.self) { count in
                                        Button(action: {
                                            withAnimation(AppAnimation.quick) {
                                                viewModel.selectedQuestionCount = count
                                            }
                                        }) {
                                            Text("\(count)")
                                                .padding(.vertical, 8)
                                                .padding(.horizontal, 16)
                                                .background(
                                                    RoundedRectangle(cornerRadius: AppLayout.largeCornerRadius)
                                                        .fill(viewModel.selectedQuestionCount == count ? 
                                                             Color.teal : 
                                                             (colorScheme == .dark ? Color.black.opacity(0.3) : Color.white))
                                                        .shadow(
                                                            color: viewModel.selectedQuestionCount == count ? 
                                                                Color.teal.opacity(0.3) : Color.black.opacity(0.05),
                                                            radius: viewModel.selectedQuestionCount == count ? 5 : 2,
                                                            x: 0, y: 2
                                                        )
                                                )
                                                .foregroundColor(
                                                    viewModel.selectedQuestionCount == count ?
                                                    Color.white : Color.teal
                                                )
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: AppLayout.largeCornerRadius)
                                                        .stroke(
                                                            viewModel.selectedQuestionCount == count ? Color.clear : Color.teal.opacity(0.5),
                                                            lineWidth: 1
                                                        )
                                                )
                                        }
                                    }
                                    
                                    Button(action: {
                                        withAnimation(AppAnimation.quick) {
                                            viewModel.selectedQuestionCount = nil
                                        }
                                    }) {
                                        Text("All")
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 16)
                                            .background(
                                                RoundedRectangle(cornerRadius: AppLayout.largeCornerRadius)
                                                    .fill(viewModel.selectedQuestionCount == nil && viewModel.selectedBook != nil ? 
                                                         Color.indigo : 
                                                         (colorScheme == .dark ? Color.black.opacity(0.3) : Color.white))
                                                    .shadow(
                                                        color: viewModel.selectedQuestionCount == nil && viewModel.selectedBook != nil ? 
                                                            Color.indigo.opacity(0.3) : Color.black.opacity(0.05),
                                                        radius: viewModel.selectedQuestionCount == nil && viewModel.selectedBook != nil ? 5 : 2,
                                                        x: 0, y: 2
                                                    )
                                            )
                                            .foregroundColor(
                                                viewModel.selectedQuestionCount == nil && viewModel.selectedBook != nil ?
                                                Color.white : Color.indigo
                                            )
                                            .overlay(
                                                RoundedRectangle(cornerRadius: AppLayout.largeCornerRadius)
                                                    .stroke(
                                                        viewModel.selectedQuestionCount == nil && viewModel.selectedBook != nil ? Color.clear : Color.indigo.opacity(0.5),
                                                        lineWidth: 1
                                                    )
                                            )
                                    }
                                }
                                .padding(.horizontal, 5)
                            }
                        }
                        .transition(.move(edge: .leading).combined(with: .opacity))
                    }
                    
                    Spacer()
                    
                    // Info display (question count)
                    if viewModel.selectedBook != nil {
                        VStack(spacing: AppLayout.tightSpacing) {
                            HStack {
                                Image(systemName: "info.circle")
                                    .foregroundColor(AppColors.info)
                                Text("\(viewModel.questionCount) Questions Available")
                                    .font(AppFonts.headline)
                                    .foregroundColor(.secondary)
                            }
                            
                            if viewModel.selectedQuestionCount != nil {
                                Text("You selected \(viewModel.selectedQuestionCount!) questions")
                                    .font(AppFonts.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
                                .fill(colorScheme == .dark ? Color.black.opacity(0.3) : Color.black.opacity(0.03))
                        )
                        .padding(.horizontal)
                        .transition(.scale.combined(with: .opacity))
                    }
                    
                    // Start Button
                    if viewModel.selectedBook != nil {
                        Button(action: {
                            withAnimation(AppAnimation.standard) {
                                viewModel.loadQuestions(
                                    book: viewModel.selectedBook,
                                    difficulty: viewModel.selectedDifficulty,
                                    count: viewModel.selectedQuestionCount
                                )
                            }
                        }) {
                            HStack {
                                Text("Start Quiz")
                                Image(systemName: "play.fill")
                            }
                            .primaryButtonStyle()
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .disabled(viewModel.questionCount == 0)
                        .opacity(viewModel.questionCount == 0 ? 0.5 : 1)
                        .transition(.scale.combined(with: .opacity))
                    }
                }
                .frame(minHeight: geometry.size.height)
            }
        }
        .onAppear {
            withAnimation(AppAnimation.standard.delay(0.3)) {
                animateButtons = true
            }
        }
        .background(AppColors.background.edgesIgnoringSafeArea(.all))
    }
    
    // Helper function to create consistent selection groups
    private func selectionGroup<Content: View>(
        title: String, 
        icon: String, 
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: AppLayout.tightSpacing) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .foregroundColor(AppColors.primary)
                Text(title)
                    .font(AppFonts.headline)
            }
            .padding(.horizontal)
            
            content()
        }
    }
    
    private func difficultyColor(_ difficulty: Difficulty) -> Color {
        AppColors.difficultyColor(difficulty)
    }
    
    private func difficultyIcon(_ difficulty: Difficulty) -> String {
        switch difficulty {
        case .easy: return "tortoise"
        case .medium: return "hare"
        case .hard: return "flame"
        }
    }
}

#Preview {
    SelectionView(viewModel: QuestionViewModel())
}
