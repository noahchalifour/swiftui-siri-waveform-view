//
//  SupportLine.swift
//  SwiftUI-SiriWaveView
//
//  Created by Noah Chalifour on 2019-09-14.
//  Copyright © 2019 Noah Chalifour. All rights reserved.
//

import SwiftUI

struct SupportLine: View {
    
    var color: Color!
    
    var body: some View {
        
        GeometryReader { geometry in
            
            Path { path in
                
                let centerY = geometry.size.height / 2.0
                
                path.move(to: CGPoint(x: 0, y: centerY))
                
                path.addLines([
                    CGPoint(x: 0, y: centerY),
                    CGPoint(x: geometry.size.width, y: centerY)
                ])
                
            }
            .stroke(self.color, lineWidth: 2)
            .opacity(0.5)
            
        }
        
    }
    
}

struct SupportLine_Previews: PreviewProvider {
    static var previews: some View {
        SupportLine(color: Color(.white))
            .background(Color(.black))
    }
}
