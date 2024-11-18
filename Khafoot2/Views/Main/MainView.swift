//
//  MainView.swift
//  khafootTest1
//
//  Created by Shahad Alhothali on 28/04/1446 AH.


import SwiftUI
import AVFoundation
import Combine

// MainView
struct MainView: View {
    @EnvironmentObject var viewModel: SoundViewModel
    
    @State private var selectedSound: SoundModel? // Track the selected sound
    @State private var isPresentingSoundView = false // Control the presentation of SoundView
    @Environment(\.layoutDirection) var layoutDirection // Detect current language direction
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Top Header
                Header()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        // Liked sounds section if there are liked sounds
                        if !viewModel.likedSounds.isEmpty {
                            LikedSoundsSection() {
                                // Navigate to SoundView when a liked sound is selected
                                selectedSound = $0
                                viewModel.loadSound($0)
                                isPresentingSoundView = true
                            }
                        }
                        
                        // Categories section
                        ForEach(Array(viewModel.categories.keys), id: \.self) { category in
                            CategorySection(
                                category: category,
                                sounds: viewModel.categories[category] ?? [],
                                selectedSound: $selectedSound,
                                isPresentingSoundView: $isPresentingSoundView
                            )
                        }
                    }
                }
                .fullScreenCover(isPresented: $isPresentingSoundView) {
                    if let sound = selectedSound {
                        SoundView(expandSheet: $isPresentingSoundView)
                    }
                }
            }
            .navigationBarHidden(true) // Hide the default navigation bar
            navigationBarBackButtonHidden(true)
        }
    }
}


/// old Code in  ForEach for Categories section -----
//                            VStack(alignment: .leading) {
//                                HStack {
//                                    Text(category)
//                                        .font(.system(size: 22))
//                                        .fontWeight(.bold)
//                                        .foregroundColor(Color("TextColor"))
//                                        .padding(.horizontal)
//
//                                    Spacer()
//
//                                    // Chevron for navigation
//                                    NavigationLink(destination: RainView()) {
//                                        Image(systemName: layoutDirection == .rightToLeft ? "chevron.left" : "chevron.right")
//                                            .foregroundColor(Color("AccentColor"))
//                                            .font(.subheadline)
//                                            .padding(.horizontal)
//                                    }
//                                }
//
//                                // Horizontal scroll for sounds in the category
//                                ScrollView(.horizontal, showsIndicators: false) {
//                                    HStack(spacing: -20) {
//                                        ForEach(viewModel.categories[category] ?? []) { sound in
//                                            SoundCard(viewModel: viewModel, sound: sound)
//                                                .onTapGesture {
//                                                    selectedSound = sound // Set the selected sound
//                                                    viewModel.loadSound(sound) // Load the sound
//                                                    isPresentingSoundView = true // Trigger the full-screen modal
//                                                }
//                                        }
//                                    }
//                                    .padding(.horizontal)
//                                    .frame(maxWidth: .infinity, alignment: layoutDirection == .rightToLeft ? .trailing : .leading)
//                                }
//                            }
//                            .frame(maxWidth: .infinity, alignment: .leading)
