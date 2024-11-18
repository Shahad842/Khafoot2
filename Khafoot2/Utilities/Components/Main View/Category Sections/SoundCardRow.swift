//
//  SoundCardRow.swift
//  Khafoot
//
//  Created by SHATHA ALQHTANI on 06/11/2024.
//

import SwiftUI

struct SoundCardRow: View {
    @EnvironmentObject var viewModel: SoundViewModel

    let sounds: [SoundModel]
    
    @Binding var selectedSound: SoundModel?
    @Binding var isPresentingSoundView: Bool
    @Environment(\.layoutDirection) var layoutDirection

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack/*(spacing: -20)*/ {
                ForEach(sounds) { sound in
                    SoundCard(sound: sound)
                        .onTapGesture {
                            selectedSound = sound
                            viewModel.loadSound(sound)
                            isPresentingSoundView = true
                        }
                }
            }
//            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: layoutDirection == .rightToLeft ? .trailing : .leading)
        }
    }
}
