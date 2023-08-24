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
    private var score = Array(repeating: Hole(par: 0, score: 0), count: 18)
   
    init(name: String, handicap: Int) {
        self.name = name
        self.handicap = handicap
    }
    
    var golferName: String {
        name
    }
    
    var golferHandicap: Int {
        handicap
    }

    mutating func setScore(holeIndex: Int, holeScore: Int, holePar: Int) {
        self.score[holeIndex] = Hole(par: holePar, score: holeScore)
    }
    
    // function for obtaining both hole par and and strokes to compute +-
    func getScore(holeIndex: Int) -> Int {
        var plus_minus = 0
        for h in score {
            let par = h.holePar
            let strokes = h.holeStrokes
            plus_minus += (strokes - par)
        }
        
        return plus_minus
    }
    
    func getStrokes(holeIndex: Int) -> Int {
        return self.score[holeIndex].holeStrokes
    }
    
    func getPar(holeIndex: Int) -> Int {
        return self.score[holeIndex].holePar
    }
    
}
