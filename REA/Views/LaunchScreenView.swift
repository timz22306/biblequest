//
//  LaunchScreenView.swift
//  REA
//
//  Created by Tim Zhao on 4/5/25.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
                Spacer()
                
                // Logo
                Image("biblequest_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                    // .glowingEffect(color: AppColors.accent, radius: 15, speed: 2.0) // Added glowing effect

                // Title
                Text("BibleQuest")
                    // .font(.custom("SnellRoundhand-Bold", size: 36)) // Updated to a more artistic font
                    .font(.custom("Noteworthy-Bold", size: 36)) // Updated to a more artistic font
                    .foregroundColor(.primary) // Adjusts color based on theme
                    .padding(.top, 20)
                
                // Tagline
                Text("He leads me beside quiet waters,\nHe restores my soul")
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    // .font(.custom("Avenir-Medium", size: 16))
                    .font(.custom("Chalkduster", size: 16))
                    .foregroundColor(.secondary) // Adjusts color based on theme
                    .padding(.top, 5)
                
                Spacer()
            }
            .background(Color("LaunchScreenBackground")) // Dynamic background color
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                // Navigate to ContentView after a delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }   
                }
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}
