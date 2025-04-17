//
//  REAApp.swift
//  REA
//
//  Created by Tim Zhao on 4/5/25.
//

import SwiftUI

@main
struct REAApp: App {
    @State private var showLaunchScreen = true // Updated variable name
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                    .accentColor(Color("AccentColor"))
                    .opacity(showLaunchScreen ? 0 : 1) // Updated variable name
                
                if showLaunchScreen { // Updated variable name
                    LaunchScreenView() // Updated from SplashScreenView to LaunchScreenView
                        .transition(.opacity)
                }
            }
            .onAppear {
                // Increased delay and made transition slower
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) { // Increased delay to 3.5 seconds
                    withAnimation(.easeInOut(duration: 1.5)) { // Slower transition duration of 1.5 seconds
                        showLaunchScreen = false // Updated variable name
                    }
                }
            }
        }
    }
}