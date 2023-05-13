//
//  GolfGameViewModel.swift
//  Birdify
//
//  Created by Michael Rudy on 2/27/23.
//

import Foundation

class GolfGameViewModel: ObservableObject {
    
    @Published var golfers = [Golfer]()
    @Published var scores = [Golfer: [Int]]()
    @Published var name = ""
    @Published var handicap = ""
    @Published var holeNumber = 1
    @Published var course: Course?
    @Published var isInit: Bool = false
    
    // add golfers from the addGolferView
    private func addGolfer(name:String, handicap: Int) -> Void {
        let newGolfer = Golfer(name:name, handicap: handicap)
        self.golfers.append(newGolfer)
        self.scores[newGolfer] = Array(repeating: 0, count: 18)
    }
    
    func validateGolfer() {
        let handicapValue = Int(handicap) ?? 0
        addGolfer(name: name, handicap: handicapValue)
        name = ""
        handicap = ""
    }
    
//    func validateCourse(name: String, par: Int) {
//        
//    }
    
    func addGolferScore(golferIndex: Int, score: String) {
        if let scoreInt = Int(score) {
            golfers[golferIndex].setScore(holeIndex: holeNumber-1, score: scoreInt)
            print(golfers[golferIndex].getScore(holeIndex: holeNumber-1))
        }
    }
    
    func getMaxGolferIndex() -> Int {
        let maxIndex = golfers.count - 1
        return maxIndex
    }
    
    func getGolferScore(golferIndex: Int) -> String {
        String(golfers[golferIndex].getScore(holeIndex: holeNumber-1))
    }
    
    func incrementHoleCount() {
        if holeNumber < self.course?.holeCount ?? 18 {
            holeNumber += 1
        }
    }
}

