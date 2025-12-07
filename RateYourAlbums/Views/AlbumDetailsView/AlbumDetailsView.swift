//
//  AlbumDetailsView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 07.12.2025.
//

import SwiftUI

struct AlbumDetailsView: View {
    var body: some View {
        ScrollView {
            VStack {
                Section {
                    AlbumCoverView(cover: "rosie", size: 320, cornerRadius: 50, hasBlur: true)
                    
                    VStack {
                        Text ("rosie")
                            .largeAlbumTitleStyle()
                        Text ("ROSÉ")
                            .largeArtistNameStyle()
                    }
                    .padding(.top, 5)
                }
                
                Section {
                    HStack (spacing: 10) {
                        InfoBadgeView(icon: "guitars.fill", text: "Pop")
                        InfoBadgeView(icon: "calendar", text: "2024")
                        InfoBadgeView(icon: "music.note.list", text: "12 tracks")
                    }
                    InfoBadgeView(icon: "calendar.badge.plus", text: "2 December 2025")
                }
                
                Section {
                    RatingSectionView()
                }
                .padding(.top, 30)
                
                HStack {
                    PrimaryButtonView(image: "plus", text: "Add to library")
                    SecondaryButtonView(image: "clock.fill")
                }
                .padding(.top, 15)
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    AlbumDetailsView()
}
