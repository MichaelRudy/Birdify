//
//  BirdifyApp.swift
//  Birdify
//
//  Created by Michael Rudy on 12/28/22.
//

import SwiftUI

@main
struct BirdifyApp: App {
    @StateObject private var golfModel = GolferModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MainMenuView()
                    .environmentObject(golfModel)
            }
           
        }
    }
}
