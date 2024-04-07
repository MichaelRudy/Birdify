//
//  Golfer.swift
//  Birdify
//
//  Created by Michael Rudy on 2/28/23.
//

import Foundation

@available(iOS 17.0, *)
@Observable class Golfer: Identifiable {
    var name: String
    let handicap: Int
    var score: [Hole]
    
    // Default Properties
    var holeNumber: Int = 1
    
    var id: UUID = UUID()
    
    init(name: String, handicap: Int, score: [Hole]) {
        self.name = name
        self.handicap = handicap
        self.score = score
    }
    
    func setScore(holeScore: Int, holePar: Int, holeTeeshot: Hole.TeeShotLocation) {
        self.score[self.holeNumber - 1].setPar(holePar)
        self.score[self.holeNumber - 1].setScore(holeScore)
        self.holeNumber += 1
    }
    
    func getScore() -> Int {
        var plus_minus = 0
        for h in score {
            let par = h.holePar
            let strokes = h.holeStrokes
            plus_minus += (strokes - par)
            }
        return plus_minus
        }

    func getTeeShot(holeIndex: Int) -> Hole.TeeShotLocation {
        print("Hole tee shot on \(holeIndex) is \(self.score[holeIndex].holeTeeShot)")
        return self.score[holeIndex].holeTeeShot
    
    }
}


