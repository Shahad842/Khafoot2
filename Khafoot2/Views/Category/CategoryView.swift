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
    @State private var dragOffset: CGFloat = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(category)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal)
                .padding(.top)
                .accessibilityAddTraits(.isHeader)
                .accessibilityLabel("\(category) sounds category")
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(sounds) { sound in
                        HStack(spacing: 15) {
                            Image(sound.soundImage)
                                .resizable()
                                .frame(width: 110, height: 110)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .accessibilityLabel("Sound image for \(sound.title)")
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(viewModel.formatDate(sound.date))
                                    .font(.system(size: 15))
                                    .foregroundColor(Color("SecondaryTextColor"))
                                    .accessibilityLabel("Date: \(viewModel.formatDate(sound.date))")
                                
                                Text(sound.title)
                                    .font(.system(size: 18))
                                    .bold()
                                    .foregroundColor(Color("TextColor"))
                                    .accessibilityLabel("Title: \(sound.title)")
                                
                                Spacer()
                                
                                HStack {
                                   if viewModel.isPlaying, viewModel.currentSound == sound {
                                        Text(viewModel.timeString(time: viewModel.currentTime))
                                            .font(.subheadline)
                                            .foregroundColor(Color("PlayIconColor"))
                                            .accessibilityLabel("Current time: \(viewModel.timeString(time: viewModel.currentTime))")
                                        
                                        Track()
                                            .accessibilityLabel("Audio progress track")
                                       
                                    } else {
                                        Text(viewModel.formatDuration(time: sound.duration))
                                            .font(.subheadline)
                                            .foregroundColor(Color("PlayIconColor"))
                                            .accessibilityLabel("Duration: \(viewModel.formatDuration(time: sound.duration))")
                                        
                                        RoundedRectangle(cornerRadius: 5)
                                            .fill(Color("PlayIconColor").opacity(0.5))
                                            .frame(height: 6)
                                            .frame(maxWidth: .infinity)
                                            .accessibilityHidden(true)
                                    }
                                    
                                        if viewModel.isPlaying, viewModel.currentSound == sound {
                                            Image(systemName: "pause.fill")
                                                .foregroundColor(Color("PlayIconColor"))
                                                .padding(8)
                                                .accessibilityLabel("Pause \(sound.title)")
                                                .accessibilityAddTraits(.isButton)
                                        } else {
                                            Image(systemName: "play.fill")
                                                .foregroundColor(Color("PlayIconColor"))
                                                .padding(8)
                                                .accessibilityLabel("Play \(sound.title)")
                                                .accessibilityAddTraits(.isButton)
                                        }
                                }
                                .padding(.horizontal, 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(Color("Neutral40"))
                                )
                                .frame(maxWidth: .infinity)
                                .accessibilityElement(children: .combine)
                                .accessibilityLabel(viewModel.isPlaying && viewModel.currentSound == sound ?
                                    "Playing \(sound.title), \(viewModel.timeString(time: viewModel.currentTime))" :
                                    "Duration \(viewModel.formatDuration(time: sound.duration))")
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
                        )
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("\(sound.title) sound")
                        .accessibilityHint("Double tap to play full screen")
                        .accessibilityValue(viewModel.isPlaying && viewModel.currentSound == sound ? "Currently playing" : "Not playing")
                        .accessibilityAddTraits(.isButton)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $expandSheet) {
            if let sound = selectedSound {
                SoundView(expandSheet: $expandSheet)
            }
        }
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
//    }
//}
