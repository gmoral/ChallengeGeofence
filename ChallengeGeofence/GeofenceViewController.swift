//
//  ViewController.swift
//  ChallengeGeofence
//
//  Created by Guillermo Moral on 14/08/2021.
//

import UIKit
import MapKit
import CoreLocation

class GeofenceViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var viewModel : GeofenceViewModel?
    var gpx = Gpx(latitude: -34.60609523863432, longitude: -58.39941234167278, radius: 5, identifier: "Target")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        mapView?.showsUserLocation = true
        self.mapView.delegate = self
        viewModel?.locationService.regionToMonitor(gpx: gpx)
    }
}

extension GeofenceViewController: MKMapViewDelegate, GeofenceViewModelDelegate {
    
    func updateRegion(region: MKCoordinateRegion) {
        mapView?.setRegion(region, animated: true)
    }
    
    func addOverlay(circleRegion: MKCircle) {
        mapView?.addOverlay(circleRegion)
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      
    if let region = overlay as? MKCircle {
        let circleView = MKCircleRenderer(overlay: region)
        circleView.fillColor = UIColor.green
        return circleView
    }
    
        return MKOverlayRenderer()
    }
}
