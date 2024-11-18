//
//  SoundViewModel.swift
//  khafootTest1
//
//  Created by Shahad Alhothali on 28/04/1446 AH.
//
import SwiftUI
import AVFoundation
import Combine

// SoundViewModel
@MainActor
class SoundViewModel: ObservableObject {
    @Published var isMiniViewVisible: Bool = false
    @Published var selectedSound: SoundModel? = nil
    @Published var dragOffset: CGSize = .zero
    
    @Published var currentSound: SoundModel?
    @Published var isPlaying = false
    @Published var currentTime: TimeInterval = 0.0
    @Published var totalTime: TimeInterval = 0.0
    @Published var volume: Float = 0.5 {
        didSet {
            player?.volume = volume
        }
    }
    
    // New property to store liked sounds
    @Published var likedSounds: [SoundModel] = []
    
    init() {
        loadLikedSounds() // Load liked sounds when the view model initializes
    }
    
    var player: AVAudioPlayer?
    private var timer: AnyCancellable?
    
    // Categories of sounds organized by type
    @Published var categories: [String: [SoundModel]] = [
        "Rain": [
            SoundModel(title: "Forest Rain", duration: 180, date: "2024-10-28", soundImage: "ForestRain", fileName: "ForestRain", category: "Rain"),
            SoundModel(title: "Street Rain", duration: 240, date: "2024-10-28", soundImage: "StreetRain", fileName: "StreetRain", category: "Rain"),
            SoundModel(title: "Thunder Rain", duration: 300, date: "2024-10-28", soundImage: "ThunderRain", fileName: "ThunderRain", category: "Rain"),
        ],
        "Nature": [
            SoundModel(title: "Night", duration: 180, date: "2024-10-28", soundImage: "Night", fileName: "Night", category: "Nature"),
            SoundModel(title: "Forest", duration: 240, date: "2024-10-28", soundImage: "Forest", fileName: "Forest", category: "Nature"),
            SoundModel(title: "Fire", duration: 300, date: "2024-10-28", soundImage: "Fire", fileName: "Fire", category: "Nature"),
        ],
        "Water": [
            SoundModel(title: "Beach", duration: 180, date: "2024-10-28", soundImage: "Beach", fileName: "Beach", category: "Water"),
            SoundModel(title: "Sea Waves", duration: 240, date: "2024-10-28", soundImage: "SeaWaves", fileName: "SeaWaves", category: "Water"),
            SoundModel(title: "Water fall", duration: 300, date: "2024-10-28", soundImage: "Waterfall", fileName: "Waterfall", category: "Water"),
        ]
    ]
    
    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // Load the selected sound and prepare the audio player
    func loadSound(_ sound: SoundModel) {
        currentSound = sound
        guard let url = Bundle.main.url(forResource: sound.fileName, withExtension: "mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.volume = volume
            totalTime = player?.duration ?? 0
            currentTime = 0 // Reset current time
            startTimer()
        } catch {
            print("Error loading audio: \(error)")
        }
    }
    
    // Toggle play/pause state
    func togglePlayPause() {
        guard let player = player else { return }

        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        isPlaying.toggle()

        // Adding accessibility properties to play/pause button
        let playPauseButton = UIButton()
        playPauseButton.accessibilityLabel = isPlaying ? "إيقاف الصوت" : "تشغيل الصوت"
        playPauseButton.accessibilityHint = "تبديل بين تشغيل وإيقاف الصوت."
    }
    
    // Seek to a specific time
    func seek(to time: TimeInterval) {
        player?.currentTime = time
        currentTime = time

        // Adding accessibility properties to time slider
        let timeSlider = UISlider()
        timeSlider.accessibilityLabel = "التحكم في وقت الصوت"
        timeSlider.accessibilityHint = "استخدم هذا للتقدم أو التراجع في الوقت."
    }
    
    // Update volume
    func updateVolume(_ newVolume: Float) {
        volume = newVolume
        
        // Adding accessibility properties to volume slider
        let volumeSlider = UISlider()
        volumeSlider.accessibilityLabel = "تغيير مستوى الصوت"
        volumeSlider.accessibilityHint = "استخدم هذا لتعديل مستوى الصوت."
    }
    
    // Seek forward 15 seconds
    func seekForward15Seconds() {
        let newTime = min(currentTime + 15, totalTime)
        seek(to: newTime)

        // Adding accessibility properties to forward button
        let forwardButton = UIButton()
        forwardButton.accessibilityLabel = "تقديم 15 ثانية للأمام"
        forwardButton.accessibilityHint = "انتقل إلى 15 ثانية بعد الموضع الحالي للصوت."
    }
    
    // Seek backward 15 seconds
    func seekBackward15Seconds() {
        let newTime = max(currentTime - 15, 0)
        seek(to: newTime)

        // Adding accessibility properties to backward button
        let backwardButton = UIButton()
        backwardButton.accessibilityLabel = "تراجع 15 ثانية للخلف"
        backwardButton.accessibilityHint = "انتقل إلى 15 ثانية قبل الموضع الحالي للصوت."
    }
    
    // Start a timer to update current time
    private func startTimer() {
        timer?.cancel()
        timer = Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self, let player = self.player else { return }
                self.currentTime = player.currentTime
                
                // Stop playback if the end is reached
                if player.currentTime >= self.totalTime {
                    self.stopAudio() // Stop when reaching the end
                }
            }
    }
    
    // Stop audio playback and reset state
    func stopAudio() {
        player?.stop()  // Stop audio playback
        isPlaying = false // Update playing state
        currentTime = 0.0 // Reset current time
    }
    
    // Format duration for display
    func formatDuration(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    // Function to format the date in "15 October" format
    func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Adjust based on your date format
        guard let date = dateFormatter.date(from: dateString) else { return dateString }
        
        dateFormatter.dateFormat = "d MMMM"
        return dateFormatter.string(from: date)
    }
    
    // Create a shareable string for the current sound
    func shareCurrentSound() -> String {
        guard let sound = currentSound else { return "No sound to share." }
        return "Check out this sound: \(sound.title) - Listen here: [Link to Sound]" // Replace with actual link if available
    }
    
    // Function to like a sound and save it
    func toggleLike(sound: SoundModel) {
        if let index = likedSounds.firstIndex(where: { $0.id == sound.id }) {
            likedSounds.remove(at: index) // Unlike if already liked
        } else {
            likedSounds.append(sound) // Add to liked sounds
        }
        saveLikedSounds() // Save to UserDefaults after updating
        
        // Adding accessibility properties to like button
        let likeButton = UIButton()
        likeButton.accessibilityLabel = likedSounds.contains(where: { $0.id == sound.id }) ? "إلغاء الإعجاب بالصوت" : "إعجاب بالصوت"
        likeButton.accessibilityHint = "تبديل بين إضافة أو إزالة الصوت من المفضلة."
    }
    
    private func saveLikedSounds() {
        let data = try? JSONEncoder().encode(likedSounds)
        UserDefaults.standard.set(data, forKey: "likedSounds")
    }
    
    private func loadLikedSounds() {
        guard let data = UserDefaults.standard.data(forKey: "likedSounds"),
              let sounds = try? JSONDecoder().decode([SoundModel].self, from: data) else { return }
        likedSounds = sounds
    }
    
    // Make this method public so it can be accessed from other views
    func reportProblem() {
        let email = "khafoot.info@gmail.com"
        let subject = "Report a Problem"
        let body = "Please describe your issue."
        
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        if let url = URL(string: "mailto:\(email)?subject=\(subjectEncoded)&body=\(bodyEncoded)") {
            UIApplication.shared.open(url)
        }
    }
}
