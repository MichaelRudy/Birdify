//
//  GolfGameViewModel.swift
//  Birdify
//
//  Created by Michael Rudy on 2/27/23.
//

import Foundation

@MainActor final class GolfGameViewModel: ObservableObject {
    
    @Published var golfers = [Golfer]()
    
    // add golfers from the addGolferView
    func addGolfer(name:String, handicap: Int) -> Void {
        let newGolfer = Golfer(name:name, handicap: handicap, score: Array(repeating: 0, count: 18))
        golfers.append(newGolfer)
    }
}
