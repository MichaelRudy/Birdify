//
//  Course.swift
//  Birdify
//
//  Created by Michael Rudy on 4/2/23.
//

import Foundation

struct Course: Identifiable {
    let id = UUID()
    private let name: String
    private let par: Int
    private let holeCount: Int
    
    init(name: String, par: Int, holeCount: Int) {
        self.name = name
        self.par = par
        self.holeCount = holeCount
    }
}
