//
//  LocationService.swift
//  Test
//
//  Created by Guillermo Moral on 03/08/2021.
//

import CoreLocation
import MapKit

protocol LocationServiceDelegate: AnyObject {
    
    func locationService(_ manager: CLLocationManager, didExitRegion region: CLRegion)
    func locationService(_ manager: CLLocationManager, didEnterRegion region: CLRegion)
    func locationService(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    func addOverlay(circleRegion: MKCircle)
}

class LocationService: NSObject {
    var regions = [Gpx]()
    let locationManager : CLLocationManager
    weak var delegate: LocationServiceDelegate?
    
    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
    }
    
    func setup() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func regionToMonitor(gpx: Gpx) {
        self.regions.append(gpx)
        let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: gpx.location.coordinate.latitude, longitude: gpx.location.coordinate.longitude), radius: gpx.radius, identifier: gpx.identifier)
        region.notifyOnEntry = true
        region.notifyOnExit = true
        locationManager.startMonitoring(for: region)
        
        let circleRegion = MKCircle(center: region.center, radius: region.radius)
        self.delegate?.addOverlay(circleRegion: circleRegion)
    }
    
    func updateRegionToMonitorState(region: CLRegion, state: GpxState) {
        
        for gpx in regions {
            if gpx.identifier == region.identifier {
                gpx.state = state
            }
        }
    }
    
    deinit {
        self.delegate = nil
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {

        self.updateRegionToMonitorState(region: region, state: GpxState.didExitRegion)
        delegate?.locationService(manager, didExitRegion: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        self.updateRegionToMonitorState(region: region, state: GpxState.didEnterRegion)
        delegate?.locationService(manager, didEnterRegion: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        delegate?.locationService(manager, didUpdateLocations: locations)
    }
}
