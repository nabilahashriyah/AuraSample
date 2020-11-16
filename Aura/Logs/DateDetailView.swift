//
//  DateDetailView.swift
//  Aura
//
//  Created by Stevhen on 18/10/20.
//

import SwiftUI

struct DateDetailView: View {
    @State var addLogModal: Bool = false
    @State var logDetailModal: Bool = false
    
    var date: Date = Date()
    
    func getLogs(date: Date) -> [LogDetail] {
        
        for item in Log.fetchDummyData() {
            
            if DateFormatter.dayAndMonth.string(from: item.date) == DateFormatter.dayAndMonth.string(from: date) {
                return item.logs
            }
        }
        
        return []
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(DateFormatter.dayAndMonth.string(from: date))
                    .font(.custom("Graphik-Bold", size: 17))
                    .foregroundColor(AuraColors.dimBlack)
                    .kerning(0.36)
                
                Spacer()
                
                Button(action: {
                    self.addLogModal.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .frame(width: 18, height: 18)
                        .foregroundColor(AuraColors.orangeBall)
                })
                .sheet(isPresented: $addLogModal) {
                    LogDetailView(showingModal: self.$addLogModal, modalState: .add)
                }
                
            }
            .padding()
            .border(AuraColors.grayBg)
            
            ScrollView {
                ForEach(getLogs(date: date)) { log in
                    
                    Button(action: {
                        self.logDetailModal.toggle()
                    }, label: {
                        HStack {
                            VStack(alignment: .leading) {
                                
                                HStack {
                                    
                                    RoundedRectangle(cornerRadius: 8)
                                        .frame(width: 8, height: 36)
                                        .foregroundColor(AuraColors.solidPurple)
                                    
                                    VStack(alignment: .leading, spacing: 5) {
                                        HStack {
                                            Text(log.location)
                                                .font(.custom("Graphik-Bold", size: 17))
                                                .kerning(0.36)
                                            
                                            Spacer()
                                            
                                            Text("11:00 AM")
                                                .font(.custom("Graphik-Bold", size: 17))
                                                .kerning(0.36)
                                        }
                                        .padding(.trailing)
                                        
                                        Text(log.duration)
                                            .font(.custom("Graphik-Regular", size: 15))
                                            .kerning(0.36)
                                    }
                                }
                                .padding(.leading, 21)
                                
                                //if data only 1, don't show this ruler
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(AuraColors.grayBg)
                                    .ignoresSafeArea()
                                    .offset(x: 36)
                            }
                        }
                        .foregroundColor(AuraColors.dimBlack)
                        
                        
                    })
                    .sheet(isPresented: $logDetailModal) {
                        LogDetailView(showingModal: self.$logDetailModal, modalState: .detail)
                    }
                    
                }
            }
        }
    }
}
