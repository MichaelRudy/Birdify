//
//  TestView.swift
//  Birdify
//
//  Created by Michael Rudy on 4/7/24.
//

import SwiftUI

@available(iOS 17.0, *)
struct TestView: View {
    @Environment(GolfGameViewModel.self) var gm
    var body: some View {
        Button(action: {
            print(gm.golfers[0].name)
            gm.golfers[0].name = "Tyler"
        }) {
            Text(gm.golfers[0].name)
        }
    }
}
@available(iOS 17.0, *)
#Preview {
    @Environment(GolfGameViewModel.self) var gm
    gm.validateGolfer(name: "Michael", handicap: "10")
    gm.validateGolfer(name: "Jack", handicap: "10")
    //        gm.validateGolfer(name: "Tyler", handicap: "10")
    gm.validateCourse(name: "Twin Lakes", par: "72", holeCount: "9")
    
    return NavigationStack {
        TestView().environment(gm)
    }
}