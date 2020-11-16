//
//  OnboardingCardModel.swift
//  Aura
//
//  Created by Stevhen on 13/10/20.
//

import SwiftUI

struct OnboardingCard: Identifiable {
    let id: String = UUID().uuidString
    let image: String
    let title: String
    let desc: String
}
