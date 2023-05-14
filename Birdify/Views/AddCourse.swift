//
//  AddCourse.swift
//  Birdify
//
//  Created by Michael Rudy on 4/2/23.
//

import SwiftUI

struct AddCourse: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var golfModel: GolfGameViewModel
    @State private var courseName: String = ""
    @State private var coursePar: String = ""
    @State private var holeCount: String = ""
    
    var body: some View {
        VStack {
            addCourseTitle
            TextField("Course Name", text: $courseName)
                .padding()
            TextField("Course Par", text: $coursePar)
                .keyboardType(.numberPad)
                .padding()
            TextField("Hole Count", text: $holeCount)
                .keyboardType(.numberPad)
                .padding()
            
            Button("Start Golf Round") {
                golfModel.validateCourse(name: self.courseName, par: self.coursePar, holeCount: self.holeCount)
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
            
var addCourseTitle: some View {
    HStack {
        Text("Add Course Information")
            .font(.title)
            .fontWeight(.black)
            .italic()
            .foregroundColor(.blue)
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        Spacer()
    }
}

struct AddCourse_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddCourse().environmentObject(GolfGameViewModel())
        }
    }
}
