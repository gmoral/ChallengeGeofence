//
//  URLRequest+Extension.swift
//  API_Layer
//
//  Created by Guillermo Moral on 08/08/2021.
//

import Foundation

extension URLRequest {
    mutating func addValues(for endpoint: RequestHelper.Endpoint) {
        switch endpoint {
            case .sendGeofence:
                setValue(Header.Value.json.rawValue, forHTTPHeaderField: Header.Field.contentType.rawValue)
        }
    }
}
