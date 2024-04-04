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
    @EnvironmentObject var gm: GolfGameViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) { // Adjust spacing as needed
                ForEach(Array(zip(holes, gm.golfers[gm.currentGolfer].scores)), id: \.0) { hole, score in
                    HStack {
                        VStack {
//                            Text(String(score.modified))
                            Text("\(hole)")
                                .frame(minWidth: 50) // Adjust the width as needed
                                .background(Color.gray.opacity(0.5))
                                .foregroundColor(.white)
                            if score.modified {
                                Text(String(score.holeStrokes))
                                    .frame(minWidth: 50) // Adjust the width as needed
                                    .background(Color.green.opacity(0.5))
                                    .foregroundColor(.black)
                            }
                            else {
                                Text("-")
                                    .frame(minWidth: 50) // Adjust the width as needed
                                    .background(Color.green.opacity(0.5))
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
            }
            .padding() // Add padding around the HStack for better presentation
        }
    }
}

#Preview {
    let gm = GolfGameViewModel()
    gm.validateGolfer(name: "Michael", handicap: "10")
    //        gm.validateGolfer(name: "Tyler", handicap: "10")
    gm.validateCourse(name: "Twin Lakes", par: "72", holeCount: "9")
    gm.addGolferScore(score: 4, holePar: 5, holeTeeShot: .center, modified: true)
    gm.addGolferScore(score: 5, holePar: 5, holeTeeShot: .center, modified: true)
    gm.addGolferScore(score: 4, holePar: 5, holeTeeShot: .center, modified: true)
    gm.addGolferScore(score: 3, holePar: 5, holeTeeShot: .center, modified: true)
    return NavigationStack {
        ScoreGridView().environmentObject(gm)
    }
}
