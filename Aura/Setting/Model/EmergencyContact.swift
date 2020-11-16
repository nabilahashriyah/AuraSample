//
//  EmergencyContact.swift
//  Aura
//
//  Created by Allicia Viona Sagi on 10/11/20.
//

import Foundation

class EmergencyContact: Identifiable{
    var id = UUID()
    var name:String!
    var relationship: String!
    var phone: String!
    var username: String!
    var isPrimary: Bool!
    
    init(name: String, relationship: String, phone: String, username: String, isPrimary: Bool) {
        self.name = name
        self.relationship = relationship
        self.phone = phone
        self.username = username
        self.isPrimary = isPrimary
    }
}
