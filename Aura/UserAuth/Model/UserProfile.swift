//
//  UserProfile.swift
//  Aura
//
//  Created by Nabilah Ashriyah on 01/11/20.
//

import Foundation
import CloudKit
import UIKit

public class UserProfile {
    
    // MARK: Properties
    
    public var firstname: String {
        get {
            return UserDefaults.standard.string(forKey: "firstName") ?? ""
        }
        set {
            UserDefaults.standard.removeObject(forKey: "firstName")
            UserDefaults.standard.set(newValue, forKey: "firstName")
        }
    }
    
    public var lastname: String {
        get {
            return UserDefaults.standard.string(forKey: "lastName") ?? ""
        }
        set(newValue) {
            UserDefaults.standard.removeObject(forKey: "lastName")
            UserDefaults.standard.set(newValue, forKey: "lastName")
        }
    }
    
    public var fullname: String {
        return "\(firstname) \(lastname)"
    }
    
    public var userID: String {
        get {
            return UserDefaults.standard.string(forKey: "userid") ?? ""
        }
        set {
            UserDefaults.standard.removeObject(forKey: "userid")
            UserDefaults.standard.set(newValue, forKey: "userid")
        }
    }
    
    public var email: String {
        get {
            return UserDefaults.standard.string(forKey: "registeredEmail") ?? ""
        }
        set {
            UserDefaults.standard.removeObject(forKey: "registeredEmail")
            UserDefaults.standard.set(newValue, forKey: "registeredEmail")
        }
    }
    
    public var username: String {
        get {
            return UserDefaults.standard.string(forKey: "username") ?? ""
        }
        set {
            UserDefaults.standard.removeObject(forKey: "username")
            UserDefaults.standard.set(newValue, forKey: "username")
        }
    }
    
    // MARK: Cloud Database Manager
    
    private let publicDatabase = CKContainer(identifier: "iCloud.nabaash.Aura").publicCloudDatabase
    
    static let shared = UserProfile()
    
    func saveToCloud() {
        let userProfileRecordID = CKRecord.ID(recordName: userID)
        let userProfileRecord = CKRecord(recordType: "UserProfile", recordID: userProfileRecordID)
        
        userProfileRecord["id"] = userID as NSString
        userProfileRecord["firstName"] = firstname as NSString
        userProfileRecord["lastName"] = lastname as NSString
        userProfileRecord["email"] = email as NSString
        userProfileRecord["username"] = username as NSString
    
        publicDatabase.save(userProfileRecord, completionHandler: {
            (record, error) in
            if let error = error {
                // Insert error handling
                print("Error: \(error)")
                return
            }
            // Insert successfully saved record code
            print("user data saved to public!")
            SubscriptionManager.instance.setupSubscription()
        })
    }
    
    func fetchFromCloud(userIdentifier: String) {
        let userProfileRecordID = CKRecord.ID(recordName: userIdentifier)
        publicDatabase.fetch(withRecordID: userProfileRecordID, completionHandler: {(record, error) in
            if ((error) != nil) {
                print("<Failed to fetch userProfileRecord from public database> : \(error!)")
                return
            }
            else {
                guard let userProfileRecord = record else {
                    print("No record found")
                    return
                }
                
                self.username = userProfileRecord["username"] as! String
                self.firstname = userProfileRecord["firstName"] as! String
                self.lastname = userProfileRecord["lastName"] as! String
                self.email = userProfileRecord["email"] as! String

                SubscriptionManager.instance.setupSubscription()
            }
            
        })
    }
    
    func hasAlreadySignedUp(userIdentifier: String, completionHandler: @escaping (Bool?) -> Void ) {
        // check user id in database
        let predicate = NSPredicate(format: "id == %@", userIdentifier)
        let query = CKQuery(recordType: "UserProfile", predicate: predicate)
        publicDatabase.perform(query, inZoneWith: nil, completionHandler: {
            (record, error) in
                if error != nil {
                    print("<Failed to fetch UserProfile from public database> : \(error!)")
                    return
                }
                else {
                    DispatchQueue.main.async {
                        guard let result = record else {
                            print("No ")
                            return
                        }
                        if result.count > 0 {
                            print("User has signed up before")
                            self.userID = userIdentifier
                            // retrieve user data profile from database
                            self.fetchFromCloud(userIdentifier: userIdentifier)
                            completionHandler(true)
                        }
                        else {
                            completionHandler(false)
                        }
                    }
                }
            })

    }
    
    func isUserNameAvailable(username: String, completionHandler: @escaping (Bool?) -> Void) {
        let predicate = NSPredicate(format: "username == %@", username)
        let query = CKQuery(recordType: "UserProfile", predicate: predicate)
        publicDatabase.perform(query, inZoneWith: nil, completionHandler: {
            (result, error) in
                if error != nil {
                    print("<Failed to fetch UserProfile from public database> : \(error!)")
                }
                else {
                    DispatchQueue.main.async {
                        if result!.count > 0 {
                            print("username has already been taken")
                            completionHandler(false)
                        }
                        else {
                            print("username is available")
                            completionHandler(true)
                        }
                    }
                }
            })
    }
    
}
