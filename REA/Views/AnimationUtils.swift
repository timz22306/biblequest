import SwiftUI
import CoreHaptics
import Foundation
// Ensure AppColors is accessible in this file

// MARK: - Haptic Feedback

class HapticManager {
    static let shared = HapticManager()
    
    private var engine: CHHapticEngine?
    
    private init() {
        prepareHaptics()
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the haptic engine: \(error.localizedDescription)")
        }
    }
    
    // For correct answers
    func successFeedback() {
        #if os(iOS)
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        #endif
    }
    
    // For incorrect answers
    func errorFeedback() {
        #if os(iOS)
        UINotificationFeedbackGenerator().notificationOccurred(.error)
        #endif
    }
    
    // For general taps and selections
    func selectionFeedback() {
        #if os(iOS)
        UISelectionFeedbackGenerator().selectionChanged()
        #endif
    }
    
    // For quiz completion
    func completionFeedback() {
        #if os(iOS)
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics,
              let engine = engine else { return }
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
        
        let event1 = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        let event2 = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0.1)
        let event3 = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0.2)
        
        do {
            let pattern = try CHHapticPattern(events: [event1, event2, event3], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
        #endif
    }
}

// MARK: - Loading Animation

struct LoadingView: View {
    @State private var isAnimating = false
    let color: Color
    
    init(color: Color = AppColors.primary) {
        self.color = color
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.2), lineWidth: 8)
                .frame(width: 60, height: 60)
            
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(color, lineWidth: 8)
                .frame(width: 60, height: 60)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
                .onAppear {
                    isAnimating = true
                }
        }
    }
}

// MARK: - Card Flip Animation

struct FlipView<Front: View, Back: View>: View {
    var front: Front
    var back: Back
    @Binding var isFlipped: Bool
    @State private var rotation: Double = 0
    
    init(isFlipped: Binding<Bool>, @ViewBuilder front: () -> Front, @ViewBuilder back: () -> Back) {
        self._isFlipped = isFlipped
        self.front = front()
        self.back = back()
    }
    
    var body: some View {
        ZStack {
            front
                .opacity(isFlipped ? 0 : 1)
                .rotation3DEffect(
                    .degrees(isFlipped ? 180 : 0),
                    axis: (x: 0, y: 1, z: 0)
                )
            
            back
                .opacity(isFlipped ? 1 : 0)
                .rotation3DEffect(
                    .degrees(isFlipped ? 0 : -180),
                    axis: (x: 0, y: 1, z: 0)
                )
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.7), value: isFlipped)
    }
}

// MARK: - View Extensions

extension View {
    // Apply a card press effect to a view
    func pressAnimation(isPressed: Bool) -> some View {
        self.scaleEffect(isPressed ? 0.95 : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isPressed)
    }
    
    // Create a bouncy appearance animation
    func appearWithBounce(delay: Double = 0) -> some View {
        self.scaleEffect(1)
            .transition(
                .asymmetric(
                    insertion: .scale(scale: 0.7)
                        .combined(with: .opacity)
                        .animation(.spring(response: 0.4, dampingFraction: 0.65).delay(delay)),
                    removal: .opacity.animation(.easeOut(duration: 0.2))
                )
            )
    }
    
    // Add a shimmer effect (useful for loading states)
    func shimmer(isActive: Bool = true, speed: Double = 0.15, angle: Angle = .degrees(70)) -> some View {
        Group {
            if isActive {
                self.modifier(ShimmerEffect(speed: speed, angle: angle))
            } else {
                self
            }
        }
    }
    
    // MARK: - Glowing Effect Modifier
    func glowingEffect(color: Color = AppColors.accent, radius: CGFloat = 20, speed: Double = 1.5) -> some View {
        self.overlay(
            Circle()
                .stroke(color.opacity(0.6), lineWidth: 4)
                .shadow(color: color.opacity(0.8), radius: radius)
                .scaleEffect(1.1)
                .opacity(0.8)
                .animation(Animation.easeInOut(duration: speed).repeatForever(autoreverses: true))
        )
    }
}

// Shimmer effect modifier
struct ShimmerEffect: ViewModifier {
    let speed: Double
    let angle: Angle
    @State private var isAnimating = false
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geo in
                    ZStack {
                        Color.white
                            .opacity(0.3)
                            .mask(
                                Rectangle()
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [.clear, .white, .clear]),
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .rotationEffect(angle)
                                    .offset(x: isAnimating ? geo.size.width : -geo.size.width)
                            )
                    }
                    .onAppear {
                        withAnimation(Animation.linear(duration: speed).repeatForever(autoreverses: false)) {
                            isAnimating = true
                        }
                    }
                }
            )
            .clipped()
    }
}

// MARK: - Custom Transitions

struct SlideWithOpacityTransition: ViewModifier {
    let edge: Edge

    func body(content: Content) -> some View {
        content
            .transition(
                .asymmetric(
                    insertion: .move(edge: edge).combined(with: .opacity),
                    removal: .opacity
                )
            )
    }
}

// Extensions for easier access to custom transitions
extension AnyTransition {
    static var slideWithFade: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .move(edge: .leading).combined(with: .opacity)
        )
    }

    static var scaleWithOpacity: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .scale.combined(with: .opacity),
            removal: .scale(scale: 0.8).combined(with: .opacity)
        )
    }
}