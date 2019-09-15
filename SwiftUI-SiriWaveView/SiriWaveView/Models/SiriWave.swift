//
//  SiriWave.swift
//  SwiftUI-SiriWaveView
//
//  Created by Noah Chalifour on 2019-09-14.
//  Copyright © 2019 Noah Chalifour. All rights reserved.
//

import SwiftUI

class SiriWave: ObservableObject {
    
    struct Curve: Equatable {
        
        var power: Double
        var A: Double
        var k: Double
        var t: Double
        
        static func random(withPower power: Double) -> Curve {
            
            return Curve(
                power: power,
                A: Double.random(in: 0.1...1.0),
                k: Double.random(in: 0.6...0.9),
                t: Double.random(in: -1.0...4.0)
            )
            
        }
        
    }
    
    struct Wave: Equatable {
        
        var power: Double
        var curves: [Curve]
        var useCurves: Int
        
        static func random(withPower power: Double) -> Wave {
            
            let numCurves = Int.random(in: 2 ... 4)
            
            return Wave(
                power: power,
                curves: (0..<4).map { _ in
                    return Curve.random(withPower: power)
                },
                useCurves: numCurves
            )
            
        }
        
    }
    
    var waves: [Wave]
    
    init(numWaves: Int, power: Double) {
        
        waves = [Wave]()
        
        for _ in 0..<numWaves {
            waves.append(.random(withPower: power))
        }
        
    }
    
}

//extension SiriWave.Curve: Animatable {
//
//    typealias AnimatableData = AnimatablePair<
//        AnimatablePair<Double, Double>, AnimatablePair<Double, Double>>
//
//    var animatableData: AnimatableData {
//
//        get {
//            .init(.init(A, power), .init(k, t))
//        }
//
//        set {
//            A = newValue.first.first
//            power = newValue.first.second
//            k = newValue.second.first
//            t = newValue.second.second
//        }
//
//    }
//
//}

// This part is temporary because you cannot create an
// array of animatable data

extension SiriWave.Wave: Animatable {
    
    typealias AnimatableData = AnimatablePair<
        AnimatablePair<
            AnimatablePair<
                AnimatablePair<Double, Double>,
                AnimatablePair<Double, Double>
            >,
            AnimatablePair<
                AnimatablePair<Double, Double>,
                AnimatablePair<Double, Double>
            >
        >,
        AnimatablePair<
            AnimatablePair<
                AnimatablePair<Double, Double>,
                AnimatablePair<Double, Double>
            >,
            AnimatablePair<
                AnimatablePair<Double, Double>,
                AnimatablePair<
                    AnimatablePair<Double, Double>,
                    AnimatablePair<Double, Double>
                >
            >
        >
    >
    
    var animatableData: AnimatableData {
        
        get {
            .init(
                .init(
                    .init(
                        .init(curves[0].A, curves[0].power),
                        .init(curves[0].k, curves[0].t)),
                    .init(
                        .init(curves[1].A, curves[1].power),
                        .init(curves[1].k, curves[1].t))),
                .init(
                    .init(
                        .init(curves[2].A, curves[2].power),
                        .init(curves[2].k, curves[2].t)),
                    .init(
                        .init(curves[3].A, curves[3].power),
                        .init(
                            .init(curves[3].k, curves[3].t),
                            .init(power, .zero)))))
        }
        
        set {
            curves[0].A = newValue.first.first.first.first
            curves[0].power = newValue.first.first.first.second
            curves[0].k = newValue.first.first.second.first
            curves[0].t = newValue.first.first.second.second
            
            curves[1].A = newValue.first.second.first.first
            curves[1].power = newValue.first.second.first.second
            curves[1].k = newValue.first.second.second.first
            curves[1].t = newValue.first.second.second.second
            
            curves[2].A = newValue.second.first.first.first
            curves[2].power = newValue.second.first.first.second
            curves[2].k = newValue.second.first.second.first
            curves[2].t = newValue.second.first.second.second
            
            curves[3].A = newValue.second.second.first.first
            curves[3].power = newValue.second.second.first.second
            curves[3].k = newValue.second.second.second.first.first
            curves[3].t = newValue.second.second.second.first.second
            
            power = newValue.second.second.second.second.first
        }
        
    }
    
}
