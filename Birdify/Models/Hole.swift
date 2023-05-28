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

    init(par: Int, score: Int) {
        self.par = par
        self.score = score
    }
    
    var holeStrokes: Int {
        self.score
    }
    
    var holePar: Int {
        self.par
    }
    
}
