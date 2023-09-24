//
//  TrackScoreView.swift
//  Birdify
//
//  Created by Michael Rudy on 3/2/23.
//

import SwiftUI

struct TrackScoreView: View {
    @EnvironmentObject var gm: GolfGameViewModel
    @State var score = 4
    @State var par = 4
    @State var teeShotLocation: Hole.TeeShotLocation = .center // assume people will hit the fairway :)
    @State private var isStrokeSheetPresented = false
    @State private var isTeeShotSheetPresented = false
    @State private var isParSheetPresented = false
    
    var body: some View {
        VStack {
            VStack {
                // Potentially move these conditonals
                if gm.golfers.isEmpty {
                    AddGolferButton()
                }
                if gm.course == nil {
                    AddCourseButton()
                }
                else if gm.golfers[gm.currentGolfer].holeNumber > gm.course?.holeCount ?? 18 {
                    ResultsView()
                }
                else {
                    ScoreSummaryBox()
                        .onTapGesture {
                            gm.toggleGolfer()
                            // figure out how to carry previous hole data submitted for the rest of them
                        }
                    List {
                        Section(header: scorecardHeader) {
                            ForEach(1..<gm.golfers[gm.currentGolfer].holeNumber, id: \.self) { hole in
                                HStack {
                                    Text(String(hole))
                                        .frame(maxWidth: .infinity) // Expand to fill available space
                                    Text(String(gm.getHolePar(holeN: hole)))
                                        .frame(maxWidth: .infinity) // Expand to fill available space
                                    gm.ScoreSynbol(par: gm.getHolePar(holeN: hole), strokes:gm.getGolferStrokes(holeN: hole))
                                        .frame(maxWidth: .infinity)
                                    gm.golferTeeShot(holeN: hole)
                                        .frame(maxWidth: .infinity)
                                }
                                .padding(.vertical, 8)
                                .background(
                                    NavigationLink("", destination: scoreRowView(holeNumber: hole).environmentObject(gm))
                                        .opacity(0.0))
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
                            // MARK: Bottom half of Screen to enter data
                            NavigationView {
                                VStack {
                                    Spacer()
                                    Group {
                                        Button(action: {
                                            isParSheetPresented.toggle()
                                        }) {
                                            HStack {
                                                Text("Hole Par")
                                                    .font(.title3)
                                                    .fontWeight(.heavy)
                                                    .foregroundColor(Color.blue)
                                                Spacer()
                                                Image(systemName: "square.and.pencil")
                                                    .foregroundColor(.blue)
                                            }
                                            .padding()
                                        }
                                        .sheet(isPresented: $isParSheetPresented) {
                                            ParSheetView(
                                                score: $score,
                                                par: $par,
                                                teeShotLocation: $teeShotLocation
                                            )
                                        }
                                        Divider()
                                        Button(action: {
                                            isTeeShotSheetPresented.toggle()
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
                                                
                                                Image(systemName: "square.and.pencil")
                                                    .foregroundColor(.blue)
                                                
                                            }
                                            .padding()
                                        }
                                        .sheet(isPresented: $isTeeShotSheetPresented) {
                                            TeeshotSheetView(
                                                teeShotLocation: $teeShotLocation,
                                                isTeeShotSheetPresented: $isTeeShotSheetPresented
                                            )
                                        }
                                        Divider()
                                        Button(action: {
                                            isStrokeSheetPresented.toggle()
                                        }) {
                                            HStack {
                                                Text("Strokes")
                                                    .font(.title3)
                                                    .fontWeight(.heavy)
                                                    .foregroundColor(Color.blue)
                                                Spacer()
                                                
                                                Image(systemName: "square.and.pencil")
                                                    .foregroundColor(.blue)
                                                
                                            }
                                            .padding()
                                        }
                                        .sheet(isPresented: $isStrokeSheetPresented) {
                                            StrokeSheetView(
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
                                gm.addGolferScore(score: self.score, holePar: self.par, holeTeeShot: self.teeShotLocation)
                                gm.incrementHoleCount()
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

// MARK: Private structs for trackscoreview
private var scorecardHeader: some View {
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

private struct scoreRowView: View {
    @EnvironmentObject var golfModel: GolfGameViewModel
    let holeNumber: Int
    
    @State private var isEditTeeShot = false
    @State private var isEditStrokes = false
    @State private var isEditPar = false
    @State private var isInfoPopoverVisible = false
    
    var body: some View {
        ScoreSummaryBox()
        List {
            Section(header: scorecardHeader) {
                HStack {
                    Text(String(holeNumber))
                        .frame(maxWidth: .infinity) // Expand to fill available space
                    Text(String(golfModel.getHolePar(holeN: holeNumber)))
                        .frame(maxWidth: .infinity) // Expand to fill available space
                    golfModel.ScoreSynbol(par: golfModel.getHolePar(holeN: holeNumber), strokes:golfModel.getGolferStrokes(holeN: holeNumber))
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            isEditStrokes.toggle()
                        }
                        .sheet(isPresented: $isEditStrokes) {
                            EditStrokesView(isEditStrokes: $isEditStrokes, strokes: golfModel.getGolferStrokes(holeN: holeNumber), holeN: holeNumber)
                        }
                    golfModel.golferTeeShot(holeN: holeNumber)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            isEditTeeShot.toggle()
                        }
                        .sheet(isPresented: $isEditTeeShot) {
                            EditTeeShotView(isEditTeeShot: $isEditTeeShot, holeN: holeNumber)
                        }
                }
                .padding(.vertical, 8)
            }
            .headerProminence(.increased)
        }
        .listStyle(.insetGrouped)
        
        Text("Click on each item to edit their values!")
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(Color.blue)
            .multilineTextAlignment(.center)
            .padding(.vertical, 100.0)
            .frame(maxWidth: .infinity) // Expand to fill available space
        
    }
}

private struct ScoreSummaryBox: View {
    @EnvironmentObject var golfModel: GolfGameViewModel
    
    var body: some View {
        VStack {
            let golfer = golfModel.golfers[golfModel.currentGolfer]
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(hue: 0.57, saturation: 1.0, brightness: 1.0))
                VStack {
                    VStack {
                        Text(golfer.golferName)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding()
                        Text(golfModel.getGolferScore())
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
            }
            .padding()
        }
    }
}

private struct StrokeSheetView: View {
    @EnvironmentObject var golfModel: GolfGameViewModel
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



struct EditStrokesView: View {
    @EnvironmentObject var golfModel: GolfGameViewModel
    @Binding var isEditStrokes: Bool
        
    @State var strokes: Int // Use a state property to track the modified strokes
    let holeN: Int
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Spacer()
                Text("Edit Strokes")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.blue)
                Spacer()
            }
            .padding()
            
            HStack {
                Text("\(strokes)") // Display the current strokes
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.blue)
                Stepper("", value: $strokes, in: 1...15) // Stepper to adjust strokes
            }
            .padding(.horizontal, 100) // Adjust the padding as needed
            
            Button(action: {
                // Handle the submission of the modified score here
                golfModel.editStroke(holeN: holeN, newStrokes: strokes)
                isEditStrokes.toggle()
            }) {
                Text("Submit")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
                    .padding()
            }
        }
    }
}


private struct ParSheetView: View {
    @EnvironmentObject var golfModel: GolfGameViewModel
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

private struct EditTeeShotView: View {
    @EnvironmentObject var golfModel: GolfGameViewModel
    @Binding var isEditTeeShot: Bool
    
    let holeN: Int
    
    var body: some View {
        VStack {
            Text("Edit Shot Direction")
                .multilineTextAlignment(.center)
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color.blue)
            HStack  {
                Button(action: {
                    golfModel.editTeeShot(holeN: holeN, holeTeeshot: .leftRough)
                    self.isEditTeeShot.toggle()
                }) {
                    Image(systemName: "arrow.up.left")
                        .font(.largeTitle)
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                Button(action: {
                    golfModel.editTeeShot(holeN: holeN, holeTeeshot: .center)
                    self.isEditTeeShot.toggle()
                }) {
                    Image(systemName: "arrow.up.circle")
                        .font(.largeTitle)
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                Button(action: {
                    golfModel.editTeeShot(holeN: holeN, holeTeeshot: .rightRough)
                    self.isEditTeeShot.toggle()
                }) {
                    Image(systemName: "arrow.up.right")
                        .font(.largeTitle)
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}

private struct TeeshotSheetView: View {
    @EnvironmentObject var golfModel: GolfGameViewModel
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
