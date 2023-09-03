//
//  GolfGameViewModel.swift
//  Birdify
//
//  Created by Michael Rudy on 2/27/23.
//

import Foundation
import SwiftUI

class GolfGameViewModel: ObservableObject {
    
    @Published var golfers = [Golfer]()
    @Published var holeNumber = 1
    @Published var course: Course?
    @Published var isInit: Bool = false
    
    // add golfers from the addGolferView
    private func addGolfer(name:String, handicap: Int) -> Void {
        let newGolfer = Golfer(name:name, handicap: handicap)
        self.golfers.append(newGolfer)
    }
    
    func validateGolfer(name: String, handicap: String) {
        let handicapValue = Int(handicap) ?? 0
        addGolfer(name: name, handicap: handicapValue)
    }
    
    func validateCourse(name: String, par: String, holeCount: String) {
        if let parInt = Int(par), let holeInt = Int(holeCount) {
            self.course = Course(name: name, par: parInt, holeCount: holeInt)
            self.isInit = true
        }
    }
        
    func addGolferScore(golferIndex: Int, score: Int, holePar: Int) {
        
//            golfers[golferIndex].setScore(holeIndex: holeNumber-1, score: scoreInt)
        golfers[golferIndex].setScore(holeIndex: holeNumber-1, holeScore: score, holePar: holePar)
        print(golfers[golferIndex].getScore(holeIndex: holeNumber-1))
        
    }
    
    func getMaxGolferIndex() -> Int {
        let maxIndex = golfers.count - 1
        return maxIndex
    }
    
    func getGolferScore(golferIndex: Int) -> String {
        let score = golfers[golferIndex].getScore(holeIndex: self.holeNumber-1)
        
        if score == 0 {
            return "E"
        }
        else if score > 0 {
            return "+"+String(score)
        }
        else {
            return String(score)
        }
    }
    
    func getGolferStrokes(golferIndex: Int, holeN: Int) -> String {
        String(golfers[golferIndex].getStrokes(holeIndex: holeN-1))
    }
    
    func getHolePar(golferIndex: Int, holeN: Int) -> String {
        String(golfers[golferIndex].getPar(holeIndex: holeN-1))
    }
    
    func incrementHoleCount() {
        if holeNumber <= self.course?.holeCount ?? 18 {
            holeNumber += 1
        }
    }
}

