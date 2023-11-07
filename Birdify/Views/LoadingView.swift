//
//  LoadingView.swift
//  Birdify
//
//  Created by Michael Rudy on 10/1/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .frame(maxWidth:.infinity, maxHeight: .infinity)
    }
}

#Preview {
    LoadingView()
}
