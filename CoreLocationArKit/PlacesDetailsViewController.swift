//
//  PlacesDetailsViewController.swift
//  CoreLocationArKit
//
//  Created by Paweł Trojan on 21.10.2017.
//  Copyright © 2017 Paweł Trojan. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import ARCL

class PlacesDetailsViewController: UIViewController, CLLocationManagerDelegate {
    
    var place: String!
    private var sceneLocationView = SceneLocationView()
    lazy private var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(sceneLocationView)
        self.sceneLocationView.run()

        self.title = self.place
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
       // print(self.locationManager.location?.coordinate)
        
        self.findLocalPlaces()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sceneLocationView.frame = self.view.bounds
    }
    
    private func findLocalPlaces() {
        guard let location = self.locationManager.location else { return }
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = place
        
        var region = MKCoordinateRegion()
        region.center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        request.region = region
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard error == nil else { return }
            guard let response = response else { return }
            
            for item in response.mapItems {
                let placeLocation = item.placemark.location
                let image = UIImage(named: "pin")!
                let annotationNode = LocationAnnotationNode(location: placeLocation, image: image)
                annotationNode.scaleRelativeToDistance = false
                
                let placeAnnotation = PlaceAnnotation(location: placeLocation, title: item.placemark.name!)
                
                DispatchQueue.main.async {
                   // self.sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
                    self.sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: placeAnnotation)

                }
            }
        }
    }
    
}
