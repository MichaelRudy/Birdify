//
//  ScoreGridView.swift
//  Birdify
//
//  Created by Michael Rudy on 4/2/24.
//

import SwiftUI

struct ScoreGridView: View {
    // Assuming a standard 18-hole course; modify this as needed.
    let holes: [Int] = Array(1...18)
    let scores: [String] = Array(repeating: "-", count: 18) // Placeholder scores; replace with actual data.
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) { // Adjust spacing as needed
                ForEach(Array(zip(holes, scores)), id: \.0) { hole, score in
                    HStack {
                        VStack {
                            Text("\(hole)")
                                .frame(minWidth: 50) // Adjust the width as needed
                                .background(Color.gray.opacity(0.5))
                                .foregroundColor(.white)
                            Text(score)
                                .frame(minWidth: 50) // Adjust the width as needed
                                .background(Color.green.opacity(0.5))
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .padding() // Add padding around the HStack for better presentation
        }
    }
}

#Preview {
    ScoreGridView()
}
