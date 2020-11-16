//
//  SettingCellWithoutImageWithContent.swift
//  Aura
//
//  Created by Allicia Viona Sagi on 13/10/20.
//

import SwiftUI

struct SettingCellWithoutImageWithContent: View {
    var title: String
    var content: String
    
    var body: some View {
        HStack{
            Text(title)
                .font(.body)
            
            Spacer()
            Text(content)
                .font(.body)
                .foregroundColor(.gray)
                .padding(.trailing,1)
            
        }
    }
}

struct SettingCellWithoutImageWithContent_Previews: PreviewProvider {
    static var previews: some View {
        SettingCellWithoutImageWithContent(title: "Title", content: "5 minutes")
    }
}
