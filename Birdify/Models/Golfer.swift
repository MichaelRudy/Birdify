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
    
    // Default Properties
    var holeNumber: Int = 1
    var score: [Hole]
    
    var id: UUID = UUID()
    
    init(name: String, handicap: Int) {
        self.name = name
        self.handicap = handicap
        // Initialize the score array with unique Hole instances
        self.score = (1...18).map { _ in Hole(par: 4, score: 4, TeeShot: .center) }
        
    }
    
    func setScore(holeScore: Int, holePar: Int, holeTeeshot: Hole.TeeShotLocation) {
        let index = self.holeNumber - 1
        self.score[index].setPar(holePar)
        self.score[index].setScore(holeScore)
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
    
    var scores: [Hole] {
        self.score
    }
}


