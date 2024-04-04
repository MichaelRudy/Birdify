//
//  BirdifyApp.swift
//  Birdify
//
//  Created by Michael Rudy on 12/28/22.
//

import SwiftUI

@main
struct BirdifyApp: App {
    @StateObject private var golfModel = GolfGameViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MainMenuView()
                    .environmentObject(golfModel)
            }

//            WeatherView()
//            MainMenuView().environmentObject(golfModel)
//            NavigationStack {
//                MainMenuView()
//                    .environmentObject(golfModel)
//            }
        }
    }
}
