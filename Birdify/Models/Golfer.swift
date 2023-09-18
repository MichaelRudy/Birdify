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
    private var score: [Hole] = Array(repeating: Hole(par: 0, score: 0, TeeShot: .center), count: 18)
   
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

    mutating func setScore(holeIndex: Int, holeScore: Int, holePar: Int, holeTeeshot: Hole.TeeShotLocation) {
        self.score[holeIndex] = Hole(par: holePar, score: holeScore, TeeShot: holeTeeshot)
    }
    
    mutating func editTeeShot(holeIndex: Int, holeTeeshot: Hole.TeeShotLocation) {
        self.score[holeIndex].setTeeShot(holeTeeshot)
        print("Hole tee shot on \(holeIndex) is \(self.score[holeIndex].holeTeeShot)")
    }
    
    mutating func editScore(holeIndex: Int, newScore: Int) {
        self.score[holeIndex].setScore(newScore)
    }
    
    func getScore(holeIndex: Int) -> Int {
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
