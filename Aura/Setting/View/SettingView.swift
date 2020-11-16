//
//  SettingView.swift
//  Aura
//
//  Created by Allicia Viona Sagi on 13/10/20.
//

import SwiftUI
import HealthKit
import Combine

struct SettingView: View {
    
    @EnvironmentObject
    var settings: Settings
    
    @EnvironmentObject
    var healthKit: HealthManagerViewModel
    
    @State
    private var isActive: Bool = false
    
    @Binding var isNavigationBarHidden: Bool
    
    var userProfile = UserProfile()
    
    var body: some View {
        VStack {
            // MARK: - Profile Picture
            CircleImage(image: Image("ProfilePictureExample"))
                .frame(width: 300, height: 97, alignment: .center)
                .padding()
            // MARK: - Name
            Text(userProfile.firstname + " " + userProfile.lastname)
                .font(.largeTitle)
            List {
                // MARK: - Section Medical Details
                Section(header: Text("Medical Details")){
                    Group{
                        // MARK: - Medical ID
                        NavigationLink(destination: HealthProfileView()){
                            Text("Medical ID")
                        }
                        // MARK: - Emergency Contacts
//                        NavigationLink(destination: EmergencyContactView()){
//                            Text("Emergency Contacts")
//                        }
                        // MARK: - Seizure Logs (Minta Stevhen Nama Objectnya)
//                        NavigationLink(destination: EmergencyContactView()){
//                            Text("Seizure Logs")
//                        }
                    }
                }
                // MARK: - Section Settings
                Section(header: Text(NSLocalizedString("Settings", comment: ""))){
                    Group{
                        // MARK: - Picker for Choosing Delay Time
                        Picker(selection: $settings.countdown
                               , label: Text(NSLocalizedString("Delay Time", comment: "")).foregroundColor(.black)
                        ){
                            ForEach(0..<Settings.countdownDurations.count, id: \.self) { index in
                                Text("\(Settings.countdownDurations[index])")
                                    .tag(index)
                            }
                        }
                        
                        // MARK: - Picker for Alert Sounds
//                        Picker(selection: $settings.alertSound
//                               , label: Text(NSLocalizedString("Alert Sounds", comment: "")).foregroundColor(.black)
//                        ){
//                            ForEach(0..<Settings.alertSounds.count, id: \.self) { index in
//                                Text("\(Settings.alertSounds[index])")
//                                    .tag(index)
//                            }
//                        }
                        
                        // MARK: - Apple Health Sync
                        NavigationLink(destination: AppleHealthView()){
//                            SettingCellWithoutImageWithContent(title: "Apple Health", content: UserDefaults.standard.string(forKey: "hkSync")!)
                            SettingCellWithoutImageWithContent(title: "Apple Health", content: healthKit.syncText)
                        }
                        
                        // MARK: - Language
                        NavigationLink(destination: ChooseLanguage()){
                            Text("Language")
                        }
                        
                    }
                }
                
                // MARK: - Section Support
//                Section(header: Text("Support")){
//                    Group{
//                        // MARK: - Seizure First Aid
//                        NavigationLink(destination: HealthProfileView()){
//                            Text("Seizure First Aid")
//                        }
//
//                        // MARK: - Tutorial
//                        NavigationLink(destination: HealthProfileView()){
//                            Text("Tutorial")
//                        }
//
//                        // MARK: - Contact Support
//                        NavigationLink(destination: HealthProfileView()){
//                            Text("Contact Support")
//                        }
//
//                        // MARK: - Contact Support
//                        NavigationLink(destination: HealthProfileView()){
//                            Text("Rate Aura App")
//                        }
//                    }
//                }
                
            }
            .listStyle(InsetGroupedListStyle())
            
        }
        
        .navigationBarTitle("Profile", displayMode: .inline)
        .onAppear {
            self.isNavigationBarHidden = false
        }
    }
}

//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            SettingView().environment(\.locale, .init(identifier: "en"))
//        }
//    }
//}

