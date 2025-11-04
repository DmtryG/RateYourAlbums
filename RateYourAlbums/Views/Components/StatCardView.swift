//
//  StatCardView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 04.11.2025.
//

import SwiftUI

struct StatCardView: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    var fullWidth: Bool = false
    
    var body: some View {
        VStack (alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(color)
                Spacer()
            }
            VStack (alignment: .leading, spacing: 2) {
                Text (value)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .foregroundStyle(.primary)
                Text (title)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: fullWidth ? .infinity : nil)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 10)
        )
    }
}

#Preview {
    HStack {
        StatCardView(title: "Total albums", value: "50", icon: "music.note.list", color: .blue)
        StatCardView(title: "This month", value: "15", icon: "calendar", color: .green)
    }
    .padding()
}
