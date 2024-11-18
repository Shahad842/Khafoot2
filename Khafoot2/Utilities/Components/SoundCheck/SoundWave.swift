//
//  SoundWave.swift
//  Khafoot
//
//  Created by SHATHA ALQHTANI on 06/11/2024.
//

import SwiftUI

struct SoundWave: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let height = geometry.size.height
                // يمكنك إضافة المزيد من التفاصيل هنا لرسم شكل الموجة الصوتية
            }
            .stroke(Color(hex: "A8C686"), lineWidth: 2)
        }
        .frame(height: 40)
    }
}
