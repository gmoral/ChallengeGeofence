//
//  ChallengeGeofenceTests.swift
//  ChallengeGeofenceTests
//
//  Created by Guillermo Moral on 14/08/2021.
//

import XCTest
import CoreLocation

class ChallengeGeofenceTests: XCTestCase {
    
    let gpx1 = Gpx(latitude: -34.60609523863432, longitude: -58.39941234167278, radius: 5, identifier: "Target")
    let gpx2 = Gpx(latitude: -34.60339743217664, longitude: -58.400512047352564, radius: 5, identifier: "Lavalle-Street")
    
    var locationService : LocationService!
    
    override func setUpWithError() throws {
        locationService = LocationService()
    }

    override func tearDownWithError() throws {
        locationService = nil
    }

    func testLocationServiceMonitoredRegions() throws {
        // Given
        locationService.regions.removeAll()
        
        // When
        locationService.regionToMonitor(gpx: gpx1)
        
        //Then
        XCTAssertEqual(locationService.regions.count, 1)
    }
    
    func testLocationServiceDidEnterRegion() throws {
        // Given
        locationService.regionToMonitor(gpx: gpx1)
        locationService.regionToMonitor(gpx: gpx2)
        
        let circularRegion = CLCircularRegion(center: CLLocationCoordinate2D(latitude: gpx1.location.coordinate.latitude, longitude: gpx1.location.coordinate.longitude), radius: gpx1.radius, identifier: gpx1.identifier)
        
        // When
        locationService.locationManager(locationService.locationManager, didEnterRegion: circularRegion)
        
        let region = locationService.regions[0]
    
        // Then
        XCTAssertEqual(region.state, GpxState.didEnterRegion)
    }
    
    func testLocationServiceDidExitRegion() throws {
        // Given
        locationService.regionToMonitor(gpx: gpx1)
        locationService.regionToMonitor(gpx: gpx2)
        
        let circularRegion = CLCircularRegion(center: CLLocationCoordinate2D(latitude: gpx2.location.coordinate.latitude, longitude: gpx2.location.coordinate.longitude), radius: gpx2.radius, identifier: gpx2.identifier)
        
        // When
        locationService.locationManager(locationService.locationManager, didExitRegion: circularRegion)
        
        let region = locationService.regions[1]
        
        // Then
        XCTAssertEqual(region.state, GpxState.didExitRegion)
    }
    
    func testApiService() {
        // Given
        let apiClientSpy = ApiClientSpy()
        let firebaseLoggerSpy = FirebaseLoggerSpy()
        
        let viewModel = GeofenceViewModel(api: apiClientSpy, firebaseLogger: firebaseLoggerSpy)
        
        let circularRegion = CLCircularRegion(center: CLLocationCoordinate2D(latitude: gpx1.location.coordinate.latitude, longitude: gpx1.location.coordinate.longitude), radius: gpx1.radius, identifier: gpx1.identifier)
        
        viewModel.locationService.regionToMonitor(gpx: gpx1)
        
        // When
        viewModel.locationService.locationManager(locationService.locationManager, didExitRegion: circularRegion)
        
        let region = viewModel.locationService.regions[0]
        
        // Then
        XCTAssertEqual(region.state, GpxState.didExitRegion)
        XCTAssertTrue(apiClientSpy.invokedSendGeofence)
    }
    
}
