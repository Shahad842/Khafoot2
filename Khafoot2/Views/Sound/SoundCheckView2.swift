//
//  SoundCheckView2.swift
//  Khafoot
//
//  Created by SHATHA ALQHTANI on 06/11/2024.
//

import SwiftUI
import AVFAudio

struct SoundCheckView2: View {
    @State private var isListening = false
    @State private var isSpeaking = false
    @State private var audioRecorder: AVAudioRecorder?
    @State private var navigateToMainView = false  // للتحكم في الانتقال إلى MainView عند رفض إذن الميكروفون

    var body: some View {
        if navigateToMainView {
            MainView()  // الانتقال إلى MainView إذا رفض المستخدم إذن الميكروفون
        } else {
            ZStack {
                Color.black.ignoresSafeArea()
                
                // تصميم الدوائر المتحركة وغيرها

                VStack {
                    Spacer()
                    
                    Image(systemName: "mic.fill")
                        .resizable()
                        .frame(width: 30, height: 50)
                        .foregroundColor(isSpeaking ? .green : .white)
                        .scaleEffect(isSpeaking ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 0.2), value: isSpeaking)
                        .padding(.top, 500)
                    
                    Spacer()
                }
            }
            .onAppear {
                startAudioMonitoring()  // بدء مراقبة الصوت
                requestMicrophoneAccess()  // طلب إذن الميكروفون
            }
        }
    }
    
    private func requestMicrophoneAccess() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
            audioSession.requestRecordPermission { granted in
                DispatchQueue.main.async {
                    if !granted {
                        navigateToMainView = true  // الانتقال إلى MainView إذا رفض المستخدم الإذن
                    }
                }
            }
        } catch {
            print("Failed to set up audio session: \(error)")
            navigateToMainView = true  // الانتقال إلى MainView في حالة وجود خطأ
        }
    }

    private func startAudioMonitoring() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
            
            let url = URL(fileURLWithPath: "/dev/null")
            let settings: [String: Any] = [
                AVFormatIDKey: kAudioFormatAppleLossless,
                AVSampleRateKey: 44100.0,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
            ]
            
            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.record()
            
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                audioRecorder?.updateMeters()
                let averagePower = audioRecorder?.averagePower(forChannel: 0) ?? -160
                isSpeaking = averagePower > -30.0
            }
        } catch {
            print("فشل في بدء مراقبة الصوت: \(error.localizedDescription)")
        }
    }
}
