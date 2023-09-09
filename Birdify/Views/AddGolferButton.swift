//
//  AddGolferButton.swift
//  Birdify
//
//  Created by Michael Rudy on 9/8/23.
//

import SwiftUI

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
