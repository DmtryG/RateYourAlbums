//
//  AlbumCoverView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 29.10.2025.
//

import SwiftUI

struct AlbumCoverView: View {
    let artworkURL: String?
    var size: CGFloat = 100
    var cornerRadius: CGFloat = 25
    
    var body: some View {
        Group {
            if let urlString = artworkURL,
               let url = URL(string: urlString) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        loadingPlaceholder
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        errorPlaceholder
                    @unknown default:
                        errorPlaceholder
                    }
                }
            } else {
                errorPlaceholder
            }
        }
        .frame(width: size, height: size)
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
    
    private var loadingPlaceholder: some View {
        ZStack {
            Color.gray.opacity(0.2)
            ProgressView()
        }
    }
    
    private var errorPlaceholder: some View {
        ZStack {
            Color.gray.opacity(0.2)
            Image (systemName: "music.note")
                .font(.system(size: size * 0.4))
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    AlbumCoverView(artworkURL: nil, size: 200, cornerRadius: 25)
}
