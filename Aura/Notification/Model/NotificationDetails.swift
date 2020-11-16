//
//  Notification.swift
//  notificationAura
//
//  Created by Nabilah Ashriyah on 12/10/20.
//

import Foundation
import CoreLocation

var isSeizureDetected: Bool = false
var isUserMakingCall: Bool = false

enum TitleType: String {
    case alert = "Alerted"
    case helped = "Helped"
    case nohelp = "Need Help"
    case emergency = "Emergency Called"
    case fivemin = "Seizure occurs more than 5 min"
    case end = "Seizure ended"
    case moving = "Moving"
    
    var localizedString: String {
        switch self {
        case .alert:
            return NSLocalizedString("Alerted", comment: "")
        case .helped:
            return NSLocalizedString(self.rawValue, comment: "")
        case .nohelp:
            return NSLocalizedString(self.rawValue, comment: "")
        case .emergency:
            return NSLocalizedString(self.rawValue, comment: "")
        case .fivemin:
            return NSLocalizedString(self.rawValue, comment: "")
        case .end:
            return NSLocalizedString(self.rawValue, comment: "")
        case .moving:
            return NSLocalizedString(self.rawValue, comment: "")
        }
    }
}

struct NotificationDetails: Identifiable, Hashable {
    var id: String?
    var loc: CLLocation?
    var latitude: Double?
    var longitude: Double?
    var date: Date?
    var sender: String?
    var title: TitleType?
    var addr: String?
}
