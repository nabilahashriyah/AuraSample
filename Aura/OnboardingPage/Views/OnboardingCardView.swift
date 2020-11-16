//
//  OnboardingCardView.swift
//  Aura
//
//  Created by Stevhen on 13/10/20.
//

import SwiftUI

struct OnboardingCardView: View {
    
    var card: OnboardingCard
    
    var body: some View {
        VStack(spacing: 18) {
            
            Image(card.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 260, height: 260)
                .padding(30)
                
            VStack(alignment: .center, spacing: 8) {
                Text(card.title)
                    .kerning(0.36)
                    .font(.custom("Graphik-Bold", size: 22))
                    .foregroundColor(AuraColors.solidPurple)
                
                Text(card.desc)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .font(.custom("Graphik-Regular", size: 17))
                    .foregroundColor(AuraColors.dimBlack)
                    
                    
            }
            .frame(width: 350)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCardView(card: OnboardingCard(image: "onboarding-1", title: "Peringatan Kejang", desc: "Aura membantu Anda memperingati orang sekitar dan mengirimkan permintaan bantuan kepada kerabat saat Anda akan mengalami kejang."))
    }
}
