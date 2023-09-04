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
    @State var score = 3
    @State var par = 3
    
    var body: some View {
        VStack {
            VStack {
                if golfModel.golfers.isEmpty {
                    NavigationLink(destination: AddGolferView().environmentObject(golfModel), label: {
                        Text("Add Golfers")
                            .font(.title2)
                            .foregroundColor(.blue)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .cornerRadius(8)
                    }).isDetailLink(false)
                }
                if golfModel.course == nil {
                    NavigationLink(destination: AddCourse().environmentObject(golfModel), label: {
                        Text("Add Course Information")
                            .font(.title2)
                            .foregroundColor(.blue)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .cornerRadius(8)
                    }).isDetailLink(false)
                }
                else if golfModel.holeNumber > golfModel.course?.holeCount ?? 18 {
                    ResultsView()
                }
                else {
                    VStack {
                        let golfer = golfModel.golfers[currentGolferIndex]
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray)
                            VStack {
                                VStack {
                                    Text(golfer.golferName)
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                    Text(golfModel.getGolferScore(golferIndex: currentGolferIndex))
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                }
                            }
                        }
                        .padding()
                        
                        List {
                            Section(header: scorecardHeader) {
                                ForEach(1..<golfModel.holeNumber, id: \.self) { hole in
                                    HStack {
                                        Text(String(hole))
                                            .frame(maxWidth: .infinity) // Expand to fill available space
                                        Text(String(golfModel.getHolePar(golferIndex: currentGolferIndex, holeN: hole)))
                                            .frame(maxWidth: .infinity) // Expand to fill available space
//                                        Text(String(golfModel.getGolferStrokes(golferIndex: currentGolferIndex, holeN: hole)))
//                                            .frame(maxWidth: .infinity) // Expand to fill available space
                                        
                                        golfModel.ScoreSynbol(par: golfModel.getHolePar(golferIndex: currentGolferIndex, holeN: hole), strokes:golfModel.getGolferStrokes(golferIndex: currentGolferIndex, holeN: hole))

                                    }
                                    .padding(.vertical, 8)
                                }
                            }
                            .headerProminence(.increased)
                        }
                        .listStyle(.insetGrouped)
                        
                        VStack(alignment: .center) {
                            Text("Score")
                                .multilineTextAlignment(.center)
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.blue)
                            Stepper(value: $score, in: 1...15, step: 1) {
                                Text("\(score)")
                                    .multilineTextAlignment(.center)
                                    .font(.title)
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.blue)
                            }
                            .padding(.horizontal, 100)
                        }
                        .padding(.all)
                        
                        VStack(alignment: .center) {
                            Text("Par")
                                .multilineTextAlignment(.center)
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.blue)
                            Stepper(value: $par, in: 3...5, step: 1) {
                                Text("\(par)")
                                    .multilineTextAlignment(.center)
                                    .font(.title)
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.blue)
                            }
                            .padding(.horizontal, 100)
                        }
                        .padding(.all)
                                
                        Button(action: {
                            golfModel.addGolferScore(golferIndex: self.currentGolferIndex, score: self.score, holePar: self.par)
                            if currentGolferIndex < golfModel.getMaxGolferIndex() {
                                score = 3
                                currentGolferIndex += 1
                            } else {
                                golfModel.incrementHoleCount()
                                score = 3
                                currentGolferIndex = 0
                            }
                        }) {
                            VStack {
                                Text("Submit")
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.green)
                                Image(systemName: "checkmark") //
                                    .resizable()
                                    .frame(width: 30, height: 30) // Adjust the size of the image as needed
                                    .foregroundColor(Color.green)
                            }
                        }
                        .onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        
                        }
                        .padding(.all)
                    }
                }
            }
        }
    }
}


var scorecardHeader: some View {
    HStack {
        Text("Hole")
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(Color.blue)
            .frame(maxWidth: .infinity) // Expand to fill available space
        Text("Par")
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(Color.blue)
            .frame(maxWidth: .infinity) // Expand to fill available space
        Text("Strokes")
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(Color.blue)
            .frame(maxWidth: .infinity) // Expand to fill available space
    }
    .padding(.vertical, 8)
}


struct TrackScoreView_Previews: PreviewProvider {
    static var previews: some View {
        let golfModel = GolfGameViewModel()
        golfModel.validateGolfer(name: "Michael", handicap: "10")
        golfModel.validateGolfer(name: "Candace", handicap: "10")
//        golfModel.validateGolfer(name: "Tyler", handicap: "10")
        golfModel.validateCourse(name: "Twin Lakes", par: "72", holeCount: "9")
        
        return NavigationStack {
            TrackScoreView().environmentObject(golfModel)
        }
    }
}

