//
//  NotificationDetailsHelper.swift
//  Aura
//
//  Created by Nabilah Ashriyah on 04/11/20.
//

import Foundation
import CoreLocation
import UIKit
import Combine
import CoreData

class NotificationDetailsHelper: ObservableObject {
    
    @Published var dataHasLoaded = false
    
    @Published var notifs = [NotificationName]()
    
    @Published var notifDetails = [NotificationList]()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchNotification() {
        notifs.removeAll()
        notifs = NotificationName.fetchAll(viewContext: context)
        notifs = notifs.sorted { $0.date! > $1.date! }
        self.dataHasLoaded = true
    }
    
    func fetchNotificationDetails(_ notificationName: NotificationName) {
        notifDetails.removeAll()
        notifDetails = notificationName.details?.allObjects as! [NotificationList]
        notifDetails = notifDetails.sorted { $0.date! > $1.date! }
        self.dataHasLoaded = true
    }
}
