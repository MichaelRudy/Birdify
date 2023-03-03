//
//  MainMenuView.swift
//  Birdify
//
//  Created by Michael Rudy on 2/23/23.
//

import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var golfModel: GolfGameViewModel
    var body: some View {
        VStack{
            title
            TabView {
                ContentView()
                    .tabItem {
                        Label("Track Round", systemImage: "menucard")
                    }
                AddGolferView()
                    .badge(golfModel.golfers.count)
                    .tabItem {
                        Label("Edit Golfers", systemImage: "figure.golf")
                    }
                
                //            NavigationView {
                //                List {
                //                    Section(header: Text("Settings")) {
                //                        NavigationLink(destination: AddGolferView().environmentObject(golfModel)) {
                //                            HStack{
                //                                Text("Add Golfers")
                //                                    .font(.title3)
                //                                    .fontWeight(.bold)
                //                                Spacer()
                //                                Text("🏌️")
                //                            }
                //                        }
                //
                //                        NavigationLink(destination: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Destination@*/Text("Destination")/*@END_MENU_TOKEN@*/) {
                //                            HStack{
                //                                Text("Customize Round")
                //                                    .font(.title3)
                //                                    .fontWeight(.bold)
                //                                Spacer()
                //                                Text("⛳️")
                //                            }
                //                        }
                //                    }
                //                    NavigationLink(destination: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Destination@*/Text("Destination")/*@END_MENU_TOKEN@*/) { /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Navigate")/*@END_MENU_TOKEN@*/ }
                //                }
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
        MainMenuView()
            .environmentObject(GolfGameViewModel())
    }
}
