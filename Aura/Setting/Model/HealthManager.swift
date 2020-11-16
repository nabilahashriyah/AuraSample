//
//  HealthManager.swift
//  Aura
//
//  Created by Allicia Viona Sagi on 04/11/20.
//

import Foundation
import HealthKit
import Combine

/// To connect swiftui view and HK model
class HealthManagerViewModel: ObservableObject {
    
    public var healthManager = HealthManager()
    public var isInitialized = false
    
    @Published
    var isHealthKitSynced: Bool!{
        didSet{
            if isHealthKitSynced == false{
                syncText = "Off"
                UserDefaults.standard.set(syncText, forKey: "hkSync")
                healthManager.setGender(gender: "Not Synced")
                healthManager.setBirthday(birthday: "Not Synced")
                healthManager.setHeight(height: 0.0)
                healthManager.setWeight(weight: 0.0)
                healthManager.setBloodType(bloodType: "Not Synced")
                isInitialized = false
            }else{
                syncText = "On"
                UserDefaults.standard.set(syncText, forKey: "hkSync")
                if !isInitialized{
                    request()
                }
            }
        }
    }
    
    @Published
    var syncText: String!
    
    /// Initialize HealthManagerViewModel, checking HealthKit Availability in device
    init(){
        syncText = "Off"
        isHealthKitSynced = false
        UserDefaults.standard.set(syncText, forKey: "hkSync")
        print("Initializing Health Manager")
        isInitialized = true
    }
    
    public func request() {
        if HKHealthStore.isHealthDataAvailable() {
            print("Yes, HealthKit is Available")
            healthManager = HealthManager()
            healthManager.requestPermissions()
            
            if !isHealthKitSynced{
                isHealthKitSynced = true
            }
            syncText = "On"
            UserDefaults.standard.set(syncText, forKey: "hkSync")
        } else {
            print("There is a problem accessing HealthKit")
            isHealthKitSynced = false
            syncText = "Off"
        }
        
    }
}

class HealthManager: ObservableObject {
    
    public let healthStore = HKHealthStore()
    public var userMedicalData = UserMedicalData()
    
    /// Request permission for accessing HealthKit
    public func requestPermissions(){
        if HKHealthStore.isHealthDataAvailable() {
            let readDataTypes : Set = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!,
                                       HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!,
                                       HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.biologicalSex)!,
                                       HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.bloodType)!,
                                       HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.dateOfBirth)!]
            
            healthStore.requestAuthorization(toShare: [], read: readDataTypes) { (success, error) in
                if !success {
                    // Handle the error here.
                    print("eh error auth")
                } else {
                    print("masuk sukses")
                    self.getCharacteristics()
                }
            }
        }
    }
    
    /// Function to change/set user gender
    /// - Parameter gender: Gender from HealthKit
    func setGender(gender: String){
        userMedicalData.sex = gender
    }
    
    /// Function to change/set user blood type
    /// - Parameter bloodType: Bloodtype from HealthKit
    func setBloodType(bloodType: String){
        userMedicalData.bloodType = bloodType
    }
    
    /// Function to change/set users height
    /// - Parameter height: Height from HealthKit
    func setHeight(height: Double){
        userMedicalData.height = height*100
    }
    
    /// Function to change/set users weight
    /// - Parameter weight: Weight from HealthKit
    func setWeight(weight: Double){
        userMedicalData.weight = weight/1000
    }
    
    /// Function to change/set birthday
    /// - Parameter birthday: Birthdate from Healthkit
    func setBirthday(birthday: String){
        userMedicalData.dob = birthday
    }
    
    /// Get values from HealthKit
    func getCharacteristics(){
        // MARK: - Get Gender Value
        if try! healthStore.biologicalSex().biologicalSex == HKBiologicalSex.female {
            setGender(gender: "Female")
            print("Femme")
        } else if try! healthStore.biologicalSex().biologicalSex == HKBiologicalSex.male {
            setGender(gender: "Male")
        } else if try! healthStore.biologicalSex().biologicalSex == HKBiologicalSex.other {
            setGender(gender: "Not Set")
            print("Not Set! Error Gender")
        }else{
            setGender(gender: "Not Synced")
        }
        
        // MARK: - Get Date of Birth
        do {
//            try healthStore.dateOfBirthComponents()
            let dob = try healthStore.dateOfBirthComponents()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            let bday = dateFormatter.string(from: dob.date ?? Date())
            setBirthday(birthday: bday)
        } catch  {
            print("Error get date of birth")
            setBirthday(birthday: "Not Synced")
        }
        
        // MARK: - Get Blood Type Value
        if try! healthStore.bloodType().bloodType == HKBloodType.aNegative {
            setBloodType(bloodType: "A-")
        } else if try! healthStore.bloodType().bloodType == HKBloodType.aPositive {
            setBloodType(bloodType: "A+")
        } else if try! healthStore.bloodType().bloodType == HKBloodType.abNegative {
            setBloodType(bloodType: "AB-")
        } else if try! healthStore.bloodType().bloodType == HKBloodType.abPositive {
            setBloodType(bloodType: "AB+")
        } else if try! healthStore.bloodType().bloodType == HKBloodType.bNegative {
            setBloodType(bloodType: "B-")
        } else if try! healthStore.bloodType().bloodType == HKBloodType.bPositive {
            setBloodType(bloodType: "B+")
        } else if try! healthStore.bloodType().bloodType == HKBloodType.oNegative {
            setBloodType(bloodType: "O-")
        } else if try! healthStore.bloodType().bloodType == HKBloodType.oPositive {
            setBloodType(bloodType: "O+")
        }else{
            setBloodType(bloodType: "Not Synced")
        }
        
        // MARK: - Get Height Value
        getRecentHeight()
        
        // MARK: - Get Weight Value
        getRecentWeight()
        
    }
    
    
    /// Fetch Sample Data from HealthKit
    func getMostRecentSample(for sampleType: HKSampleType,
                             completion: @escaping (HKQuantitySample?, Error?) -> Swift.Void) {
        
        //1. Use HKQuery to load the most recent samples.
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: Date.distantPast,
                                                              end: Date(),
                                                              options: .strictEndDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                              ascending: false)
        
        let limit = 1
        
        let sampleQuery = HKSampleQuery(sampleType: sampleType,
                                        predicate: mostRecentPredicate,
                                        limit: limit,
                                        sortDescriptors: [sortDescriptor]) { (query, samples, error) in
            
            //2. Always dispatch to the main thread when complete.
            DispatchQueue.main.async {
                
                guard let samples = samples,
                      let mostRecentSample = samples.first as? HKQuantitySample else {
                    
                    completion(nil, error)
                    return
                }
                
                completion(mostRecentSample, nil)
            }
        }
        
        HKHealthStore().execute(sampleQuery)
    }
    
    /// Display recent height
    func getRecentHeight(){
        //1. Use HealthKit to create the Height Sample Type
        guard let heightSampleType = HKSampleType.quantityType(forIdentifier: .height) else {
          print("Height Sample Type is no longer available in HealthKit")
          return
        }
            
        getMostRecentSample(for: heightSampleType) { (sample, error) in
              
          guard let sample = sample else {
              
            if let _ = error {
              print("Error getting most recent height sample :(")
            }
                
            return
          }
            
          let heightInMeters = sample.quantity.doubleValue(for: HKUnit.meter())
          self.setHeight(height: heightInMeters)
        }
    }
    
    func getRecentWeight(){
        
        guard let weightSampleType = HKSampleType.quantityType(forIdentifier: .bodyMass) else {
          print("bodyMass Sample Type is no longer available in HealthKit")
          return
        }
            
        getMostRecentSample(for: weightSampleType) { (sample, error) in
              
          guard let sample = sample else {
              
            if let _ = error {
              print("Error getting most recent body mass sample :(")
            }
                
            return
          }
        
         let weightInGram = sample.quantity.doubleValue(for: HKUnit.gram())
         self.setWeight(weight: weightInGram)
        
        }
    }
}

