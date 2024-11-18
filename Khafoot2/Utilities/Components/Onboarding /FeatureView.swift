//
//  FeatureView.swift
//  Khafoot
//
//  Created by SHATHA ALQHTANI on 06/11/2024.
//

import SwiftUI

struct FeatureView: View {
    let imageName: String
    let title: String
    let description: String
    let imageWidth: CGFloat
    let imageHeight: CGFloat

    var body: some View {
        HStack {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: imageWidth, height: imageHeight)
                .foregroundColor(Color("AccentColor"))

            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color("TextColor"))

                Text(description)
                    .font(.system(size: 12))
                    .foregroundColor(Color("TextColor"))
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.leading, 40)
    }
}
