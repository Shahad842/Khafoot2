//
//  Header.swift
//  Khafoot
//
//  Created by SHATHA ALQHTANI on 06/11/2024.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack {
            Text("Listen Now")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color("TextColor"))
                .padding()
            
            Spacer()
            
            NavigationLink(destination: SettingsView()) {
                Image(systemName: "gearshape")
                    .font(.title)
                    .foregroundColor(Color("AccentColor"))
                    .padding()
                    .navigationBarHidden(true)

            }
        }
    }
}
