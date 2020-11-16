//
//  PaginationButtonView.swift
//  Aura
//
//  Created by Hubert Daryanto on 06/10/20.
//

import SwiftUI

struct PaginationButtonView: View {
    //    @ObservedObject var page: PageSelection = PageSelection()
    @State var firstAidStepsCount: Int
    @Binding var page: Int
    var body: some View {
        ZStack
        {
            HStack(spacing: -8){
                ForEach(0..<firstAidStepsCount)
                { index in
                    if index == page{
                        PaginationSelectedView(index: index, page: $page)
                    }
                    else if index == page + 1 || index == page - 1
                    {
                        PaginationBesideSelectedView(index: index, page: $page)
                    }
                    else
                    {
                        PaginationNotSelectedView(index: index, page: $page)
                    }
                }
            }
        }.frame(width: 382, height: 56, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        
    }
}
