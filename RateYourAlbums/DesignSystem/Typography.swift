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
    }
}

struct ArtistNameText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color.accent)
            .font(.subheadline)
            .fontWeight(.semibold)
            .fontWidth(.expanded)
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
}

#Preview {
    Typography()
}
