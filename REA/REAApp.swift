//
//  REAApp.swift
//  REA
//
//  Created by Tim Zhao on 4/5/25.
//

import SwiftUI

@main
struct REAApp: App {
    @State private var showSplashScreen = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                    .accentColor(Color("AccentColor"))
                    .opacity(showSplashScreen ? 0 : 1)
                
                if showSplashScreen {
                    SplashScreenView()
                        .transition(.opacity)
                }
            }
            .onAppear {
                // Add a slight delay before transitioning from splash screen
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation(.easeInOut(duration: 0.7)) {
                        showSplashScreen = false
                    }
                }
            }
        }
    }
}
