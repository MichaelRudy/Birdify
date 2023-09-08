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
    @State private var isEditButtonVisible = true
    
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
                        
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.green)
                                .padding()
                            
                            HStack {
                                // Left side with navigation view
                                NavigationView {
                                    VStack {
                                        Spacer()
                                        
                                        Group {
                                            Button(action: {
                                                isParSheetPresented = true
                                                //                                                isEditButtonVisible = false
                                            }) {
                                                HStack {
                                                    Text("Hole Par")
                                                        .font(.title3)
                                                        .fontWeight(.heavy)
                                                        .foregroundColor(Color.blue)
                                                    Spacer()
                                                    if isEditButtonVisible {
                                                        Image(systemName: "square.and.pencil")
                                                            .foregroundColor(.blue)
                                                    }
                                                }
                                                .padding()
                                            }
                                            .sheet(isPresented: $isParSheetPresented) {
                                                ParSheetView(
                                                    currentGolferIndex: $currentGolferIndex,
                                                    score: $score,
                                                    par: $par,
                                                    teeShotLocation: $teeShotLocation
                                                )
                                            }
                                            
                                            Divider()
                                            
                                            Button(action: {
                                                isStrokeSheetPresented = true
                                                //                                                isEditButtonVisible = false
                                            }) {
                                                HStack {
                                                    Text("Strokes")
                                                        .font(.title3)
                                                        .fontWeight(.heavy)
                                                        .foregroundColor(Color.blue)
                                                    Spacer()
                                                    if isEditButtonVisible {
                                                        Image(systemName: "square.and.pencil")
                                                            .foregroundColor(.blue)
                                                    }
                                                }
                                                .padding()
                                            }
                                            .sheet(isPresented: $isStrokeSheetPresented) {
                                                StrokeSheetView(
                                                    currentGolferIndex: $currentGolferIndex,
                                                    score: $score,
                                                    par: $par,
                                                    teeShotLocation: $teeShotLocation
                                                )
                                            }
                                            
                                            Divider()
                                            Button(action: {
                                                isTeeShotSheetPresented = true
                                                //                                                isEditButtonVisible = false
                                            }) {
                                                HStack {
                                                    VStack {
                                                        Text("Tee Shot")
                                                            .font(.title3)
                                                            .fontWeight(.heavy)
                                                            .foregroundColor(Color.blue)
                                                        Text("Location")
                                                            .font(.title3)
                                                            .fontWeight(.heavy)
                                                            .foregroundColor(Color.blue)
                                                        
                                                    }
                                                    
                                                    Spacer()
                                                    if isEditButtonVisible {
                                                        Image(systemName: "square.and.pencil")
                                                            .foregroundColor(.blue)
                                                    }
                                                }
                                                .padding() 
                                            }
                                            .sheet(isPresented: $isTeeShotSheetPresented) {
                                                TeeshotSheetview(
                                                    currentGolferIndex: $currentGolferIndex,
                                                    score: $score,
                                                    par: $par,
                                                    teeShotLocation: $teeShotLocation
                                                )
                                            }
                                        }
                                        
                                        Spacer()
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                
                                Spacer()
                                
                                // Right side with submit button
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
                            }
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

// modularity
struct SheetButton<SheetView: View>: View {
    let title: String
    let imageSystemName: String
    @Binding var isSheetPresented: Bool
    let sheetView: () -> SheetView
    
    var body: some View {
        HStack {
            Text(title)
                .multilineTextAlignment(.center)
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color.blue)
                .padding(.leading)
            Spacer().frame(width: 8)
            Button(action: {
                isSheetPresented = true
            }) {
                Image(systemName: imageSystemName)
                    .font(.system(size: 24))
                    .foregroundColor(.blue)
                    .padding(.trailing)
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            sheetView()
        }
        .padding()
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

