//
//  AirPlayButton.swift
//  khafootTest1
//
//  Created by Shahad Alhothali on 29/04/1446 AH.
//

import SwiftUI
import AVKit

struct AirPlayButton: UIViewRepresentable {
    func makeUIView(context: Context) -> AVRoutePickerView {
        let routePicker = AVRoutePickerView()
        routePicker.backgroundColor = .clear
        routePicker.activeTintColor = UIColor.white
        routePicker.tintColor = UIColor.white
        
        // Add accessibility features
        routePicker.isAccessibilityElement = true
        routePicker.accessibilityLabel = "AirPlay"
        routePicker.accessibilityHint = "Select audio output device"
        
        // Add accessibility traits
        routePicker.accessibilityTraits = [.button, .adjustable]
        
        // Optional: Add custom accessibility actions if needed
        let playAction = UIAccessibilityCustomAction(
            name: "Connect to AirPlay device",
            target: context.coordinator,
            selector: #selector(Coordinator.handleAirPlayAction)
        )
        routePicker.accessibilityCustomActions = [playAction]
        
        return routePicker
    }
    
    func updateUIView(_ uiView: AVRoutePickerView, context: Context) {
        // Update accessibility state if needed
        if AVAudioSession.sharedInstance().currentRoute.outputs.count > 1 {
            uiView.accessibilityValue = "Connected"
        } else {
            uiView.accessibilityValue = "Not connected"
        }
    }
    
    // Add Coordinator for handling custom actions
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator {
        @objc func handleAirPlayAction() -> Bool {
            // Handle custom AirPlay action if needed
            return true
        }
    }
}

// Preview provider for testing
struct AirPlayButton_Previews: PreviewProvider {
    static var previews: some View {
        AirPlayButton()
    }
}

// Extension to check AirPlay connection status
extension AVAudioSession {
    var isAirPlayConnected: Bool {
        return currentRoute.outputs.contains { $0.portType == .airPlay }
    }
}
