//
//  AlertButton.swift
//  notificationAura
//
//  Created by Nabilah Ashriyah on 16/10/20.
//

import SwiftUI

struct AlertButton: View {
    var body: some View {
        GeometryReader { geometry in
            let centerX = geometry.size.width / 2
            let centerY = geometry.size.height / 2
            
            Image("alarm_button")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: geometry.size.width * 0.65, alignment: .center)
                .position(CGPoint(x: centerX, y: centerY))
                .clipped()
                .shadow(color: Color.black, radius: 4, x: 3, y: 3)
        }
    }
}

struct AlertButton_Previews: PreviewProvider {
    static var previews: some View {
        AlertButton()
    }
}
