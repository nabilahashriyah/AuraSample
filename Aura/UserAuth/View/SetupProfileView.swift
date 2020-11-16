//
//  SetupProfileView.swift
//  Aura
//
//  Created by Nabilah Ashriyah on 02/11/20.
//

import SwiftUI

struct SetupProfileView: View {
    @State var firstname: String = ""
    
    @State var lastname: String = ""
    
    @State var nextPage: Bool = false
    
    let userProfile = UserProfile()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .center) {
                    let horizontalWidth = 260 / 414 * UIScreen.main.bounds.width
                    
                    let spacing = UIScreen.main.bounds.midX / 4
                    
                    VStack {
                        Text("Let’s set up Your Profile")
                            .font(.custom(Graphik.medium.rawValue, size: 20, relativeTo: .body))
                            .padding(.bottom, 5)
                        
                        Text("Tap on the fields below to setup your profile")
                            .font(.custom(Graphik.regular.rawValue, size: 17, relativeTo: .body))
                            .frame(width: horizontalWidth)
                            .padding(.horizontal, 5)
                            .frame(width: (365 / 414) * UIScreen.main.bounds.width, alignment: .center)
                            .multilineTextAlignment(.center)
                    } .padding(.bottom, spacing)
                    
                    TextField("First Name", text: $firstname, onEditingChanged: { (changed) in
                        print("Username onEditingChanged - \(changed)")
                    }) {
                        print("Username onCommit")
                    }
                    .font(.custom(Graphik.regular.rawValue, size: 17, relativeTo: .body))
                    .multilineTextAlignment(.center)
                    .frame(width: horizontalWidth)
                    .padding(.top)
                    
                    Divider().padding(.bottom).frame(width: horizontalWidth)
                    
                    TextField("Last Name", text: $lastname, onEditingChanged: { (changed) in
                        print("Username onEditingChanged - \(changed)")
                    }) {
                        print("Username onCommit")
                    }
                    .font(.custom(Graphik.regular.rawValue, size: 17, relativeTo: .body))
                    .multilineTextAlignment(.center)
                    .frame(width: horizontalWidth)
                    
                    Divider().frame(width: horizontalWidth)
                    
                    Spacer()
                    
                    Button(action: {
                        userProfile.firstname = firstname
                        userProfile.lastname = lastname
                        nextPage.toggle()
                    }, label: {
                        Text("Set up")
                            .foregroundColor(Color("purple50"))
                            .frame(width: horizontalWidth)
                            .padding(.vertical)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("purple50"), lineWidth: 1)
                            )
                    }) 
                }
                .padding(.horizontal)
                .padding(.bottom, UIScreen.main.bounds.midY / 3.5)
                .padding(.top, UIScreen.main.bounds.midY / 6)
                
                NavigationLink(
                    destination: HomePageView().navigationBarHidden(true),
                    isActive: $nextPage,
                    label: {
                        Text("")
                    })
            }
        }
    }
}

struct SetupProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SetupProfileView()
    }
}
