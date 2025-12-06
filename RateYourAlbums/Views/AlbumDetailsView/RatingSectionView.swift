//
//  RatingSectionView.swift
//  RateYourAlbums
//
//  Created by Dmitriy Guryanov on 03.12.2025.
//

import SwiftUI

struct RatingSectionView: View {
    var body: some View {
        VStack {
            HStack {
                AdditionalInfoView(image: "star.circle.fill", text: "Your rating")
                
                Spacer()
                
                Button {
                    print ("asdasd")
                } label: {
                    HStack {
                        Image(systemName: "pencil")
                        Text ("Edit")
                    }
                }
                .buttonStyle(.glassProminent)
                .fontWeight(.semibold)
            }
            .padding(.top, 15)
            .padding(.horizontal, 15)
            Divider()
            
            RatingBadgeView(rating: 7.8, size: 250)
                .padding(.top, 26)
                .padding(.bottom, 34)
            
        }
        .background (
            LinearGradient(colors: [Color.gradientColor1, Color.gradientColor2], startPoint: .top, endPoint: .bottom)
        )
        .clipShape(RoundedRectangle(cornerRadius: 26))
        .overlay (
            RoundedRectangle(cornerRadius: 26)
                .stroke(Color.border, lineWidth: 1)
        )
    }
}

#Preview {
    RatingSectionView()
}
