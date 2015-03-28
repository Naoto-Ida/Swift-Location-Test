//
//  Perimeter.swift
//  Location
//
//  Created by Naoto Ida on 3/28/15.
//  Copyright (c) 2015 Naoto Ida All rights reserved.
//

import Foundation

class Perimeter {
    
    var pointA: Array<AnyObject>?,
        pointB: Array<AnyObject>?,
        pointC: Array<AnyObject>?,
        pointD: Array<AnyObject>?
    
    init(points: Array<Array<Double>>) {
        self.pointA = points[0]
        self.pointB = points[1]
        self.pointC = points[2]
        self.pointD = points[3]
    }
}