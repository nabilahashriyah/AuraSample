//
//  BAB_post.swift
//  Aura
//
//  Created by Hubert Daryanto on 23/10/20.
//

import SwiftUI

struct BAB_post: View {
    @State var showingMedicaId = false
    @ObservedObject var firstAidStatus: CaseSwitcher
    var body: some View {
        HStack{
            Button(action: {
                self.showingMedicaId = true
            }) {
                ZStack
                {
                    Rectangle().foregroundColor(Color("warning_timer_background")).cornerRadius(8.0)
                    HStack
                    {
                        Text("Medical ID").font(.custom("Graphik-Regular", size: 18)).foregroundColor(.white)
                    }
                }
            }.sheet(isPresented: $showingMedicaId, content: {
                VStack(alignment: .center, spacing: 0){
                    HStack(alignment: .center, spacing: 0){
                        Text("").frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                        Spacer()
                        Text("Medical ID").font(.system(size: 17, weight: .bold, design: .default))
                        Spacer()
                        Button(action: {
                            self.showingMedicaId = false
                        }, label: {
                            Text("Done").foregroundColor(AuraColors.solidPurple).frame(width: 100, alignment: .trailing)
                        })
                    }.padding(.horizontal).padding(.top, 26).padding(.bottom, 11)
                    Divider().frame(width: UIScreen.main.bounds.width, height: 1, alignment: .center)
                    HealthProfileView()
                }
                
            }).frame(width: 187, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            //            NavigationLink(destination: HealthProfileView()){
            //
            //            }
            Spacer()
            
            Button(action: {
                firstAidStatus.FirstAidState = .thankyou
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


//
//struct BAB_post_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack{
//            HStack(alignment: .center, spacing: 0){
//                Text("").frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
//                Spacer()
//                Text("Medical ID").font(.system(size: 17, weight: .bold, design: .default))
//                Spacer()
//                Text("Done").foregroundColor(AuraColors.solidPurple).frame(width: 100, height: 100, alignment: .trailing)
//            }.padding()
////            HealthProfileView()
//        }
//    }
//}

struct BAB_post_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .center, spacing: 0){
            HStack(alignment: .center, spacing: 0){
                Text("").frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                Spacer()
                Text("Medical ID").font(.system(size: 17, weight: .bold, design: .default))
                Spacer()
                    Text("Done").foregroundColor(AuraColors.solidPurple).frame(width: 100, alignment: .trailing)
            }.padding(.horizontal).padding(.top, 26).padding(.bottom, 11)
            Divider().frame(width: UIScreen.main.bounds.width, height: 1, alignment: .center)
        }.background(Color.green)
    }
}
