//
//  ResultsView.swift
//  Birdify
//
//  Created by Michael Rudy on 5/29/23.
//

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var golfModel: GolfGameViewModel
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray)
            VStack {
                ForEach(golfModel.golfers, id: \.self) { golfer in
                    Text(golfer.golferName)
                }
            }
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        let golfModel = GolfGameViewModel()
        golfModel.validateGolfer(name: "Michael", handicap: "10")
        //        golfModel.validateGolfer(name: "Tyler", handicap: "10")
        golfModel.validateCourse(name: "Twin Lakes", par: "72", holeCount: "2")
        return NavigationStack {
            TrackScoreView().environmentObject(golfModel)
        }
    }
}
