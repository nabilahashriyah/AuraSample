//
//  TV_normal.swift
//  Aura
//
//  Created by Hubert Daryanto on 23/10/20.
//

import SwiftUI

struct TV_normal: View {
    @ObservedObject var firstAidStatus: CaseSwitcher
    @ObservedObject var stopwatchManager: StopwatchManager
    @State var showAlert = false
    var body: some View {
        ZStack{
            Rectangle().foregroundColor(Color("normal_timer_background"))
            VStack (alignment: .center){
                
                Spacer().frame(width: 382, height: 12, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Text(AlertLanguage.getData(language: UserDefaults.standard.string(forKey: "firstAidLanguage")!)[4])
                    .foregroundColor(Color.white).font(.custom("Graphik-Regular", size: 17)).kerning(-0.24)
                    .frame(width: 164, height: 13, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Spacer().frame(width: 382, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Text(String(stopwatchManager.secondsToMintesAndSeconds(seconds: stopwatchManager.secondsElapsed)))
                    .foregroundColor(Color.white).font(.custom("Graphik-Bold", size: 34)).kerning(0.36)
                    .frame(width: 150, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Spacer().frame(width: 382, height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Text(AlertLanguage.getData(language: UserDefaults.standard.string(forKey: "firstAidLanguage")!)[5])
                    .foregroundColor(Color.white)
                    .font(.custom("Graphik-Regular", size: 13)).kerning(0.07).multilineTextAlignment(.center)
                    .frame(width: 382, height: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Spacer().frame(width: 382, height: 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
            }.frame(width: 382, height: 114, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).cornerRadius(8.0)
            
            VStack{
                Spacer().frame(width: 382, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                HStack{
                    Spacer()
                    Button(action: {
                        self.showAlert = true
                    }, label: {
                        Image(systemName: "xmark.circle").foregroundColor(.white)
                    }).frame(width: 19.05, height: 18, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).alert(isPresented: $showAlert)
                    {
                        Alert(title: Text(AlertLanguage.getData(language: UserDefaults.standard.string(forKey: "firstAidLanguage")!)[13]), message: Text(""), primaryButton: .destructive(Text(AlertLanguage.getData(language: UserDefaults.standard.string(forKey: "firstAidLanguage")!)[14]), action: dismiss), secondaryButton: .default(Text(AlertLanguage.getData(language: UserDefaults.standard.string(forKey: "firstAidLanguage")!)[15]), action: changeFirstAidStatus))
                    }
                    Spacer().frame(width: 10, height: 114, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                Spacer().frame(width: 382, height: 72 + 14, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }.frame(width: 382, height: 114, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
        }.frame(width: 382, height: 114, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).cornerRadius(8.0)
    }
    
    func changeFirstAidStatus()
    {
        firstAidStatus.FirstAidState = .thankyou
    }
    
    func dismiss()
    {
        showAlert = false
    }
}
