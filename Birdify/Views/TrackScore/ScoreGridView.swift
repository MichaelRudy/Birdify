//
//  ScoreGridView.swift
//  Birdify
//
//  Created by Michael Rudy on 4/2/24.
//

import SwiftUI

@available(iOS 17.0, *)
struct ScoreGridView: View {
    // Assuming a standard 18-hole course; modify this as needed.
    let holes: [Int] = Array(1...18)
    @Environment(GolfGameViewModel.self) var gm
    @State private var selectedHole: Int?
    @State private var isEditScorePresented = false
    @State var score = 4
    @State var par = 4
    @State var teeShotLocation: Hole.TeeShotLocation = .center // Default fairway hit
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(zippedScores, id: \.0) { hole, score in
                    VStack {
                        Text("\(hole)")
                            .frame(minWidth: 50) // Adjust the width as needed
                            .background(Color.gray.opacity(0.5))
                            .foregroundColor(.white)
                        
                        Button(action: {
                            selectedHole = hole
                            isEditScorePresented.toggle()
                        }) {
                            if score.modified {
                                if score.overPar {
                                    Text(String(score.holeStrokes))
                                        .frame(minWidth: 50)
                                        .background(Color.red.opacity(0.5))
                                        .foregroundColor(.black)
                                } else {
                                    Text(String(score.holeStrokes))
                                        .frame(minWidth: 50)
                                        .background(Color.green.opacity(0.5))
                                        .foregroundColor(.black)
                                }
                            } else {
                                Text("-")
                                    .frame(minWidth: 50)
                                    .background(Color.green.opacity(0.5))
                                    .foregroundColor(.black)
                            }
                        }
                        .popover(isPresented: Binding(
                            get: { selectedHole == hole && isEditScorePresented },
                            set: { if !$0 { selectedHole = nil } }
                        )) {
                            EditScoreSheetView(score: $score, par: $par, teeShot: $teeShotLocation, selectedHole: $selectedHole, isEditScoreSheetView: $isEditScorePresented)
                        }
                    }
                }
            }
            .padding() // Add padding around the HStack for better presentation
        }
    }
    
    private var zippedScores: [(Int, Hole)] {
        Array(zip(holes, gm.golfers[gm.currentGolfer].scores))
    }
}



@available(iOS 17.0, *)
private struct EditScoreSheetView: View {
    @Environment(GolfGameViewModel.self) var gm
    @Binding var score: Int
    @Binding var par: Int
    @Binding var teeShot: Hole.TeeShotLocation
    @Binding var selectedHole: Int?
    @Binding var isEditScoreSheetView: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Spacer() // Add a spacer to separate the label and Stepper
                Text("Strokes")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.blue)
                
                Spacer() // Add a spacer to separate the label and Stepper
            }
            .padding()
            HStack {
                Stepper(value: $score, in: 1...15, step: 1) {
                    Text("\(score)")
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.blue)
                }
                .padding(.horizontal, 100) // Adjust the padding as needed
            }
            .padding()
            HStack {
                Spacer() // Add a spacer to separate the label and Stepper
                Text("Par")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.blue)
                
                Spacer() // Add a spacer to separate the label and Stepper
            }
            .padding()
            HStack {
                Stepper(value: $par, in: 3...5, step: 1) {
                    Text("\(par)")
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.blue)
                }
                .padding(.horizontal, 100) // Adjust the padding as needed
            }
            .padding()
            HStack  {
                Button(action: {
                    self.teeShot = .leftRough
                }) {
                    Image(systemName: "arrow.up.left")
                        .font(.largeTitle)
                        .foregroundColor(teeShot == .leftRough ? .blue : .gray)
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                Button(action: {
                    self.teeShot = .center
                    
                }) {
                    Image(systemName: "arrow.up.circle")
                        .font(.largeTitle)
                        .foregroundColor(teeShot == .center ? .blue : .gray)
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                Button(action: {
                    self.teeShot = .rightRough
                }) {
                    Image(systemName: "arrow.up.right")
                        .font(.largeTitle)
                        .foregroundColor(teeShot == .rightRough ? .blue : .gray)
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
            submitButton
            
        }
        .padding()
    }
    
    private var submitButton: some View {
        Button(action: {
            gm.golfers[gm.currentGolfer].editScore(holeNumber: selectedHole ?? 1, holeScore: score, holePar: par, teeShot: teeShot)
            self.score = 4
            self.par = 4
            self.teeShot = .center
            self.isEditScoreSheetView.toggle()
        }) {
            Text("Submit")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .padding()
                .background(Color.green)
                .cornerRadius(10)
        }
        .padding()
    }
}


@available(iOS 17.0, *)
#Preview {
    let gm = GolfGameViewModel()
    gm.validateGolfer(name: "Michael", handicap: "10")
    //        gm.validateGolfer(name: "Tyler", handicap: "10")
    gm.validateCourse(name: "Twin Lakes", par: "72", holeCount: "9")
    gm.addGolferScore(score: 3, holePar: 5, holeTeeShot: .center)
    gm.addGolferScore(score: 10, holePar: 5, holeTeeShot: .center)
    gm.addGolferScore(score: 5, holePar: 5, holeTeeShot: .center)
//    gm.addGolferScore(score: 3, holePar: 5, holeTeeShot: .center)
    return NavigationStack {
        ScoreGridView().environment(gm)
    }
}
