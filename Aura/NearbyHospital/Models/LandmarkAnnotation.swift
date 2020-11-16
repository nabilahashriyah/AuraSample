//
//  LandmarkAnnotation.swift
//  MapApple1
//
//  Created by Alldo Kurniawan on 14/10/20.
//

import Foundation
import MapKit

final class LandmarkAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(landmark: Landmark) {
        self.title = landmark.name
        self.coordinate = landmark.coordinate
    }
}
