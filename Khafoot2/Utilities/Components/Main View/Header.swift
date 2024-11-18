//
//  Header.swift
//  Khafoot
//
//  Created by SHATHA ALQHTANI on 06/11/2024.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack {
            Text("Listen Now")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color("TextColor"))
                .padding()
                // Mark as header for VoiceOver
                .accessibilityAddTraits(.isHeader)
                // Provide clear label
                .accessibilityLabel("Listen Now main heading")
            
            Spacer()
            
            NavigationLink(destination: SettingsView()) {
                Image(systemName: "gearshape")
                    .font(.title)
                    .foregroundColor(Color("AccentColor"))
                    .padding()
                    .navigationBarHidden(true)
                    // Make settings button more accessible
                    .accessibilityLabel("Settings")
                    .accessibilityHint("Open app settings")
                    // Add button trait
                    .accessibilityAddTraits(.isButton)
            }
        }
        // Optional: Combine header elements for streamlined VoiceOver navigation
        // .accessibilityElement(children: .combine)
        // .accessibilityLabel("Listen Now screen with settings")
    }
}
