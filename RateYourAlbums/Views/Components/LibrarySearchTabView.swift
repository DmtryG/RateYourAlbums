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
        }
        .tint(.red)
    }
}

#Preview {
    LibrarySearchTabView()
}
