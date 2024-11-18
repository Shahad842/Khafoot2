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
//    @State private var showPermissionDeniedAlert = false
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Welcome to")
                    .font(.system(size: 48, weight: .semibold))
                    .foregroundColor(Color("TextColor"))
                
                Text("Khafoot")
                    .font(.system(size: 48, weight: .semibold))
                    .foregroundColor(Color("AccentColor"))
            }
            .padding(.leading, 40)
            .padding(.bottom, 50)
            .padding(.top, 80)
            
            VStack(alignment: .leading, spacing: 20) {
                FeatureView(imageName: "waveform.and.magnifyingglass", title: "Noise Detection", description: "The app uses advanced technology to monitor\n ambient noise levels, ensuring a relaxing,\n distraction-free experience.", imageWidth: 52.86, imageHeight: 46.77)
                
                FeatureView(imageName: "ear.and.waveform", title: "Personalized Meditation", description: "Meditation in the app includes listening to \n nature sounds, which helps promote relaxation \n and calm.", imageWidth: 48, imageHeight: 62.42)
                
                FeatureView(imageName: "brain.head.profile", title: "Embrace Slow Living", description: "In the app, embracing the Slow Lifestyle \n encourages you to focus on the present moment, and reduce clutter.", imageWidth: 49, imageHeight: 59)
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
                    
                    Spacer()
                }
                
                Text("Khafoot collects your activity, which is not \nassociated with your Apple ID, in order to \nimprove and personalize Khafoot. Your\n Apple ID may be used to check for news \n subscriptions.")
                    .font(.system(size: 12))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("Neutral40"))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.top, 50)
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    requestNotificationPermission() { granted in
                        navigateToSoundCheck = granted
                        UserDefaults.standard.set(true, forKey: "OnboardingCompleted")
                        isOnboardingCompleted = true
//                        showPermissionDeniedAlert = !granted
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
//            .alert(isPresented: $showPermissionDeniedAlert) {
//                Alert(title: Text("Permission Denied"),
//                      message: Text("Please enable microphone access in Settings to use this feature."),
//                      dismissButton: .default(Text("OK")))
//            }
            .padding(.bottom, 50)
        }
        .opacity(isLoading ? 1 : 0)
        .onAppear {
            withAnimation(.easeIn(duration: 1.5)) {
                isLoading = true
            }
        }
    }
}
