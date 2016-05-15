//
//  Location.swift
//  TDDToDo
//
//  Created by Michael Vilabrera on 5/15/16.
//  Copyright © 2016 Michael Vilabrera. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    let name: String
    let coordinate: CLLocationCoordinate2D?
    
    init(name: String,
         coordinate: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
}