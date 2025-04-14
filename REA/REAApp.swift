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
            if showSplashScreen {
                SplashScreenView()
            } else {
                ContentView()
                    .accentColor(Color("AccentColor"))
            }
        }
    }
}
