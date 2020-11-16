//
//  Extension+Fonts.swift
//  Aura
//
//  Created by Stevhen on 13/10/20.
//

import SwiftUI

enum Graphik: String {
    case bold = "Graphik-Bold"
    case semibold = "Graphik-Semibold"
    case medium = "Graphik-Medium"
    case light = "Graphik-Light"
    case regular = "Graphik-Regular"
}

extension ContentSizeCategory {
    var size: CGFloat {
        switch self {
        case .small:
            return 14
        case .medium:
            return 16
        case .large:
            return 20
        case .extraLarge:
            return 28
        default:
            return 14
        }
    }
}

extension View {
    func customFont(_ font: Graphik, category: ContentSizeCategory) -> some View {
        return self.customFont(font.rawValue, category: category)
    }
    func customFont(_ name: String, category: ContentSizeCategory) -> some View {
        return self.font(.custom(name, size: category.size))
    }
}
