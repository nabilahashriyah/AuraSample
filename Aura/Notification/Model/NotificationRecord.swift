//
//  NotificationRecord.swift
//  EpilepsyProject
//
//  Created by Nabilah Ashriyah on 29/07/20.
//  Copyright © 2020 Allicia Viona. All rights reserved.
//

import Foundation
import CloudKit
import CoreLocation
import UIKit
import CoreData

enum ContentType: String {
    case alert = "is having a seizure"
    case helped = "has been helped by someone"
    case nohelp = "is not getting any help"
    case emergency = ": Emergency Number being called"
    case end = ": Seizure has ended"
    case moving = "is moving"
    case fivemin = ": Seizure occurs more than 5 min"
}

// Record event to be sent as notif (user -> caregiver)
class NotificationRecord: ObservableObject {
    
    static let instance = NotificationRecord()
    
    var sender: String {
        /// dummy
//        return "dia"
        return UserProfile().username
    }
    
    var receiver: [String] = ["nabaash"] /// dummy
//    var receiver: [String] {
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let caregiver = Caregiver.fetchAll(viewContext: context)
//        var result: [String] = []
//        for index in 0..<caregiver.count {
//            result.append(caregiver[index].phonenumber ?? "")
//        }
//        return result
//    }
    
    var contentType: ContentType = .alert
    
    var content: String {
        return "\(contentType.rawValue)"
    }
    
    var date: Date {
        return Date()
    }
    
    var location: CLLocation {
//        var loc = CLLocation()
//        if (locationManager.authorizationStatus == .authorizedWhenInUse) {
//            loc = locationManager.location ?? CLLocation()
//        }
//        return loc
        return CLLocation(latitude: 37.33182, longitude: -122.03118) /// dummy
    }
    
    var recordIDs: [String] {
        get {
            return ((UserDefaults.standard.object(forKey: "recordIDs") as? [String] ?? []) )
        }
        set {
            UserDefaults.standard.removeObject(forKey: "recordIDs")
            UserDefaults.standard.set(newValue, forKey: "recordIDs")
        }
    }
    
    var helpStatus: Bool = false
    var seizureStatus: Bool = true
    
    private let publicDatabase = CKContainer(identifier: "iCloud.nabaash.Aura").publicCloudDatabase
    
    private var locationManager = CLLocationManager()
    
    func sendNotification(generatedRecordID: [String]) {
        contentType = .alert
        if !generatedRecordID.isEmpty {
            for index in 0..<generatedRecordID.count {
                let notificationRecordID = CKRecord.ID(recordName: generatedRecordID[index])
                let notificationRecord = CKRecord(recordType: "Notification", recordID: notificationRecordID)
                
                notificationRecord["id"] = generatedRecordID[index] as NSString
                notificationRecord["sender"] = sender as NSString
                notificationRecord["receiver"] = receiver[index] as NSString
                notificationRecord["content"] = content as NSString
                notificationRecord["location"] = location as CLLocation
                notificationRecord["date"] = date as NSDate
                
                publicDatabase.save(notificationRecord) {
                    (record, error) in
                    if let error = error {
                        // Insert error handling
                        print("Error saving: \(error)")
                    } else {
                        // Insert successfully saved record code
                        print("Notification sent!")
                    }
                }
            }
        }
    }
    
    func generateNotificationRecordID() -> [String] {
        var arrayRecordID: [String] = []
        if (receiver.count > 0) && (sender != "") {
            for receiverUsername in receiver {
                let date = Date()
                
                let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
                
                let datetime = "\(components.year!)\(components.month!)\(components.day!)\(components.hour!)\(components.minute!)\(components.second!)"
                let recordID = sender.uppercased() + receiverUsername.uppercased() + datetime
                
                arrayRecordID.append(recordID)
            }
        }
        return arrayRecordID
    }
    
    func updateNotification(generatedRecordID: [String], contentType: ContentType) {
        self.contentType = contentType
        // Fetch the record from the database
        for recordID in generatedRecordID {
            let notificationRecordID = CKRecord.ID(recordName: recordID)
            
            publicDatabase.fetch(withRecordID: notificationRecordID, completionHandler: { [self] (record, error) in
                if let err = error {
                    print("Failed fetching record: \(err)")
                    return
                } else {
                    guard let notificationRecord = record else {
                        print("No record found")
                        return
                    }
                    
                    notificationRecord["content"] = self.content as NSString
                    notificationRecord["location"] = self.location as CLLocation
                    notificationRecord["date"] = self.date as NSDate
                    
                    publicDatabase.save(notificationRecord, completionHandler: { (savedrecord, error) in
                        if let err = error {
                            print("Failed update record: \(err)")
                        } else {
                            print("Notification record updated")
                        }
                    })
                }
            })
        }
    }
    
    static func startUpdatingNotification() {
        DispatchQueue.main.async {
            let generatedRecordIDs = self.instance.generateNotificationRecordID()
            self.instance.recordIDs = generatedRecordIDs
            self.instance.sendNotification(generatedRecordID: generatedRecordIDs)
            LiveLocationManager.instance.startLiveLocation()
            isSeizureDetected = true
        }
    }
    
    static func stopUpdatingNotification() {
        DispatchQueue.main.async {
            if isSeizureDetected {
                let recordIDs = NotificationRecord.instance.recordIDs
                NotificationRecord.instance.updateNotification(generatedRecordID: recordIDs, contentType: .end)
                NotificationRecord.instance.recordIDs.removeAll()
                LiveLocationManager.instance.locationManager.stopUpdatingLocation()
                isSeizureDetected = false
            }
        }
    }
}
