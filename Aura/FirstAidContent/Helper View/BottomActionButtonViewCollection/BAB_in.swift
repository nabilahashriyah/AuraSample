//
//  BAB_in.swift
//  Aura
//
//  Created by Hubert Daryanto on 23/10/20.
//

import SwiftUI
import PartialSheet

struct BAB_in: View {
    @State private var showingActionSheet = false
    @ObservedObject var firstAidStatus: CaseSwitcher
    @Binding var page: Int
    @Binding var showingEmergencyModal: Bool
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    @State var showAlert = false
    
    var body: some View {
        HStack{
            if page == 0{
                Spacer().frame(width: 98, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            else
            {
                Button(action: {
                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                    impactLight.impactOccurred()
                    self.page -= 1
                }, label: {
                    ZStack{
                        Rectangle().foregroundColor(Color("normal_timer_background")).cornerRadius(8.0)
                        Image(systemName: "chevron.left").frame(width: 13, height: 13, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                    }
                }).frame(width: 98, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            Button(action: {
                self.showingEmergencyModal.toggle()
            }, label: {
                ZStack
                {
                    Rectangle().foregroundColor(Color("warning_timer_background")).cornerRadius(8.0)
                    HStack
                    {
                        Image(uiImage: UIImage(data: try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "emergency.png", ofType: nil)!)))!).resizable().frame(width: 27.04, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                        Text(AlertLanguage.getData(language: UserDefaults.standard.string(forKey: "firstAidLanguage")!)[8]).font(.custom("Graphik-Regular", size: 18)).foregroundColor(.white)
                    }
                }
            }
            ).frame(width: 171, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).partialSheet(isPresented: $showingEmergencyModal)
            {
                EmergencyCallContactView(showEmergencyModal: $showingEmergencyModal)
            }
            if page == 4
            {
                Button(action: {
                    self.showAlert.toggle()
                }, label: {
                    ZStack{
                        Rectangle().foregroundColor(Color("normal_timer_background")).cornerRadius(8.0)
                        Text(AlertLanguage.getData(language: UserDefaults.standard.string(forKey: "firstAidLanguage")!)[7]).font(.custom("Graphik-Regular", size: 18)).foregroundColor(.white)
                    }
                })
                .alert(isPresented: $showAlert)
                {
                    Alert(title: Text(AlertLanguage.getData(language: UserDefaults.standard.string(forKey: "firstAidLanguage")!)[0]), message: Text(AlertLanguage.getData(language: UserDefaults.standard.string(forKey: "firstAidLanguage")!)[1]), primaryButton: .destructive(Text(AlertLanguage.getData(language: UserDefaults.standard.string(forKey: "firstAidLanguage")!)[2]), action: dismiss), secondaryButton: .default(Text(AlertLanguage.getData(language: UserDefaults.standard.string(forKey: "firstAidLanguage")!)[3]), action: changeFirstAidStatus))
                }
                .frame(width: 98, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            else
            {
                Button(action: {
                    //next page
                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                    impactLight.impactOccurred()
                    self.page += 1
                }, label: {
                    ZStack{
                        Rectangle().foregroundColor(Color("normal_timer_background")).cornerRadius(8.0)
                        Image(systemName: "chevron.right").frame(width: 13, height: 13, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                    }
                }).frame(width: 98, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }.frame(width: 382, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
    
    func dismiss()
    {
        showAlert = false
    }
    func changeFirstAidStatus()
    {
        firstAidStatus.FirstAidState = .postHelp
    }
}
