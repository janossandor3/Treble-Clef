//
//  asd.swift
//  Treble Clef
//
//  Created on 2018. 07. 02..
//  Copyright © 2018. Janos Sandor. All rights reserved.
//

import UIKit

// Helper for coordinates
public protocol CoordinateConverter: Hashable {
    func multiplier() -> CGFloat
}

public extension CoordinateConverter where Self: RawRepresentable, Self.RawValue == CGFloat {
    public func multiplier() -> CGFloat {
        return self.rawValue / 1000
    }
}
