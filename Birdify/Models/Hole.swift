//
//  Hole.swift
//  Birdify
//
//  Created by Michael Rudy on 5/28/23.
//

import Foundation

struct Hole: Identifiable, Hashable {
    var id = UUID()
    private let par: Int
    private let score: Int
    
    enum TeeShotLocation {
        case center
        case leftRough
        case rightRough
    }
    
    private let teeShot: TeeShotLocation

    init(par: Int, score: Int, TeeShot:TeeShotLocation) {
        self.par = par
        self.score = score
        self.teeShot = TeeShot
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
