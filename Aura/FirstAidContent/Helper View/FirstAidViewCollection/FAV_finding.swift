//
//  FAV_finding.swift
//  Aura
//
//  Created by Hubert Daryanto on 23/10/20.
//

import SwiftUI
import PartialSheet

struct FAV_finding: View {
    @ObservedObject var firstAidStatus: CaseSwitcher
    @State var firstAidSupportData: [FirstAidSupport]
    @State var name = "Jonathan"
    @ObservedObject var stopwatchManager: StopwatchManager
    @Binding var showingEmergencyModal: Bool
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    var body: some View {
        HStack
        {
            VStack
            {
                TimerView(firstAidStatus: firstAidStatus, stopwatchManager: stopwatchManager).frame(width: 382, height: stopwatchManager.timerHeightSize, alignment: .center)
                Spacer().frame(width: 382, height: 8, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                ZStack{
                    VStack
                    {
                        SVC_finding(steps: firstAidSupportData[0], name: name)
                        Spacer()
                    }.frame(width: 382, height: stopwatchManager.stepsViewHeightSize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                BAB_finding(firstAidStatus: firstAidStatus ,showingEmergencyModal: $showingEmergencyModal).environmentObject(partialSheetManager)
            }
        }
        }
    }

