//
//  FirstAidSteps.swift
//  Aura
//
//  Created by Hubert Daryanto on 06/10/20.
//

import Foundation
import UIKit

struct FirstAidSteps: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var description: [NSMutableAttributedString]
}

public class FirstAidStepsData {
    static func getData(language: String) -> [FirstAidSteps]
    {
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Graphik-Bold", size: 20) ]//font weight: 700 maybe
        
        let myAttribute2 = [ NSAttributedString.Key.font: UIFont(name: "Graphik-Regular", size: 20) ]
        
        let style = NSMutableParagraphStyle()
        
        style.alignment = .center
        
        if language == "0"
        {
            let holdmedown = "Jangan menahan kejang saya."
            let objects = "Jangan masukkan benda apapun ke dalam mulut saya."
            let minutes = "Jika saya kejang lebih dari 5 menit,"
            
            let resultStep1_1 = NSMutableAttributedString()
            resultStep1_1.append(NSAttributedString(string: "Peringati orang sekitar untuk tidak panik.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultStep1_2 = NSMutableAttributedString()
            resultStep1_2.append(NSAttributedString(string: "Pastikan saya berada di tempat aman.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultStep2_1 = NSMutableAttributedString()
            resultStep2_1.append(NSAttributedString(string: "Beri saya ruang untuk bernapas.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultStep2_2 = NSMutableAttributedString()
            resultStep2_2.append(NSAttributedString(string: "Anjurkan orang sekitar untuk memberi jarak.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultStep3_1 = NSMutableAttributedString()
            resultStep3_1.append(NSAttributedString(string: "Letakkan bantalan lembut di bawah kepala saya.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultStep3_2 = NSMutableAttributedString()
            resultStep3_2.append(NSAttributedString(string: "Longgarkan pakaian atau aksesoris yang membuat saya kesulitan bernapas.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultStep3_3 = NSMutableAttributedString()
            resultStep3_3.append(NSAttributedString(string: holdmedown, attributes: myAttribute as [NSAttributedString.Key : Any]))
            
            let resultStep4_1 = NSMutableAttributedString()
            resultStep4_1.append(NSAttributedString(string: "Arahkan wajah saya menghadap ke bawah.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultStep4_2 = NSMutableAttributedString()
            resultStep4_2.append(NSAttributedString(string: objects, attributes: myAttribute as [NSAttributedString.Key : Any]))
            
            let resultStep5_1 = NSMutableAttributedString()
            resultStep5_1.append(NSAttributedString(string: minutes, attributes: myAttribute as [NSAttributedString.Key : Any]))
            resultStep5_1.append(NSAttributedString(string: " segera hubungi ambulans.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultStep5_2 = NSMutableAttributedString()
            resultStep5_2.append(NSAttributedString(string: "Jika saya sudah sadarkan diri, tolong hubungi kerabat saya.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            return [
                FirstAidSteps(image: "step_1.gif", title: "Tetap Tenang", description: [resultStep1_1, resultStep1_2]),
                FirstAidSteps(image: "step_2.gif", title: "Beri Jarak", description: [resultStep2_1, resultStep2_2]),
                FirstAidSteps(image: "step_3.gif", title: "Baringkan Tubuh Saya", description: [resultStep3_1, resultStep3_2, resultStep3_3]),
                FirstAidSteps(image: "step_4.gif", title: "Miringkan tubuh saya ke kanan.", description: [resultStep4_1, resultStep4_2]),
                FirstAidSteps(image: "step_5.gif", title: "Hubungi kontak darurat.", description: [resultStep5_1, resultStep5_2]),
            ]
        }
        else
        {
            let holdmedown = "Don't hold me down,"
            let objects = "Don’t put any objects"
            let minutes = "If my seizure lasts longer than 5 minutes,"
            
            let resultStep1_1 = NSMutableAttributedString()
            resultStep1_1.append(NSAttributedString(string: "Tell others to stay calm too.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultStep1_2 = NSMutableAttributedString()
            resultStep1_2.append(NSAttributedString(string: "Make sure I’m in a safe place.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultStep2_1 = NSMutableAttributedString()
            resultStep2_1.append(NSAttributedString(string: "Give me some space.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultStep2_2 = NSMutableAttributedString()
            resultStep2_2.append(NSAttributedString(string: "Encourage people to take a few steps back.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultStep3_1 = NSMutableAttributedString()
            resultStep3_1.append(NSAttributedString(string: "Put something soft under my head.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultStep3_2 = NSMutableAttributedString()
            resultStep3_2.append(NSAttributedString(string: "Loosen anything tight that may make it hard for me to breathe.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultStep3_3 = NSMutableAttributedString()
            resultStep3_3.append(NSAttributedString(string: holdmedown, attributes: myAttribute as [NSAttributedString.Key : Any]))
            resultStep3_3.append(NSAttributedString(string: " it won't stop my seizure.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultStep4_1 = NSMutableAttributedString()
            resultStep4_1.append(NSAttributedString(string: "Point my mouth toward the ground.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultStep4_2 = NSMutableAttributedString()
            resultStep4_2.append(NSAttributedString(string: objects, attributes: myAttribute as [NSAttributedString.Key : Any]))
            resultStep4_2.append(NSAttributedString(string: " in my mouth.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultStep5_1 = NSMutableAttributedString()
            resultStep5_1.append(NSAttributedString(string: minutes, attributes: myAttribute as [NSAttributedString.Key : Any]))
            resultStep5_1.append(NSAttributedString(string: " please call an ambulance.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultStep5_2 = NSMutableAttributedString()
            resultStep5_2.append(NSAttributedString(string: "If I have fully awaken, please call my caregiver.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            return[
                FirstAidSteps(image: "step_1.gif", title: "Remain calm", description: [resultStep1_1, resultStep1_2]),
                FirstAidSteps(image: "step_2.gif", title: "Keep airway clear", description: [resultStep2_1, resultStep2_2]),
                FirstAidSteps(image: "step_3.gif", title: "Lay me down", description: [resultStep3_1, resultStep3_2, resultStep3_3]),
                FirstAidSteps(image: "step_4.gif", title: "Turn me onto my right side", description: [resultStep4_1, resultStep4_2]),
                FirstAidSteps(image: "step_5.gif", title: "Call Emergency if necessary", description: [resultStep5_1, resultStep5_2]),
            ]
        }
    }
}
