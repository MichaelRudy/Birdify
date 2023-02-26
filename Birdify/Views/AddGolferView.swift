//
//  AddGolferView.swift
//  Birdify
//
//  Created by Michael Rudy on 2/24/23.
//

import SwiftUI

struct AddGolferView: View {
    @EnvironmentObject var golfModel: GolferModel
    
    @State private var numberOfGolfers = 1
    @State private var golfersAdded = 0
    
    var body: some View {
        
        VStack {
            Stepper(value: $numberOfGolfers, in: 1...4) {
                Text("Add \(numberOfGolfers) Golfer(s)")
                    .font(.title3)
            }
            
            ForEach(0..<numberOfGolfers, id: \.self) { index in
                GolferInputView(golferAdded: { name, handicap in
                    golfModel.addGolfer(name: name, handicap: handicap)
                    golfersAdded += 1
                })
            }
            
            
            if golfersAdded == numberOfGolfers {
                Button("Done") {
                    // Dismiss the view
                }
            }
        }
        .padding()
        
    }
}

struct GolferInputView: View {
//    @EnvironmentObject var golfModel: GolferModel
    let golferAdded: (String, Int) -> Void
    
    @State private var name = ""
    @State private var handicap = ""
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
            TextField("Handicap", text: $handicap)
                .keyboardType(.numberPad)
            
            Button("Add") {
                if let handicapValue = Int(handicap) {
                    golferAdded(name, handicapValue)
                }
            }
            .disabled(name.isEmpty || handicap.isEmpty)
        }
//        .environmentObject(golfModel)
    }
}

struct AddGolferView_Previews: PreviewProvider {
    static var previews: some View {
        AddGolferView()
    }
}
