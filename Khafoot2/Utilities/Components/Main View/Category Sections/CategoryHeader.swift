//
//  CategoryHeader.swift
//  Khafoot
//
//  Created by SHATHA ALQHTANI on 06/11/2024.
//
import SwiftUI

struct CategoryHeader: View {
    @EnvironmentObject var viewModel: SoundViewModel
    let category: String
    @Environment(\.layoutDirection) var layoutDirection
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(category)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(Color("TextColor"))
                    // Add accessibility for the category title
                    .accessibilityAddTraits(.isHeader)

                NavigationLink(destination: CategoryView(category: category, sounds: viewModel.categories[category] ?? [])) {
                    Image(systemName: layoutDirection == .rightToLeft ? "chevron.left" : "chevron.right")
                        .foregroundColor(Color("AccentColor"))
                        .frame(width: 15, height: 23)
                }
                // Make the navigation link more accessible
                .accessibilityLabel("View all \(category) sounds")
                .accessibilityHint("Navigate to see the complete list of \(category) sounds")
            }
            // Combine the header elements for better VoiceOver experience
            .accessibilityElement(children: .combine)
            .accessibilityLabel("\(category) category")
            
            Text("Relaxing \(category) Sounds")
                .font(.system(size: 15))
                .foregroundColor(Color("SecondaryTextColor"))
                // Add accessibility for the subtitle
                .accessibilityLabel("Category description")
                .accessibilityValue("Relaxing \(category) Sounds")
        }
    }
}
