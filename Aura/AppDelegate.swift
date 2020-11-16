//
//  AppDelegate.swift
//  Aura
//
//  Created by Stevhen on 30/09/20.
//

import UIKit
import UserNotifications
import CloudKit
import CoreLocation
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window : UIWindow?
    
    private let locationManager = CLLocationManager()
    
    private func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UNUserNotificationCenter.current().delegate = self
       
        // Detect first launch
        if !isKeyPresentInUserDefaults(key: "isOnboarded") {
            UserDefaults.standard.set("0", forKey: "countdown")
            //Language: 1 for EN, 0 for ID
            UserDefaults.standard.set("0", forKey: "appLanguage")
            UserDefaults.standard.set("0", forKey: "alertSound")
            UserDefaults.standard.set("1", forKey: "firstAidLanguage")
            UserDefaults.standard.set(false, forKey: "isOnboarded")
        }
        
        return true
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: Remote Notification Manager
    func pushNotificationAuthorization() {
        /// Ask user permission for sending push notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { authorized, error in
            if authorized {
                DispatchQueue.main.async(execute: {
                    UIApplication.shared.registerForRemoteNotifications()
                })
            }
        })
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let remoteNotification = CKNotification(fromRemoteNotificationDictionary: userInfo as! [String : NSObject])
        
        print("bg fetch notif")
        if (remoteNotification?.notificationType ==
                CKNotification.NotificationType.query) {
            print("bg fetch notif 2")
            let queryNotification =
                remoteNotification as! CKQueryNotification
            
            if let recordID = queryNotification.recordID {
                print("bg fetch notif 3")
//                DispatchQueue.main.async {
//                    let notificationManager = NotificationManager()
//                    notificationManager.fetchNotification(recordID)
//                }
                completionHandler(.newData)
            } else {
                completionHandler(.noData)
            }
            
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let application = UIApplication.shared
        
        if(application.applicationState == .active){
            print("app received notification while in foreground")
            // show the notification alert (banner), and with sound
            completionHandler([.sound, .banner])
        } else {
            // show the notification alert (banner), and with sound
            completionHandler([.list, .sound, .banner, .badge])
        }
        
//        if let aps = userInfo["aps"] as? NSDictionary {
//            if let content = aps["content"] as? NSString {
//                if content as String == ContentType.moving.rawValue {
//                    completionHandler(.sound)
//                }
//            }
//        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let application = UIApplication.shared
        UIApplication.shared.applicationIconBadgeNumber = 0
        if(application.applicationState == .active){
            print("user tapped the notification bar when the app is in foreground")
        }
        
        if(application.applicationState == .inactive)
        {
            print("user tapped the notification bar when the app is in background")
        }
        NotificationCenter.default.post(name: NSNotification.Name("SeizureEvent"), object: nil)
        // tell the app that we have finished processing the user’s action / response
        completionHandler()
    }
    
    func setupApp() {
        pushNotificationAuthorization()
        DispatchQueue.main.async(execute: {
            self.locationManager.requestWhenInUseAuthorization()
        })
    }
    
    // MARK: - Core Data Saving support
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UsersDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    
}

