//
//  FirebaseLogger.swift
//  ChallengeGeofence
//
//  Created by Guillermo Moral on 16/08/2021.
//

import Foundation
import FirebaseCore
import FirebaseAnalytics

class FirebaseLogger : LoggerProtocol {
    
    static let shared = FirebaseLogger()
    
    init() {
        FirebaseApp.configure()
    }
    
    func log(event: Events, parameters: [String : Any]?) {
        Analytics.logEvent(event.rawValue, parameters: parameters)
    }
}
