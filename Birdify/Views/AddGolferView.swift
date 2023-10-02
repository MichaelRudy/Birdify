//
//  AddGolferView.swift
//  Birdify
//
//  Created by Michael Rudy on 2/24/23.
//

import SwiftUI

struct AddGolferView: View {
    @EnvironmentObject var golfModel: GolfGameViewModel
    @State var name = ""
    @State var handicap = ""
    
    var body: some View {
        VStack {
            addGolferTitle    
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
            
            VStack(alignment: .center) {
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
                
                Button("Add") {
                    golfModel.validateGolfer(name: self.name, handicap: self.handicap)
                    self.name = ""
                    self.handicap = ""
                }
                .disabled(self.name.isEmpty || self.handicap.isEmpty)
                .onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
            }
            .padding()
                
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

var courseHeader: some View {
    HStack {
        Text("Course Name")
        Spacer()
        Text("Course Par")
    }
}

var addGolferTitle: some View {
    HStack {
        Text("Add Golfers")
            .font(.title)
            .fontWeight(.black)
            .italic()
            .foregroundColor(.blue)
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        Spacer()
    }
}

struct AddGolferView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddGolferView().environmentObject(GolfGameViewModel())
        }
        
    }
}
