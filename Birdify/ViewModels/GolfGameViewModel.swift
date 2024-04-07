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
    @Published var currentGolfer = 0
    @Published var gameInit = false
    @Published var courseInfoAdded = false
    @Published var playerInfoAdded = false
    @Published var course: Course?
    @Published var selectedHole: Int = 0
    
    /// Adds golfers to the golfers array
    /// - Parameters:
    ///   - name: Player name
    ///   - handicap: Handicap of player
    /// - Returns: Void
    private func addGolfer(name:String, handicap: Int, score: [Hole]) -> Void {
        let newGolfer = Golfer(name:name, handicap: handicap, score: score)
        self.golfers.append(newGolfer)
    }

    /// Validates golfer by ensuring proper values were inputted by the user
    /// - Parameters:
    ///   - name: Player name
    ///   - handicap: Handicap of player
    func validateGolfer(name: String, handicap: String) {
        let handicapValue = Int(handicap) ?? 0
        let score = Array(repeating: Hole(par: 4, score: 4, TeeShot: .center, modified: false), count: self.course?.holeCount ?? 18) // check this line
        self.addGolfer(name: name, handicap: handicapValue, score: score)
    }
    
    /// Validates course by ensuring proper values were inputted by the user
    /// - Parameters:
    ///   - name: Name of golf course
    ///   - par: Par of golf course (usually 72)
    ///   - holeCount: Number of holes user intends to play
    func validateCourse(name: String, par: String, holeCount: String) {
        if let parInt = Int(par), let holeInt = Int(holeCount) {
            self.course = Course(name: name, par: parInt, holeCount: holeInt)
        }
    }

    /// Sets an individuals golfer score based on certain parameters
    /// - Parameters:
    ///   - score: Score of the indexed golfer on a particular hole
    ///   - holePar: Par of a particular hole provided by the user
    ///   - holeTeeShot: Teeshot direction of the user (left, center, right)
    func addGolferScore(score: Int, holePar: Int, holeTeeShot: Hole.TeeShotLocation, modified: Bool) {
        golfers[currentGolfer].setScore(holeScore: score, holePar: holePar, holeTeeshot: holeTeeShot, modified: modified)
        self.incrementHoleCount()
    }

    /// Gets golfers score of for a particular index
    /// - Parameter golferIndex: Used to index the golfers array
    /// - Returns: A string representation of their score to be used in a view
    func getGolferScore() -> String {
        let score = golfers[currentGolfer].getScore()
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
    
    /// Increments the hole count variable by 1
    func incrementHoleCount() {
        if golfers[currentGolfer].holeNumber <= self.course?.holeCount ?? 18 { // check this line
            golfers[currentGolfer].holeNumber += 1
        }
    }
}
