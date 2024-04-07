//
//  Hole.swift
//  Birdify
//
//  Created by Michael Rudy on 5/28/23.
//

import Foundation

@available(iOS 17.0, *)
@Observable class Hole: Identifiable {
    private var par: Int
    private var score: Int
    enum TeeShotLocation {
        case center
        case leftRough
        case rightRough
    }
    private var teeShot: TeeShotLocation
    
    // Default Properties
    let id: UUID = UUID()
    var modified: Bool = false
    
    init(par: Int, score: Int, TeeShot: TeeShotLocation) {
        self.par = par
        self.score = score
        self.teeShot = TeeShot
    }
    
    // computed properties (value type not reference to hole)
    var holePar: Int {
        self.par
    }
    
    var holeTeeShot: TeeShotLocation {
        self.teeShot
    }
    
    func setPar(_ newPar: Int) {
        self.par = newPar
        modified = true
    }
        
    func setScore(_ newScore: Int) {
        self.score = newScore
        modified = true
    }
    
    var holeStrokes: Int {
        self.score
    }
    
    var overPar: Bool {
        if self.holeStrokes - self.par >= 0 {
            return true
        }
        else {
            return false
        }
    }
}

