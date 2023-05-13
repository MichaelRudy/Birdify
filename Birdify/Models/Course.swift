//
//  Course.swift
//  Birdify
//
//  Created by Michael Rudy on 4/2/23.
//

import Foundation

struct Course: Identifiable, Hashable {
    let id = UUID()
    private let name: String
    private let par: Int
    public let holeCount: Int
    
    init(name: String, par: Int, holeCount: Int) {
        self.name = name
        self.par = par
        self.holeCount = holeCount
    }
}
