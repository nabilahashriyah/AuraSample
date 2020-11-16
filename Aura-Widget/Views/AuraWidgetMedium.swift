//
//  AuraWidgetMedium.swift
//  Aura-WidgetExtension
//
//  Created by Stevhen on 08/11/20.
//

import SwiftUI
import WidgetKit

struct LogModel: Hashable {
    let id: String = UUID().uuidString
    let location: String
    let duration: String
}

struct AuraWidgetMedium: View {
    
    private let logs = [
        LogModel(location: "Pasar Minggu Station", duration: "1m 30s"),
        LogModel(location: "Grand Indonesia", duration: "3m 42s"),
        LogModel(location: "Jl. K.H. Hasyim Ashari", duration: "3m 42s")
    ]
    
    var body: some View {
        ZStack {
            Image("widget-med")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 360, height: 169)
            
            HStack {
                
                ///Alert Section
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
                .padding(.leading)
                .frame(width: 169)
                
                ///Logs Section
                ZStack {
                    VStack(alignment: .leading) {
                        
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
                        }
                    }
                    .padding(.leading, 11)
                    .padding(.top, 16)
                    .padding([.trailing, .bottom])
                    .foregroundColor(.white)
                }
            }
        }
    }
}

struct AuraWidgetMedium_Previews: PreviewProvider {
    static var previews: some View {
        AuraWidgetMedium()
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

struct WidgetLogRowView: View {
    let log: LogModel
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            RoundedRectangle(cornerRadius: 3)
                .frame(width: 5, height: 29)
            
            VStack(alignment: .leading) {
                Text(log.location)
                    .font(.custom("Graphik-Bold", size: 12))
                
                Text(log.duration)
                    .font(.custom("Graphik-Regular", size: 11))
            }
        }
    }
}

struct WidgetLogDateView: View {
    var body: some View {
        HStack {
            Text("Monday, Oct. 5")
                .font(.custom("Graphik-Bold", size: 13))
                .foregroundColor(.white)
                .kerning(0.36)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
    }
}
