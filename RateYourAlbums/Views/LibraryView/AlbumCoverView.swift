//
//  AlbumCoverView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 01.12.2025.
//

import SwiftUI

struct AlbumCoverView: View {
    let coverName: String
    
    var body: some View {
        Image(coverName)
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.border, lineWidth: 1)
            )
    }
}

#Preview {
    AlbumCoverView(coverName: "rosie")
}
