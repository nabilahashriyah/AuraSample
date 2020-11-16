//
//  NotificationDetailsView.swift
//  notificationAura
//
//  Created by Nabilah Ashriyah on 12/10/20.
//

import SwiftUI
import Foundation
import CoreLocation
import MapKit

struct NotificationDetailsView: View {
    
    @EnvironmentObject var notifications: NotificationDetailsHelper
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    var notificationName: NotificationName
    
    var pageTitle: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: notificationName.date ?? Date())
    }
        
    var body: some View {
        VStack(alignment: .leading) {
            Map(coordinateRegion: $region)
                //.aspectRatio(414/230, contentMode: .fit)
            VStack(alignment: .leading) {
                Text(notificationName.landmark ?? "No Data Found")
                    .font(.custom(Graphik.semibold.rawValue, size: 22, relativeTo: .body))
                    .foregroundColor(Color("purple50"))
                Text(notificationName.addr ?? "No Data Found")
                    .font(.custom(Graphik.regular.rawValue, size: 12, relativeTo: .body))
                    .fontWeight(.light)
                    .foregroundColor(Color("grayLabel"))
            } .padding(6).padding(.horizontal)
            ScrollView {
                Group {
                    if notifications.dataHasLoaded {
                        ForEach(self.notifications.notifDetails) { notifData in
                            HStack {
                                VStack {
                                    if notifData == notifications.notifDetails.first {
                                        Image(systemName: "circle.fill").font(.caption).foregroundColor(Color.red)
                                    } else {
                                        Image(systemName: "circle.fill").font(.caption).foregroundColor(Color.red.opacity(0.5))
                                    }
                                    Text("")
                                } .padding()
                                VStack(alignment: .leading) {
                                    Text(notifData.title ?? "Seizure Event")
                                        .foregroundColor(.black)
                                        .font(.custom(Graphik.medium.rawValue, size: 17, relativeTo: .body))
                                    HStack {
                                        Text(notifData.addr ?? "Seizure location not found")
                                            .font(.custom(Graphik.regular.rawValue, size: 12, relativeTo: .body))
                                            .fontWeight(.light)
                                            .foregroundColor(Color("grayLabel"))
                                        Spacer()
                                        Text(self.getTimeUnit(notifData.date ?? Date()))
                                            .font(.custom(Graphik.regular.rawValue, size: 12, relativeTo: .body))
                                            .fontWeight(.light)
                                            .foregroundColor(Color("grayLabel"))
                                            .padding(.horizontal)
                                    }
                                }
                            }
                        }
                    }
                    else {
                        Text("Loading Data")
                    }
                } .background(Color.white.cornerRadius(8)).padding()
            } .background(Color("graybg"))
        }
        .navigationBarTitle(pageTitle, displayMode: .inline)
        .onAppear(perform: {
            notifications.dataHasLoaded = false
            notifications.fetchNotificationDetails(self.notificationName)
            if let lat = notifications.notifDetails.first?.latitude {
                if let long = notifications.notifDetails.first?.longitude {
                    region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                }
            }
        })
    }
    
    func getTimeUnit(_ date: Date) -> String {
        let interval = DateInterval(start: date, end: Date())
        let duration = DateComponents.durationToDate(duration: interval.duration)
        
        var result = ""
        
        switch duration.sign {
        case "hours":
            result = "\(duration.hours)" + NSLocalizedString("h", comment: "")
            
        case "minutes":
            result = "\(duration.minutes)m"
            
        case "just now":
            result = NSLocalizedString("Just now", comment: "")
            
        default:
            result = DateComponents.getTime(date)
        }
        return result
    }
}

