//
//  UserAuthView.swift
//  Aura
//
//  Created by Nabilah Ashriyah on 26/10/20.
//

import SwiftUI

struct UserAuthView: View {
    
    @State var gotoHome: Bool = false
    
    @State var gotoSetupUsername: Bool = false
    
    @State var gotoSetupProfile: Bool = false
    
    var body: some View {
            ZStack {
                VStack {
                    let imageWidth = 260 / 414 * UIScreen.main.bounds.width
                    
                    Image("onboarding-4")
                        .resizable()
                        .frame(width: imageWidth, height: imageWidth, alignment: .center)
                        .aspectRatio(contentMode: .fit)
                    
                    Text("Get the full experience")
                        .font(.custom(Graphik.bold.rawValue, size: 20, relativeTo: .body))
                        .foregroundColor(Color("purple50"))
                        .padding(.top)
                        .padding(.bottom, 5)
                    
                    Text("Sign in to alert and allow your caregiver to track your current location each time seizure about to happen.")
                        .font(.custom(Graphik.regular.rawValue, size: 17, relativeTo: .body))
                        .foregroundColor(Color("purple50"))
                        .frame(width: (365 / 414) * UIScreen.main.bounds.width, alignment: .center)
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .padding(.horizontal, 5)
                    
                    Text("")
                        .padding()
                    
                    AppleIDButton(gotoSetupUsername: self.$gotoSetupUsername, gotoHome: self.$gotoHome, label: .continue)
                        .aspectRatio(260 / 50, contentMode: .fit)
                        .frame(width: imageWidth, alignment: .center)
                    
                    Button(action: {
                        gotoSetupProfile.toggle()
                    }, label: {
                        Text("Maybe later").foregroundColor(.gray)
                    }) .padding(.top)
                }
                
                NavigationLink(
                    destination: HomePageView().navigationBarHidden(true),
                    isActive: $gotoHome,
                    label: {
                        Text("")
                    })
                
                NavigationLink(
                    destination: SetupProfileView().navigationBarHidden(true),
                    isActive: $gotoSetupProfile,
                    label: {
                        Text("")
                    })
                
                NavigationLink(
                    destination: SetupUsername().navigationBarHidden(true),
                    isActive: $gotoSetupUsername,
                    label: {
                        Text("")
                    })
                
            }
            .navigationBarHidden(true)
        }
    
}

struct UserAuthView_Previews: PreviewProvider {
    static var previews: some View {
        UserAuthView()
    }
}
