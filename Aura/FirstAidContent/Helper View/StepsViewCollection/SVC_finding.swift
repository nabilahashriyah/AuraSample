//
//  SVC_finding.swift
//  Aura
//
//  Created by Hubert Daryanto on 23/10/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct SVC_finding: View {
    @State var steps: FirstAidSupport
    @State var name: String
    var body: some View {
        VStack (alignment: .leading){
            ZStack
            {
                AnimatedImage(data: try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "\(steps.image)", ofType: nil)!))).customLoopCount(0).playbackRate(1.0).resizable().cornerRadius(8.0, antialiased: false)
                
            }.frame(width: 382, height: 298, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Spacer().frame(width: 382, height: 16, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text(steps.title).font(.custom("Graphik-Bold", size: 34)).foregroundColor(Color("first_aid_title_color").opacity(1.0))
            Spacer().frame(width: 382, height: 16, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            ScrollView(){
                VStack(alignment: .leading, spacing: 0)
                {
                    ForEach(0..<steps.description.count)
                    {
                        index in
                            HStack(alignment: .top)
                            {
                                TextWithAttributedString(attributedString: steps.description[index] ,width: CGFloat(382))

                                
//                                Text("\(steps.description[index])").multilineTextAlignment(.leading).font(.custom("Graphik-Regular", size: 20)).foregroundColor(Color("first_aid_text_color")).lineSpacing(0)
                            }
                    }
                }
            }
        }
    }
}

