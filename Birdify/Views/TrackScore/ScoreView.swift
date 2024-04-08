//
//  ScoreView.swift
//  Birdify
//
//  Created by Michael Rudy on 3/5/24.
//

import SwiftUI

@available(iOS 17.0, *)
struct ScoreView: View {
    @Environment(GolfGameViewModel.self) private var gm
    @State var score = 4
    @State var par = 4
    @State var teeShotLocation: Hole.TeeShotLocation = .center // assume people will hit the fairway :)
    @State private var isStrokeSheetPresented = false
    @State private var isTeeShotSheetPresented = false
    @State private var isParSheetPresented = false
    @State private var isEditTeeShot = false
    @State private var isEditStrokes = false
    @State private var isEditPar = false
    
    var body: some View {
        VStack {
            HStack {
                let golfer = gm.golfers[gm.currentGolfer]
                Button(action: {
                    gm.changeGolfer()
                }) {
                    Text(golfer.name).padding()
                }
                Spacer()
                Text("Hole \(String(golfer.holeNumber))")
            }
            Spacer(minLength: 100)
            HStack {
                Button(action: {
                    isTeeShotSheetPresented.toggle()
                }){
                    Image(systemName: "location.circle")
                        .resizable()
                        .frame(width: 32.0, height: 32.0)
                }
                .popover(isPresented: $isTeeShotSheetPresented) {
                    TeeshotSheetView(
                        teeShotLocation: $teeShotLocation,
                        isTeeShotSheetPresented: $isTeeShotSheetPresented
                    )
                }
                Spacer()
                Button(action: {
                    isParSheetPresented.toggle()
                }){
                    Image(systemName: "parkingsign.circle")
                        .resizable()
                        .frame(width: 32.0, height: 32.0)
                }
                .popover(isPresented: $isParSheetPresented, content: {
                    ParSheetView(
                        score: $score,
                        par: $par,
                        teeShotLocation: $teeShotLocation
                    )
                })
                Spacer()
                Button(action: {
                    isStrokeSheetPresented.toggle()
                }){
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .frame(width: 32.0, height: 32.0)
                }
                .popover(isPresented: $isStrokeSheetPresented, content: {
                    StrokeSheetView(
                        score: $score,
                        par: $par,
                        teeShotLocation: $teeShotLocation
                    )
                })
            }
            Spacer(minLength: 100)
        }
        .frame(width: 350, height: 250)
        .padding()
        // scoregrid goes here and replace the above stuff
        ScoreGridView().environment(gm)
        Spacer(minLength: 50)
        ZStack {
            let score = gm.getGolferScore()
            if score.contains("-") {
                Circle()
                    .stroke(Color.blue, lineWidth: 2) // Customize the color and line width as needed
                    .frame(width: 250, height: 250)
                    .overlay(
                        Text(score)
                            .font(.system(size: 200))
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                    )
            }
            else {
                Rectangle()
                    .stroke(Color.blue, lineWidth: 2) // Customize the color and line width as needed
                    .frame(width: 250, height: 250)
                    .overlay(
                        Text(gm.getGolferScore())
                            .font(.system(size: 200))
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                    )
            }
        }
        Spacer(minLength: 10)
        
        Button(action: {
            gm.addGolferScore(score: self.score, holePar: self.par, holeTeeShot: self.teeShotLocation)
            self.score = 4
            self.par = 4
            self.teeShotLocation = .center
        }) {
            Text("Submit")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .padding()
                .background(Color.green)
                .cornerRadius(10)
        }
        .frame(maxWidth: .infinity)
        .padding()
        Spacer(minLength: 10)
    }
}

@available(iOS 17.0, *)
private struct StrokeSheetView: View {
    @Environment(GolfGameViewModel.self) var gm
    @Binding var score: Int
    @Binding var par: Int
    @Binding var teeShotLocation: Hole.TeeShotLocation
    
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
        }
        .padding()
    }
}

@available(iOS 17.0, *)
private struct ParSheetView: View {
    @Environment(GolfGameViewModel.self) var gm
    @Binding var score: Int
    @Binding var par: Int
    @Binding var teeShotLocation: Hole.TeeShotLocation
    
    var body: some View {
        VStack(alignment: .center) {
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
        }
        .padding()
    }
}

@available(iOS 17.0, *)
private struct TeeshotSheetView: View {
    @Environment(GolfGameViewModel.self) var gm
    @Binding var teeShotLocation: Hole.TeeShotLocation
    @Binding var isTeeShotSheetPresented: Bool
    
    var body: some View {
        VStack {
            Text("Shot Direction")
                .multilineTextAlignment(.center)
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color.blue)
            HStack  {
                Button(action: {
                    self.teeShotLocation = .leftRough
                    self.isTeeShotSheetPresented.toggle()
                }) {
                    Image(systemName: "arrow.up.left")
                        .font(.largeTitle)
                        .foregroundColor(teeShotLocation == .leftRough ? .blue : .gray)
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                Button(action: {
                    self.teeShotLocation = .center
                    self.isTeeShotSheetPresented.toggle()
                }) {
                    Image(systemName: "arrow.up.circle")
                        .font(.largeTitle)
                        .foregroundColor(teeShotLocation == .center ? .blue : .gray)
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                Button(action: {
                    self.teeShotLocation = .rightRough
                    self.isTeeShotSheetPresented.toggle()
                }) {
                    Image(systemName: "arrow.up.right")
                        .font(.largeTitle)
                        .foregroundColor(teeShotLocation == .rightRough ? .blue : .gray)
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    let gm = GolfGameViewModel()
    gm.validateGolfer(name: "Michael", handicap: "10")
    //        gm.validateGolfer(name: "Tyler", handicap: "10")
    gm.validateCourse(name: "Twin Lakes", par: "72", holeCount: "9")
    return NavigationStack {
        ScoreView().environment(gm)
    }
}
