//
//  AddPlayerInfo.swift
//  Birdify
//
//  Created by Michael Rudy on 3/4/24.
//

import SwiftUI

@available(iOS 17.0, *)
struct AddPlayerInfo: View {
    @Environment(GolfGameViewModel.self) var gm
    @State private var name: String = ""
    @State private var handicap: Double = 0
    var body: some View {
        VStack {
            HStack {
                Text("Add Player Information")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .bold()
                    .italic()
                    .foregroundColor(.blue)
                    .padding()
                Spacer()
            }
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading, 10)
                
                TextField("Player Name", text: $name)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .font(.title2)
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
            }
            .cornerRadius(10)
            .padding()
            Slider(value: $handicap, in: -15...50, step: 1.0)
                .padding()
                .accentColor(.blue)
            
            Text("Player Handicap: \(Int(handicap))")
                .font(.title2)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .bold()
                .italic()
                .foregroundColor(.blue)
                .padding()
            Spacer()
            List {
                Section(header: header) {
                    ForEach(gm.golfers) { golfer in
                        HStack {
                            Text(golfer.name)
                            Spacer()
                            Text(String(golfer.handicap))
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            HStack {
                Button(action: {
                    let str_handicap = String(Int(handicap))
                    gm.validateGolfer(name: name, handicap: str_handicap)
                    name = ""
                    handicap = 0
                }) {
                    Text("Add")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                Button(action: {
                    gm.playerInfoAdded.toggle()
                }) {
                    Text("Play ⛳️")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
    }
}

var header: some View {
    HStack {
        Text("Golfer")
        Spacer()
        Text("Handicap")
    }
}

@available(iOS 17.0, *)
#Preview {
    let gm = GolfGameViewModel()
    return AddPlayerInfo().environment(gm)
}

