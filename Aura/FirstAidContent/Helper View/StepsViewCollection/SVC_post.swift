//
//  SVC_post.swift
//  Aura
//
//  Created by Hubert Daryanto on 23/10/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct SVC_post: View {
    @State var steps: FirstAidSupport
    @ObservedObject var firstAidStatus: CaseSwitcher
    @State var showAlert = false
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            ZStack
            {
                AnimatedImage(data: try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "\(steps.image)", ofType: nil)!))).customLoopCount(0).playbackRate(1.0).resizable().cornerRadius(8.0, antialiased: false)
//                VStack{
//                    Spacer().frame(width: 382, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                    
//                    Spacer().frame(width: 382, height: 270, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                }.frame(width: 382, height: 298, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }.frame(width: 382, height: 298, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Spacer().frame(width: 382, height: 16, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text(steps.title).font(.custom("Graphik-Bold", size: 34)).foregroundColor(Color("first_aid_title_color").opacity(1.0)).frame(width: 382, height: 30, alignment: .leading)
            Spacer().frame(width: 382, height: 16, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            ScrollView(){
                VStack(alignment: .leading, spacing: 0)
                {
                    TextWithAttributedString(attributedString: steps.description[0] ,width: CGFloat(382))
                    //                    Text("\(steps.description[0])").multilineTextAlignment(.leading).font(.custom("Graphik-Regular", size: 20)).foregroundColor(Color("first_aid_text_color")).lineSpacing(0)
                    ForEach(1..<steps.description.count)
                    {
                        index in
                            HStack(alignment: .top)
                            {
                                Circle().frame(width: 8.47, height: 8, alignment: .top).foregroundColor(.black).offset(x: 0, y: 10.0)
                                    TextWithAttributedString(attributedString: steps.description[index] ,width: CGFloat(356))
                                //                                Text("\(steps.description[index])").multilineTextAlignment(.leading).font(.custom("Graphik-Regular", size: 20)).foregroundColor(Color("first_aid_text_color")).lineSpacing(0)
                            }
                    }
                }
            }
            Spacer()
        }
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
