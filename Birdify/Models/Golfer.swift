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
    private var score = Array(repeating: 0, count: 18)
   
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

    mutating func setScore(holeIndex: Int, score: Int) {
        self.score[holeIndex] = score
    }
    
    func getScore(holeIndex: Int) -> Int {
        self.score[holeIndex]
    }
    
}
