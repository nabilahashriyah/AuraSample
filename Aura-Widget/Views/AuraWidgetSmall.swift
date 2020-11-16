//
//  AuraWidgetSmall.swift
//  Aura-WidgetExtension
//
//  Created by Stevhen on 08/11/20.
//

import SwiftUI
import WidgetKit

struct AuraWidgetSmall: View {
    var body: some View {
        ZStack {
            Image("widget-sm")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 169, height: 169)
            
            VStack(spacing: 16) {
                
                Text("Alert Surroundings")
                    .font(.custom("Graphik-Bold", size: 13))
                    .foregroundColor(.white)
                    .kerning(0.36)
                
                Image("alert")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 107, height: 107, alignment: .center)

            }
            .padding()
        }
    }
}

struct AuraWidgetSmall_Previews: PreviewProvider {
    static var previews: some View {
        AuraWidgetSmall()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
