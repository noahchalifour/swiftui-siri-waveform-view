//
//  SiriWaveView.swift
//  SwiftUI-SiriWaveView
//
//  Created by Noah Chalifour on 2019-09-13.
//  Copyright © 2019 Noah Chalifour. All rights reserved.
//

import SwiftUI

struct Wave: View {
    
    let color: Color!
    let numCurves = Int.random(in: 2...4)

    private func sine(x: Float, A: Float, k: Float, t: Float) -> Float {

        return A * sin((k * x) - t)

    }

    private func g(x: Float, t: Float, K: Float, k: Float) -> Float {

        return pow(K / (K + pow((k * x) - t, 2)), K)

    }

    private func attn(x: Float, A: Float, k: Float, t: Float) -> Float {

        return abs(sine(x: x, A: A, k: k, t: t) * g(x: x, t: t - (Float.pi / 2), K: 4, k: k))

    }

    var body: some View {

        GeometryReader { geometry in
                
            Path { path in
                            
                let centerY = geometry.size.height / 2.0
                let centerX = geometry.size.width / 2.0
                
                // Trial and error values
                let xScale = centerX / 9.0
                
                path.move(to: CGPoint(x: 0, y: centerY))
            
                var curveY: [[Float]] = []
                
                for _ in 0..<self.numCurves {
                    
                    // Ranges
                    let A = Float.random(in: 0.1...1.0) * Float(centerY) // Scale
                    let k = Float.random(in: 0.6...0.9)
                    let t = Float.random(in: -1.0...4.0)
                    
                    var i = 0
                    
                    for graphX in stride(from: -centerX, through: centerX, by: 0.01) {
                        
                        let graphScaledX = Float(graphX / xScale)
                    
                        let x = centerX + graphX
                        let y = self.attn(x: graphScaledX, A: A, k: k, t: t) + Float(centerY)
                        
                        if (i >= curveY.count) {
                            curveY.append([Float(x), y])
                        } else {
                            curveY[i] = [Float(x), max(curveY[i][1], y)]
                        }
                        
                        i += 1
                        
                    }
                    
                }
                
                // Create inverted points
                curveY += curveY.map { (coordList) -> [Float] in
                    return [coordList[0], ((coordList[1] - Float(centerY)) * -1) + Float(centerY)]
                }
                
                let points = curveY.map { (coordList) -> CGPoint in
                    return CGPoint(x: CGFloat(coordList[0]), y: CGFloat(coordList[1]))
                }
                
                path.addLines(points)
                
            }
            .fill(self.color)
            
        }

    }

}

struct SiriWaveView: View {
    
    var colors: [Color]!
    var supportLineColor: Color!
    
    init() {
        
        // Use default Siri colors
        
        self.colors = [
           // Red
           Color(red: (173 / 255), green: (57 / 255), blue: (76 / 255)),
           // Green
           Color(red: (48 / 255), green: (220 / 255), blue: (155 / 255)),
           // Blue
           Color(red: (15 / 255), green: (82 / 255), blue: (169 / 255))
        ]
        
        self.supportLineColor = Color(.white)
        
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                Path { path in
                    let centerY = geometry.size.height / 2.0
                    path.move(to: CGPoint(x: 0, y: centerY))
                    path.addLines([
                        CGPoint(x: 0, y: centerY),
                        CGPoint(x: geometry.size.width, y: centerY)
                    ])
                }
                .stroke(self.supportLineColor, lineWidth: 2)
                .opacity(0.5)
                ForEach(self.colors, id: \.self) { color in
                    Wave(color: color)
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
