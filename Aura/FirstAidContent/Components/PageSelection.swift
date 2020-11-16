//
//  PageController.swift
//  Aura
//
//  Created by Hubert Daryanto on 07/10/20.
//

import Foundation

class PageSelection: ObservableObject {
    @Published var page:Int = 0
    @Published var maskSizeLeft:Float = 0
    @Published var maskSizeRight:Float = 382 - 82.4
    
    func updatePage()
    {
        if page == 0
        {
            self.maskSizeLeft = 0
            self.maskSizeRight = 382 - 82.4
        }
        else if page == 1
        {
            self.maskSizeLeft = 70.4
            self.maskSizeRight = 382 - 76.4 - 82.4
        }
        else if page == 2
        {
            self.maskSizeLeft = 76.4 + 70.4
            self.maskSizeRight = 382 - 76.4 - 76.4 - 82.4
        }
        else if page == 3
        {
            self.maskSizeLeft = 76.4 + 76.4 + 70.4
            self.maskSizeRight = 382 - 76.4 - 76.4 - 76.4 - 82.4
        }
        else if page == 4
        {
            self.maskSizeLeft = 76.4 + 76.4 + 76.4 + 70.4
            self.maskSizeRight = 382 - 76.4 - 76.4 - 76.4 - 76.4 - 82.4
        }
    }
    
}
