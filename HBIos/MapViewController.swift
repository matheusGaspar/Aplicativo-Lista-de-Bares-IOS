//
//  MapsTableViewController.swift
//  HBIos
//
//  Created by Jonathan on 18/02/20.
//  Copyright © 2020 Hbsis. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: -26.916966, longitude: -49.070854)
        
        
        centerMapOnLocation(location: initialLocation)
        
        carregarBares()
        
        // show artwork on map
        /*let artwork = Artwork(title: "King David Kalakaua",
         locationName: "Waikiki Gateway Park",
         discipline: "Sculpture",
         coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))*/
        // mapView.addAnnotation(artwork)
        //Final View
        mapView.delegate = self 
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func carregarBares(){
        var Salve = NSKeyedUnarchiver.unarchiveObject(withFile: Bar.ArchiveURL.path) as? [Bar] ?? [Bar]()
        
        if (Salve.isEmpty){
            let bar = Bar(name: "ze", photo: nil, rating: 3, telefone: "33972727", endereco: "rua Ipiranga", latitude: -26.915410, longitude: -49.068909)
            let barPoint = Artwork(bar: bar!)
            mapView.addAnnotation(barPoint!)
        }else{
            for bar in Salve {
                let barPoint = Artwork(bar: bar)!
                
                /*barPoint.coordinate = CLLocationCoordinate2D(latitude: barPoint.coordinate.longitude, longitude: barPoint.coordinate.latitude)*/
                
            print("\(barPoint.coordinate.latitude) e \(barPoint.coordinate.longitude)")
                
                mapView.addAnnotation(barPoint)
            }
        }
        
    }
    let locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
}





