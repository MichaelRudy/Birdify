//
//  AddGolferView.swift
//  Birdify
//
//  Created by Michael Rudy on 2/24/23.
//

import SwiftUI

struct AddGolferView: View {
    let golfModel: GolferModel
    @State private var name = ""
    @State private var handicap = ""
    
    var body: some View {
        
        VStack {
            List {
                Section(header: header) {
                    ForEach(golfModel.golfers) { golfer in
                        HStack {
                            Text(golfer.name)
                            Spacer()
                            Text(String(golfer.handicap))
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            VStack(alignment: .center) {
                TextField("Name", text: $name)
                    .padding(.bottom, 10)
                    .multilineTextAlignment(.center)
                
                TextField("Handicap", text: $handicap)
                    .keyboardType(.numberPad)
                    .padding(.bottom, 10)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                
                Button("Add") {
                    if let handicapValue = Int(handicap) {
                        golfModel.addGolfer(name: name, handicap: handicapValue)
                        name = ""
                        handicap = ""
                    }
                }
                .disabled(name.isEmpty || handicap.isEmpty)
            }
            .padding()
            
//            if golfModel.golfers.isEmpty {
//                Button("Done") {
//                    // Dismiss the view
//                }
//            }
    
            Spacer()
        }
        .padding()
    }
}

var header: some View {
    HStack {
        Text("Golfer")
        Spacer()
        Text("Handicap")
    }
}

struct AddGolferView_Previews: PreviewProvider {
    static let golfModel = GolferModel()
    static var previews: some View {
        NavigationStack {
            AddGolferView(golfModel: golfModel)
        }
        
    }
}
