//
//  ClosedRange.swift
//  Treble Clef
//
//  Created on 2018. 06. 29..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import Foundation

extension ClosedRange where Bound : FloatingPoint {
    
    func random() -> Bound {
        let max = UInt32.max
        return Bound(arc4random_uniform(max)) / Bound(max) * (upperBound - lowerBound) + lowerBound
    }
    
}
