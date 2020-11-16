//
//  PaginationButtonEveryNumberView.swift
//  Aura
//
//  Created by Hubert Daryanto on 04/11/20.
//

import SwiftUI

struct PaginationSelectedView: View {
    @State var index: Int
    @Binding var page: Int
    var body: some View {
        Button(action: {
            self.page = index
        }, label: {
            ZStack{
                VStack
                {
                    Spacer()
                    RoundedRectangle(cornerRadius: 12).stroke(Color.white, lineWidth: 8).frame(width: 78, height: 74, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }.frame(width: 78, height: 100, alignment: .top)
                VStack(alignment: .center){
                    Text("\(index + 1)").font(.custom("Graphik-Bold", size: 17)).foregroundColor(Color.white)
                }.frame(width: 70, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }).frame(width: 86, height: 56, alignment: .center).clipShape(Rectangle().size(CGSize(width: 86, height: 40)))
    }
}
