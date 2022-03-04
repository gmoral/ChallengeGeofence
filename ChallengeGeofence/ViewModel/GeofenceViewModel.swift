//
//  ViewModel.swift
//  ChallengeGeofence
//
//  Created by Guillermo Moral on 14/08/2021.
//

import Foundation
import CoreLocation
import MapKit
import FirebaseAnalytics

protocol GeofenceViewModelDelegate: AnyObject {
    
    func updateRegion(region: MKCoordinateRegion)
    func addOverlay(circleRegion: MKCircle)
}

class GeofenceViewModel {
    
    var api : ApiClientProtocol?
    var firebaseLogger : LoggerProtocol?
    let locationService : LocationService!
    weak var delegate: GeofenceViewModelDelegate?
    
    init(api: ApiClientProtocol, firebaseLogger: LoggerProtocol) {
        self.api = api
        self.firebaseLogger = firebaseLogger
        locationService = LocationService()
        locationService.delegate = self
        locationService.setup()
    }
    
    deinit {
        self.delegate = nil
    }
}

extension GeofenceViewModel: LocationServiceDelegate {
    
    func locationService(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        api?.sendGeofence(geo: Geofence(identifier: region.identifier, regionState: "didExitRegion")) { geofence in
            print(">>> didExitRegion")
            self.firebaseLogger?.log(event: Events.didExitRegion, parameters:["event_name": "didExitRegion"])
        }
    }
    
    func locationService(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        api?.sendGeofence(geo: Geofence(identifier: region.identifier, regionState: "didEnterRegion")) { geofence in
            print(">>> didEnterRegion")
            self.firebaseLogger?.log(event: Events.didEnterRegion, parameters:["event_name": "didEnterRegion"])
        }
    }
    
    func locationService(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else {
            return
        }
        
        print("didUpdateLocation")
        self.updateLocation(location: location)
    }
    
    func addOverlay(circleRegion: MKCircle) {
        self.delegate?.addOverlay(circleRegion: circleRegion)
    }
    
    func updateLocation(location: CLLocation) {
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: 200, longitudinalMeters: 200)
        self.delegate?.updateRegion(region: region)
    }
}
