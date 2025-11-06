//
//  StatsView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 05.11.2025.
//

import SwiftUI
import SwiftData

struct StatsView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = StatsViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 20) {
                    statsCards
                    
                    contributionSection
                }
                .padding(.horizontal, 20)
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            viewModel.setModelContext(modelContext)
            viewModel.fetchAlbums()
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
    
    private var contributionSection: some View {
        VStack (alignment: .leading, spacing: 6) {
            Text ("Activity")
                .font(.title2)
                .fontWeight(.bold)
            Text ("Your album rating acitivty over the past year")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fontWeight(.medium)
            
            ContributionGraphView(contributions: viewModel.getContributionData(), monthLabels: viewModel.getMonthLabels())
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.secondarySystemBackground))
                        .shadow(color: .black.opacity(0.05), radius: 10)
                )
        }
        
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Album.self, configurations: config)
    
    let calendar = Calendar.current
    let now = Date()
    
    for i in 0..<50 {
        let daysAgo = Int.random(in: 0...365)
        let date = calendar.date(byAdding: .day, value: -daysAgo, to: now)!
        
        let album = Album(
            id: "\(i)",
            title: "Album \(i)",
            artistName: "Artist \(i)",
            rating: Double.random(in: 5...10),
            dateAdded: date
        )
        container.mainContext.insert(album)
    }
    
    return StatsView()
        .modelContainer(container)
}
