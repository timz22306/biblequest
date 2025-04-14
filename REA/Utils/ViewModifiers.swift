//
//  ViewModifiers.swift
//  REA
//
//  Created by Tim Zhao on 4/5/25.
//

import SwiftUI
import Foundation

// MARK: - Button Styles

struct PrimaryButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(AppFonts.buttonLabel)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: AppLayout.buttonHeight)
            .background(
                AppColors.primaryGradient
                    .cornerRadius(AppLayout.cornerRadius)
                    .shadow(color: AppColors.primary.opacity(0.3), radius: 5, x: 0, y: 2)
            )
            .contentShape(Rectangle())
    }
}

struct SecondaryButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(AppFonts.buttonLabel)
            .foregroundColor(AppColors.primary)
            .frame(maxWidth: .infinity)
            .frame(height: AppLayout.buttonHeight)
            .background(
                RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
                            .stroke(AppColors.primary, lineWidth: 1.5)
                    )
            )
            .contentShape(Rectangle())
    }
}

// MARK: - Card Styles

struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(AppLayout.standardPadding)
            .background(
                RoundedRectangle(cornerRadius: AppLayout.cornerRadius)
                    .fill(AppColors.cardBackground)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
            )
            .padding(.horizontal, AppLayout.standardPadding)
    }
}

// MARK: - Option Button Styles

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

// MARK: - Tag Styles

struct TagStyle: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .font(AppFonts.caption)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(color.opacity(0.15))
            .foregroundColor(color)
            .cornerRadius(AppLayout.smallCornerRadius)
    }
}

// MARK: - Extensions

extension View {
    func primaryButtonStyle() -> some View {
        self.modifier(PrimaryButtonStyle())
    }
    
    func secondaryButtonStyle() -> some View {
        self.modifier(SecondaryButtonStyle())
    }
    
    func cardStyle() -> some View {
        self.modifier(CardStyle())
    }
    
    func optionButtonStyle(isSelected: Bool, isCorrect: Bool? = nil) -> some View {
        self.modifier(OptionButtonStyle(isSelected: isSelected, isCorrect: isCorrect))
    }
    
    func tagStyle(color: Color) -> some View {
        self.modifier(TagStyle(color: color))
    }
}
