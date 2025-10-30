//
//  RateYourAlbumsApp.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 28.10.2025.
//

import SwiftUI
import SwiftData

@main
struct RateYourAlbumsApp: App {
    var body: some Scene {
        WindowGroup {
            SearchView()
        }
        .modelContainer(for: Album.self)
    }
}
