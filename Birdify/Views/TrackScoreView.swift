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
    @State var teeShotLocation: Hole.TeeShotLocation = .center // assume people will hit the fairway :)
    @State private var isStrokeSheetPresented = false
    @State private var isTeeShotSheetPresented = false
    @State private var isParSheetPresented = false
    
    var body: some View {
        VStack {
            VStack {
                // Potentially move these conditonals
                if golfModel.golfers.isEmpty {
                    AddGolferButton()
                }
                if golfModel.course == nil {
                    AddCourseButton()
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
                                        golfModel.ScoreSynbol(par: golfModel.getHolePar(golferIndex: currentGolferIndex, holeN: hole), strokes:golfModel.getGolferStrokes(golferIndex: currentGolferIndex, holeN: hole))
                                            .frame(maxWidth: .infinity)
                                        golfModel.getGolferTeeShot(golferIndex: currentGolferIndex, holeN: hole)
                                            .frame(maxWidth: .infinity)
                                    }
                                    .padding(.vertical, 8)
                                }
                            }
                            .headerProminence(.increased)
                        }
                        .listStyle(.insetGrouped)
                        
                        VStack {
                            HStack {
                                Text("Hole Par: ")
                                    .multilineTextAlignment(.center)
                                    .font(.title)
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.blue)
                                    .padding(.leading)
                                Spacer().frame(width: 8) // Add a spacer with a custom width to control spacing
                                Button(action: {
                                    // Set isSheetPresented to true when the button is tapped
                                    isParSheetPresented = true
                                }) {
                                    Image(systemName: "pencil")
                                        .font(.system(size: 24)) // Adjust the size as needed
                                        .foregroundColor(.blue)
                                        .padding(.trailing) // Adjust the trailing padding as needed
                                }
                            }
                            .sheet(isPresented: $isParSheetPresented) {
                                // Present StrokeSheetView as a sheet when isSheetPresented is true
                                ParSheetView(currentGolferIndex: $currentGolferIndex, score: $score, par: $par, teeShotLocation: $teeShotLocation)
                            }
                            .padding()
                            
                            HStack {
                                Text("Strokes:")
                                    .multilineTextAlignment(.center)
                                    .font(.title)
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.blue)
                                    .padding(.leading) // Adjust the leading padding as needed
                                Spacer().frame(width: 8) // Add a spacer with a custom width to control spacing
                                Button(action: {
                                    // Set isSheetPresented to true when the button is tapped
                                    isStrokeSheetPresented = true
                                }) {
                                    Image(systemName: "pencil") // Use the pencil icon for edit
                                        .font(.system(size: 24)) // Adjust the size as needed
                                        .foregroundColor(.blue)
                                        .padding(.trailing) // Adjust the trailing padding as needed
                                }
                            }
                            .sheet(isPresented: $isStrokeSheetPresented) {
                                // Present StrokeSheetView as a sheet when isSheetPresented is true
                                StrokeSheetView(currentGolferIndex: $currentGolferIndex, score: $score, par: $par, teeShotLocation: $teeShotLocation)
                            }
                            .padding()
                            
                            HStack {
                                Text("Tee Shot Location: ")
                                    .multilineTextAlignment(.center)
                                    .font(.title)
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.blue)
                                    .padding(.leading)
                                Spacer().frame(width: 8) // Add a spacer with a custom width to control spacing
                                Button(action: {
                                    // Set isSheetPresented to true when the button is tapped
                                    isTeeShotSheetPresented = true
                                }) {
                                    Image(systemName: "arrow.up.forward.app.fill")
                                        .font(.system(size: 24)) // Adjust the size as needed
                                        .foregroundColor(.blue)
                                        .padding(.trailing) // Adjust the trailing padding as needed
                                }
                            }
                            .sheet(isPresented: $isTeeShotSheetPresented) {
                                // Present StrokeSheetView as a sheet when isSheetPresented is true
                                TeeshotSheetview(currentGolferIndex: $currentGolferIndex, score: $score, par: $par, teeShotLocation: $teeShotLocation)
                            }
                            .padding()
                        }
                        .padding()
                        
                        //
                        //                        HStack {
                        //                            GeometryReader { geometry in
                        //                                VStack(alignment: .center) {
                        //                                    Text("Strokes")
                        //                                        .multilineTextAlignment(.cente
                        //                                        .font(.title)
                        //                                        .fontWeight(.heavy)
                        //                                        .foregroundColor(Color.blue)
                        //                                    Stepper(value: $score, in: 1...15, step: 1) {
                        //                                        Text("\(score)")
                        //                                            .multilineTextAlignment(.center)
                        //                                            .font(.title)
                        //                                            .fontWeight(.heavy)
                        //                                            .foregroundColor(Color.blue)
                        //                                    }
                        //                                    .padding(.horizontal, geometry.size.width * 0.18) // Adjust the multiplier as needed
                        //                                }
                        //                                .padding(.vertical, 50) // Adjust the vertical padding as needed
                        //                            }
                        //
                        //                            GeometryReader { geometry in
                        //                                VStack(alignment: .center) {
                        //                                    Text("Par")
                        //                                        .multilineTextAlignment(.center)
                        //                                        .font(.title)
                        //                                        .fontWeight(.heavy)
                        //                                        .foregroundColor(Color.blue)
                        //                                    Stepper(value: $par, in: 3...5, step: 1) {
                        //                                        Text("\(par)")
                        //                                            .multilineTextAlignment(.center)
                        //                                            .font(.title)
                        //                                            .fontWeight(.heavy)
                        //                                            .foregroundColor(Color.blue)
                        //                                    }
                        //                                    .padding(.horizontal, geometry.size.width * 0.18) // Adjust the multiplier as needed
                        //                                }
                        //                                .padding(.vertical, 50) // Adjust the vertical padding as needed
                        //                            }
                        //                        }
                        //
                        
                        Button(action: {
                            golfModel.addGolferScore(golferIndex: self.currentGolferIndex, score: self.score, holePar: self.par, holeTeeShot: self.teeShotLocation)
                            
                            if currentGolferIndex < golfModel.getMaxGolferIndex() {
                                score = 3
                                teeShotLocation = .center
                                currentGolferIndex += 1
                            } else {
                                golfModel.incrementHoleCount()
                                score = 3
                                teeShotLocation = .center
                                currentGolferIndex = 0
                            }
                        }) {
                            VStack {
                                Text("Submit")
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.green)
                                Image(systemName: "figure.golf")
                                    .resizable()
                                    .frame(width: 30, height: 30) // Adjust the size of the image as needed
                                    .foregroundColor(Color.green)
                            }
                        }
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
        Text("TeeShot")
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(Color.blue)
            .frame(maxWidth: .infinity) // Expand to fill available space
    }
    .padding(.vertical, 8)
}

struct AddGolferButton: View {
    @EnvironmentObject var golfModel: GolfGameViewModel
    var body: some View {
        NavigationLink(destination: AddGolferView().environmentObject(golfModel)) {
            Text("Add Golfers")
                .font(.title2)
                .foregroundColor(.blue)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .cornerRadius(8)
        }
        .isDetailLink(false)
    }
}

struct StrokeSheetView: View {
    @EnvironmentObject var golfModel: GolfGameViewModel
    @Binding var currentGolferIndex: Int
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

struct ParSheetView: View {
    @EnvironmentObject var golfModel: GolfGameViewModel
    @Binding var currentGolferIndex: Int
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

struct TeeshotSheetview: View {
    @EnvironmentObject var golfModel: GolfGameViewModel
    @Binding var currentGolferIndex: Int
    @Binding var score: Int
    @Binding var par: Int
    @Binding var teeShotLocation: Hole.TeeShotLocation

    var body: some View {
        HStack  {
            Button(action: {
                self.teeShotLocation = .leftRough
            }) {
                Image(systemName: "arrow.up.left")
                    .font(.largeTitle)
                    .foregroundColor(teeShotLocation == .leftRough ? .blue : .gray)
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            
            Button(action: {
                self.teeShotLocation = .center
            }) {
                Image(systemName: "arrow.up.circle")
                    .font(.largeTitle)
                    .foregroundColor(teeShotLocation == .center ? .blue : .gray)
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            Button(action: {
                self.teeShotLocation = .rightRough
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

struct AddCourseButton: View {
    @EnvironmentObject var golfModel: GolfGameViewModel
    var body: some View {
        NavigationLink(destination: AddCourse().environmentObject(golfModel)) {
            Text("Add Course Information")
                .font(.title2)
                .foregroundColor(.blue)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .cornerRadius(8)
        }
        .isDetailLink(false)
    }
}

struct TrackScoreView_Previews: PreviewProvider {
    static var previews: some View {
        let golfModel = GolfGameViewModel()
        golfModel.validateGolfer(name: "Michael", handicap: "10")
        //        golfModel.validateGolfer(name: "Candace", handicap: "10")
        //        golfModel.validateGolfer(name: "Tyler", handicap: "10")
        golfModel.validateCourse(name: "Twin Lakes", par: "72", holeCount: "9")
        
        return NavigationStack {
            TrackScoreView().environmentObject(golfModel)
        }
    }
}

