//
//  ApiHelper.swift
//  API_Layer
//
//  Created by Guillermo Moral on 08/08/2021.
//

import Foundation

struct RequestHelper {
    
    private static let baseUrl = "postman-echo.com"
    
    enum Endpoint {
        case sendGeofence(geofence: Geofence, path: String = "/post")
        
        var request: URLRequest? {
            guard let url = url else { return nil }
            
            var request = URLRequest(url: url)
            
            request.httpMethod = httpMethod
            request.httpBody = httpBody
            request.addValues(for: self)
            
            return request
        }
        
        private var url : URL? {
            var components = URLComponents()
            
            components.scheme = "https"
            components.host = baseUrl
            components.path = path
            return components.url
        }
        
        private var path: String {
            switch self {
            case .sendGeofence(_, let path):
                return path
            }
        }
        
        private var httpMethod: String {
            switch self {
            case .sendGeofence:
                return HTTP.Mathod.post.rawValue
            }
        }
        
        private var httpBody: Data? {
            return try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        private var body: [String: Any] {
            switch  self {
            case .sendGeofence(let geofences,_):
                return geofences.toDictionary()
            }
        }
    }
}
