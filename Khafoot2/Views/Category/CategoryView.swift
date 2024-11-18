//  CategoryView.swift
//  Khafoot
//
//  Created by SHATHA ALQHTANI on 06/11/2024.
//


import SwiftUI

struct CategoryView: View {
    @EnvironmentObject var viewModel: SoundViewModel

    let category: String
    let sounds: [SoundModel]

    @State private var selectedSound: SoundModel?
    @State private var expandSheet = false
    @State private var dragOffset: CGFloat = 0 // Track drag offset
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(category)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal)
                .padding(.top)
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(sounds) { sound in
                        // Card View for each sound
                        HStack(spacing: 15) {
                            // Sound image
                            Image(sound.soundImage)
                                .resizable()
                                .frame(width: 110, height: 110)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            //                                .shadow(radius: 2)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(viewModel.formatDate(sound.date))
                                    .font(.system(size: 15))
                                    .foregroundColor(Color("SecondaryTextColor"))
                                
                                Text(sound.title)
                                    .font(.system(size: 18))
                                    .bold()
                                    .foregroundColor(Color("TextColor"))
                                
                                Spacer()
                                
                                HStack {
                                   if viewModel.isPlaying, viewModel.currentSound == sound {
                                        Text(viewModel.timeString(time: viewModel.currentTime))
                                            .font(.subheadline)
                                            .foregroundColor(Color("PlayIconColor"))
                                        
                                        Track()
                                       
                                    } else {
                                        
                                        Text(viewModel.formatDuration(time: sound.duration))
                                            .font(.subheadline)
                                            .foregroundColor(Color("PlayIconColor"))
                                        
                                        RoundedRectangle(cornerRadius: 5)
                                            .fill(Color("PlayIconColor").opacity(0.5))
                                            .frame(height: 6)
                                            .frame(maxWidth: .infinity)
                                    }
                                                                        
//                                    Button(action: {
//                                        // Pause the sound if it is currently playing
//                                        viewModel.togglePlayPause()
//                                        
//                                    }) {
                                        if viewModel.isPlaying, viewModel.currentSound == sound {
                                            // Change the icon based on play/pause state
                                            Image(systemName: "pause.fill")
                                                .foregroundColor(Color("PlayIconColor"))
                                                .padding(8)
                                        } else {
                                            Image(systemName: "play.fill")
                                                .foregroundColor(Color("PlayIconColor"))
                                                .padding(8)
                                        }
//                                    }
                                }
                                .padding(.horizontal, 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(Color("Neutral40"))
                                    //                                        .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                                )
                                .frame(maxWidth: .infinity)
                            }
                        }
                        .onTapGesture {
                            viewModel.loadSound(sound)
                            selectedSound = sound
                            expandSheet = true
                        }
                        .padding(.bottom, 22)
                        .padding(.horizontal)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color("SplashColor"))
                            //                                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
                        )
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $expandSheet) {
            if let sound = selectedSound {
                SoundView(expandSheet: $expandSheet)
            }
        }
        
        // Mini view
//        .overlay(
//            VStack {
//                Spacer()
//                
//                if let sound = selectedSound {
//                    SoundMiniView(sound: sound, dragOffset: $dragOffset, expandSheet: $expandSheet)
//                        .frame(height: 100)
//                        .offset(y: dragOffset)
//                        .gesture(DragGesture()
//                            .onChanged { value in
//                                // Dragging logic
//                                dragOffset = min(value.translation.height, 0) // Prevent going above the screen
//                            }
//                            .onEnded { value in
//                                // If the mini view is dragged up sufficiently, open the sheet
//                                if dragOffset < -150 {
//                                    expandSheet = true
//                                    dragOffset = 0 // Reset the drag offset
//                                } else {
//                                    // Reset position if not dragged up enough
//                                    dragOffset = 0
//                                }
//                            }
//                        )
//                        .animation(.spring(), value: dragOffset)
//                }
//            }
//        )
    }
}
