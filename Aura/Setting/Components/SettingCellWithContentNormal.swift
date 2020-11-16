//
//  SettingCellWithContentNormal.swift
//  Aura
//
//  Created by Allicia Viona Sagi on 14/10/20.
//

import SwiftUI

struct SettingCellWithContentNormal: View {
    var title: String
    var content: String
    
    var body: some View {
        HStack{
            Text(title)
                .font(.body)
                .padding(.leading, 16)
            
            Spacer()
            Text(content)
                .font(.body)
                .foregroundColor(.gray)
                .padding(.trailing,16)
            
        }
    }
}

struct SettingCellWithContentNormal_Previews: PreviewProvider {
    static var previews: some View {
        SettingCellWithContentNormal(title: "Nama Depan", content: "Jonathan")
    }
}
