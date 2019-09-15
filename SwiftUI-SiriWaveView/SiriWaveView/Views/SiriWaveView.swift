//
//  SiriWaveView.swift
//  SwiftUI-SiriWaveView
//
//  Created by Noah Chalifour on 2019-09-14.
//  Copyright © 2019 Noah Chalifour. All rights reserved.
//

import SwiftUI

struct SiriWaveView: View {
    
    var siriWave: SiriWave!
    var colors: [Color]!
    var supportLineColor: Color!
    
    var power: Double!
    
    init(power: Double) {
        
        self.power = power
        
        // Initialize default Siri waveform
        
        self.colors = [
           // Red
           Color(red: (173 / 255), green: (57 / 255), blue: (76 / 255)),
           // Green
           Color(red: (48 / 255), green: (220 / 255), blue: (155 / 255)),
           // Blue
           Color(red: (15 / 255), green: (82 / 255), blue: (169 / 255))
        ]
        
        self.supportLineColor = Color(.white)
        
        // Initialize model
        self.siriWave = SiriWave(numWaves: self.colors.count, power: power)
        
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                SupportLine(color: self.supportLineColor)
                ForEach(0..<self.colors.count, id: \.self) { i in
                    WaveView(wave: self.siriWave.waves[i], color: self.colors[i])
//                        .scaleEffect(CGFloat(self.power))
                        .animation(.spring())
                }
                
            }
            .blendMode(.lighten)
            .drawingGroup()
            
        }
        
    }
    
}

struct SiriWaveView_Previews: PreviewProvider {
    static var previews: some View {
        SiriWaveView(power: 0.0)
    }
}
