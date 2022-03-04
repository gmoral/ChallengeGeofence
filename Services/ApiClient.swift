//
//  ApiClient.swift
//  API_Layer
//
//  Created by Guillermo Moral on 08/08/2021.
//

import Foundation

protocol ApiClientProtocol {
    func sendGeofence(geo: Geofence,completion: @escaping (Geofence) -> Void)
}

class ApiClient: ApiClientProtocol {
    init() {}

    func sendGeofence(geo: Geofence,completion: @escaping (Geofence) -> Void) {
        
        guard let request = RequestHelper.Endpoint.sendGeofence(geofence: geo).request else { return }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                print("response error")
                return
            }
            
            if let data = data {
                print("data")
                let decoder = JSONDecoder()
                if let jsonGeofences = try? decoder.decode(Geofences.self, from: data) {
                    completion(jsonGeofences.data)
                }
            }
        }.resume()
    }
}
