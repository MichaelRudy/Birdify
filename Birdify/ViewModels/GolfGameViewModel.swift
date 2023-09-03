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
    
    func getGolferStrokes(golferIndex: Int, holeN: Int) -> Int {
        golfers[golferIndex].getStrokes(holeIndex: holeN-1)
    }
    
    func getHolePar(golferIndex: Int, holeN: Int) -> Int {
        golfers[golferIndex].getPar(holeIndex: holeN-1)
    }
    
    func incrementHoleCount() {
        if holeNumber <= self.course?.holeCount ?? 18 {
            holeNumber += 1
        }
    }
    
    func ScoreSynbol(par: Int, strokes: Int) -> some View {
        ZStack {
            let plus_minus = strokes - par
            if plus_minus == 0 {
                Text("E")
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
            
            else if plus_minus == 2 {
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
}
