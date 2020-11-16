//
//  HomePageView.swift
//  notificationAura
//
//  Created by Nabilah Ashriyah on 16/10/20.
//

import SwiftUI
import PartialSheet

struct HomePageView: View {
    
    @State var showingNotification = false
    
    @State var showNotifDetail = false
    
    @State var showingProfile = false
    
    @State var showingDelay = false
    
    @GestureState var isDetectingLongPress = false
    
    @State var dragState = false
    
    @State var viewState = CGSize.zero
    
    @State var translation = CGSize.zero
    
    @State var isNavigationBarHidden: Bool = true
    
    // MARK: - Overall View
    
    var body: some View {
        //        let longPressDrag = dragGesture.exclusively(before: longPress)
        
        //        let combinedGestures = longPressDrag.exclusively(before: tapGesture)
        
        NavigationView {
            ZStack {
                // navigation bar items
                GeometryReader { geometry in
                    HStack {
                        notificationButton
                        Spacer()
                        
                        profileButton
                    } .position(x: UIScreen.main.bounds.midX, y: geometry.safeAreaInsets.top)
                }
                
                alertLabel
                
                AlertButton()
                    .opacity(dragState ? 0.5 : 1)
                    .offset(
                        x: viewState.width + translation.width,
                        y: viewState.height + translation.height
                    )
                    .animation(.interactiveSpring())
                    .gesture(tapGesture)
                
                NavigationLink(
                    destination: AlertDelayView(showAlertDelay: $showingDelay),
                    isActive: $showingDelay,
                    label: {
                        Text("")
                    })
                
//                NavigationLink(
//                    destination: NotificationView(isNavigationBarHidden: self.$isNavigationBarHidden, showDetail: self.$showNotifDetail),
//                    isActive: $showingNotification,
//                    label: {
//                        Text("")
//                    })
                
                NavigationLink(
                    destination: SettingView(isNavigationBarHidden: self.$isNavigationBarHidden),
                    isActive: $showingProfile,
                    label: {
                        Text("")
                    })
                
            }
            
            .background(
                Image("home_bg")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
            )
            .navigationBarHidden(self.isNavigationBarHidden)
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear {
                self.isNavigationBarHidden = true
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.setupApp()
                
//                NotificationRecord.stopUpdatingNotification()
                
                let notFirstLaunch = UserDefaults.standard.bool(forKey: "isOnboarded")
                if !notFirstLaunch {
                    UserDefaults.standard.removeObject(forKey: "isOnboarded")
                    UserDefaults.standard.setValue(true, forKey: "isOnboarded")
                }
                
                /// dummy
                SubscriptionManager.instance.setupSubscription()
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name("SeizureEvent"), object: nil, queue: .main) { (_) in
                    self.showingNotification.toggle()
                    self.showNotifDetail.toggle()
                }
            }
        }
    }
    // MARK: - Gestures
    var tapGesture: some Gesture {
        TapGesture()
            .onEnded({
                showingDelay = true
            })
    }
    //
    //    var longPress: some Gesture {
    //        LongPressGesture(minimumDuration: 1)
    //            .updating($isDetectingLongPress) {
    //                value, state, transaction in
    //                state = value
    //                dragState = true
    //            }
    //            .onEnded({ _ in
    //                showingDelay = true
    //            })
    //    }
    //
    //    var dragGesture: some Gesture {
    //        DragGesture()
    //            .onChanged({ value in
    //                translation = value.translation
    //                dragState = true
    //
    //            })
    //            .onEnded({ value in
    //                let minDis = UIScreen.main.bounds.width / 4
    //                if ((abs(translation.width) > minDis) || (abs(translation.height) > minDis)) {
    //                    showingDelay = false
    //                } else {
    //                    showingDelay = true
    //                }
    //                dragState = false
    //                translation = .zero
    //            })
    //    }
    
    // MARK: - the components on home page view
    var alertLabel: some View {
        GeometryReader { geometry in
            let centerX = geometry.size.width / 2
            let centerY = geometry.size.height / 2
            
            Text("Alert Surroundings")
                .font(.custom(Graphik.bold.rawValue, size: 38, relativeTo: .largeTitle))
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .frame(width: geometry.size.width * 0.61)
                .aspectRatio(252/34, contentMode: .fit)
                .minimumScaleFactor(0.5)
                .allowsTightening(true)
                .position(x: centerX, y: centerY - centerX + 10)
                .foregroundColor(.white)
        }
    }
    
    //    var alertButton: some View {
    //        Button(action: {
    //            self.showingDelay.toggle()
    //        }) {
    //            AlertButton()
    //        }
    //    }
    
    var profileButton: some View {
        Button(action: {
            self.showingProfile.toggle()
        }) {
            Image(systemName: "person.crop.circle")
                .font(.title)
                .imageScale(.large)
                .accessibility(label: Text("User Profile"))
                .padding()
                .padding(.trailing,8)
                .foregroundColor(.white)
        }
    }
    
    var notificationButton: some View {
        Button(action: {
            self.showingNotification.toggle()
        }) {
            Image(systemName: "bell.fill")
                .font(.title)
                .imageScale(.large)
                .accessibility(label: Text("NotificationHistory"))
                .padding()
                .padding(.leading,8)
                .foregroundColor(.white)
        }
    }
}
