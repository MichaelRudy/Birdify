//
//  GolferModel.swift
//  Birdify
//
//  Created by Michael Rudy on 2/24/23.
//

import Foundation

@MainActor final class GolferModel: ObservableObject {
    
    struct Golfer: Identifiable {
        var id = UUID()
        var name: String
        var handicap: Int
        var score: [Int] // consider making this a hash map ?
    }
    
    @Published var golfers = [Golfer]()
    
    // add golfers from the addGolferView
    func addGolfer(name:String, handicap: Int) -> Void {
        let newGolfer = Golfer(name:name, handicap: handicap, score: [])
        golfers.append(newGolfer)
    }
}

