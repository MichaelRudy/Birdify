//
//  WeatherView.swift
//  Birdify
//
//  Created by Michael Rudy on 10/1/23.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        if let location = locationManager.location {
            Text("Your coordinates are \(location.longitude), \(location.latitude)")
            
        } else {
            if locationManager.isLoading {
                LoadingView()
            } else {
                WelcomeView().environmentObject(locationManager)
            }
        }
    }
}

#Preview {
    WeatherView()
}
