//
//  testView.swift
//  Birdify
//
//  Created by Michael Rudy on 4/17/24.
//

import SwiftUI

struct TestView: View {
    @State var golfers: [TestGolfer]

    var body: some View {
        
        VStack {
            Text(golfers[0].name)
            Text("Handicap: \(golfers[0].holeNumber)")
            Button(action: {
                // Perform action on golfer, e.g., increase handicap
                golfers[0].holeNumber += 1
            }) {
                Text("Increase Hole Number")
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = TestGolfGameViewModel()
        vm.addGolfer(name: "Michael", handicap: 10)
        
        return NavigationView {
            TestView(golfers: vm.golfers)
                
        }
    }
}
