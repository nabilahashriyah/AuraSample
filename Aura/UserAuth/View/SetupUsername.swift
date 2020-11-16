//
//  UsernameEntry.swift
//  Aura
//
//  Created by Nabilah Ashriyah on 30/10/20.
//

import SwiftUI

struct SetupUsername: View {
    @State var username: String = ""
    
    @State var nextPage: Bool = false
    
    var userProfile = UserProfile()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                
                let horizontalWidth = 260 / 414 * UIScreen.main.bounds.width
                
                let spacing = UIScreen.main.bounds.midX / 2.5
                
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
                
                TextField("Username", text: $username, onEditingChanged: { (changed) in
                    print("Username onEditingChanged - \(changed)")
                }) {
                    print("Username onCommit")
                }
                .font(.custom(Graphik.regular.rawValue, size: 17, relativeTo: .body))
                .multilineTextAlignment(.center)
                .frame(width: horizontalWidth)
                
                
                Divider().frame(width: horizontalWidth)
                
                Text("Usernames must be between 4 and 15 characters long.")
                    .font(.custom(Graphik.regular.rawValue, size: 12, relativeTo: .body))
                    .padding(.top, 5)
                    .foregroundColor(.secondary)
                    .frame(width: horizontalWidth)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Button(action: {
                    saveUsername(userName: username)
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
            
        }
        
        NavigationLink(
            destination: HomePageView().navigationBarHidden(true),
            isActive: $nextPage,
            label: {
                Text("")
            })
        
    }
    
    func saveUsername(userName: String) {
        userProfile.isUserNameAvailable(username: userName, completionHandler: {
            result in
            if result == true {
                userProfile.username = userName
                userProfile.saveToCloud()
                self.nextPage.toggle()
            } else {
                print("udah ada namanya cuy")
            }
        })
    }
    
}

struct SetupUsername_Previews: PreviewProvider {
    static var previews: some View {
        SetupUsername()
    }
}
