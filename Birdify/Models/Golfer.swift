//
//  Golfer.swift
//  Birdify
//
//  Created by Michael Rudy on 2/28/23.
//

import Foundation

struct Golfer: Identifiable {
    var id = UUID()
    var name: String
    var handicap: Int
    let score: [Int] // consider making this a hash map ?
    
}
