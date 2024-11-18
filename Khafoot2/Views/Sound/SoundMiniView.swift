//
//  SoundMiniView.swift
//  Khafoot
//
//  Created by SHATHA ALQHTANI on 06/11/2024.
//
//
//  SoundMiniView.swift
//  Khafoot
//
//  Created by SHATHA ALQHTANI on 06/11/2024.
//

import SwiftUI

struct SoundMiniView: View {
    @EnvironmentObject var viewModel: SoundViewModel
    
    @State var isPresentingSoundView: Bool = false
    
    var body: some View {
        VStack {
            if viewModel.isMiniViewVisible, let sound = viewModel.currentSound {
                HStack {
                    // Sound image
                    Image(sound.soundImage)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(radius: 2)
                        .accessibilityLabel("صورة الصوت \(sound.title)") // إضافة label
                        .accessibilityHint("هذا هو الصوت الذي يتم تشغيله") // إضافة hint
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(sound.title)
                            .font(.headline)
                            .foregroundColor(.black)
                            .accessibilityLabel("عنوان الصوت: \(sound.title)") // إضافة label
                        
                        Text(viewModel.formatDate(sound.date))
                            .font(.system(size: 15))
                            .foregroundColor(Color("SecondaryTextColor"))
                            .accessibilityLabel("تاريخ الصوت: \(viewModel.formatDate(sound.date))") // إضافة label
                        
                        HStack {
                            
                            Text(viewModel.timeString(time: viewModel.currentTime))
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .accessibilityLabel("الوقت الحالي: \(viewModel.timeString(time: viewModel.currentTime))") // إضافة label
                            
                            Track()
                            
                            // Play button
                            Button(action: {
                                viewModel.togglePlayPause()
                            }) {
                                Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                                    .foregroundColor(.black)
                                    .padding(8)
                            }
                            .accessibilityLabel(viewModel.isPlaying ? "إيقاف الصوت" : "تشغيل الصوت") // إضافة label
                            .accessibilityHint("اضغط لتبديل حالة الصوت بين التشغيل والإيقاف") // إضافة hint
                            
                            // Seek forward button
                            Button(action: {
                                viewModel.seekForward15Seconds()
                            }) {
                                Image(systemName: "goforward.15")
                                    .foregroundColor(.black)
                                    .padding(8)
                            }
                            .accessibilityLabel("تقديم الصوت 15 ثانية للأمام") // إضافة label
                            .accessibilityHint("اضغط لتقديم الصوت للأمام بمقدار 15 ثانية") // إضافة hint
                        }
                    }
                }
                .padding(.top)
                .padding(.horizontal)
                .background(Color("MiniViewBoxColor").opacity(0.89))
            }
                
        }
        .onTapGesture {
            isPresentingSoundView = true
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $isPresentingSoundView) {
            if let sound = viewModel.selectedSound {
                SoundView(expandSheet: $isPresentingSoundView)
            }
        }
        
    }
}
