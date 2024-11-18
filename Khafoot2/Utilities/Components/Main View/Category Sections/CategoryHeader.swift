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

//                Spacer()

                NavigationLink(destination: CategoryView(category: category, sounds: viewModel.categories[category] ?? [])) {
                    Image(systemName: layoutDirection == .rightToLeft ? "chevron.left" : "chevron.right")
                        .foregroundColor(Color("AccentColor"))
//                        .font(.subheadline)
                        .frame(width: 15, height: 23)
                }
            }
            
            Text("Relaxing \(category) Sounds")
                .font(.system(size: 15))
                .foregroundColor(Color("SecondaryTextColor"))
        }
//        .padding(.horizontal)
    }
}
