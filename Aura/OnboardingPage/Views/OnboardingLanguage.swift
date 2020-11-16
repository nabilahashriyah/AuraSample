//
//  OnboardingLanguage.swift
//  Aura
//
//  Created by Stevhen on 08/11/20.
//

import Foundation

struct OnboardingLanguage {
    static func getData(language: String) -> [String]
    {
        if language == "0"
        {
            return [
                "ID",
                "Berikut",
                "Berikan Akses",
                "Lewatkan dulu",
                "Pilih Bahasa",
                "Bahasa apa yang anda inginkan?"
            ]
        }
        else
        {
            return [
                "EN",
                "Next",
                "Grant Access",
                "Skip for now",
                "Choose Language",
                "Which language do you prefer?"
            ]
        }
    }
}
