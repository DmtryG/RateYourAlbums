//
//  StatsView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 05.11.2025.
//

import SwiftUI

struct StatsView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = StatsViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 20) {
                    statsCards
                }
                .padding(.horizontal, 20)
            }
            .navigationTitle("Profile")
        }
    }
    
    private var statsCards: some View {
        VStack (spacing: 20) {
            HStack (spacing: 20) {
                StatCardView(title: "Total albums", value: "\(viewModel.totalAlbumsRated)", icon: "music.note.square.stack.fill", color: .red)
                
                StatCardView(title: "This month", value: "\(viewModel.albumsRatedThisMonth)", icon: "31.calendar", color: .red)
            }
            StatCardView(title: "Average rating", value: "\(viewModel.averageRating)", icon: "10.circle.fill", color: .red)
        }
    }
}

#Preview {
    StatsView()
}
