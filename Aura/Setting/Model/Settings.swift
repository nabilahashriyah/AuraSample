//
//  Settings.swift
//  Aura
//
//  Created by Allicia Viona Sagi on 15/10/20.
//

import Foundation
import SwiftUI
import Combine

class Settings: ObservableObject {
    @Published
    var showSettings = false
    
    static var countdownDurations = [10, 15, 20, 25, 30]
    static var appLanguages = ["Indonesia","English"]
    static var faLanguages = ["Indonesia","English"]
    static var alertSounds = ["Chimes","Radar","Default"]
    
    @Published
    var delay_time = 10
    
    @Published
    var app_language = "English"
    
    @Published
    var fa_language = "English"
    
    @Published
    var alert_sound = "Default"
    
    @Published
    var lang: String = "en"
    
//    in_ID
    
    @Published
    var appLanguage: Int{
        didSet{
            UserDefaults.standard.set(appLanguage, forKey: "appLanguage")
            app_language = Settings.appLanguages[appLanguage]
            print(app_language)
            
            if app_language == "Indonesia"{
                lang = "id_ID"
            }else{
                lang = "en"
            }
            
            UserDefaults.standard.set([lang], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            print(lang)
        }
    }
    
    @Published
    var countdown: Int{
        didSet{
            UserDefaults.standard.set(countdown, forKey: "countdown")
            delay_time = Settings.countdownDurations[countdown]
            print(delay_time)
        }
    }
    
    @Published
    var firstAidLanguage: Int{
        didSet{
            UserDefaults.standard.set(firstAidLanguage, forKey: "firstAidLanguage")
            fa_language = Settings.faLanguages[firstAidLanguage]
            print(fa_language)
        }
    }
    
    @Published
    var alertSound: Int{
        didSet{
            UserDefaults.standard.set(alertSound, forKey: "alertSound")
            alert_sound = Settings.alertSounds[alertSound]
            print(alert_sound)
        }
    }
    
    
    init() {
        self.countdown = UserDefaults.standard.object(forKey: "countdown") as? Int ?? 0
        self.appLanguage = UserDefaults.standard.object(forKey: "appLanguage") as? Int ?? 0
        self.firstAidLanguage = UserDefaults.standard.object(forKey: "firstAidLanguage") as? Int ?? 0
        self.alertSound = UserDefaults.standard.object(forKey: "alertSound") as? Int ?? 0
    }
    
    
    
    
}
