import SwiftUI

struct OptionView: View {
    let option: String
    let index: Int
    let isSelected: Bool
    let isCorrect: Bool?
    let showingFeedback: Bool
    let action: () -> Void
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isPressed = false
    @State private var animateCorrect = false
    @State private var wiggle = false
    
    private var backgroundColor: Color {
        if !showingFeedback {
            return isSelected ? AppColors.primary : (colorScheme == .dark ? Color.black : Color.white)
        } else if let isCorrect = isCorrect {
            return isCorrect ? .green : .red
        } else {
            return .gray
        }
    }
    
    private var textColor: Color {
        if !showingFeedback {
            return isSelected ? .white : .primary
        } else if let isCorrect = isCorrect, isCorrect {
            return .white
        } else {
            return isSelected ? .white : .primary
        }
    }
    
    var body: some View {
        Button(action: {
            #if os(iOS)
            HapticManager.shared.selectionFeedback()
            #endif
            
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                isPressed = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    isPressed = false
                }
                action()
            }
        }) {
            HStack {
                Text("\(["A", "B", "C", "D"][index])")
                    .font(AppFonts.headline)
                    .foregroundColor(textColor)
                    .padding(8)
                    .background(Circle().fill(backgroundColor))
                    .rotationEffect(.degrees(wiggle ? -5 : 0))
                    .animation(
                        showingFeedback && isSelected && isCorrect == false ? 
                            Animation.easeInOut(duration: 0.1).repeatCount(5, autoreverses: true) : 
                            .default,
                        value: wiggle
                    )
                
                Spacer()
                
                Text(option)
                    .font(AppFonts.body)
                    .foregroundColor(textColor)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                if showingFeedback && isCorrect == true {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.white)
                        .scaleEffect(animateCorrect ? 1.2 : 0.8)
                        .animation(
                            Animation.spring(response: 0.3, dampingFraction: 0.5).repeatCount(1),
                            value: animateCorrect
                        )
                        .onAppear {
                            animateCorrect = true
                        }
                } else if showingFeedback && isSelected && isCorrect == false {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
                    .fill(backgroundColor)
                    .shadow(
                        color: isSelected ? backgroundColor.opacity(0.6) : Color.black.opacity(0.1), 
                        radius: isSelected ? 8 : 4,
                        x: 0, y: isSelected ? 4 : 2
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
                    .stroke(isSelected && !showingFeedback ? .clear : backgroundColor.opacity(0.7), lineWidth: 1)
            )
            .scaleEffect(isPressed ? 0.98 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal)
        .contentShape(Rectangle())
        .onChange(of: showingFeedback) { newValue in
            if newValue && isSelected && isCorrect == false {
                wiggle = true
            }
        }
        .transition(.asymmetric(
            insertion: .scale(scale: 0.9).combined(with: .opacity),
            removal: .opacity
        ))
    }
}
