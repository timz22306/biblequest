//
//  REAApp.swift
//  REA
//
//  Created by Tim Zhao on 4/5/25.
//

import SwiftUI

@main
struct REAApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .accentColor(Color("AccentColor")) // Changed to use named color directly until AppColors is available
        }
    }
}
