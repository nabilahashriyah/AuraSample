//
//  AddLogNavRowView.swift
//  Aura
//
//  Created by Stevhen on 15/10/20.
//

import SwiftUI

struct LogRowView: View {
    
    var title: String
    var status: String = "Tidak Ada"
    var isNav: Bool = true
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(AuraColors.dimBlack)
            Spacer()
            
            HStack {
                Text(status)
                    
                if isNav {
                    Image(systemName: "chevron.right")
                }
                    
            }
            .foregroundColor(.gray)
        }
        .font(.custom("Graphik-Regular", size: 17))
    }
}

struct PickerRowView: View {
    
    var title: String
    var isChecked: Bool = false
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.blue)
            Spacer()
            
            if isChecked {
                Image(systemName: "checkmark")
                .foregroundColor(.gray)
            }
        }
        .padding()
    }
}

struct CellSpacer: View {
    var body: some View {
        Section {
            HStack {
                Text("")
                Spacer()
            }
            .padding(.top, 28)
            .listRowInsets(EdgeInsets())
        }
        .background(AuraColors.grayBg)
    }
}
