//
//  Geofence.swift
//  Test
//
//  Created by Guillermo Moral on 06/08/2021.
//

import Foundation
import CoreLocation

struct Geofence: Codable {
    let identifier: String
    let regionState : String
    
    init(identifier: String, regionState: String) {
        self.identifier = identifier
        self.regionState = regionState
    }
    
    func toDictionary() -> [String : Any] {
            let props = ["identifier" : self.identifier,
                         "regionState" : self.regionState
                         
            ] as [String : Any]
            return props
    }
}
