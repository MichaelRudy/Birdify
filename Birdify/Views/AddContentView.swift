import SwiftUI

enum AddViewSelection {
    case course
    case golfer
}

struct AddContentView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var golfModel: GolfGameViewModel
    @State private var courseName: String = ""
    @State private var coursePar: String = ""
    @State private var holeCount: String = ""
    @State private var name: String = ""
    @State private var handicap: String = ""
    @State private var selectedView: AddViewSelection = .course
    @State private var isCourseSubmitted: Bool = false // Added state variable

    var body: some View {
        VStack {
            Picker("Add:", selection: $selectedView) {
                Text("Course").tag(AddViewSelection.course)
                Text("Golfer").tag(AddViewSelection.golfer)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Form {
                Section(header: Text("Edit").font(.title2).bold().italic().foregroundColor(.blue)) {
                    if selectedView == .course {
                        TextField("Course Name", text: $courseName)
                            .multilineTextAlignment(.center)
                        TextField("Course Par", text: $coursePar)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                        TextField("Hole Count", text: $holeCount)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                    } else {
                        TextField("Name", text: self.$name)
                            .padding(.bottom, 10)
                            .multilineTextAlignment(.center)
                            .onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                        
                        TextField("Handicap", text: self.$handicap)
                            .keyboardType(.numberPad)
                            .padding(.bottom, 10)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                    }
                }
            }
            
            if selectedView == .golfer {
                List {
                    Section(header: header) {
                        ForEach(golfModel.golfers) { golfer in
                            HStack {
                                Text(golfer.golferName)
                                Spacer()
                                Text(String(golfer.golferHandicap))
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            } else {
                List {
                    Section(header: courseHeader) {
                        HStack {
                            Text(golfModel.course?.courseName ?? "Golf Course")
                            Spacer()
                            Text(golfModel.course?.coursePar ?? "72")
                        }
                    }
                    
                }
            }
        
            Button("Add") {
                switch selectedView {
                case .course:
                    golfModel.validateCourse(name: self.courseName, par: self.coursePar, holeCount: self.holeCount)
                    self.courseName = ""
                    self.coursePar = ""
                    self.holeCount = ""
                    isCourseSubmitted.toggle() // Set the flag
                case .golfer:
                    golfModel.validateGolfer(name: self.name, handicap: self.handicap)
                    self.name = ""
                    self.handicap = ""
                }
            }
            .disabled((selectedView == .course && (self.courseName.isEmpty || self.coursePar.isEmpty || self.holeCount.isEmpty && !isCourseSubmitted)) || (selectedView == .golfer && (self.name.isEmpty || self.handicap.isEmpty)))
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Button("Start Golf Round") {
                golfModel.gameInit.toggle()
                self.presentationMode.wrappedValue.dismiss()
            }
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
        .navigationBarTitle(selectedView == .course ? "Add Course" : "Add Golfer", displayMode: .inline)
    }
}

struct AddContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddContentView().environmentObject(GolfGameViewModel())
        }
    }
}
