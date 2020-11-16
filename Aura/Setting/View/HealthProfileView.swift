//
//  HealthProfileView.swift
//  Aura
//
//  Created by Allicia Viona Sagi on 14/10/20.
//

import SwiftUI
import HealthKit

struct HealthProfileView: View {
    
    @EnvironmentObject
    var healthKit: HealthManagerViewModel
    
    var userProfile = UserProfile()
    
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Spacer()
                }
                
                CircleImage(image: Image("ProfilePictureExample"))
                    .frame(width: 300, height: 97, alignment: .center)
                Text(userProfile.firstname + " " + userProfile.lastname)
                    .font(.largeTitle)
                List{
                    SettingCellWithContentNormal(title: "First Name", content: userProfile.firstname)
                    SettingCellWithContentNormal(title: "Last Name", content: userProfile.lastname)
                    SettingCellWithContentNormal(title: "Date of Birth", content: healthKit.healthManager.userMedicalData.dob ?? "Not Synced")
                    SettingCellWithContentNormal(title: "Sex", content: healthKit.healthManager.userMedicalData.sex ?? "Not Synced")
                    SettingCellWithContentNormal(title: "Blood Type", content: healthKit.healthManager.userMedicalData.bloodType ?? "Not Synced")
                    SettingCellWithContentNormal(title: "Weight", content: String(format: "%.0f kg", healthKit.healthManager.userMedicalData.weight ?? 0.0))
                    SettingCellWithContentNormal(title: "Height", content: "\(healthKit.healthManager.userMedicalData.height ?? 0) cm")
                }
            }
        }
    }
    
    func updateProfile() {
        print("Update profile")
    }
    
}

struct HealthProfileView_Previews: PreviewProvider {
    static var previews: some View {
        HealthProfileView()
    }
}
