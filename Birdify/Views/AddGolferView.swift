//
//  AddGolferView.swift
//  Birdify
//
//  Created by Michael Rudy on 2/24/23.
//

import SwiftUI

struct AddGolferView: View {
    @EnvironmentObject var golfModel: GolfGameViewModel
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
                    .onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                
                TextField("Handicap", text: $handicap)
                    .keyboardType(.numberPad)
                    .padding(.bottom, 10)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                
                Button("Add") {
                    if let handicapValue = Int(handicap) {
                        golfModel.addGolfer(name: name, handicap: handicapValue)
                        name = ""
                        handicap = ""
                    }
                    else {
                        golfModel.addGolfer(name: name, handicap: 0)
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
    static var previews: some View {
        NavigationStack {
            AddGolferView().environmentObject(GolfGameViewModel())
        }
        
    }
}
