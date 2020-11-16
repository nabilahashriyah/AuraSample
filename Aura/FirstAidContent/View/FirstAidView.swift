//
//  ContentView.swift
//  Aura
//
//  Created by Stevhen on 30/09/20.
//

import SwiftUI
import PartialSheet
import AVFoundation
import MediaPlayer

struct FirstAidView: View {
    @ObservedObject var settings: Settings = Settings()
    @ObservedObject var firstAidStatus = CaseSwitcher()
    @ObservedObject var stopwatchManager = StopwatchManager()
    @ObservedObject var page = PageSelection()
    @State var alarm: AVAudioPlayer = AlarmAudio().playaudio()
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    @Binding var isPresented: Bool
    @State var showingEmergencyModal = false

    var body: some View {
        HStack{
            Spacer().frame(width: 16, height: UIScreen.main.bounds.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            VStack{
                Spacer().frame(width: 382, height: 16, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                switch firstAidStatus.FirstAidState {
                case .findingHelp:
                    FAV_finding(firstAidStatus: firstAidStatus,firstAidSupportData: FirstAidSupportData.getData(language: UserDefaults.standard.string(forKey: "firstAidLanguage")!), stopwatchManager: stopwatchManager, showingEmergencyModal: $showingEmergencyModal).onDisappear(perform: {
                        alarm.stop()
                        self.stopwatchManager.isHelped = true
                        self.stopwatchManager.turnOffFlashlight()
                    })
                case .inHelp:
                    FAV_in(firstAidStatus: firstAidStatus, firstAidStepsData: FirstAidStepsData.getData(language: UserDefaults.standard.string(forKey: "firstAidLanguage")!), stopwatchManager: stopwatchManager, page: page, showingEmergencyModal: $showingEmergencyModal).environmentObject(partialSheetManager)
                case .postHelp:
                    FAV_post(firstAidStatus: firstAidStatus, firstAidSupportData: FirstAidSupportData.getData(language: UserDefaults.standard.string(forKey: "firstAidLanguage")!))
                case .thankyou:
                    FAV_thankyou(firstAidStatus: firstAidStatus, firstAidSupportData: FirstAidSupportData.getData(language: UserDefaults.standard.string(forKey: "firstAidLanguage")!), isPresented: $isPresented)
                }
                Spacer().frame(width: 382, height: 21, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }.frame(width: 382, height: UIScreen.main.bounds.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Spacer().frame(width: 16, height: UIScreen.main.bounds.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }.onAppear(perform: {
            
            if stopwatchManager.isHelped == false
            {
                MPVolumeView.setVolume(1.0)
                alarm.play()
                stopwatchManager.start()
            }
            DispatchQueue.main.async {
                NotificationRecord.startUpdatingNotification()
            }
        }).onDisappear(perform: {
            UIScrollView.appearance().bounces = true
        })
    }
}

//Update system volume
extension MPVolumeView{
    static func setVolume(_ volume: Float){
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider}) as? UISlider
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            slider?.value = volume
        }
    }
}

// To check if headphone is connected
extension AVAudioSession{
    static var isHeadphonesConnected: Bool{
        return sharedInstance().isHeadphonesConnected
    }
    
    var isHeadphonesConnected: Bool{
        return !currentRoute.outputs.filter { $0.isHeadphones }.isEmpty
    }
}

extension AVAudioSessionPortDescription{
    var isHeadphones: Bool{
        return portType == AVAudioSession.Port.headphones
    }
}

