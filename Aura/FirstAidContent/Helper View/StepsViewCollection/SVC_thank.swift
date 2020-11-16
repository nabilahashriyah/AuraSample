//
//  SVC_thank.swift
//  Aura
//
//  Created by Hubert Daryanto on 23/10/20.
//

import SwiftUI

struct SVC_thank: View {
    @State var steps: FirstAidSupport
    var body: some View {
        VStack(alignment: .center, spacing: 0){
            ZStack
            {
                Image(uiImage: UIImage(data: try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "\(steps.image)", ofType: nil)!)))!).resizable().aspectRatio(contentMode: .fit).cornerRadius(8)
            }.frame(width: 414, height: 324, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Spacer().frame(width: 414, height: 16, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text(steps.title).font(.custom("Graphik-Bold", size: 34)).foregroundColor(Color("first_aid_title_color").opacity(1.0)).frame(width: 382, height: 30, alignment: .center)
            Spacer().frame(width: 414, height: 16, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            TextWithAttributedString(attributedString: steps.description[0] ,width: CGFloat(307)).frame(minWidth: 307, idealWidth: 307, maxWidth: 307, minHeight: 43, idealHeight: 43, maxHeight: 68, alignment: .center)
            Spacer()
                }
    }
}
