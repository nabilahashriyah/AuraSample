//
//  SubscriptionManager.swift
//  EpilepsyProject
//
//  Created by Nabilah Ashriyah on 03/08/20.
//  Copyright © 2020 Allicia Viona. All rights reserved.
//

import CloudKit

class SubscriptionManager {
    
    static let instance = SubscriptionManager()
    
    var username: String {
//        return UserProfile().username
        return "nabaash"  /// dummy
    }
    
    var subscriptionID: CKQuerySubscription.ID?
    
    private var subscription: CKQuerySubscription?
    
    let publicDatabase = CKContainer(identifier: "iCloud.nabaash.Aura").publicCloudDatabase
    
    func setupSubscription() {
        subscription = CKQuerySubscription(recordType: "Notification", predicate: NSPredicate(format: "receiver == %@", username), options: .firesOnRecordCreation)
        subscriptionID = subscription?.subscriptionID
        notificationSetUp()
        saveSubscription()
        
        subscription = CKQuerySubscription(recordType: "Notification", predicate: NSPredicate(format: "receiver == %@", username), options: .firesOnRecordUpdate)
        subscriptionID = subscription?.subscriptionID
        notificationSetUp()
        saveSubscription()
    }
    
    func setupSubscriptionLiveLocation() {
        subscription = CKQuerySubscription(recordType: "LiveLocation", predicate: NSPredicate(format: "receiver == %@", username), options: .firesOnRecordCreation)
        subscriptionID = subscription?.subscriptionID
        saveSubscription()
    }
    
    func notificationSetUp() {
        // Here we customize the notification message
        let info = CKSubscription.NotificationInfo()
        
        info.titleLocalizationKey = "Seizure Alert"
        
        info.alertLocalizationKey = "%1$@ %2$@"
        info.alertLocalizationArgs = ["sender", "content"]
        
        info.desiredKeys = ["content", "date", "location"]
        
        // increment the red number count on the top right corner of app icon
        info.shouldBadge = false
        
        info.shouldSendContentAvailable = true
        
        // use system default notification sound
        info.soundName = "default"
        
        subscription?.notificationInfo = info
    }
    
    func notificationLiveLocationSetUp() {
        // Here we customize the notification message
        let info = CKSubscription.NotificationInfo()
        
        info.titleLocalizationKey = "Live Location Alert"
        
        info.alertLocalizationKey = "From %1$@"
        info.alertLocalizationArgs = ["sender"]
        
        info.desiredKeys = ["location"]
        
        // increment the red number count on the top right corner of app icon
//        info.shouldBadge = false
        
        // use system default notification sound
        info.soundName = "default"
        
        subscription?.notificationInfo = info
    }
    
    func saveSubscription() {
        // Save the subscription to Public Database in CloudKit
        publicDatabase.save(subscription!, completionHandler: { subscription, error in
            if error == nil {
                // Subscription saved successfully
                print("Subs OK")
            } else {
                // Error occurred
                print("Subscription failed!: \(error!)")
            }
        })
    }
    
}
