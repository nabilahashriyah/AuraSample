//
//  CaseSwitcher.swift
//  Aura
//
//  Created by Hubert Daryanto on 22/10/20.
//

import Foundation

class CaseSwitcher: ObservableObject {
    enum FirstAidHelpProcess{
        case findingHelp
        case inHelp
        case postHelp
        case thankyou
    }
    
    @Published var FirstAidState = FirstAidHelpProcess.findingHelp
}
