//
//  FAV_in.swift
//  Aura
//
//  Created by Hubert Daryanto on 23/10/20.
//

import SwiftUI
import PartialSheet

struct FAV_in: View {
    @ObservedObject var firstAidStatus: CaseSwitcher
    @State var firstAidStepsData: [FirstAidSteps]
    @ObservedObject var stopwatchManager: StopwatchManager
    @ObservedObject var page: PageSelection
    @Binding var showingEmergencyModal: Bool
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    var body: some View {
        HStack
        {
            VStack
            {
                TimerView(firstAidStatus: firstAidStatus, stopwatchManager: stopwatchManager).frame(width: 382, height: stopwatchManager.timerHeightSize, alignment: .center)
//                Spacer().frame(width: 382, height: 8, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                ZStack{
                    TabView(selection: $page.page)
                    {
                        ForEach(0..<firstAidStepsData.count) {
                            index in
                            VStack(alignment: .center)
                            {
                                SVC_in(steps: firstAidStepsData[index]).tag(index)
                                Spacer()
                            }
                        }
                    }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)).onAppear(perform: {
                        UIScrollView.appearance().bounces = false
                    }).offset(x: 4.0, y: 0)
                    VStack
                    {
                        ZStack(alignment: .top){
                            PaginationButtonView(firstAidStepsCount: firstAidStepsData.count, page: $page.page).onReceive(page.$page, perform: { _ in
                                page.updatePage()
                            })
                            VStack{
                                Spacer().frame(width: 390, height: 52, alignment: .center)
                                RoundedRectangle(cornerRadius: 12).stroke(Color.white, lineWidth: 8).frame(width: 390, height: 258, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).mask(
                                    HStack{
                                        VStack
                                        {
                                            Rectangle().frame(width: CGFloat(page.maskSizeLeft), height: 200, alignment: .center)
                                            Spacer()
                                        }
                                        Spacer()
                                        VStack{
                                            Rectangle().frame(width: CGFloat(page.maskSizeRight), height: 200, alignment: .center)
                                            Spacer()
                                        }
                                    }.frame(width: 382, height: 258, alignment: .center)
                                    )
                                Spacer()
                            }
                        }
                        Spacer()
                    }.offset(x: 0, y: -8.0)
                }.frame(width: 382, height: stopwatchManager.stepsViewHeightSize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                BAB_in(firstAidStatus: firstAidStatus,page: $page.page,showingEmergencyModal: $showingEmergencyModal).environmentObject(partialSheetManager)
            }
        }
    }
}
