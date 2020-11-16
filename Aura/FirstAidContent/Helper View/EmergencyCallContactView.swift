//
//  EmergencyCallContactView.swift
//  Aura
//
//  Created by Hubert Daryanto on 25/10/20.
//

import SwiftUI

struct EmergencyCallContactView: View {
    
    @State var showNearbyHospital = false
    @Binding var showEmergencyModal: Bool
    var body: some View {
        HStack{
            Spacer().frame(width: 16, alignment: .center)
            
            VStack(alignment: .leading){
                
                HStack(alignment: .top){
                    
                    VStack(alignment: .leading){
                        Text(AlertLanguage.getData(language: UserDefaults.standard.string(forKey: "firstAidLanguage")!)[8]).foregroundColor(Color("warning_timer_background")).font(.system(size: 20)).bold()
                        Text(AlertLanguage.getData(language: UserDefaults.standard.string(forKey: "firstAidLanguage")!)[10]).foregroundColor(Color("gray_color")).font(.system(size: 14))
                    }.frame(width: 342, height: 59, alignment: .leading)
                    
                    Button(action: {
                        self.showEmergencyModal = false
                    }, label: {
                        Image(systemName: "xmark.circle").foregroundColor(Color("warning_timer_background"))
                    })
                    .frame(width: 19, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                }
                .frame(width: 382, height: 59, alignment: .leading)
                
                Divider().frame(width: 382, height: 1, alignment: .center)
                
                Button(action: {
                    guard let number = URL(string: "tel://" + "112") else { return }
                        UIApplication.shared.open(number)
                }, label: {
                    
                    HStack{
                        Image(systemName: "phone.fill").frame(width: 24, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(Color("warning_timer_background"))
                        Text(AlertLanguage.getData(language: UserDefaults.standard.string(forKey: "firstAidLanguage")!)[12] + " 112").font(.system(size: 18)).foregroundColor(Color("emergency_call_text_color"))
                    }.frame(width: 382, height: 57, alignment: .leading)
                })
                
                Divider().frame(width: 382, height: 1, alignment: .center)
                
                    NavigationLink(
                        destination: PlaceListView().eraseToAnyView(),
                        label: {
                            
                            HStack{
                                Image(systemName: "plus")
                                    .font(Font.system(.title2).bold())
                                    .frame(width: 24, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(Color("warning_timer_background"))
                                Text(AlertLanguage.getData(language: UserDefaults.standard.string(forKey: "firstAidLanguage")!)[11]).font(.system(size: 18)).foregroundColor(Color("emergency_call_text_color"))
                            }.frame(width: 382, height: 57, alignment: .leading)
                        })
                
                Spacer().frame(width: 382, height: 100, alignment: .center)
            }
            
            Spacer().frame(width: 16, alignment: .center)
            
            .navigationBarTitle("Back", displayMode: .inline)
        }
    }
}

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
