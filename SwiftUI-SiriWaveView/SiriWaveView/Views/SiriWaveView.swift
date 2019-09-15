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
    
    var _colors: [Color]!
    var _supportLineColor: Color!
    var _power: Double!
    
    init() {
        
        self._power = 0.0
    
        // Initialize default Siri waveform
        
        self._colors = [
           // Red
           Color(red: (173 / 255), green: (57 / 255), blue: (76 / 255)),
           // Green
           Color(red: (48 / 255), green: (220 / 255), blue: (155 / 255)),
           // Blue
           Color(red: (25 / 255), green: (122 / 255), blue: (255 / 255))
        ]
        
        self._supportLineColor = Color(.white)
        
        // Initialize model
        self.siriWave = SiriWave(numWaves: self._colors.count, power: self._power)
        
    }
    
    func colors(colors: [Color]) -> Self {
        
        var this = self;
        
        if (colors.count != this._colors.count) {
            this.siriWave = SiriWave(numWaves: colors.count, power: this._power)
        }
        
        this._colors = colors
        
        return this
        
    }
    
    func power(power: Double) -> Self {
        
        var this = self;
        
        this.siriWave = SiriWave(numWaves: self._colors.count, power: power)
        
        return this
        
    }
    
    func supportLineColor(color: Color) -> Self {
        
        var this = self;
        
        this._supportLineColor = color
        
        return this
        
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                SupportLine(color: self._supportLineColor)
                ForEach(0..<self._colors.count, id: \.self) { i in
                    WaveView(wave: self.siriWave.waves[i], color: self._colors[i])
//                        .animation(.spring())
                        .animation(.linear(duration: 0.3))
//                        .shadow(color: self.colors[i], radius: 2, x: 0, y: 0)
                }
                
            }
            .blendMode(.lighten)
            .drawingGroup()
            
        }
        
    }
    
}

struct SiriWaveView_Previews: PreviewProvider {
    static var previews: some View {
        SiriWaveView()
    }
}
