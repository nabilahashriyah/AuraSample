//
//  AuraWidgetLarge.swift
//  Aura-WidgetExtension
//
//  Created by Stevhen on 09/11/20.
//

import SwiftUI
import WidgetKit

struct AuraWidgetLarge: View {
    
    private let logs = [
        LogModel(location: "Pasar Minggu Station", duration: "1m 30s"),
        LogModel(location: "Grand Indonesia", duration: "3m 42s"),
        LogModel(location: "Jl. K.H. Hasyim Ashari", duration: "3m 42s")
    ]
    
    var body: some View {
        ZStack {
            Image("widget-big")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 360, height: 380)
            
            VStack(alignment: .leading) {
                
                Spacer(minLength: 15)
                
                WidgetLogDateView()
                
                VStack(alignment: .leading) {
                    
                    if logs.isEmpty {
                        Spacer()
                        Text("No Seizures")
                            .font(.custom("Graphik-Regular", size: 11))
                        Spacer()
                        
                    } else {
                        ForEach(logs, id: \.self) { log in
                            WidgetLogRowView(log: log)
                        }
                    }
                    Spacer()
                }
                
                Spacer()
                    
                HStack {
                    
                    Image("alert")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 121, height: 121)
                    
                    Spacer(minLength: 10)
                    
                    Text("Alert Surroundings")
                        .font(.custom("Graphik-Bold", size: 17))
                        .foregroundColor(.white)
                        .kerning(0.36)
                    
                }
                .padding(.horizontal, 10)
                
                Spacer(minLength: 30)
                
            }
            .padding(.leading, 20)
            .padding([.trailing, .bottom])
            .foregroundColor(.white)
        }
    }
}

struct AuraWidgetLarge_Previews: PreviewProvider {
    static var previews: some View {
        AuraWidgetLarge()
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
