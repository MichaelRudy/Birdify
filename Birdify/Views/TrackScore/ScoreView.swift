//
//  ScoreView.swift
//  Birdify
//
//  Created by Michael Rudy on 3/5/24.
//

import SwiftUI

@available(iOS 17.0, *)
struct ScoreView: View {
    @Environment(GolfGameViewModel.self) var gm

    @State var score = 4
    @State var par = 4
    @State var teeShotLocation: Hole.TeeShotLocation = .center // Default fairway hit
    @State private var isStrokeSheetPresented = false
    @State private var isTeeShotSheetPresented = false
    @State private var isParSheetPresented = false
    @State private var isEditScorePresented = false

    var body: some View {
        ZStack { // Outer ZStack for background
            Color.black.edgesIgnoringSafeArea(.all) // Ensures background color extends to all edges

            VStack {
                // Header view with golfer name and hole number
                headerView

                // Main content area with score representation and modification options
                mainContentView
                
                // Score grid and submit button at the bottom
//                ScoreGridView()
//                    .environment(gm)
                ScoreGridView()

                submitButton
            }
            .padding() // General padding around the VStack content
        }
    }

    private var headerView: some View {
        HStack {
            Button(action: {
                gm.changeGolfer()
            }) {
                Text(gm.golfers[gm.currentGolfer].name)
                    .foregroundColor(.white)
                    .padding()
            }
            Spacer()
            Text("Hole \(String(gm.golfers[gm.currentGolfer].holeNumber))")
                .foregroundColor(.white)
        }
        .padding(.horizontal)
    }

    private var mainContentView: some View {
        VStack {
            let score = gm.getGolferScore()
            scoreCircleOrRectangle(score: score)
                .frame(width: 250, height: 300)
            Spacer()
            controlButtons2
            Spacer()
        }
    }

    private func scoreCircleOrRectangle(score: String) -> some View {
        Group {
            if score.contains("-") {
                Circle()
                    .stroke(Color.blue, lineWidth: 2)
                    .overlay(
                        Text(score)
                            .font(.system(size: 200))
                            .foregroundColor(.blue)
                    )
            } else {
                Rectangle()
                    .stroke(Color.blue, lineWidth: 2)
                    .overlay(
                        Text(score)
                            .font(.system(size: 200))
                            .foregroundColor(.blue)
                    )
            }
        }
    }
    
    private var controlButtons2: some View {
        VStack {
            SegmentedPickerView(selection: $teeShotLocation, options: ["center", "left", "right"], title: "Tee Shot")
            HStack {
                ValuePicker(title: "Strokes", value: $score, range: 1...10)
                ValuePicker(title: "Par", value: $par, range: 3...5)
            }
        }
        
    }
    
    struct SegmentedPickerView: View {
        @Binding var selection: Hole.TeeShotLocation
        let options: [String]
        let title: String

        var body: some View {
            VStack {
                Text(title)
                    .font(.headline)
                Picker(title, selection: $selection) {
                    ForEach(options, id: \.self) { option in
                        Text(option).tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding()
        }
    }
    
    private var controlButtons: some View {
        HStack {
            Button(action: {
                isTeeShotSheetPresented.toggle()
            }) {
                Image(systemName: "location.circle")
                    .resizable()
                    .frame(width: 32.0, height: 32.0)
            }
            .popover(isPresented: $isTeeShotSheetPresented) {
                TeeshotSheetView(teeShotLocation: $teeShotLocation, isTeeShotSheetPresented: $isTeeShotSheetPresented)
            }
            // Additional buttons here
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
                        par: $par
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
                        score: $score
                    )
                })
        }
    }
    
    struct ValuePicker: View {
        let title: String
        @Binding var value: Int
        let range: ClosedRange<Int>
        
        var body: some View {
            VStack {
                Text(title)
                    .frame(minWidth: 50) // Adjust the width as needed
                    .background(Color.gray.opacity(0.5))
                    .foregroundColor(.white)
                Picker(selection: $value, label: Text("")) {
                    ForEach(range, id: \.self) { index in
                        Text("\(index)")
                            .font(.largeTitle)
                            .tag(index)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 150)
            }
        }
    }
    
    private var submitButton: some View {
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
        .padding()
    }
}



@available(iOS 17.0, *)
private struct StrokeSheetView: View {
    @Environment(GolfGameViewModel.self) var gm
    @Binding var score: Int
    
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
    @Binding var par: Int
    
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
    gm.validateGolfer(name: "Dad", handicap: "10")
    //        gm.validateGolfer(name: "Tyler", handicap: "10")
    gm.validateCourse(name: "Twin Lakes", par: "72", holeCount: "9")
    return NavigationStack {
        ScoreView().environment(gm)
    }
}
