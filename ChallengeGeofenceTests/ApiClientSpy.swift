//
//  MockApiClient.swift
//  API_Layer
//
//  Created by Guillermo Moral on 09/08/2021.
//

import Foundation

class ApiClientSpy: ApiClientProtocol {

    var invokedSendGeofence = false
    var invokedSendGeofenceCount = 0
    var invokedSendGeofenceParameters: (geo: Geofence, Void)?
    var invokedSendGeofenceParametersList = [(geo: Geofence, Void)]()
    var stubbedSendGeofenceCompletionResult: (Geofence, Void)?

    func sendGeofence(geo: Geofence,completion: @escaping (Geofence) -> Void) {
        invokedSendGeofence = true
        invokedSendGeofenceCount += 1
        invokedSendGeofenceParameters = (geo, ())
        invokedSendGeofenceParametersList.append((geo, ()))
        if let result = stubbedSendGeofenceCompletionResult {
            completion(result.0)
        }
    }
}
