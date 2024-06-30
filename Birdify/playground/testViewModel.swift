//
//  testViewModel.swift
//  Birdify
//
//  Created by Michael Rudy on 4/17/24.
// https://rhonabwy.com/2021/02/13/nested-observable-objects-in-swiftui/

import Foundation

class TestGolfGameViewModel: ObservableObject, Identifiable {
    @Published var golfer = TestGolfer(name: "bobby jones", handicap: 10)
    @Published var golfers = [TestGolfer]()
    @Published var currentGolfer = 0
    @Published var courseInfoAdded = false
    @Published var playerInfoAdded = false
    
    func addGolfer(name: String, handicap: Int) {
        self.golfers.append(TestGolfer(name: name, handicap: handicap))
    }
    
    func increaseGolferHoleNumber() {
        self.golfer.increaseHole()
        objectWillChange.send()
    }
    
    func getGolferHoleNumber() -> String {
        String(self.golfer.holeNumber)
    }
}
