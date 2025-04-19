//
//  SelectionView.swift
//  REA
//
//  Created by Tim Zhao on 4/5/25.
//
import SwiftUI

// MARK: - Loading Animation
struct LoadingSpinnerView: View {
    @State private var isAnimating = false
    let color: Color

    init(color: Color = AppColors.primary) {
        self.color = color
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.2), lineWidth: 8)
                .frame(width: 60, height: 60)

            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(color, lineWidth: 8)
                .frame(width: 60, height: 60)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
                .onAppear {
                    isAnimating = true
                }
        }
    }
}

struct SelectionView: View {
    @ObservedObject var viewModel: QuestionViewModel
    @Environment(\.colorScheme) var colorScheme
    @State private var animateButtons = false
    @State private var animateQuestionOptions = false
    @State private var previousDifficulty: Difficulty? = nil
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let itemWidth = min(max(screenWidth / 4 - 20, 80), 120) // Adaptive width based on screen size
            
            ScrollView {
                VStack(alignment: .leading, spacing: AppLayout.wideSpacing) {
                    // Bible Book Selection - Adaptive grid layout
                    selectionGroup(title: "Select a Book:", icon: "book") {
                        LazyVGrid(
                            columns: [
                                GridItem(.adaptive(minimum: 80, maximum: 120), spacing: 12)
                            ],
                            spacing: 12
                        ) {
                            ForEach(viewModel.availableBooks, id: \.self) { book in
                                Button(action: {
                                    withAnimation(AppAnimation.quick) {
                                        viewModel.selectedBook = book
                                        // Reset subsequent selections when book changes
                                        viewModel.selectedDifficulty = nil
                                        viewModel.selectedQuestionCount = nil
                                    }
                                }) {
                                    Text(book.abbreviation)
                                        .font(AppFonts.subheadline)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 16)
                                }
                                .selectionButtonStyle(
                                    isSelected: viewModel.selectedBook == book,
                                    selectedColor: AppColors.primary
                                )
                                .padding(.vertical, 4)
                                .offset(y: animateButtons ? 0 : 5)
                                .animation(
                                    AppAnimation.bounce.delay(Double(viewModel.availableBooks.firstIndex(of: book) ?? 0) * 0.03),
                                    value: animateButtons
                                )
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        
                        // Display full book name dynamically
                        if let selectedBook = viewModel.selectedBook {
                            HStack(spacing: 8) {
                                Image(systemName: "book.fill")
                                    .foregroundColor(AppColors.primary)
                                Text("\(selectedBook.rawValue)")
                                    .font(AppFonts.headline)
                                    .foregroundColor(.blue) // Changed color to blue
                            }
                            .padding(.top, 12)
                            .padding(.horizontal, 20) // Align with other sections
                        }
                    }
                    
                    // Difficulty Selection - Adaptive layout
                    if viewModel.selectedBook != nil {
                        selectionGroup(title: "Select Difficulty:", icon: "speedometer") {
                            let difficultyLayout = viewModel.selectedDifficulty == nil ? 
                                AnyLayout(HStackLayout(alignment: .center, spacing: 8)) : 
                                AnyLayout(FlowLayout(spacing: 8, minWidth: itemWidth))
                            
                            difficultyLayout {
                                ForEach(Difficulty.allCases, id: \.self) { difficulty in
                                    Button(action: {
                                        previousDifficulty = viewModel.selectedDifficulty
                                        
                                        if viewModel.selectedDifficulty != nil && viewModel.selectedDifficulty != difficulty {
                                            withAnimation(AppAnimation.quick) {
                                                animateQuestionOptions = false
                                                viewModel.selectedQuestionCount = nil
                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                                withAnimation(AppAnimation.quick) {
                                                    viewModel.selectedDifficulty = difficulty
                                                }
                                                
                                                withAnimation(AppAnimation.bounce.delay(0.1)) {
                                                    animateQuestionOptions = true
                                                }
                                            }
                                        } else {
                                            withAnimation(AppAnimation.quick) {
                                                viewModel.selectedDifficulty = difficulty
                                                if previousDifficulty != difficulty {
                                                    viewModel.selectedQuestionCount = nil
                                                }
                                            }
                                            
                                            withAnimation(AppAnimation.bounce.delay(0.1)) {
                                                animateQuestionOptions = true
                                            }
                                        }
                                    }) {
                                        VStack {
                                            Image(systemName: difficultyIcon(difficulty))
                                                .font(.system(size: 24))
                                                .padding(.bottom, 5)
                                            Text(difficulty.rawValue)
                                                .font(AppFonts.subheadline)
                                        }
                                        .frame(minWidth: itemWidth, minHeight: itemWidth)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 8)
                                        .background(
                                            RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
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
                                            RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
                                                .stroke(
                                                    viewModel.selectedDifficulty == difficulty ? Color.clear : AppColors.difficultyColor(difficulty).opacity(0.5),
                                                    lineWidth: 1
                                                )
                                        )
                                    }
                                }
                            }
                            .padding(.horizontal, screenWidth > 400 ? 16 : 8)
                            .frame(maxWidth: .infinity)
                        }
                        .transition(.move(edge: .leading).combined(with: .opacity))
                    }
                    
                    // Question Count Selection - Adaptive layout
                    if viewModel.selectedBook != nil && viewModel.availableQuestionCounts.count > 0 {
                        selectionGroup(title: "How many questions?", icon: "number.circle") {
                            let buttonWidth = min(max(screenWidth / CGFloat(viewModel.availableQuestionCounts.count + 1) - 10, 60), 100)
                            let buttonHeight = buttonWidth * 0.42 // Reduce height to ensure spacing between rows
                            
                            FlowLayout(spacing: 8, minWidth: buttonWidth) {
                                ForEach(viewModel.availableQuestionCounts, id: \.self) { count in
                                    Button(action: {
                                        withAnimation(AppAnimation.quick) {
                                            viewModel.selectedQuestionCount = count
                                        }
                                    }) {
                                        VStack {
                                            Text("\(count)")
                                                .font(.system(size: 20, weight: .bold))
                                            Text("Questions")
                                                .font(.caption)
                                        }
                                        .frame(minWidth: buttonWidth, minHeight: buttonHeight)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 8)
                                        .background(
                                            RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
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
                                            RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
                                                .stroke(
                                                    viewModel.selectedQuestionCount == count ? Color.clear : Color.teal.opacity(0.5),
                                                    lineWidth: 1
                                                )
                                        )
                                    }
                                    .primaryButtonStyle()
                                    .scaleEffect(animateQuestionOptions ? 1 : 0.7)
                                    .opacity(animateQuestionOptions ? 1 : 0)
                                    .animation(
                                        AppAnimation.bounce.delay(Double(viewModel.availableQuestionCounts.firstIndex(of: count) ?? 0) * 0.05),
                                        value: animateQuestionOptions
                                    )
                                }
                                
                                // "All" questions button
                                Button(action: {
                                    withAnimation(AppAnimation.quick) {
                                        viewModel.selectedQuestionCount = nil
                                    }
                                }) {
                                    VStack {
                                        Text("All")
                                            .font(.system(size: 20, weight: .bold))
                                        Text("Questions")
                                            .font(.caption)
                                    }
                                    .frame(minWidth: buttonWidth, minHeight: buttonHeight)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 8)
                                    .background(
                                        RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
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
                                        RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
                                            .stroke(
                                                viewModel.selectedQuestionCount == nil && viewModel.selectedBook != nil ? Color.clear : Color.indigo.opacity(0.5),
                                                lineWidth: 1
                                            )
                                    )
                                }
                                .primaryButtonStyle()
                                .scaleEffect(animateQuestionOptions ? 1 : 0.7)
                                .opacity(animateQuestionOptions ? 1 : 0)
                                .animation(
                                    AppAnimation.bounce.delay(Double(viewModel.availableQuestionCounts.count) * 0.05),
                                    value: animateQuestionOptions
                                )
                            }
                            .padding(.horizontal, screenWidth > 400 ? 16 : 8)
                        }
                        .transition(.move(edge: .leading).combined(with: .opacity))
                    }
                    
                    Spacer(minLength: 30)
                    
                    // Info display and Start Button - Keep these centered but more prominent
                    VStack(spacing: AppLayout.standardSpacing) {
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
                        
                        // Start Quiz Button with loading state - Enlarged
                        VStack {
                            if viewModel.isLoading {
                                LoadingSpinnerView(color: AppColors.primary)
                                    .padding(.vertical)
                                    .transition(.opacity)
                            } else if viewModel.selectedBook != nil {
                                Button(action: {
                                    // Show loading state
                                    withAnimation {
                                        viewModel.isLoading = true
                                    }
                                    
                                    // Delayed start to show loading animation
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                        withAnimation(AppAnimation.standard) {
                                            viewModel.loadQuestions(
                                                book: viewModel.selectedBook,
                                                difficulty: viewModel.selectedDifficulty,
                                                count: viewModel.selectedQuestionCount
                                            )
                                            viewModel.isLoading = false
                                        }
                                    }
                                }) {
                                    HStack {
                                        Text("Start Quiz")
                                            .font(.headline)
                                        Image(systemName: "play.fill")
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 60) // Taller button for better visibility
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [AppColors.primary, AppColors.primary.opacity(0.8)]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                        .cornerRadius(AppLayout.cornerRadius)
                                        .shadow(color: AppColors.primary.opacity(0.3), radius: 5, x: 0, y: 2)
                                    )
                                    .foregroundColor(.white)
                                }
                                .primaryButtonStyle()
                                .padding(.horizontal)
                                .padding(.bottom)
                                .disabled(viewModel.questionCount == 0)
                                .opacity(viewModel.questionCount == 0 ? 0.5 : 1)
                                .transition(.asymmetric(
                                    insertion: .scale.combined(with: .opacity),
                                    removal: .opacity
                                ))
                                .scaleEffect(animateButtons ? 1 : 0.8)
                                .animation(
                                    Animation.spring(response: 0.6, dampingFraction: 0.7).delay(0.5),
                                    value: animateButtons
                                )
                            }
                        }
                    }
                    .frame(maxWidth: .infinity) // Keep footer content centered
                }
                .padding(.horizontal, screenWidth > 400 ? 16 : 10)
                .frame(minHeight: geometry.size.height, alignment: .leading) // Set left alignment
            }
        }
        .onAppear {
            withAnimation(AppAnimation.standard.delay(0.3)) {
                animateButtons = true
            }
            DispatchQueue.main.async {
                if viewModel.selectedDifficulty != nil {
                    animateQuestionOptions = true
                }
            }
        }
        .onChange(of: viewModel.selectedBook) { _ in
            animateQuestionOptions = false
        }
        .background(AppColors.background.edgesIgnoringSafeArea(.all))
    }
    
    // Helper function to create consistent selection groups
    private func selectionGroup<Content: View>(
        title: String, 
        icon: String, 
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: AppLayout.standardSpacing) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .foregroundColor(AppColors.primary)
                Text(title)
                    .font(AppFonts.headline)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 6)
            
            content()
                .padding(.top, 2)
        }
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity, alignment: .leading)
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

// FlowLayout to wrap content based on available width
struct FlowLayout: Layout {
    var spacing: CGFloat
    var minWidth: CGFloat
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
        let width = proposal.width ?? 0
        var height: CGFloat = 0
        var rowWidth: CGFloat = 0
        var rowHeight: CGFloat = 0
        
        for subview in subviews {
            let viewSize = subview.sizeThatFits(.unspecified)
            
            if rowWidth + viewSize.width + spacing > width {
                // Start a new row
                height += rowHeight + spacing
                rowWidth = viewSize.width
                rowHeight = viewSize.height
            } else {
                // Add to current row
                rowWidth += viewSize.width + spacing
                rowHeight = max(rowHeight, viewSize.height)
            }
        }
        
        // Add last row
        height += rowHeight
        
        return CGSize(width: width, height: height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
        let width = bounds.width
        var rowX: CGFloat = bounds.minX
        var rowY: CGFloat = bounds.minY
        var rowHeight: CGFloat = 0
        
        for subview in subviews {
            let viewSize = subview.sizeThatFits(.unspecified)
            
            if rowX + viewSize.width > bounds.maxX {
                // Start a new row
                rowX = bounds.minX
                rowY += rowHeight + spacing
                rowHeight = 0
            }
            
            subview.place(
                at: CGPoint(x: rowX, y: rowY),
                proposal: ProposedViewSize(width: viewSize.width, height: viewSize.height)
            )
            
            rowX += viewSize.width + spacing
            rowHeight = max(rowHeight, viewSize.height)
        }
    }
}

#Preview {
    SelectionView(viewModel: QuestionViewModel())
}
