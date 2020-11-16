//
//  AppleHealthView.swift
//  Aura
//
//  Created by Allicia Viona Sagi on 09/11/20.
//

import SwiftUI

struct AppleHealthView: View {
    
    @EnvironmentObject
    var healthKit: HealthManagerViewModel
    
    @State
    var isHealthSync: Bool = true
    var body: some View {
        List{
            Toggle(isOn: $healthKit.isHealthKitSynced){
                    Text("Apple Health Sync")
                }
        }.listStyle(InsetGroupedListStyle())
    }
}

struct AppleHealthView_Previews: PreviewProvider {
    static var previews: some View {
        AppleHealthView()
    }
}
