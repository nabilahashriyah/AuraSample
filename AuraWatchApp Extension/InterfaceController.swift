//
//  InterfaceController.swift
//  AuraWatchApp Extension
//
//  Created by Alldo Kurniawan on 12/11/20.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBAction func alertButton() {
        pushController(withName: "DelayScreen", context: "")
    }
    

}
