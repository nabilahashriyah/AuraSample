//
//  LocationManager.swift
//  MapApple1
//
//  Created by Alldo Kurniawan on 13/10/20.
//

import Foundation
import Combine
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation? = nil
    public var myLatitude: Double = 0
    public var myLongitude: Double = 0
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
//        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    //baru
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(manager.authorizationStatus)
    }
    //baru
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        self.location = location
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
//            print("locations = \(locValue.latitude) \(locValue.longitude)")
//        if myLatitude == 0 || myLongitude == 0 {
            myLatitude = locValue.latitude
            myLongitude = locValue.longitude
        
        locationManager.stopUpdatingLocation()
//        }
        
    }
    
}
