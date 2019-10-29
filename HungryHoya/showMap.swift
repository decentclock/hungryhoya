//
//  showMap.swift
//  HungryHoya
//
//  Created by jules on 5/1/19.
//  Copyright © 2019 Jules Comte. All rights reserved.
//
import UIKit
import MapKit

class showMap: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    var currentPlace: restaurant! // we are showing this restaurant's location
    var locationManager = CLLocationManager()
    var userOnMap = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isToolbarHidden = true // hide the toolbar
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let locationShown = currentPlace.location // the location of this restaurant
        let latitude: CLLocationDegrees = locationShown.latitude
        let longitude: CLLocationDegrees = locationShown.longitude
        let latDelta: CLLocationDegrees = 0.01
        let lonDelta: CLLocationDegrees = 0.01
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: false)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = currentPlace.name
        map.addAnnotation(annotation) // add an annotation at the restaurant's location with its name
        userOnMap.title = "You Are Here!"
        // the title of the annotation that will show the location of the user on the map
    }//viewDidLoad
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // keep updating the annotation that shows the user's location so that
        // they can navigate to it
        map.removeAnnotation(userOnMap)
        let userLocation: CLLocation = locations[0]
        userOnMap.coordinate = userLocation.coordinate
        map.addAnnotation(userOnMap) // add an annotation to the map at the user's location
    }//locationManager
} // showMap
