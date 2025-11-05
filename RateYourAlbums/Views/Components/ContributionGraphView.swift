//
//  ContributionGraphView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 05.11.2025.
//

import SwiftUI

struct ContributionGraphView: View {
    let contributions: [[DayContribution]]
    let monthLabels: [(month: String, weekIndex: Int)]
    
    private let cellSize: CGFloat = 20
    private let cellSpacing: CGFloat = 5
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ContributionGraphView()
}
