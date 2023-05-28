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
    @State var par = ""
    
    var body: some View {
        VStack {
            VStack {
                if golfModel.golfers.isEmpty || golfModel.course == nil {
                    NavigationLink(destination: AddGolferView().environmentObject(golfModel), label: {
                        Text("Add Golfers")
                            .font(.title2)
                            .foregroundColor(.blue)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .cornerRadius(8)
                    }).isDetailLink(false)
                    
                    NavigationLink(destination: AddCourse().environmentObject(golfModel), label: {
                        Text("Add Course Information")
                            .font(.title2)
                            .foregroundColor(.blue)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .cornerRadius(8)
                    }).isDetailLink(false)
                }
                else {
                    VStack {
                        let golfer = golfModel.golfers[currentGolferIndex]
                        HStack {
                            Text(golfer.golferName)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                            Text(golfModel.getGolferScore(golferIndex: currentGolferIndex))
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                            
                        }
                        List {
                            Section(header: scorecardHeader) {
                                ForEach(1..<golfModel.holeNumber, id: \.self) { hole in
                                    HStack {
                                        Text(String(hole))
                                        Spacer()
                                        Text(String(golfModel.getHolePar(golferIndex: currentGolferIndex, holeN: hole)))
                                        Spacer()
                                        Text(String(golfModel.getGolferStrokes(golferIndex: currentGolferIndex, holeN: hole)))
                                    }
                                }
                            }
                        }
                        .onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        .listStyle(InsetGroupedListStyle())
                        TextField("Score", text: $score)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                        TextField("Par", text: $par)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                        Button("Add Score") {
                            golfModel.addGolferScore(golferIndex: self.currentGolferIndex, score: self.score, holePar: self.par)
                            if currentGolferIndex < golfModel.getMaxGolferIndex() {
                                score = ""
                                par = ""
                                currentGolferIndex += 1
                            }
                            else {
                                golfModel.incrementHoleCount()
                                score = ""
                                par = ""
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
}

var scorecardHeader: some View {
    HStack {
        Text("Hole")
        Spacer()
        Text("Par")
        Spacer()
        Text("Strokes")
    }
}


struct TrackScoreView_Previews: PreviewProvider {
    static var previews: some View {
        let golfModel = GolfGameViewModel()
        golfModel.validateGolfer(name: "Michael", handicap: "10")
//        golfModel.validateGolfer(name: "Tyler", handicap: "10")
        golfModel.validateCourse(name: "Twin Lakes", par: "72", holeCount: "18")
        
        return NavigationStack {
            TrackScoreView().environmentObject(golfModel)
        }
    }
}

