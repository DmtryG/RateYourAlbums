//
//  LibrarySearchTabView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 30.10.2025.
//

import SwiftUI

struct LibrarySearchTabView: View {
    var body: some View {
        TabView {
            Tab("Library", systemImage: "music.note.square.stack") {
                LibraryView()
            }
            Tab("Search", systemImage: "magnifyingglass") {
                SearchView()
            }
            Tab("Profile", systemImage: "person.crop.circle.fill") {
                StatsView()
            }
        }
        .tint(.red)
    }
}

#Preview {
    LibrarySearchTabView()
}
