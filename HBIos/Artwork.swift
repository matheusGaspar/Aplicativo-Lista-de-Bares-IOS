//
//  Artwork.swift
//  HBIos
//
//  Created by Jonathan on 26/02/20.
//  Copyright © 2020 Hbsis. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Artwork: NSObject, MKAnnotation {
    
    var bar : Bar?
    
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    
    init! (bar:Bar){
        self.title = bar.name
        self.locationName = bar.name
        self.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(bar.latitude), longitude: CLLocationDegrees(bar.longitude))
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    // Annotation right callout accessory opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
