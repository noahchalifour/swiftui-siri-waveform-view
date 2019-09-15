//
//  WaveView.swift
//  SwiftUI-SiriWaveView
//
//  Created by Noah Chalifour on 2019-09-14.
//  Copyright © 2019 Noah Chalifour. All rights reserved.
//

import SwiftUI

private struct WaveGeometry {
    
    var wave: SiriWave.Wave
    var points: [CGPoint]
    var origin: CGPoint
    
    init(_ wave: SiriWave.Wave, in rect: CGRect) {
        
        self.wave = wave
        self.points = [CGPoint]()
        self.origin = CGPoint(x: 0, y: rect.midY)
        
        let xPoints = Array(stride(from: -rect.midX, to: rect.midX, by: 1.0))
        
        var coordinates = [[Double]](repeating: [0.0, 0.0], count: xPoints.count)
        
        for i in 0..<self.wave.useCurves {
            
            let A = self.wave.curves[i].A * Double(rect.midY) * self.wave.power
            
            var j = 0
            
            for graphX in xPoints {
                
                let graphScaledX = graphX / (rect.midX / 9.0)
                
                let x = rect.midX + graphX
                let y = self.attn(x: Double(graphScaledX), A: A, k: self.wave.curves[i].k, t: self.wave.curves[i].t) + Double(self.origin.y)
                
                coordinates[j] = [Double(x), max(coordinates[j][1], y)]
                
                j += 1
                
            }
            
        }
        
        // Create inverse points
        coordinates += coordinates.map({ (coord) -> [Double] in
            return [coord[0], ((coord[1] - Double(rect.midY)) * -1) + Double(rect.midY)]
        })
        
        for coord in coordinates {
            self.points.append(CGPoint(x: coord[0], y: coord[1]))
        }
        
    }
    
    private func sine(x: Double, A: Double, k: Double, t: Double) -> Double {

        return A * sin((k * x) - t)

    }

    private func g(x: Double, t: Double, K: Double, k: Double) -> Double {

        return pow(K / (K + pow((k * x) - t, 2)), K)

    }

    private func attn(x: Double, A: Double, k: Double, t: Double) -> Double {

        return abs(sine(x: x, A: A, k: k, t: t) * g(x: x, t: t - (Double.pi / 2), K: 4, k: k))

    }
    
}

struct WaveShape: Shape {
    
    var wave: SiriWave.Wave
    
    func path(in rect: CGRect) -> Path {
        
        let geometry = WaveGeometry(wave, in: rect)
        var path = Path()
        
        path.move(to: geometry.origin)
        path.addLines(geometry.points)
        
        return path
        
    }
    
    var animatableData: SiriWave.Wave.AnimatableData {
        
        get {
            return wave.animatableData
        }
        
        set {
            wave.animatableData = newValue
        }

    }
    
}

struct WaveView: View {
    
    var wave: SiriWave.Wave
    var color: Color
    
    var body: some View {
        
        WaveShape(wave: wave)
            .fill(color)
        
    }
    
}

struct WaveView_Previews: PreviewProvider {
    static var previews: some View {
        WaveView(wave: .random(withPower: 1), color: Color(.red))
    }
}
