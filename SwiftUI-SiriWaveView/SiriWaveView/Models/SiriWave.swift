//
//  SiriWave.swift
//  SwiftUI-SiriWaveView
//
//  Created by Noah Chalifour on 2019-09-14.
//  Copyright © 2019 Noah Chalifour. All rights reserved.
//

import SwiftUI

class SiriWave: ObservableObject {
    
    struct Wave: Equatable {
        
        var power: Double
        var numCurves: Int
        var A: [Double]
        var k: [Double]
        var t: [Double]
        
        static func random(withPower power: Double) -> Wave {
            
            let numCurves = Int.random(in: 2 ... 4)
            var A = [Double]()
            var k = [Double]()
            var t = [Double]()
            
            for _ in 0..<numCurves {
                A.append(Double.random(in: 0.1...1.0))
                k.append(Double.random(in: 0.6...0.9))
                t.append(Double.random(in: -1.0...4.0))
            }
            
            return Wave(
                power: power,
                numCurves: numCurves,
                A: A,
                k: k,
                t: t
            )
            
        }
        
    }
    
    var waves: [Wave]
    
    init(numWaves: Int) {
        
        waves = [Wave]()
        
        for _ in 0..<numWaves {
            waves.append(.random(withPower: 1.0))
        }
        
    }
    
    func randomize() {
        
        waves = waves.map {
            
            var wave = $0
            
            wave.numCurves = Int.random(in: 2 ... 4)
            
            wave.A = [Double]()
            wave.k = [Double]()
            wave.t = [Double]()
            
            for _ in 0..<wave.numCurves {
                wave.A.append(Double.random(in: 0.1...1.0))
                wave.k.append(Double.random(in: 0.6...0.9))
                wave.t.append(Double.random(in: -1.0...4.0))
            }
            
//            wave.A = Array(wave.A.prefix(upTo: wave.numCurves))
            
            return wave
            
        }
        
    }
    
}

//extension SiriWave.Wave: Animatable {
//    
//    typealias AnimatableData = AnimatablePair<Double, Double>
//    
//    var animatableData: EmptyAnimatableData {
//        
//        get {}
//        set {}
//        
//    }
//    
//}
