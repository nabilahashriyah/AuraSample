//
//  AppleIDButton.swift
//  Aura
//
//  Created by Nabilah Ashriyah on 01/11/20.
//

import SwiftUI
import AuthenticationServices


var errorSigningIn: Bool = false

struct AppleIDButton: View {
    
    @Binding var gotoSetupUsername: Bool
    
    @Binding var gotoHome: Bool
    
    let userProfile = UserProfile()
    
    var label: SignInWithAppleButton.Label = .continue
    
    var body: some View {
        SignInWithAppleButton(label, onRequest: { request in
            request.requestedScopes = [.fullName, .email]
        }, onCompletion: { result in
            switch result {
            case .success(let authResults):
                print("Authorisation successful")
                switch authResults.credential {
                case let appleIDCredential as ASAuthorizationAppleIDCredential:
                    
                    // Create an account in your system.
                    let userIdentifier = appleIDCredential.user
                    let fullName = appleIDCredential.fullName
                    let email = appleIDCredential.email
                
                    userProfile.userID = userIdentifier
                    
                    self.saveUserInKeychain(userIdentifier)
                    
                    userProfile.hasAlreadySignedUp(userIdentifier: userIdentifier, completionHandler: {
                        result in
                        if result == true {
                            userProfile.fetchFromCloud(userIdentifier: userIdentifier)
                            gotoHome.toggle()
                        } else {
                            userProfile.firstname = (fullName?.givenName)!
                            userProfile.lastname = (fullName?.familyName)!
                            userProfile.email = email!
                            gotoSetupUsername.toggle()
                        }
                    })
                
                case let passwordCredential as ASPasswordCredential:

                    // Sign in using an existing iCloud Keychain credential.
                    let username = passwordCredential.user
                    let password = passwordCredential.password

                    print("udah pernah login ada di keychain")
                    gotoHome.toggle()
                default:
                    break
                }
                
            case .failure(let error):
                print("Authorisation failed: \(error.localizedDescription)")
                errorSigningIn = true
                gotoHome.toggle()
            }
        })
        
    }
    
    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: "com.nabaash.Aura", account: "userIdentifier").saveItem(userIdentifier)
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }
}
