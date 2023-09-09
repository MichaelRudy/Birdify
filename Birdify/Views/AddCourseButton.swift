//
//  AddCourseButton.swift
//  Birdify
//
//  Created by Michael Rudy on 9/8/23.
//

import SwiftUI

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

