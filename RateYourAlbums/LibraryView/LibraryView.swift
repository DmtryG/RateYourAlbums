//
//  ContentView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 29.11.2025.
//

import SwiftUI

struct LibraryView: View {
    var body: some View {
        ZStack {
            Color.background
            VStack {
                Text("RateYourAlbums")
                    .foregroundStyle(Color.accent)
                    .font(.title2)
                    .fontWeight(.bold)
                    .fontWidth(.expanded)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LibraryView()
}
