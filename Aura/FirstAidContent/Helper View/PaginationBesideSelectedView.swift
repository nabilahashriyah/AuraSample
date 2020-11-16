//
//  PaginationButtonEveryNumberView3.swift
//  Aura
//
//  Created by Hubert Daryanto on 04/11/20.
//

import SwiftUI

struct PaginationBesideSelectedView: View {
    @State var index: Int
    @Binding var page: Int
    var body: some View {
        Button(action: {
            self.page = index
        }, label: {
            ZStack{
                RoundedRectangle(cornerRadius: 8.0).foregroundColor(.white)
                ZStack{
                    Rectangle().foregroundColor(Color("normal_timer_background")).cornerRadius(8.0)
                    Text("\(index + 1)").font(.custom("Graphik-Bold", size: 17)).foregroundColor(Color.white)
                }.frame(width: 70, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }
        ).frame(width: 86, height: 56, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

