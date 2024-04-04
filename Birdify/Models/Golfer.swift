//
//  Golfer.swift
//  Birdify
//
//  Created by Michael Rudy on 2/28/23.
//

import Foundation

struct Golfer: Identifiable, Hashable {    
    var id = UUID()
    private let name: String
    private let handicap: Int
    private var score: [Hole]    
    var holeNumber = 1
    var scoreCount: Int {
            return score.count
        }
    
    init(name: String, handicap: Int, score: [Hole]) {
        self.name = name
        self.handicap = handicap
        self.score = score
    }
    
    var scores: [Hole] {
        score
    }
    
    var golferName: String {
        name
    }
    
    var golferHandicap: Int {
        handicap
    }

    mutating func setScore(holeScore: Int, holePar: Int, holeTeeshot: Hole.TeeShotLocation, modified: Bool) {
        self.score[holeNumber-1] = Hole(par: holePar, score: holeScore, TeeShot: holeTeeshot, modified: modified)
    }
    
    mutating func editTeeShot(holeIndex: Int, holeTeeshot: Hole.TeeShotLocation) {
        self.score[holeIndex].setTeeShot(holeTeeshot)
        print("Hole tee shot on \(holeIndex) is \(self.score[holeIndex].holeTeeShot)")
    }
    
    mutating func editScore(holeIndex: Int, newScore: Int) {
        self.score[holeIndex].setScore(newScore)
    }
    
    mutating func editPar(holeIndex: Int, newPar: Int) {
        self.score[holeIndex].setPar(newPar)
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

    func getHoleData(holeIndex: Int) -> Hole {
        self.score[holeIndex]
    }
    
    func getTeeShot(holeIndex: Int) -> Hole.TeeShotLocation {
        print("Hole tee shot on \(holeIndex) is \(self.score[holeIndex].holeTeeShot)")
        return self.score[holeIndex].holeTeeShot
        
    }
    
    func getStrokes(holeIndex: Int) -> Int {
        return self.score[holeIndex].holeStrokes
    }
    
    func getPar(holeIndex: Int) -> Int {
        return self.score[holeIndex].holePar
    }
}
