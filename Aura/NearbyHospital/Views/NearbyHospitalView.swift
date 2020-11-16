//
//  NearbyHospitalView.swift
//  Aura
//
//  Created by Alldo Kurniawan on 26/10/20.
//

import SwiftUI
import MapKit

struct NearbyHospitalView: View {
    
    @ObservedObject private var locationManager = LocationManager()
    @State private var landmarks: [Landmark] = [Landmark]()
    @State private var search: String = "Hospital"
    @State private var tapped: Bool = false
//    @Binding var isPresented: Bool
    
//    var latitude = CLLocationManager().location?.coordinate.latitude
    
    private func getNearbyLandmark() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.search
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response {
                let mapItems = response.mapItems
                print(mapItems)
//                print("Ini LATITUDE SAYA \(latitude)")
                self.landmarks = mapItems.map {
                    Landmark(placemark: $0.placemark, placePhone: $0)
                }
                
            }
        }
    }
    
    func calculateOffset() -> CGFloat {
        if self.landmarks.count > 0 && !self.tapped {
            return UIScreen.main.bounds.size.height / 1.15
        }
        else if self.tapped {
            return 200
        }
        else {
            return UIScreen.main.bounds.size.height
        }
    }
    
    var body: some View {
        
//        let coordinate = self.locationManager.location != nil ? self.locationManager.location!.coordinate: CLLocationCoordinate2D()
        
        
        ZStack(alignment: .top){
            MapView(landmarks: landmarks)
            TextField("Search", text: self.$search, onEditingChanged: { _ in }) {
                //commit
                self.getNearbyLandmark()
            }.textFieldStyle(RoundedBorderTextFieldStyle()).padding().offset(y: 44)
            
//            PlaceListView(landmarks: landmarks, onTap: {
//
//                //on tap
//                self.tapped.toggle()
//
//            }).animation(.spring()).offset(y: calculateOffset())
            
//            Text("\(coordinate.latitude), \(coordinate.longitude)").foregroundColor(.white).padding().background(Color.green).cornerRadius(50)
        }
    }
}


struct NearbyHospitalView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
