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
        let score = Array(repeating: Hole(par: 4, score: 4, TeeShot: .center), count: self.course?.holeCount ?? 18) // check this line
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
    func addGolferScore(score: Int, holePar: Int, holeTeeShot: Hole.TeeShotLocation) {
        golfers[currentGolfer].setScore(holeScore: score, holePar: holePar, holeTeeshot: holeTeeShot)
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
    
    /// Gets golfers tee shot direction for a particular index on a particular hole
    /// - Parameters:
    ///   - holeN: Hole number
    /// - Returns: View that represents the teeshot direction (left, center, right)
    func golferTeeShot(holeN: Int) -> some View {
        let teeShot = golfers[currentGolfer].getTeeShot(holeIndex: holeN-1)
        switch teeShot {
        case .center:
            return ZStack {
                Circle()
                    .stroke(Color.blue, lineWidth: 2)
                    .frame(width: 40, height: 40)
                Image(systemName: "arrow.up")
                    .font(.title)
                    .foregroundColor(.blue)
            }
        case .leftRough:
            return ZStack {
                Circle()
                    .stroke(Color.blue, lineWidth: 2)
                    .frame(width: 40, height: 40)
                Image(systemName: "arrow.up.left")
                    .font(.title)
                    .foregroundColor(.blue)
            }
        case .rightRough:
            return ZStack {
                Circle()
                    .stroke(Color.blue, lineWidth: 2)
                    .frame(width: 40, height: 40)
                Image(systemName: "arrow.up.right")
                    .font(.title)
                    .foregroundColor(.blue)
            }
        }
    }
    
    /// Gets golfers strokes
    /// - Parameters:
    ///   - holeN: Hole Number
    /// - Returns: the strokes of a golfer on a particular hole.
    func getGolferStrokes(holeN: Int) -> Int {
        golfers[currentGolfer].getStrokes(holeIndex: holeN-1)
    }
    
    /// Gets hole par
    /// - Parameters:
    ///   - holeN: Hole Number
    /// - Returns: Hole par (3,4,5)
    func getHolePar(holeN: Int) -> Int {
        golfers[currentGolfer].getPar(holeIndex: holeN-1)
    }
    
    /// Increments the hole count variable by 1
    func incrementHoleCount() {
        if golfers[currentGolfer].holeNumber <= self.course?.holeCount ?? 18 { // check this line
            golfers[currentGolfer].holeNumber += 1
        }
    }
    
    /// Returns a view of the score symbol used (birides are circled, bogeys are squared)
    /// - Parameters:
    ///   - par: Par integer for the hole
    ///   - strokes: Amount of strokes taken on a hole
    /// - Returns: Strokes nested in a particular view (circled represents birdies, no symbol represents par, squares represent bogeys)
    func ScoreSynbol(par: Int, strokes: Int) -> some View {
        ZStack {
            let plus_minus = strokes - par
            if plus_minus == 0 {
                Text(String(strokes))
                    .font(.title)
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity)
            }
            else if plus_minus == -1 {
                Circle()
                    .stroke(Color.blue, lineWidth: 2)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text(String(strokes))
                            .font(.title)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity))
            }
            else if plus_minus < -1 {
                Circle()
                    .stroke(Color.blue, lineWidth: 2)
                    .frame(width: 40, height: 40)
                Circle()
                    .stroke(Color.blue, lineWidth: 2)
                    .frame(width: 30, height: 30)
                    .overlay(
                        Text(String(strokes))
                            .font(.title)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity))
            }
            else if plus_minus == 1 {
                Rectangle()
                    .stroke(Color.blue, lineWidth: 2) // Customize the color and line width as needed
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text(String(strokes))
                            .font(.title)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                    )
            }
            else if plus_minus > 1 {
                Rectangle()
                    .stroke(Color.blue, lineWidth: 2) // Customize the color and line width as needed
                    .frame(width: 40, height: 40)
                Rectangle()
                    .stroke(Color.blue, lineWidth: 2) // Customize the color and line width as needed
                    .frame(width: 30, height: 30)
                    .overlay(
                        Text(String(strokes))
                            .font(.title)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                    )
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    /// Edit Tee Shot
    /// - Parameters:
    ///   - holeN: Hole Number
    ///   - holeTeeshot: Shot Direction
    func editTeeShot(holeN: Int, holeTeeshot: Hole.TeeShotLocation) {
        golfers[currentGolfer].editTeeShot(holeIndex: holeN-1, holeTeeshot: holeTeeshot)
    }
    
    /// Edit Stroke
    /// - Parameters:
    ///   - holeN: Hole Number
    ///   - newStrokes: Updated Stroke
    func editStroke(holeN: Int, newStrokes: Int) {
        golfers[currentGolfer].editScore(holeIndex: holeN-1, newScore: newStrokes)
    }

    /// Edit Par
    /// - Parameters:
    ///   - holeN: Hole Number edited
    ///   - newPar: Updated Par for hole
    func editPar(holeN: Int, newPar: Int) {
        golfers[currentGolfer].editPar(holeIndex: holeN-1, newPar: newPar)
    }
    
    /// Gets golf hole data in the gofer's score array
    /// - Parameters:
    ///   - holeN: Hole Number
    /// - Returns: Shot Direction
    func golfHoleData(golferIndex: Int, holeN: Int) -> Hole {
        golfers[golferIndex].getHoleData(holeIndex: holeN-1)
    }
    
    func golferShotDirection(golferIndex: Int, holeN: Int) -> Hole.TeeShotLocation {
        golfers[golferIndex].getTeeShot(holeIndex: holeN)
    }
}
