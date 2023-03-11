//
//  TrackScoreView.swift
//  Birdify
//
//  Created by Michael Rudy on 3/2/23.
//

import SwiftUI

struct TrackScoreView: View {
    @EnvironmentObject var golfModel: GolfGameViewModel
    @State var currentGolferIndex = 0
    @State var score = ""
    
    var body: some View {
        VStack {
            Text("Hole: \(String(golfModel.holeNumber))")
                .font(.title)
                .fontWeight(.bold)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Divider()
            VStack {
                if golfModel.golfers.isEmpty {
                    NavigationLink(destination: AddGolferView().environmentObject(golfModel), label: {
                        Text("Add Golfers")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color(UIColor.systemGreen))
                            .cornerRadius(8)
                    }).isDetailLink(false)
                }
                
                else {
                    let golfer = golfModel.golfers[currentGolferIndex]
                    Text(golfer.golferName)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    TextField("Score", text: $score)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
    
                    Button("Add Score") {
                        golfModel.addGolferScore(golferIndex: currentGolferIndex, score: score)
                        if currentGolferIndex < golfModel.getMaxGolferIndex() {
                            score = ""
                            currentGolferIndex += 1
                        }
                        else {4
                            golfModel.incrementHoleCount()
                            score = ""
                            currentGolferIndex = 0
                        }
                    }
                    .disabled(score.isEmpty)
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
            }
        }
    }
}

struct TrackScoreView_Previews: PreviewProvider {
    static var previews: some View {
        let golfModel = GolfGameViewModel()
        golfModel.name = "Michael"
        golfModel.handicap = "10"
        golfModel.validateGolfer()
        golfModel.name = "Candace"
        golfModel.handicap = "2"
        golfModel.validateGolfer()
        
        return NavigationStack {
            TrackScoreView().environmentObject(golfModel)
        }
    }
}

