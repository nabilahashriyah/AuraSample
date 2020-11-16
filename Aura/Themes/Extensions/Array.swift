//
//  Array.swift
//  Aura
//
//  Created by Hubert Daryanto on 11/11/20.
//

import Foundation

extension Array{
    subscript(safe index: Index) -> Element? {
        let isValidIndex = index >= 0 && index < count
        return isValidIndex ? self[index] : nil
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
