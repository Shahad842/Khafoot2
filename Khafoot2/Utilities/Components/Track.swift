//
//  Track.swift
//  Khafoot
//
//  Created by Gehad Eid on 06/11/2024.
//

import SwiftUI

struct Track: View {
    @EnvironmentObject var viewModel: SoundViewModel
    
    var body: some View {
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
            .frame(height: 10)
        }
    }
}
