//
//  AppTheme.swift
//  REA
//
//  Created by Tim Zhao on 4/5/25.
//

import SwiftUI
import Foundation

// App-wide color scheme
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

// App-wide text styles
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

// Layout constants
struct AppLayout {
    static let standardSpacing: CGFloat = 16
    static let tightSpacing: CGFloat = 8
    static let wideSpacing: CGFloat = 24
    
    static let cornerRadius: CGFloat = 12
    static let smallCornerRadius: CGFloat = 8
    static let largeCornerRadius: CGFloat = 16
    
    static let buttonHeight: CGFloat = 50
    static let standardPadding: CGFloat = 16
}

// Animation definitions
struct AppAnimation {
    static let standard = Animation.easeInOut(duration: 0.3)
    static let quick = Animation.easeOut(duration: 0.2)
    static let bounce = Animation.spring(response: 0.4, dampingFraction: 0.6)
}
