//
//  EmptyStateView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 30.10.2025.
//

import SwiftUI

struct EmptyStateView: View {
    let icon: String
    let titleText: String
    let bodyText: String
    
    var body: some View {
        VStack (spacing: 18) {
            Image (systemName: icon)
                .font(.system(size: 64))
                .foregroundStyle(.gray)
            Text (titleText)
                .font(.title2)
                .fontWeight(.semibold)
            Text (bodyText)
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    EmptyStateView(icon: "music.note.list", titleText: "The library is empty", bodyText: "Find albums in the \"Search\" tab and add them to your library")
}
