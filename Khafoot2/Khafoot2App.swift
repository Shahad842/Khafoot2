//
//  Khafoot2App.swift
//  Khafoot2
//
//  Created by Shahad Alhothali on 11/05/1446 AH.
//

import SwiftUI

@main
struct KhafootApp: App {
    @StateObject private var soundViewModel = SoundViewModel()
    
    // متغير لتحديد ما إذا كان هذا هو المرة الأولى التي يتم فيها تحميل التطبيق
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ZStack {
                    // عرض SplashScreen فقط في المرة الأولى
                    if isFirstLaunch {
                        SplashScreen()
                            .onDisappear {
                                // عند اختفاء SplashScreen، قم بتحديث UserDefaults بحيث لا يتم عرضها مرة أخرى
                                isFirstLaunch = false
                            }
                    }
                    
                    // Mini View (يظهر دائمًا في الأعلى)
                    if soundViewModel.isMiniViewVisible, let sound = soundViewModel.selectedSound {
                        VStack {
                            Spacer()
                            
                            SoundMiniView()
                                .offset(x: soundViewModel.dragOffset.width, y: soundViewModel.dragOffset.height)
                                .gesture(DragGesture()
                                    .onChanged { value in
                                        // Track drag position
                                        soundViewModel.dragOffset = value.translation
                                    }
                                    .onEnded { value in
                                        // Handle drag release logic
                                        if abs(soundViewModel.dragOffset.width) > 150 {
                                            // If dragged to the sides, hide the mini view
                                            soundViewModel.isMiniViewVisible = false
                                            soundViewModel.dragOffset = .zero
                                            soundViewModel.stopAudio()
                                        } else {
                                            // Otherwise, reset the mini view position
                                            soundViewModel.dragOffset = .zero
                                        }
                                    }
                                )
                                .animation(.spring(), value: soundViewModel.dragOffset)
                        }
                    }
                }
                .onAppear {
                    soundViewModel.isMiniViewVisible = false // Ensure the mini view starts hidden
                }
            }
            .environmentObject(soundViewModel)
        }
    }
}
