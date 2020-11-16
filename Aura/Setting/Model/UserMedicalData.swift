//
//  User.swift
//  Aura
//
//  Created by Allicia Viona Sagi on 14/10/20.
//

import SwiftUI
import HealthKit

class UserMedicalData: ObservableObject {
    @Published
    var firstName: String!
    
    @Published
    var lastName: String!
    
    @Published
    var dob: String!
    
    @Published
    var sex: String!
    
    @Published
    var bloodType: String!
    
    @Published
    var weight: Double!
    
    @Published
    var height: Double!
}

