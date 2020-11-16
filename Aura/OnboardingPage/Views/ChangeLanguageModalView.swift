//
//  ChangeLanguageModalView.swift
//  Aura
//
//  Created by Stevhen on 08/11/20.
//

import SwiftUI

struct ChangeLanguageModalView: View {
    @Binding var showingChangeLanguageModal: Bool
    
    @ObservedObject var card: OnboardingCardViewModel
    
    func fetchCards() {
        self.card.fetchCards(UserDefaults.standard.string(forKey: "appLanguage")!)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            
            VStack(alignment: .leading) {
                
                HStack(alignment: .top) {
                    
                    VStack(alignment: .leading) {
                        
                        Text(OnboardingLanguage.getData(language: UserDefaults.standard.string(forKey: "appLanguage")!)[4])
                            .foregroundColor(AuraColors.solidPurple)
                            .font(.custom("Graphik-Bold", size: 20))
                        
                        Text(OnboardingLanguage.getData(language: UserDefaults.standard.string(forKey: "appLanguage")!)[5])
                            .foregroundColor(Color("gray_color"))
                            .font(.custom("Graphik-Regular", size: 14))
                        
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.showingChangeLanguageModal = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(.black)
                            .font(.title3)
                            .offset(y: 7)
                    })
                    .frame(width: 19, height: 20, alignment: .center)
                    
                }
                
                Divider().frame(width: 382, height: 1, alignment: .center)
                
                Button(action: {
                    print("Languange Changed to EN")
                    UserDefaults.standard.set(1, forKey: "appLanguage")
                    UserDefaults.standard.set(1, forKey: "firstAidLanguage")
                    
                    fetchCards()
                    
                    self.showingChangeLanguageModal.toggle()
                }, label: {
                    
                    HStack(spacing: 16) {
                        
                        Image("EN")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 24, height: 24)
                        
                        Text("English")
                            .font(.custom("Graphik-Regular", size: 17))
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    
                })
                
                Divider().frame(width: 382, height: 1, alignment: .center)
                
                Button(action: {
                    print("Languange Changed to ID")
                    UserDefaults.standard.set(0, forKey: "appLanguage")
                    UserDefaults.standard.set(0, forKey: "firstAidLanguage")
                    
                    fetchCards()
                    
                    self.showingChangeLanguageModal.toggle()
                }, label: {
                    
                    HStack(spacing: 16) {
                        
                        Image("ID")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 24, height: 24)
                        
                        Text("Bahasa Indonesia")
                            .font(.custom("Graphik-Regular", size: 17))
                            .foregroundColor(.black)
                            
                        Spacer()
                    }
                })
            }
            .padding(.horizontal)
                
            .navigationBarTitle("Back", displayMode: .inline)
        }
    }
}
