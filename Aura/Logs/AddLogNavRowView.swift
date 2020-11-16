//
//  AddLogNavRowView.swift
//  Aura
//
//  Created by Stevhen on 15/10/20.
//

import SwiftUI

struct AddLogRowView: View {
    
    var title: String
    var status: String
    var isNav: Bool = true
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.blue)
            Spacer()
            
            HStack {
                Text(status)
                    
                if isNav {
                    Image(systemName: "chevron.right")
                }
                    
            }
            .foregroundColor(.gray)
        }
    }
}
