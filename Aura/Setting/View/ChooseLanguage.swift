//
//  ChooseLanguage.swift
//  Aura
//
//  Created by Allicia Viona Sagi on 22/10/20.
//

import SwiftUI

struct ChooseLanguage: View {
    
    @EnvironmentObject
    var settings: Settings
    
    @State
    private var showAlert: Bool = false
    
    func exitApp(){
        exit(0)
    }
    
    func dismiss(){
        showAlert = false
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    // MARK: - Picker for Choosing First Aid Language
                    Picker(selection: $settings.firstAidLanguage
                           , label: Text("First Aid Language").foregroundColor(.black)
                    ) {
                        ForEach(0..<Settings.faLanguages.count, id: \.self) { index in
                            Text("\(Settings.faLanguages[index])")
                                .tag(index)
                        }
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                    }

                    // MARK: - Picker for Choosing App Language
                    Picker(selection: $settings.appLanguage
                           , label: Text("App Language").foregroundColor(.black)
                    ) {
                        ForEach(0..<Settings.appLanguages.count, id: \.self) { index in
                            Text("\(Settings.appLanguages[index])")
                                .tag(index)
                        }
                        .onChange(of: settings.appLanguage) { value in
                            showAlert.toggle()
                        }
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                    }
                    .alert(isPresented: $showAlert){
                        Alert(title: Text("Restart App"), message: Text("In order to change language, app need to be restarted."), primaryButton: .destructive(Text("Yes"), action: exitApp), secondaryButton: .default(Text("No"), action: dismiss))
                    }
                    
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ChooseLanguage_Previews: PreviewProvider {
    static var previews: some View {
        ChooseLanguage()
    }
}
