//
//  MainMenuView.swift
//  Birdify
//
//  Created by Michael Rudy on 2/23/23.
// https://levelup.gitconnected.com/state-vs-stateobject-vs-observedobject-vs-environmentobject-in-swiftui-81e2913d63f9

import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var golfModel: GolfGameViewModel
    var body: some View {
        VStack{
            TabView {
                TrackScoreView()
                    .tabItem {
                        Label("Track Round", systemImage: "menucard")
                    }
                AddGolferView()
                    .badge(golfModel.golfers.count)
                    .tabItem {
                        Label("Edit Golfers", systemImage: "figure.golf")
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
    static var previews: some View {
        NavigationStack {
            MainMenuView()
                .environmentObject(GolfGameViewModel())
        }
    }
}
