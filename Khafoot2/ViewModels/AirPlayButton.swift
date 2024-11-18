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
        routePicker.activeTintColor = UIColor.white // Optional: Customize tint for active state
        routePicker.tintColor = UIColor.white // Optional: Customize tint for default state
        return routePicker
    }
    
    func updateUIView(_ uiView: AVRoutePickerView, context: Context) {
        // No update logic needed for static views
    }
}
