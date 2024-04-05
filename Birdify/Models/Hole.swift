//
//  Hole.swift
//  Birdify
//
//  Created by Michael Rudy on 5/28/23.
//

import Foundation

class Hole: ObservableObject {
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
    
    init(par: Int, score: Int, TeeShot: TeeShotLocation) {
        self.par = par
        self.score = score
        self.teeShot = TeeShot
    }
    
    
}

//
//struct Hole: Identifiable, Hashable {
//    var id = UUID()
//    private var par: Int?
//    private var score: Int?
//    var modified: Bool 
//    
//    
//    enum TeeShotLocation {
//        case center
//        case leftRough
//        case rightRough
//    }
//    
//    private var teeShot: TeeShotLocation
//
//    init(par: Int, score: Int, TeeShot:TeeShotLocation, modified:Bool) {
//        self.par = par
//        self.score = score
//        self.teeShot = TeeShot
//        self.modified = modified
//    }
//    
//    mutating func setPar(_ newPar: Int) {
//        // You can add validation logic here if needed
//        par = newPar
//    }
//    
//    mutating func setScore(_ newScore: Int) {
//        // You can add validation logic here if needed
//        score = newScore
//        self.modified = true
//    }
//    
//    mutating func setTeeShot(_ newTeeShot: TeeShotLocation) {
//        // You can add validation logic here if needed
//        teeShot = newTeeShot
////        print(self.teeShot)
//        
//    }
//    
//    var holeStrokes: Int {
//        self.score ?? 4
//    }
//    
//    var holePar: Int {
//        self.par ?? 4
//    }
//    
//    var holeTeeShot: TeeShotLocation {
//        self.teeShot
//    }
//    
//}
