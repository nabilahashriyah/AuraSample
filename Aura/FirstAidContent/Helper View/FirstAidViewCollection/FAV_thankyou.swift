//
//  FAV_thankyou.swift
//  Aura
//
//  Created by Hubert Daryanto on 23/10/20.
//

import SwiftUI

struct FAV_thankyou: View {
    @ObservedObject var firstAidStatus: CaseSwitcher
    @State var firstAidSupportData: [FirstAidSupport]
    @Binding var isPresented: Bool
    var body: some View {
        VStack(spacing: 0)
        {
            SVC_thank(steps: firstAidSupportData[2]).frame(width: 414, height: UIScreen.main.bounds.size.height - 138, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            BAB_thankyou(firstAidStatus: firstAidStatus, isPresented: $isPresented)
        }
        .onAppear(perform: {
            NotificationRecord.stopUpdatingNotification()
        })
    }
}

//struct FAV_thankyou_Previews: PreviewProvider {
//    static var previews: some View {
//        FAV_thankyou()
//    }
//}
