//
//  SceneDelegate.swift
//  Aura
//
//  Created by Stevhen on 30/09/20.
//

import UIKit
import SwiftUI
import PartialSheet
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        // Create the SwiftUI view that provides the window contents.
        let sheetManager = PartialSheetManager()
        let settings = Settings()
        let healthKit = HealthManagerViewModel()
//        let notifications = NotificationDetailsHelper()
//        let navigationManager = NavigationManager()
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            let contentView = SplashView()
                .environmentObject(sheetManager)
                .environmentObject(settings)
                .environmentObject(healthKit)
//                .environmentObject(notifications)
//                .environment(\.managedObjectContext, context)
            
            window.rootViewController = UIHostingController(rootView: contentView)
            
            self.window = window
            window.makeKeyAndVisible()
        }
        
        if let shortcutItem = connectionOptions.shortcutItem {
            if shortcutItem.type == "Alert Surroundings" {
                let contentView = HomePageView(showingDelay: true)
                    .environmentObject(sheetManager)
                    .environmentObject(settings)
                    .environmentObject(healthKit)
//                    .environmentObject(notifications)
                
                window?.rootViewController = UIHostingController(rootView: contentView)
                
                window?.makeKeyAndVisible()
            }
        }
        
    }
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let sheetManager = PartialSheetManager()
        let settings = Settings()
        let healthKit = HealthManagerViewModel()
//        let notifications = NotificationDetailsHelper()
        
        let contentView = HomePageView(showingDelay: true)
            .environmentObject(sheetManager)
            .environmentObject(settings)
            .environmentObject(healthKit)
//            .environmentObject(notifications)
        
        window?.rootViewController? = UIHostingController(rootView: contentView)
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        var shortcutItems = UIApplication.shared.shortcutItems ?? []
        
        if shortcutItems.isEmpty {
            shortcutItems += [
                UIApplicationShortcutItem(
                    type: "Alert Surroundings",
                    localizedTitle: NSLocalizedString("Alert Surroundings", comment: ""),
                    localizedSubtitle: nil,
                    icon: UIApplicationShortcutIcon(templateImageName: "HSQA_black")
                )
            ]
        } else {
            if let mutableShortcutItem = shortcutItems.first?.mutableCopy() as? UIMutableApplicationShortcutItem {
                mutableShortcutItem.type = "Alert Surroundings"
                mutableShortcutItem.localizedTitle = NSLocalizedString("Alert Surroundings", comment: "")
                mutableShortcutItem.icon = UIApplicationShortcutIcon(templateImageName: "HSQA_black")
                shortcutItems[0] = mutableShortcutItem
            }
        }
        
        UIApplication.shared.shortcutItems = shortcutItems
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        //        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

