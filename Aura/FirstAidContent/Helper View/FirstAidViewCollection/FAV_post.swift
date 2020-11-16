//
//  FAV_post.swift
//  Aura
//
//  Created by Hubert Daryanto on 23/10/20.
//

import SwiftUI

struct FAV_post: View {
    @ObservedObject var firstAidStatus: CaseSwitcher
    @State var firstAidSupportData: [FirstAidSupport]
    var body: some View {
        VStack(spacing: 0)
        {
            SVC_post(steps: firstAidSupportData[1], firstAidStatus: firstAidStatus).frame(width: 382, height: UIScreen.main.bounds.size.height - 138, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            BAB_post(firstAidStatus: firstAidStatus)
            
        }.onAppear(perform: {
            NotificationRecord.stopUpdatingNotification()
        })
    }
}

//struct FAV_post_Previews: PreviewProvider {
//    static var previews: some View {
//        FAV_post()
//    }
//}
