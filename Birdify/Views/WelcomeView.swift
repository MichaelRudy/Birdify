//
//  WelcomeView.swift
//  Birdify
//
//  Created by Michael Rudy on 10/1/23.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Get Weather Data For Your Golf Round")
                    .bold().font(.title)
                
                Text("Please share your current location to get the weather in your area")
            }
            .multilineTextAlignment(.center)
            .padding()
            
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    WelcomeView()
}
