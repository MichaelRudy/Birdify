//
//  Hole.swift
//  Birdify
//
//  Created by Michael Rudy on 5/28/23.
//

import Foundation

struct Hole: Identifiable, Hashable {
    var id = UUID()
    private var par: Int
    private var score: Int
    
    enum TeeShotLocation {
        case center
        case leftRough
        case rightRough
    }
    
    private var teeShot: TeeShotLocation

    init(par: Int, score: Int, TeeShot:TeeShotLocation) {
        self.par = par
        self.score = score
        self.teeShot = TeeShot
    }
    
    mutating func setPar(_ newPar: Int) {
        // You can add validation logic here if needed
        par = newPar
    }
    
    mutating func setScore(_ newScore: Int) {
        // You can add validation logic here if needed
        score = newScore
    }
    
    mutating func setTeeShot(_ newTeeShot: TeeShotLocation) {
        // You can add validation logic here if needed
        teeShot = newTeeShot
//        print(self.teeShot)
        
    }
    
    var holeStrokes: Int {
        self.score
    }
    
    var holePar: Int {
        self.par
    }
    
    var holeTeeShot: TeeShotLocation {
        self.teeShot
    }
    
}
