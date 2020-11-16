//
//  Notification.swift
//  notificationAura
//
//  Created by Nabilah Ashriyah on 12/10/20.
//

import SwiftUI
import Foundation
import UIKit

struct NotificationView: View {
    
    @Binding var isNavigationBarHidden: Bool
    
    @Binding var showDetail: Bool
    
    @State var showDetailView: Bool = false
    
    @EnvironmentObject var notifications: NotificationDetailsHelper
    
    @State private var isAnimating = false
    
    var body: some View {
        Group {
            if self.notifications.dataHasLoaded {
                if self.notifications.notifs.isEmpty {
                    Text("No seizure event notification")
                }
                else {
                    ScrollView {
                        ForEach(self.notifications.notifs) { notifData in
                            NavigationLink(
                                destination: NotificationDetailsView(notificationName: notifData),
                                label: {
                                    ZStack(alignment: .leading) {
                                        VStack(alignment: .leading) {
                                            Text(notifData.landmark ?? "")
                                                .bold()
                                                .foregroundColor(.black)
//
                                            Text(notifData.addr ?? "")
                                                .font(.caption)
                                                .foregroundColor(.black)
//
                                            let dateInterval = DateComponents.getInterval(startDate: notifData.date ?? Date())
                                            Text("\(dateInterval)")
                                                .font(.caption)
                                                .foregroundColor(.black)
                                        } .padding()
                                    }
                                    .frame(width: UIScreen.main.bounds.width - 25, alignment: .leading)
                                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.white).shadow(color: .gray, radius: 3, x: 3, y: 3))
                                    .padding(.top, 5)
                                    .padding(.horizontal)
                                })
                        }
                    }
                }
            } else {
                LoadingView(isAnimating: self.$isAnimating)
            }
        }
        .navigationBarTitle(Text("Pemberitahuan Kejang"), displayMode: .inline)
        .onAppear {
            self.isNavigationBarHidden = false
            self.notifications.fetchNotification()
        }
    }
}

struct LoadingView: View {
    private var foreverAnimation: Animation {
            Animation.linear(duration: 3.0)
                .repeatForever(autoreverses: false)
        }
    
    @Binding var isAnimating: Bool
    
    var body: some View {
        VStack {
            Image(systemName: "circle.dashed")
                .font(.title)
                .imageScale(.large)
                .animation(.linear)
                .foregroundColor(.black)
                .rotationEffect(Angle(degrees: self.isAnimating ? 360 : 0.0))
                .animation(self.isAnimating ? foreverAnimation : .default)
                .onAppear { self.isAnimating = true }
            Text("")
            Text("Loading Data")
        }
    }
}

