//
//  AttributedFirstAidSupportTextView.swift
//  Aura
//
//  Created by Hubert Daryanto on 12/11/20.
//

import SwiftUI

struct AttributedFirstAidSupportTextView: View {
    var body: some View {
            Text("Nama saya") + Text("Jon").font(.custom("Graphik-Bold", size: 20)) + Text(", saya sedang kejang karena ")
    }
}

struct AttributedFirstAidSupportTextView_Previews: PreviewProvider {
    static var previews: some View {
        AttributedFirstAidSupportTextView()
    }
}
