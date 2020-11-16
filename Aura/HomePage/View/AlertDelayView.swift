//
//  AlertDelayView.swift
//  Aura
//
//  Created by Stevhen on 20/10/20.
//

import SwiftUI

struct AlertDelayView: View {
    @Binding var showAlertDelay: Bool
    
    @State var isAnimating: Bool = false
    @State var isDelayScreenActive: Bool = true
    
    var anim = Animation.linear(duration: 2)
    
    @State var delayCountdownDuration: Int
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var nextView: Bool = false
    
    @State var pos = CGPoint(x: 125, y: 125)
    
    @State var alertScaling: CGFloat = 1.0
    
    init(showAlertDelay: Binding<Bool> = .constant(true), delayCountdownDuration: Int = 0) {
        _showAlertDelay = showAlertDelay
        _delayCountdownDuration = State(initialValue: Settings.countdownDurations[UserDefaults.standard.integer(forKey: "countdown")])
    }
    
    var body: some View {
        VStack(spacing: 15) {
            Spacer(minLength: 105)
            VStack(spacing: 10) {
                Text("Alerting Surroundings")
                    .font(.custom("Graphik-Bold", size: 28))
                    .bold()
                
                    .foregroundColor(self.delayCountdownDuration >= Settings.countdownDurations[UserDefaults.standard.integer(forKey: "countdown")] - 3 ? .black : .white)
                
                if isDelayScreenActive {
                    Text(NSLocalizedString("in", comment: "") + " \(delayCountdownDuration) " + NSLocalizedString("seconds", comment: ""))
                        .font(.custom("Graphik-Regular", size: 20))
                        
                        .foregroundColor(self.delayCountdownDuration >= Settings.countdownDurations[UserDefaults.standard.integer(forKey: "countdown")] - 2 ? .black : .white)
                        
                        .onReceive(timer) { _ in
                            guard self.isDelayScreenActive else { return }

                            if self.delayCountdownDuration > 0 {
                                self.delayCountdownDuration -= 1

                                let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                impactHeavy.impactOccurred()
                            }

                            if delayCountdownDuration == 0 {
                                self.isDelayScreenActive.toggle()
                                self.nextView.toggle()
                            }
                        }
                }
            }
            .padding(.bottom, 48)
            
            ZStack {
                
//                NavigationLink(destination: FirstAidView(isPresented: $showAlertDelay).navigationBarHidden(true), isActive: $nextView) {
//                    
//                }
//                .hidden()
                
                Image("alarm_button")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 238, height: 238)
                    .position(pos)
                
                Image("alert-delay")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 238, height: 238)
                    .position(CGPoint(x: 125, y: 125))
                    
                    .scaleEffect(self.isDelayScreenActive ? ((abs((CGFloat(delayCountdownDuration) - CGFloat(Settings.countdownDurations[UserDefaults.standard.integer(forKey: "countdown")]))) * 0.3) + 1) : 1)
                    .animation(anim)
                    
                    .zIndex(-3)
                
            }
            .frame(width: 250, height: 250)
            .zIndex(-2)
            
            Button(action: {
                self.showAlertDelay = false
            }) {
                Image("cancel")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .padding(.top, 48)
            }
            
            Spacer()
            Text("Sending your current location to your caregivers, please find a safe place")
                .font(.custom("Graphik-Regular", size: 17))
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 10)
                .foregroundColor(self.delayCountdownDuration >= Settings.countdownDurations[UserDefaults.standard.integer(forKey: "countdown")] - 6 ? .black : .white)
                .opacity(self.isAnimating ? 0.2: 1)
                .animation(anim.repeatForever())
                .onAppear {
                    self.isAnimating = true
                }
                .padding(.top, 60)
            
            Spacer()
        }
        .onAppear {
            
            delayCountdownDuration = Settings.countdownDurations[UserDefaults.standard.integer(forKey: "countdown")]
        }
//        .onDisappear {
//            isDelayScreenActive = false
//        }
        .padding()
        
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    
}
