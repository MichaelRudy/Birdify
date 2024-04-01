//
//  AddCourseName.swift
//  Birdify
//
//  Created by Michael Rudy on 3/3/24.
//

import SwiftUI

struct AddCourseInfo: View {
    @EnvironmentObject var golfModel: GolfGameViewModel
    @State private var courseName: String = ""
    @State private var holeCount: Int = 9
    @State private var coursePar: Double = 72
    @State private var isNextViewReady = false // Added state variable for sheet presentation
    
    var body: some View {
        VStack {
            HStack {
                Text("Add Course Name")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .bold()
                    .italic()
                    .foregroundColor(.blue)
                    .padding()
                Spacer()
            }
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading, 10)
                
                
                TextField("Course Name", text: $courseName)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .font(.title2)
                    .foregroundColor(.primary) // Use primary color for text
                    .background(.black) // Use a light background color in dark mode
                    .onTapGesture {
                        // Dismiss the keyboard
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
            }
            .cornerRadius(10)
            .padding()
            
            Picker("Hole Count", selection: $holeCount) {
                Text("9 Holes").tag(9)
                Text("18 Holes").tag(18)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            
            Slider(value: $coursePar, in: 62...82, step: 1.0)
                .padding()
                .accentColor(.blue)
            
            Text("Course Par: \(Int(coursePar))")
                .font(.title2)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .bold()
                .italic()
                .foregroundColor(.blue)
                .padding()
            
            Spacer()
            Button(action: {
                // Handle "Next" button action
                // Add your logic here
                golfModel.validateCourse(name: self.courseName, par: String(self.coursePar), holeCount: String(self.holeCount))
                golfModel.courseInfoAdded.toggle()
            }) {
                Text("Add")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
        }
        
    }
}

#Preview {
    NavigationStack {
        AddCourseInfo().environmentObject(GolfGameViewModel())
    }
}
