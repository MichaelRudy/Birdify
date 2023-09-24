//
//  HoleBlockView.swift
//  Birdify
//
//  Created by Michael Rudy on 9/23/23.
//

import SwiftUI

struct HoleBlockView: View {
    @EnvironmentObject var golfModel: GolfGameViewModel
    var hole: Int
    var par: Int

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 35)
                .fill(Color(hue: 0.57, saturation: 1.0, brightness: 1.0))
                .frame(width: 350, height: 200)
                .padding()
            VStack {
                HStack {
                    Text("Hole \(String(hole))")
                        .font(.title3)
                        .frame(width: 100, height: 50)
                        .padding(.leading, 20) // Adjust the leading padding as needed
                    Spacer()
                    Text("Par \(par)")
                        .font(.title3)
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 30) // Adjust the leading padding as needed
                }
                HStack {
                    Text("Hello")
                }
            }
            .padding(.bottom, 140.0)
        }
    }
}

struct HoleBlockView_Previews: PreviewProvider {
    static var previews: some View {
        let hole = 3
        let par = 4
        let golfModel = GolfGameViewModel()
        golfModel.validateGolfer(name: "Michael", handicap: "10")
        //        golfModel.validateGolfer(name: "Candace", handicap: "10")
        //        golfModel.validateGolfer(name: "Tyler", handicap: "10")
        golfModel.validateCourse(name: "Twin Lakes", par: "72", holeCount: "9")
        
        return NavigationStack {
            HoleBlockView(hole: hole, par: par).environmentObject(golfModel)
        }
    }
}
