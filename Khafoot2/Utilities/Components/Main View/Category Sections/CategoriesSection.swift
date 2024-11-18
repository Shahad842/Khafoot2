//
//  CategoriesSection.swift
//  Khafoot
//
//  Created by SHATHA ALQHTANI on 06/11/2024.
//

import SwiftUI

struct CategorySection: View {
    @EnvironmentObject var viewModel: SoundViewModel

    let category: String
    let sounds: [SoundModel]
    
    @Binding var selectedSound: SoundModel?
    @Binding var isPresentingSoundView: Bool
    @Environment(\.layoutDirection) var layoutDirection
    
    var body: some View {
        VStack(alignment: .leading) {
            CategoryHeader(category: category)
            
            SoundCardRow(
                sounds: sounds,
                selectedSound: $selectedSound,
                isPresentingSoundView: $isPresentingSoundView
            )
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
