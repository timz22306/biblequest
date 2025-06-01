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
                    .glowingEffect(color: AppColors.accent, radius: 15, speed: 2.0) // Added glowing effect
                
                // Title
                Text("Biblitz")
                    .font(.custom("Avenir-Heavy", size: 36))
                    .foregroundColor(.black)
                    .padding(.top, 20)
                
                // Tagline
                Text("Your journey through scripture")
                    .font(.custom("Avenir-Medium", size: 16))
                    .foregroundColor(.gray)
                    .padding(.top, 5)
                
                Spacer()
            }
            .background(Color.white)
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