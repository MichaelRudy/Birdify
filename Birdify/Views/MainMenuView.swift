//
//  MainMenuView.swift
//  Birdify
//
//  Created by Michael Rudy on 2/23/23.
// https://levelup.gitconnected.com/state-vs-stateobject-vs-observedobject-vs-environmentobject-in-swiftui-81e2913d63f9

import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var gm: GolfGameViewModel
    var body: some View {
        VStack{
            TabView {
                if gm.gameInit {
                    TrackScoreView()
                        .environmentObject(gm)
                        .tabItem {
                            Label("Track Round", systemImage: "menucard")
                        }
                    AddContentView()
                        .environmentObject(gm)
                        .badge(gm .golfers.count)
                        .tabItem {
                            Label("Golf Round", systemImage: "figure.golf")
                        }
                }
                else {
                    AddContentView()
                        .environmentObject(gm)
                }
            }
        }
    }
}

var title: some View {
    HStack {
        Text("Birdify")
            .font(.title)
            .fontWeight(.black)
            .italic()
            .foregroundColor(.blue)
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        Spacer()
    }
}

struct MainMenuView_Previews: PreviewProvider {
    @EnvironmentObject var golfModel: GolfGameViewModel
    static var previews: some View {
        NavigationStack {
            MainMenuView()
                .environmentObject(GolfGameViewModel())
        }
    }
}
