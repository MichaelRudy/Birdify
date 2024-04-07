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
            
            if (gm.courseInfoAdded && gm.playerInfoAdded) {
                ScoreView()
                    .environmentObject(gm)
                    .tabItem {
                        Label("Track Round", systemImage: "menucard")
                    }
            }
            else {
                if !gm.courseInfoAdded {
                    AddCourseInfo()
                        .environmentObject(gm)
                }
                else {
                    AddPlayerInfo().environmentObject(gm)
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

#Preview {
    let gm = GolfGameViewModel()
    gm.validateGolfer(name: "Michael", handicap: "10")
    //        gm.validateGolfer(name: "Tyler", handicap: "10")
    gm.validateCourse(name: "Twin Lakes", par: "72", holeCount: "9")
    gm.addGolferScore(score: 4, holePar: 5, holeTeeShot: .center, modified: true)
    gm.addGolferScore(score: 5, holePar: 5, holeTeeShot: .center, modified: true)
    gm.addGolferScore(score: 4, holePar: 5, holeTeeShot: .center, modified: true)
    gm.addGolferScore(score: 3, holePar: 5, holeTeeShot: .center, modified: true)
    return NavigationStack {
        MainMenuView().environmentObject(gm)
    }
}
