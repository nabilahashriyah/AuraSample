//
//  OnboardingCardViewModel.swift
//  Aura
//
//  Created by Stevhen on 13/10/20.
//

import SwiftUI

class OnboardingCardViewModel: ObservableObject {
    @Published var cards: [OnboardingCard] = []
    
    func fetchCards(_ language: String) {
        cards = [
            OnboardingCard(
                image: "onboarding-1",
                title: "Seizure Alert",
                desc: "Aura will alert your surroundings and send immediate help requests to caregivers when you are about to have a seizure."
            ),
            OnboardingCard(
                image: "onboarding-2",
                title: "Seizure First Aid",
                desc: "During a seizure, Aura will guide people around you to give first aid with step-by-step guidance."
            ),
            OnboardingCard(image: "onboarding-3", title: "Allow access to Health App", desc: "Aura will read your Medical ID data in order to assist first responder in emergency situations.")
        ]
        
        if language == "0" {
            cards = [
                OnboardingCard(image: "onboarding-1", title: "Peringatan Kejang", desc: "Aura memperingati orang sekitar dan mengirimkan permintaan bantuan pada kerabat saat Anda akan mengalami kejang."),
                OnboardingCard(image: "onboarding-2", title: "Pertolongan Pertama Kejang", desc: "Aura akan memandu orang di sekitar Anda untuk memberikan pertolongan pertama saat terjadi kejang."),
                OnboardingCard(image: "onboarding-3", title: "Izinkan akses ke app Kesehatan", desc: "Aura akan mengakses data ID Medis Anda untuk membantu petugas medis dalam situasi darurat.")
            ]
        }
    }
}
