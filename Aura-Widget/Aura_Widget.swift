//
//  Aura_Widget.swift
//  Aura-Widget
//
//  Created by Stevhen on 08/11/20.
//

import WidgetKit
import SwiftUI
import Intents

struct WidgetModel: TimelineEntry {
    var date: Date
    var currentTime: String
}

struct DataProvider: TimelineProvider {
    func placeholder(in context: Context) -> WidgetModel {
        return WidgetModel(date: Date.distantPast, currentTime: "Loading...")
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetModel>) -> Void) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss a"
        let time = formatter.string(from: date)
        
        let entryData = WidgetModel(date: date, currentTime: time)
        
        let refresh = Calendar.current.date(byAdding: .second, value: 10, to: Date())!
        let timeline = Timeline<WidgetModel>(entries: [entryData], policy: .after(refresh))
        
        print("Updated...")
        
        completion(timeline)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (WidgetModel) -> Void) {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss a"
        let time = formatter.string(from: date)
        
        let entryData = WidgetModel(date: date, currentTime: time)
        
        completion(entryData)
    }
}

struct WidgetView: View {
    
    var data: DataProvider.Entry
    @Environment (\.widgetFamily) var family
    
    var deeplinkURL: URL {
       URL(string: "widget://demo/tap/\(family)")!
    }
    
    @ViewBuilder
    var body: some View {
        if family == .systemSmall {
            
            ZStack {
                Image("widget-small-bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 169, height: 169)
            }
            .zIndex(-1)
            
            VStack {
                
                Text("Alert Surrounding")
                    .font(.system(size: 13))
                
                Image("alert")
                    .frame(width: 95, height: 95, alignment: .center)
                
            }
            .padding()
            .widgetURL(deeplinkURL)
        } else {
            HStack {
                Link(destination: URL(string: "widget://demo/tap/\(family)/left")!) {
                    Text("Left")
                }
                
                Spacer()
                
                Link(destination: deeplinkURL) {
                    Text("Right")
                }
            }
            
        }
    }
}

@main
struct Config: Widget {
    
    var body: some WidgetConfiguration {
        
        StaticConfiguration(kind: "Widget", provider: DataProvider()) { data in
            
            WidgetView(data: data)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .description(Text("Current Time Widget"))
        
    }
    
}
