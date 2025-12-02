//
//  Typography.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 01.12.2025.
//

import SwiftUI

struct Typography: View {
    var body: some View {
        VStack {
            HStack {
                Text ("Rated")
                    .titleStyle1()
                Text ("To-Listen")
                    .titleStyle2()
            }
            VStack(alignment: .leading) {
                Text ("Album Title")
                    .albumTitleStyle()
                Text ("Artist Name")
                    .artistNameStyle()
                
                Text ("Album Title")
                    .largeAlbumTitleStyle()
                Text ("Artist Name")
                    .largeArtistNameStyle()
            }
        }
    }
}

struct TitleText1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color.title)
            .font(.largeTitle)
            .fontWeight(.heavy)
            .fontWidth(.expanded)
    }
}



struct TitleText2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color.title)
            .font(.largeTitle)
            .fontWeight(.regular)
            .fontWidth(.expanded)
    }
}

struct AlbumTitleText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color.title)
            .font(.headline)
            .fontWeight(.bold)
            .lineLimit(1)
    }
}

struct LargeAlbumTitleText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.title)
            .font(.title)
            .fontWeight(.bold)
            .lineLimit(1)
    }
}

struct ArtistNameText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color.accent)
            .font(.subheadline)
            .fontWeight(.semibold)
            .fontWidth(.expanded)
            .lineLimit(1)
    }
}

struct LargeArtistNameText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color.accent)
            .font(.title2)
            .fontWeight(.semibold)
            .fontWidth(.expanded)
            .lineLimit(1)
    }
}

extension View {
    func titleStyle1() -> some View {
        self.modifier(TitleText1())
    }
    func titleStyle2() -> some View {
        self.modifier(TitleText2())
    }
    func albumTitleStyle() -> some View {
        self.modifier(AlbumTitleText())
    }
    func artistNameStyle() -> some View {
        self.modifier(ArtistNameText())
    }
    func largeAlbumTitleStyle() -> some View {
        self.modifier(LargeAlbumTitleText())
    }
    func largeArtistNameStyle() -> some View {
        self.modifier(LargeArtistNameText())
    }
}

#Preview {
    Typography()
}
