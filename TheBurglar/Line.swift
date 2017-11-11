//
//  Line.swift
//  TouchTracker
//
//  Created by Александр Гаврилов on 29.10.17.
//  Copyright © 2017 Александр Гаврилов. All rights reserved.
//

import Foundation
import CoreGraphics

struct Line{
    var begin = CGPoint.zero
    var end = CGPoint.zero
    var angle: Measurement<UnitAngle> {
        var angleInRads: Measurement<UnitAngle>
        angleInRads = Measurement(value: -atan2(Double(end.y - begin.y),Double(end.x - begin.x)), unit: .radians)
        
        if angleInRads.value < 0 {
           angleInRads = Measurement(value: 2 * Double.pi + angleInRads.value, unit: .radians)
        }
        
        return angleInRads.converted(to: .degrees)
    }
}
