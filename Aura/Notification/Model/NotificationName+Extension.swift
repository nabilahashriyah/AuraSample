//
//  NotificationName+Extension.swift
//  Aura
//
//  Created by Nabilah Ashriyah on 10/11/20.
//

import Foundation
import CoreData

extension NotificationName {
    static func fetchQuery(viewContext: NSManagedObjectContext, id: String) -> [NotificationName] {
        let request: NSFetchRequest<NotificationName> = NotificationName.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", id)
        request.predicate = predicate
        let result = try? viewContext.fetch(request)
        return result ?? []
    }
    
    static func fetchAll(viewContext: NSManagedObjectContext) -> [NotificationName] {
        let request: NSFetchRequest<NotificationName> = NotificationName.fetchRequest()
        let result = try? viewContext.fetch(request)
        return result ?? []
    }
    
    static func deleteAll(viewContext: NSManagedObjectContext) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NotificationName")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        let _ = try? viewContext.execute(deleteRequest)
    }
}

extension Caregiver {
    static func fetchAll(viewContext: NSManagedObjectContext) -> [Caregiver] {
        let request: NSFetchRequest<Caregiver> = Caregiver.fetchRequest()
        let result = try? viewContext.fetch(request)
        return result ?? []
    }
}
