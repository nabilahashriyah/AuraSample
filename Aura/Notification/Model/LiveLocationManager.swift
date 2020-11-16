//
//  LiveLocationManager.swift
//  Aura
//
//  Created by Nabilah Ashriyah on 11/11/20.
//

import Foundation
import CoreLocation

class LiveLocationManager: NSObject, CLLocationManagerDelegate {
    
    static let instance = LiveLocationManager()
    
    let locationManager = CLLocationManager()
    
    var sendNotif: Bool = false
    
    var lastUpdate: Date = Date()
    
    var i = 0
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        locationManager.distanceFilter = 100 // 15m
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = true
    }
    
    func startLiveLocation() {
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
//            if !CLLocationManager.significantLocationChangeMonitoringAvailable() {
//                // The device does not support this service.
//                return
//            }
//            locationManager.startMonitoringSignificantLocationChanges()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if (error as NSError).code == CLError.locationUnknown.rawValue {
            return
        }
        print("didFailWithError \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last!
        let timeinterval = DateInterval(start: lastUpdate, end: Date()).duration
        if timeinterval > 20 {
            sendNotif = false
        }
        if !sendNotif {
                DispatchQueue.main.async {
                    let recordIDs = NotificationRecord.instance.recordIDs
                    NotificationRecord.instance.updateNotification(generatedRecordID: recordIDs, contentType: .moving)
                    print("oyee\(self.i)")
                }
                lastUpdate = Date()
                sendNotif = true
        }
//        else {
//            if newLocation == lastLocation {
//                let recordIDs = NotificationRecord.instance.recordIDs
//                NotificationRecord.instance.updateNotification(generatedRecordID: recordIDs, contentType: .moving)
//            }
//        }
        print("didUpdateLocations \(newLocation)")
    }
}
