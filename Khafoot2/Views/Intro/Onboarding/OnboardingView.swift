//
//  Onboarding.swift
//  Khafoot
//
//  Created by SHATHA ALQHTANI on 06/11/2024.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var isOnboardingCompleted: Bool
    @Binding var navigateToSoundCheck: Bool
    @State private var isLoading = false
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Welcome to")
                    .font(.system(size: 48, weight: .semibold))
                    .foregroundColor(Color("TextColor"))
                    .accessibilityAddTraits(.isHeader)
                
                Text("Khafoot")
                    .font(.system(size: 48, weight: .semibold))
                    .foregroundColor(Color("AccentColor"))
                    .accessibilityAddTraits(.isHeader)
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Welcome to Khafoot")
            .padding(.leading, 40)
            .padding(.bottom, 50)
            .padding(.top, 80)
            
            VStack(alignment: .leading, spacing: 20) {
                FeatureView(imageName: "waveform.and.magnifyingglass",
                           title: "Noise Detection",
                           description: "The app uses advanced technology to monitor\n ambient noise levels, ensuring a relaxing,\n distraction-free experience.",
                           imageWidth: 52.86,
                           imageHeight: 46.77)
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Feature: Noise Detection")
                    .accessibilityHint("The app uses advanced technology to monitor ambient noise levels, ensuring a relaxing, distraction-free experience.")
                
                FeatureView(imageName: "ear.and.waveform",
                           title: "Personalized Meditation",
                           description: "Meditation in the app includes listening to \n nature sounds, which helps promote relaxation \n and calm.",
                           imageWidth: 48,
                           imageHeight: 62.42)
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Feature: Personalized Meditation")
                    .accessibilityHint("Meditation in the app includes listening to nature sounds, which helps promote relaxation and calm.")
                
                FeatureView(imageName: "brain.head.profile",
                           title: "Embrace Slow Living",
                           description: "In the app, embracing the Slow Lifestyle \n encourages you to focus on the present moment, and reduce clutter.",
                           imageWidth: 49,
                           imageHeight: 59)
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Feature: Embrace Slow Living")
                    .accessibilityHint("In the app, embracing the Slow Lifestyle encourages you to focus on the present moment, and reduce clutter.")
            }
            .padding(.top, 20)
            
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "checkmark.icloud.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 29.46, height: 22.28)
                        .foregroundColor(Color("AccentColor"))
                        .accessibilityHidden(true) // Hide decorative image from VoiceOver
                    
                    Spacer()
                }
                
                Text("Khafoot collects your activity, which is not \nassociated with your Apple ID, in order to \nimprove and personalize Khafoot. Your\n Apple ID may be used to check for news \n subscriptions.")
                    .font(.system(size: 12))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("Neutral40"))
                    .fixedSize(horizontal: false, vertical: true)
                    .accessibilityLabel("Privacy Information")
                    .accessibilityHint("Khafoot collects your activity to improve and personalize the app. This is not associated with your Apple ID, which may be used to check for news subscriptions.")
            }
            .padding(.top, 50)
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    requestNotificationPermission() { granted in
                        navigateToSoundCheck = granted
                        UserDefaults.standard.set(true, forKey: "OnboardingCompleted")
                        isOnboardingCompleted = true
                    }
                }
            }) {
                Text("Continue")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color("ButtonTextColor"))
                    .padding()
                    .frame(width: 279, height: 49)
                    .background(Color("AccentColor"))
                    .cornerRadius(8)
                    .padding(.bottom, 20)
                    .frame(maxWidth: .infinity)
            }
            .accessibilityLabel("Continue to app")
            .accessibilityHint("Completes onboarding and requests notification permission")
            .accessibilityAddTraits(.isButton)
        }
    }
}
