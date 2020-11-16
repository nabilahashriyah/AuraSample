//
//  EmergencyContactView.swift
//  Aura
//
//  Created by Allicia Viona Sagi on 18/10/20.
//

import SwiftUI
import CoreData

struct EmergencyContactView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext

    @FetchRequest(
        entity: Caregiver.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Caregiver.name, ascending: true),
            NSSortDescriptor(keyPath: \Caregiver.phonenumber, ascending: false)
        ]
    ) var languages: FetchedResults<Caregiver>
    
    @State
    private var isActive: Bool = false
    
    var body: some View {
        let one = EmergencyContact( name: "Viona", relationship: "Family", phone: "123456", username: "vionahoho", isPrimary: true)
        let two = EmergencyContact( name: "Totoro", relationship: "Family", phone: "456789", username: "totoro", isPrimary: false)
        let three = EmergencyContact( name: "Anya", relationship: "Friend", phone: "456789", username: "anyaiueo", isPrimary: false)
        let four = EmergencyContact( name: "Jeje", relationship: "Friend", phone: "345678", username: "jjj", isPrimary: false)
        let emergencyContacts = [one, two, three, four]
        NavigationView{
            VStack(alignment: .center) {
                ZStack{
                    Color(hex: "F1F1F1")
                        .ignoresSafeArea()
                    Text("When you experience aura or warnings, Emergency Contacts will help you in an urgent situation by automatically sending help requests to your caregivers. We suggest you adding at least one contact before you use Aura.")
                        .multilineTextAlignment(.leading)
                }
                
                
                List{
                    Section(header:Text("Emergency Contact")){
                        NavigationLink(
                            destination: HealthProfileView(),
                            isActive: self.$isActive,
                            label: {
                                SettingCellWithoutImage(title: "112 ( Default )")
                            }).foregroundColor(.blue)
                    }
                }.listStyle(InsetGroupedListStyle())
                List{
                ForEach(emergencyContacts){ emergencyContact in
                    NavigationLink(destination: HealthProfileView()){
                        Text(emergencyContact.name.capitalized)
                    }
                }
                }.listStyle(InsetGroupedListStyle())
            }
        }
    }
}

//struct EmergencyContactView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmergencyContactView()
//    }
//}
