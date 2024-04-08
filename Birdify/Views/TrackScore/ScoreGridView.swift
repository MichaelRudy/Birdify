//
//  ScoreGridView.swift
//  Birdify
//
//  Created by Michael Rudy on 4/2/24.
//

import SwiftUI

@available(iOS 17.0, *)
struct ScoreGridView: View {
    // Assuming a standard 18-hole course; modify this as needed.
    let holes: [Int] = Array(1...18)
    @Environment(GolfGameViewModel.self) var gm

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) { // Adjust spacing as needed
                ForEach(Array(zip(holes, gm.golfers[gm.currentGolfer].scores)), id: \.0) { hole, score in
                    HStack {
                        VStack {
                            Text("\(hole)")
                                .frame(minWidth: 50) // Adjust the width as needed
                                .background(Color.gray.opacity(0.5))
                                .foregroundColor(.white)
                            if score.modified {
                                if score.overPar {
                                    Text(String(score.holeStrokes))
                                        .frame(minWidth: 50) // Adjust the width as needed
                                        .background(Color.red.opacity(0.5))
                                        .foregroundColor(.black)
                                }
                                else {
                                    Text(String(score.holeStrokes))
                                        .frame(minWidth: 50) // Adjust the width as needed
                                        .background(Color.green.opacity(0.5))
                                        .foregroundColor(.black)
                                }
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
@available(iOS 17.0, *)
#Preview {
    let gm = GolfGameViewModel()
    gm.validateGolfer(name: "Michael", handicap: "10")
    //        gm.validateGolfer(name: "Tyler", handicap: "10")
    gm.validateCourse(name: "Twin Lakes", par: "72", holeCount: "9")
    gm.addGolferScore(score: 3, holePar: 5, holeTeeShot: .center)
    gm.addGolferScore(score: 10, holePar: 5, holeTeeShot: .center)
    gm.addGolferScore(score: 5, holePar: 5, holeTeeShot: .center)
//    gm.addGolferScore(score: 3, holePar: 5, holeTeeShot: .center)
    return NavigationStack {
        ScoreGridView().environment(gm)
    }
}
