import SwiftUI

// MARK: - Primary Button Style
struct PrimaryButtonStyle: ViewModifier {
    var backgroundColor: Color = AppColors.primary
    var height: CGFloat = AppLayout.buttonHeight
    func body(content: Content) -> some View {
        content
            .font(AppFonts.buttonLabel)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: AppLayout.buttonHeight)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [backgroundColor, backgroundColor.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .cornerRadius(AppLayout.cornerRadius)
                .shadow(color: backgroundColor.opacity(0.3), radius: 5, x: 0, y: 2)
            )
            .contentShape(Rectangle())
    }
}

// MARK: - Secondary Button Style
struct SecondaryButtonStyle: ViewModifier {
    var borderColor: Color = AppColors.primary
    var height: CGFloat = AppLayout.buttonHeight
    func body(content: Content) -> some View {
        content
            .font(AppFonts.buttonLabel)
            .foregroundColor(borderColor)
            .frame(maxWidth: .infinity)
            .frame(height: AppLayout.buttonHeight)
            .background(
                RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
                            .stroke(borderColor, lineWidth: 1.5)
                    )
            )
            .contentShape(Rectangle())
    }
}

// MARK: - Selection Button Style (for book/difficulty/question count)
struct SelectionButtonStyle: ViewModifier {
    var isSelected: Bool
    var selectedColor: Color = AppColors.primary
    var cornerRadius: CGFloat = AppLayout.cornerRadius
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(isSelected ? selectedColor : Color(UIColor.systemBackground))
                    .shadow(
                        color: isSelected ? selectedColor.opacity(0.3) : Color.black.opacity(0.05),
                        radius: isSelected ? 5 : 2, x: 0, y: 2
                    )
            )
            .foregroundColor(isSelected ? Color.white : selectedColor)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(isSelected ? Color.clear : selectedColor.opacity(0.5), lineWidth: 1)
            )
            .contentShape(Rectangle())
    }
}

// MARK: - Option Button Style (for quiz answers)
struct OptionButtonStyle: ViewModifier {
    var isSelected: Bool
    var isCorrect: Bool?
    func body(content: Content) -> some View {
        content
            .font(AppFonts.optionText)
            .frame(maxWidth: .infinity)
            .padding(AppLayout.standardPadding)
            .background(
                RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
                    .fill(backgroundColor)
                    .shadow(color: shadowColor, radius: isSelected ? 5 : 2, x: 0, y: isSelected ? 2 : 1)
            )
            .foregroundColor(textColor)
            .contentShape(Rectangle())
    }
    private var backgroundColor: Color {
        if let isCorrect = isCorrect {
            if isCorrect {
                return AppColors.success.opacity(0.15)
            } else if isSelected {
                return AppColors.error.opacity(0.15)
            }
        }
        return isSelected ? AppColors.accent.opacity(0.2) : Color.white
    }
    private var textColor: Color {
        if let isCorrect = isCorrect {
            if isCorrect {
                return AppColors.success
            } else if isSelected {
                return AppColors.error
            }
        }
        return isSelected ? AppColors.accent : Color.primary
    }
    private var shadowColor: Color {
        if let isCorrect = isCorrect, isSelected {
            return (isCorrect ? AppColors.success : AppColors.error).opacity(0.2)
        }
        return Color.black.opacity(0.05)
    }
}

// MARK: - View Extension for Button Styles
extension View {
    func primaryButtonStyle(backgroundColor: Color = AppColors.primary, height: CGFloat = AppLayout.buttonHeight) -> some View {
        self.modifier(PrimaryButtonStyle(backgroundColor: backgroundColor, height: AppLayout.buttonHeight))
    }
    func secondaryButtonStyle(borderColor: Color = AppColors.primary, height: CGFloat = AppLayout.buttonHeight) -> some View {
        self.modifier(SecondaryButtonStyle(borderColor: borderColor, height: AppLayout.buttonHeight))
    }
    func selectionButtonStyle(isSelected: Bool, selectedColor: Color = AppColors.primary, cornerRadius: CGFloat = AppLayout.cornerRadius) -> some View {
        self.modifier(SelectionButtonStyle(isSelected: isSelected, selectedColor: selectedColor, cornerRadius: cornerRadius))
    }
    func optionButtonStyle(isSelected: Bool, isCorrect: Bool? = nil) -> some View {
        self.modifier(OptionButtonStyle(isSelected: isSelected, isCorrect: isCorrect))
    }
}
