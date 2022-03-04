//
//  GPX.swift
//  Test
//
//  Created by Guillermo Moral on 04/08/2021.
//

import Foundation
import CoreLocation

enum GpxState: Int {
    case unknow = 0
    case didExitRegion = 1
    case didEnterRegion = 2
}

class Gpx {
    let location : CLLocation
    let radius: Double
    let identifier: String
    var state : GpxState
    
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees, radius: Double, identifier: String) {
        self.location = CLLocation(latitude: latitude, longitude: longitude)
        self.radius = radius
        self.identifier = identifier
        self.state = GpxState.unknow
    }
    
    func stateString() -> String {
        switch self.state {
            case .unknow:
                return "unknow"
            case .didEnterRegion:
                return "didEnterRegion"
            case .didExitRegion:
                return "didExitRegion"
        }
    }
}
