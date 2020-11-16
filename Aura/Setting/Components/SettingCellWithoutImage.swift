//
//  SettingCellWithoutImage.swift
//  Aura
//
//  Created by Allicia Viona Sagi on 13/10/20.
//

import SwiftUI

struct SettingCellWithoutImage: View {
    
    var title: String
    
    var body: some View {
        HStack{
            Text(title)
                .font(.body)
            
            Spacer()
            
        }
    }
}

struct SettingCellWithoutImage_Previews: PreviewProvider {
    static var previews: some View {
        SettingCellWithoutImage(title: "Health Profile")
    }
}
