//
//  SVC_in.swift
//  Aura
//
//  Created by Hubert Daryanto on 23/10/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct SVC_in: View {
    @State var steps: FirstAidSteps
    var body: some View {
        VStack (alignment: .leading, spacing: 0){
            ZStack
            {
                AnimatedImage(data: try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "\(steps.image)", ofType: nil)!)))
                    .customLoopCount(0)
                    .playbackRate(1.0)
                    .resizable()
                    .cornerRadius(8.0, antialiased: false).frame(width: 382, height: 298, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }.frame(width: 382, height: 298, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Spacer().frame(width: 382, height: 16, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text(steps.title).font(.custom("Graphik-Bold", size: 34)).foregroundColor(Color("first_aid_title_color").opacity(1.0)).lineSpacing(0).padding(.bottom, 8)
            ScrollView(){
                VStack(alignment: .leading, spacing: 0)
                {
                    ForEach(0..<steps.description.count)
                    {
                        index in
                            HStack(alignment: .top)
                            {
                                Circle().frame(width: 8.47, height: 8, alignment: .top).foregroundColor(.black).offset(x: 0, y: 10.0)
                                TextWithAttributedString(attributedString: steps.description[index] ,width: CGFloat(363))
                            }
                    }
                }
            }
        }
    }
}
