//
//  SoundView 2.swift
//  khafootTest1
//
//  Created by Shahad Alhothali on 29/04/1446 AH.

import SwiftUI
import AVFoundation
import Combine

struct SoundView: View {
    @EnvironmentObject var viewModel: SoundViewModel

    @Binding var expandSheet: Bool
    @State private var showShareSheet = false

    var body: some View {
        ZStack {
            if let sound = viewModel.currentSound {
                Rectangle()
                    .fill(.ultraThickMaterial) // Background with a material effect
                    .overlay {
                        // Background image with a blur effect
                        Image(sound.soundImage)
                            .resizable()
                            .scaledToFill()
                            .blur(radius: 100)
                            .overlay(Color.black.opacity(0.4))
                    }
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Dismiss indicator line at the top
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 35, height: 5)
                        .cornerRadius(2)
                        .padding(.top, 8)
                    
                    // Display the sound image
                    Image(sound.soundImage)
                        .resizable()
                        .frame(width: 343.71, height: 322.66)
                        .cornerRadius(8.56)
                        .shadow(radius: 5)
                        .padding()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(viewModel.formatDate(sound.date))
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                                .padding(.bottom, 1)
                            
                            Text(sound.category)
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding(.bottom, 1)
                            
                            Text(sound.title)
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding(.bottom, 1)
                            
                        }
                        .padding(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Menu Button for Share and Report Problem
                        Menu {
                            Button("Report a Problem") {
                                reportProblem()
                            }
                            Button("Share") {
                                showShareSheet = true
                            }
                            
                        } label: {
                            Image(systemName: "ellipsis.circle.fill")
                                .resizable()
                                .frame(width: 26, height: 26)
                                .foregroundColor(Color.white.opacity(0.9))
                                .blendMode(.overlay)
                                .padding()
                        }
                        .sheet(isPresented: $showShareSheet) {
                            ShareSheet(activityItems: [viewModel.shareCurrentSound()])
                        }
                    }
                    .padding()
                    
                    // Player Controls View
                    PlayerControlsView()
                    .padding()
                    
                    // AirPlay and Like buttons at the bottom
                    HStack {
                        Spacer()
                        
                        // AirPlay Button
                        AirPlayButton()
                            .frame(width: 30, height: 30)
                            .padding()
                        
                        Spacer()
                        
                        // Like Button
                        Button(action: {
                            viewModel.toggleLike(sound: sound)
                        }) {
                            Image(systemName: viewModel.likedSounds.contains(where: { $0.id == sound.id }) ? "heart.fill" : "heart")
                                .font(.title2)
                                .foregroundColor(viewModel.likedSounds.contains(where: { $0.id == sound.id }) ? .red : .white)
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom)
                    
                }
                .padding()
            } else {
                Text("No sound selected")
                    .foregroundColor(.white)
            }
        }
        .onAppear(){
            viewModel.togglePlayPause()
        }
//        .onDisappear {
//            viewModel.stopAudio() // Stop audio playback when the view disappears
//        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.height > 100 {
                        expandSheet = false
                        
                        // Set selected sound and show mini view
                        viewModel.selectedSound = viewModel.currentSound
//                        viewModel.loadSound(viewModel.categories["Rain"]?[0] ?? SoundModel(title: "Unknown", duration: 0, date: "", soundImage: "", fileName: "", category: ""))

                        viewModel.isMiniViewVisible = true
                    }
                }
        )
        .interactiveDismissDisabled(false) // Enable interactive dismissal
    }
    
    private func reportProblem() {
        let email = "support@example.com"
        let subject = "Report a Problem"
        let body = "Please describe your issue."
        
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        let urlString = "mailto:\(email)?subject=\(subjectEncoded)&body=\(bodyEncoded)"
        guard let url = URL(string: urlString) else { return }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: { success in
                if !success {
                    print("Failed to open email app.")
                }
            })
        } else {
            print("Invalid URL: \(urlString)")
        }
    }
}
