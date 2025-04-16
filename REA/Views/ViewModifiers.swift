//
//  ViewModifiers.swift
//  REA
//
//  Created by Tim Zhao on 4/5/25.
//

import SwiftUI
import Foundation

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
            .background(
                RoundedRectangle(cornerRadius: AppLayout.smallCornerRadius)
                    .fill(Color.clear)
            )
    }
}

// MARK: - Extensions

extension View {
    func cardStyle() -> some View {
        self.modifier(CardStyle())
    }
    
    func tagStyle(color: Color) -> some View {
        self.modifier(TagStyle(color: color))
    }
}
