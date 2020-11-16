//
//  BAB_thankyou.swift
//  Aura
//
//  Created by Hubert Daryanto on 23/10/20.
//

import SwiftUI

struct BAB_thankyou: View {
    @ObservedObject var firstAidStatus: CaseSwitcher
    @Binding var isPresented: Bool
    var body: some View {
        HStack{
            Button(action: {
                self.isPresented = false
            }) {
                ZStack
                {
                    Rectangle().foregroundColor(Color("normal_timer_background")).cornerRadius(8.0)
                    HStack
                    {
                        Text(AlertLanguage.getData(language: UserDefaults.standard.string(forKey: "firstAidLanguage")!)[7]).font(.custom("Graphik-Regular", size: 18)).foregroundColor(.white)
                    }
                }
            }.frame(width: 187, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

        }.frame(width: 382, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}
