import SwiftUI
import AVFoundation
import UserNotifications

struct OnboardingContainer: View {
    @State private var isOnboardingCompleted = UserDefaults.standard.bool(forKey: "OnboardingCompleted")
    @State private var navigateToSoundCheck = false
    @State private var isPermissionGranted = false  // لتخزين حالة الإذن
    @State private var isNavigating = false
    
    var body: some View {
        ZStack {
            if !isOnboardingCompleted {
                OnboardingView(isOnboardingCompleted: $isOnboardingCompleted, navigateToSoundCheck: $navigateToSoundCheck)
//            } else if !isPermissionGranted {
//                // عند الوصول إلى هنا، نطلب إذن الإشعارات
//                Text("نطلب إذن الإشعارات")
//                    .onAppear {
//                        requestNotificationPermission { granted in
//                            isPermissionGranted = granted
//                            if granted {
//                                navigateToSoundCheck = true
//                            } else {
//                                // في حالة رفض الإذن
//                                print("تم رفض إذن الإشعارات")
//                            }
//                        }
//                    }
            } else if navigateToSoundCheck, !isNavigating {
                SoundCheckView(showMainView: $navigateToSoundCheck, isNavigating: $isNavigating)
            } else {
                MainView()
            }
        }
    }
}

func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        DispatchQueue.main.async {
            if granted {
                print("تم منح إذن الإشعارات")
            } else {
                print("تم رفض إذن الإشعارات")
            }
            completion(granted)
        }
    }
}

#Preview {
    OnboardingContainer()
}
