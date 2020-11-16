//
//  NotificationManager.swift
//  Aura
//
//  Created by Nabilah Ashriyah on 07/11/20.
//

import Foundation
import CloudKit
import UIKit

class NotificationManager {

    private let publicDatabase = CKContainer(identifier: "iCloud.nabaash.Aura").publicCloudDatabase
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var landmark: String = ""
    
    var notificationDetails = NotificationDetails()
    
    func fetchNotification(_ recordID: CKRecord.ID) -> Void {
        print("berhasil kesini")
        publicDatabase.fetch(withRecordID: recordID, completionHandler: retrieveDataFromCloud)
    }
    
    func retrieveDataFromCloud(record: CKRecord?, error: Error?) {
        guard error == nil else {
            print("Error getting location name: \(error!)")
            return
        }
        
        guard let records = record else {
            print("No Data")
            return
        }
        
        DispatchQueue.main.async {
            self.notificationDetails.id = records["id"] as? String
            self.notificationDetails.date = records["date"] as? Date
            self.notificationDetails.sender =  records["sender"] as? String
            
            let content =  records["content"] as? String
            self.defineTitle(content: content!)
            
            let location =  records["location"] as? CLLocation
            self.notificationDetails.loc = location
            self.getLocationName(loc: location ?? CLLocation())
        }
    }
    
    func saveNotificationLocally() {
        let notificationList = NotificationList(context: context)
        notificationList.date = notificationDetails.date
        notificationList.latitude = Double(notificationDetails.loc?.coordinate.latitude ?? 0)
        notificationList.longitude = Double(notificationDetails.loc?.coordinate.longitude ?? 0)
        notificationList.title = notificationDetails.title?.rawValue
        notificationList.sender = notificationDetails.sender
        notificationList.addr = notificationDetails.addr
        
        if let notifID = notificationDetails.id {
            let notificationNames = NotificationName.fetchQuery(viewContext: context, id: notifID)
            print(notificationNames.count)
            if notificationNames.isEmpty {
                let notificationName = NotificationName(context: context)
                notificationName.id = notificationDetails.id
                notificationName.addr = notificationDetails.addr
                notificationName.date = notificationDetails.date
                notificationName.landmark = self.landmark
                notificationName.addToDetails(notificationList)
                
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                let notificationName = notificationNames[0]
//                let prevNotificationList = notificationName.details?.allObjects as! [NotificationList]
                notificationName.addToDetails(notificationList)
                
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getLocationName(loc: CLLocation) {
        // Use the last reported location.
        let geocoder = CLGeocoder()
        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(loc, completionHandler: { (placemarks, error) in
            guard error == nil else {
                print("Error getting location name: \(error!)")
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("No Data")
                return
            }
            
            DispatchQueue.main.async {
                let locationName = "\(placemark.thoroughfare ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? "")"
                self.notificationDetails.addr = locationName
                self.landmark = placemark.name ?? locationName
                self.saveNotificationLocally()
            }
        })
    }
}

extension NotificationManager {
    func defineTitle(content: String) {
        let contentType = ContentType(rawValue: content)
        switch contentType {
        case .alert:
            self.notificationDetails.title = .alert
        case .emergency:
            self.notificationDetails.title = .emergency
        case .helped:
            self.notificationDetails.title = .helped
        case .nohelp:
            self.notificationDetails.title = .nohelp
        case .end:
            self.notificationDetails.title = .end
        case .moving:
            self.notificationDetails.title = .moving
        case .fivemin:
            self.notificationDetails.title = .fivemin
        case .none:
            return
        }
    }
}
