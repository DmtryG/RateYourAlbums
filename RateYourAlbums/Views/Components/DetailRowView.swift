//
//  DetailRow.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 31.10.2025.
//

import SwiftUI

struct DetailRowView: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image (systemName: icon)
                .font(.body)
                .foregroundStyle(.secondary)
                .frame(width: 24, alignment: .leading)
            
            VStack (alignment: .leading, spacing: 2) {
                Text (title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text (value)
                    .font(.body)
                    .lineLimit(1)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
        }
    }
}

#Preview {
    DetailRowView(icon: "clock", title: "Date added", value: "25 oct 2025")
}
