//
//  PlayerControlsView.swift
//  khafootTest1
//
//  Created by Shahad Alhothali on 28/04/1446 AH.
//
import AVFoundation
import Combine
import SwiftUI

import AVFoundation
import Combine
import SwiftUI

// PlayerControlsView
struct PlayerControlsView: View {
    @EnvironmentObject var viewModel: SoundViewModel

//    let totalTime: TimeInterval
//    @Binding var currentTime: TimeInterval
//    @Binding var isPlaying: Bool
//    @Binding var volume: Float
    
//    var playAction: () -> Void
//    var forwardAction: () -> Void
//    var backwardAction: () -> Void
//    var viewModel: SoundViewModel

    var body: some View {
        VStack {
            // Slider for current playback time
            HStack {
                GeometryReader { geometry in
                    let sliderWidth = geometry.size.width
                    
                    // Custom track
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(height: 6.6)
                        .cornerRadius(8)
                    
                    // Progress track
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: CGFloat(viewModel.currentTime / viewModel.totalTime) * sliderWidth, height: 6.6)
                        .cornerRadius(8)
                        .animation(.easeInOut(duration: 0.1), value: viewModel.currentTime) // Smoother animation
                    
                    // Invisible slider for dragging
                    Rectangle()
                        .fill(Color.clear)
                        .contentShape(Rectangle())
                        .gesture(DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let location = value.location.x
                                let newValue = Double(location / sliderWidth) * viewModel.totalTime
                                viewModel.currentTime = min(max(newValue, 0), viewModel.totalTime) // Clamp the value
                                viewModel.seek(to: viewModel.currentTime) // Seek in the view model
                            }
                        )
                }
                .frame(height: 20)
            }
            .padding(.horizontal)
            
            HStack {
                Text(viewModel.timeString(time: viewModel.currentTime))
                    .font(.system(size: 10.8))
                    .foregroundColor(.white)
                    .padding(.bottom, 1)
                Spacer()
                Text(viewModel.timeString(time: viewModel.totalTime))
                    .font(.system(size: 10.8))
                    .foregroundColor(.white)
                    .padding(.bottom, 1)
            }
            Spacer()
            
            HStack(spacing: 60) {
                Button(action: {
                    viewModel.seekBackward15Seconds()
                }) {
                    Image(systemName: "gobackward.15")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 33)
                        .foregroundColor(.white)
                        .padding()
                }
                
                Button(action: {
                    viewModel.togglePlayPause()
                }) {
                    Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 43, height: 43)
                        .foregroundColor(.white)
                        .animation(nil, value: viewModel.isPlaying)
                }
                
                Button(action: {
                    viewModel.seekForward15Seconds()
                }) {
                    Image(systemName: "goforward.15")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 33)
                        .foregroundColor(.white)
                        .padding()
                }
            }
            .padding(.bottom)
            
            // Volume Slider
            HStack {
                Image(systemName: "speaker.fill")
                    .frame(width: 13, height: 16)
                    .foregroundColor(.white)

                GeometryReader { geometry in
                    let sliderWidth = geometry.size.width
                    
                    // Custom track for volume
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(height: 6.6)
                        .cornerRadius(8)
                    
                    // Progress track for volume
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: CGFloat(viewModel.volume) * sliderWidth, height: 6.6)
                        .cornerRadius(8)
                        .animation(.easeInOut(duration: 0.1), value: viewModel.volume)
                    
                    // Invisible slider for dragging
                    Rectangle()
                        .fill(Color.clear)
                        .contentShape(Rectangle())
                        .gesture(DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let location = value.location.x
                                let newValue = Float(location / sliderWidth)
                                viewModel.volume = min(max(newValue, 0), 1)
                                viewModel.updateVolume(viewModel.volume) // Update the view model's volume
                            }
                        )
                }
                .frame(height: 20)
                .padding(.horizontal)
                
                Image(systemName: "speaker.wave.2.fill")
                    .frame(width: 22, height: 16)
                    .foregroundColor(.white)
            }
            Spacer()
            .padding(.horizontal)
        }
        .environment(\.layoutDirection, .leftToRight) // Force LTR layout
    }
}
