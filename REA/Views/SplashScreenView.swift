//
//  SplashScreenView.swift
//  REA
//
//  Created by Tim Zhao on 4/5/25.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.7
    @State private var opacity = 0.5
    @State private var rotation = 0.0
    @State private var textOpacity = 0.0
    @State private var showGlow = false
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                // Background
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color("PrimaryColor").opacity(0.6),
                        Color("BackgroundColor")
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    // Logo with glow effect
                    ZStack {
                        // Glow effect
                        if showGlow {
                            Image("biblequest_logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .blur(radius: 20)
                                .opacity(0.7)
                        }
                        
                        // Main logo
                        Image("biblequest_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 160, height: 160)
                            .rotationEffect(.degrees(rotation))
                            .scaleEffect(size)
                            .opacity(opacity)
                    }
                    
                    // Title text with animation
                    Text("BibleQuest")
                        .font(.custom("Avenir-Heavy", size: 36))
                        .foregroundColor(Color("PrimaryColor"))
                        .opacity(textOpacity)
                        .padding(.top, 20)
                    
                    // Tagline with animation
                    Text("Your journey through scripture")
                        .font(.custom("Avenir-Medium", size: 16))
                        .foregroundColor(.secondary)
                        .opacity(textOpacity)
                        .padding(.top, 5)
                    
                    Spacer()
                }
            }
            .onAppear {
                // Animate logo
                withAnimation(.easeIn(duration: 1.0)) {
                    self.size = 1.0
                    self.opacity = 1.0
                }
                
                // Rotate logo
                withAnimation(.easeInOut(duration: 2.0)) {
                    self.rotation = 360
                }
                
                // Show glow effect
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeIn(duration: 1.0)) {
                        self.showGlow = true
                    }
                }
                
                // Fade in text
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    withAnimation(.easeIn(duration: 1.0)) {
                        self.textOpacity = 1.0
                    }
                }
                
                // Navigate to ContentView after animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
