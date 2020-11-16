//
//  BAB_finding.swift
//  Aura
//
//  Created by Hubert Daryanto on 23/10/20.
//

import SwiftUI
import PartialSheet

struct BAB_finding: View {
    @State private var showingActionSheet = false
    @ObservedObject var firstAidStatus: CaseSwitcher
    @Binding var showingEmergencyModal: Bool
    @EnvironmentObject var partialSheetManager: PartialSheetManager
//    @EnvironmentObject var navigationManager: NavigationManager
    var body: some View {
        HStack{
            Button(action: {
                self.showingEmergencyModal.toggle()
            }) {
                ZStack{
                    Rectangle().foregroundColor(Color("warning_timer_background")).cornerRadius(8.0)
                    Image(uiImage: UIImage(data: try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "emergency.png", ofType: nil)!)))!).resizable().frame(width: 27.04, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                }
            }
            .frame(width: 50, height: 50, alignment: .center)
            .partialSheet(isPresented: $showingEmergencyModal)
            {
                EmergencyCallContactView(showEmergencyModal: $showingEmergencyModal)
            }
            
            Button(action: {
                let impactLight = UIImpactFeedbackGenerator(style: .light)
                impactLight.impactOccurred()
                firstAidStatus.FirstAidState = .inHelp
            }, label: {
                ZStack{
                    
                    Rectangle().foregroundColor(Color("normal_timer_background")).cornerRadius(8.0)
                    Text(AlertLanguage.getData(language: UserDefaults.standard.string(forKey: "firstAidLanguage")!)[9]).font(.custom("Graphik-Regular", size: 18)).foregroundColor(.white)
                }
            })
        }.frame(width: 382, height: 50, alignment: .center)
    }
}
