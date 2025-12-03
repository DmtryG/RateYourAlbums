//
//  AlbumCoverView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 01.12.2025.
//

import SwiftUI

struct AlbumCoverView: View {
    let cover: String
    let size: CGFloat
    let cornerRadius: CGFloat
    var hasBlur: Bool = false
    
    var body: some View {
        ZStack {
            if hasBlur {
                Image (cover)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    .blur(radius: 30).opacity(0.7)
            }
            
            Image(cover)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(Color.border, lineWidth: 1)
                )
        }
    }
}


#Preview {
    AlbumCoverView(cover: "iu", size: 250, cornerRadius: 50, hasBlur: true)
}
