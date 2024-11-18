import AVFoundation
import UserNotifications
import SwiftUI


struct SoundCheckView: View {
    @Binding var showMainView: Bool
    @State private var isListening = false
    @State private var isSpeaking = false
    @State private var audioRecorder: AVAudioRecorder?
    @State private var message = ""
    @State private var timer: Timer?

    private let threshold: Float = -30.0  // مستوى الصوت المسموع

    // رابط التنقل التلقائي
//    @State private var isNavigating = false
    @Binding var isNavigating : Bool

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                // واجهة المستخدم لعرض عملية المراقبة الصوتية
                ZStack {
                    // شكل دوائر متغيرة الحجم للعرض التفاعلي
                    ForEach(0..<4) { i in
                        Circle()
                            .stroke(
                                Color(hex: "17531E").opacity(Double(4 - i) / 4),
                                lineWidth: 2
                            )
                            .frame(width: CGFloat(130 + (i * 50)), height: CGFloat(130 + (i * 50)))
                            .scaleEffect(isListening ? 1.3 : 0.8)
                            .animation(
                                Animation.easeInOut(duration: 1.5)
                                    .repeatForever(autoreverses: true)
                                    .delay(Double(i) * 0.2),
                                value: isListening
                            )
                    }
                    
                    Circle()
                        .fill(Color(hex: "17531E").opacity(0.3))
                        .frame(width: 160, height: 160)
                        .overlay(
                            Circle()
                                .stroke(Color(hex: "17531E"), lineWidth: 5)
                                .shadow(color: isListening ? Color(hex: "A8C686").opacity(0.8) : .clear, radius: 20)
                        )
                        .shadow(color: isSpeaking ? Color.white.opacity(0.6) : .clear, radius: 50)
                    
                    SoundWave()
                        .offset(y: 20)
                }
                .onAppear {
                    isListening = true
                    startAudioMonitoring()
                    requestNotificationPermission()
                }
                
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
                    
                    Text(message)
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                }
                
                // رابط التنقل التلقائي
//                NavigationLink(
//                    destination: MainView(),
//                    isActive: $isNavigating,
//                    label: { EmptyView() }
//                )
                
            }
            .navigationBarHidden(true)  // إخفاء شريط التنقل بالكامل
            .navigationBarBackButtonHidden(true)  // إخفاء زر الرجوع فقط
        }
    }
    
    private func startAudioMonitoring() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: .mixWithOthers)
            try audioSession.setActive(true)

            let url = URL(fileURLWithPath: "/dev/null")  // تسجيل الصوت إلى مكان غير مستخدم
            let settings: [String: Any] = [
                AVFormatIDKey: kAudioFormatAppleLossless,
                AVSampleRateKey: 44100.0,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
            ]

            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            audioRecorder?.isMeteringEnabled = true  // تمكين المتر
            audioRecorder?.record()

            // تحديث المتر كل نصف ثانية
            timer = Timer.scheduledTimer(withTimeInterval: 3.5, repeats: true) { _ in
                self.audioRecorder?.updateMeters()
                let averagePower = self.audioRecorder?.averagePower(forChannel: 0) ?? -160
                print("مستوى الصوت: \(averagePower)")

                if averagePower > self.threshold && !self.isNavigating {
                    self.isSpeaking = true
                    self.message = "تم تفعيل الصوت بنجاح"
                    // تفعيل الانتقال التلقائي إلى MainView إذا لم يتم الانتقال مسبقًا
                    self.isNavigating = true
                    timer?.invalidate() // إيقاف المؤقت
                    audioRecorder?.stop() // إيقاف التسجيل
                } else {
                    self.isSpeaking = false
                }
            }
        } catch {
            print("فشل في بدء مراقبة الصوت: \(error.localizedDescription)")
        }
    }
    
    private func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("خطأ في طلب الإذن: \(error.localizedDescription)")
            } else {
                print("إذن الإشعارات مُعطى: \(granted)")
            }
        }
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = Double((rgbValue & 0xff0000) >> 16) / 255.0
        let g = Double((rgbValue & 0xff00) >> 8) / 255.0
        let b = Double(rgbValue & 0xff) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}


struct SoundCheckView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide an instance of SoundViewModel to the preview
        SoundCheckView(showMainView: .constant(false), isNavigating: .constant(false))
            .environmentObject(SoundViewModel()) // Add this line to inject the environment object
    }
}
