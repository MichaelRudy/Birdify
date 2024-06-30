//
//  testGolfer.swift
//  Birdify
//
//  Created by Michael Rudy on 4/17/24.
//

import Foundation

struct TestGolfer: Hashable, Identifiable {
    var id = UUID()
    
    // Default Properties
    var holeNumber: Int = 1
    var name: String
    let handicap: Int
    
    mutating func increaseHole() {
        self.holeNumber += 1
    }
}


