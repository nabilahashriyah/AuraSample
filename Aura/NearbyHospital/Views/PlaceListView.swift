//
//  PlaceListView.swift
//  MapApple1
//
//  Created by Alldo Kurniawan on 14/10/20.
//

import SwiftUI
import MapKit

struct PlaceListView: View {
    
    //    var landmarks: [Landmark]
    let myLocationManager = LocationManager()
    @State private var landmarks: [Landmark] = [Landmark]()
    @State private var search: String = "Hospital"
    
    @State var statusPhoneNumber = false
    
    //Tap Gesture
    //    var onTap: () -> ()
    
    private func getNearbyLandmark(){
        let request = MKLocalSearch.Request()
        request.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: myLocationManager.myLatitude, longitude: myLocationManager.myLongitude), latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        request.naturalLanguageQuery = self.search
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response {
                let mapItems = response.mapItems
                print(mapItems)
                //                print("Ini LATITUDE SAYA \(latitude)")
                self.landmarks = landmarks.sorted {
                    $0.distance < $1.distance
                }
                
                self.landmarks = mapItems.map {
                    Landmark(placemark: $0.placemark, placePhone: $0)
                }
                
            }
//            if landmarks.count == 10 {
//                search.cancel()
//            }
        }
    }
    
    
    func getSortedLandmarks() -> [Landmark] {
        let sortedLandmarks = landmarks.sorted {
            $0.distance < $1.distance
        }
        return sortedLandmarks
    }
    
    var body: some View {
        //        VStack(alignment: .leading){
        //            HStack{
        //                EmptyView()
        //            }.frame(width: UIScreen.main.bounds.width, height: 60, alignment: .center).background(Color.gray)
        //            .gesture(TapGesture().onEnded(self.onTap))
        VStack{
            Spacer()
            List {
                ForEach(landmarks, id: \.id) { landmark in
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 8).fill(Color.white).opacity(1).shadow(color: .gray, radius: 1, x: 1, y: 1)
                        
                        VStack{
                            HStack{
                                VStack(alignment: .leading){
                                    Text(landmark.name).font(.custom("Graphik-Bold", size: 17))
                                        .lineLimit(1)
                                    Text(landmark.title).font(.custom("Graphik-Regular", size: 12)).foregroundColor(.black)
                                        .lineLimit(1)
                                }.padding(5)
                                
                                Text("\(landmark.distance / 1000, specifier: "%.1f")Km").font(.custom("Graphik-Regular", size: 12)).foregroundColor(.gray).padding()
                            }
                            
                            
                            HStack{
                                Spacer()
                                Button("Open Maps") {
                                    
                                }.foregroundColor(.white)
                                .frame(width: 171, height: 45, alignment: .center)
                                .background(Color.purpleColor)
                                .font(.custom("Graphik-Regular", size: 17))
                                .cornerRadius(8).onTapGesture(count: 1, perform: {
                                    print("Direct\(landmark.coordinate.latitude)")
                                    if(UIApplication.shared.canOpenURL(URL(string:"http://maps.apple.com")!)) {
                                        UIApplication.shared.open(URL(string:
                                                                        "http://maps.apple.com/?saddr=\(landmark.coordinate.latitude),\(landmark.coordinate.longitude)&daddr=\(myLocationManager.myLatitude),\(myLocationManager.myLongitude)")!)
                                    } else {
                                        NSLog("Can't use Apple Maps");
                                    }
                                })
                                .padding()
                                .frame(width: 150, height: 50, alignment: .center)
                                
                                Spacer()
                                
                                Button(action: {
                                    let telephone = "tel://"
                                    let formattedString = telephone + landmark.phoneNumber.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                                    if landmark.phoneNumber != "" {
                                        guard let url = URL(string: formattedString) else { return }
                                        UIApplication.shared.open(url)
                                        print("Calling \(landmark.phoneNumber)")
                                    } else {
                                        self.statusPhoneNumber = true
                                    }
                                    
                                    
                                }) {
                                    Text("Call").padding().frame(width: 150, height: 50, alignment: .center)
                                }
                                .foregroundColor(.white)
                                .font(.custom("Graphik-Regular", size: 17))
                                .frame(width: 171, height: 45, alignment: .center)
                                .background(Color.orangeColor)
                                .cornerRadius(8)
                                .padding(10)
                                
                            }
                        }
                        .padding(.vertical, 5)
                    }
                    .padding(.vertical, 5)
                    .frame(width: 382, height: 135, alignment: .center)
                }.animation(nil)
                .listRowBackground(Color.grayBackgroundColor)
                .ignoresSafeArea()
            }
            .navigationBarTitle("Nearby Hospital", displayMode: .inline)
            .cornerRadius(10)
            .alert(isPresented: $statusPhoneNumber, content: {
                Alert(title: Text("Alert"), message: Text("This Hospital Has No Phone Number"), dismissButton: .default(Text("OK")))
            })
            .onAppear {
                self.getNearbyLandmark()
            }
            Spacer()
        }
    }
}

//    struct PlaceListView_Previews: PreviewProvider {
//        static var previews: some View {
//            PlaceListView(landmarks: [Landmark(placemark: MKPlacemark())], onTap: {} )
//        }
//    }


struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
    }
}

extension Color {
    static let orangeColor = Color("orange_color_button")
    static let purpleColor = Color("purple_color_button")
    static let grayBackgroundColor = Color("background_color_gray")
}
