//
//  LoggerProtocol.swift
//  ChallengeGeofence
//
//  Created by Guillermo Moral on 16/08/2021.
//

import Foundation

protocol LoggerProtocol {
    func log(event:Events, parameters: [String: Any]?)
}
