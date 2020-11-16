//
//  Landmark.swift
//  MapApple1
//
//  Created by Alldo Kurniawan on 14/10/20.
//

import Foundation
import MapKit

struct Landmark {
    let placemark: MKPlacemark
    let placePhone: MKMapItem
    
    let myLocationManager = LocationManager()
    
    var id: UUID {
        return UUID()
    }
    
    var name: String {
        return placemark.name ?? ""
    }
    
    var title: String {
        return placemark.title ?? ""
    }
    
    var phoneNumber: String {
        return placePhone.phoneNumber ?? ""
    }
    
    var distance: Double {
        let placeLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let myLocation = CLLocation(latitude: myLocationManager.myLatitude, longitude: myLocationManager.myLongitude)
        let distance = myLocation.distance(from: placeLocation) / 1000
        
        return distance
    }
    
    var coordinate: CLLocationCoordinate2D {
        self.placemark.coordinate
    }
}
