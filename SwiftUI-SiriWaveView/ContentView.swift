//
//  ContentView.swift
//  SwiftUI-SiriWaveView
//
//  Created by Noah Chalifour on 2019-09-13.
//  Copyright © 2019 Noah Chalifour. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            SiriWaveView()
                .frame(height: 100, alignment: .leading)
                .background(Color(red: (28 / 255), green: (44 / 255), blue: (61 / 255)))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
