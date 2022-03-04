//
//  FirebaseLoggerSpy.swift
//  ChallengeGeofenceTests
//
//  Created by Guillermo Moral on 16/08/2021.
//

import Foundation

class FirebaseLoggerSpy : LoggerProtocol {

    var invokedLog = false
    var invokedLogCount = 0
    var invokedLogParameters: (event: Events, parameters: [String: Any]?)?
    var invokedLogParametersList = [(event: Events, parameters: [String: Any]?)]()

    func log(event:Events, parameters: [String: Any]?) {
        invokedLog = true
        invokedLogCount += 1
        invokedLogParameters = (event, parameters)
        invokedLogParametersList.append((event, parameters))
    }
}
