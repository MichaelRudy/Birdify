//
//  MainMenuView.swift
//  Birdify
//
//  Created by Michael Rudy on 2/23/23.
// https://levelup.gitconnected.com/state-vs-stateobject-vs-observedobject-vs-environmentobject-in-swiftui-81e2913d63f9

import SwiftUI

@available(iOS 17.0, *)
struct MainMenuView: View {
    @Environment(GolfGameViewModel.self) var gm 
    
    var body: some View {
        VStack{
            if (gm.courseInfoAdded && gm.playerInfoAdded) {
//                ScoreView().environment(gm)
                ScoreView()            }
            else {
                if !gm.courseInfoAdded {
//                    AddCourseInfo()
//                        .environment(gm)
                    AddCourseInfo()
                }
                else {
//                    AddPlayerInfo().environment(gm)
                    AddPlayerInfo()
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

@available(iOS 17.0, *)
#Preview {
    let gm = GolfGameViewModel()
    return NavigationStack {
        MainMenuView().environment(gm)
    }
}
