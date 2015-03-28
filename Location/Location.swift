//
//  Location.swift
//  Location
//
//  Created by Naoto Ida on 3/28/15.
//  Copyright (c) 2015 Naoto Ida All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    
    var latitude    : CLLocationDegrees!,
        longitude   : CLLocationDegrees!
    
    init(coordinates: Array<CLLocationDegrees>) {
        self.latitude   = coordinates[0]
        self.longitude  = coordinates[1]
    }
}