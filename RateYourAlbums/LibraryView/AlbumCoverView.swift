//
//  AlbumCoverView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 01.12.2025.
//

import SwiftUI

struct AlbumCoverView: View {
    var body: some View {
        Image("rosie")
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.black.opacity(0.1), lineWidth: 1)
            )
    }
}

#Preview {
    AlbumCoverView()
}
