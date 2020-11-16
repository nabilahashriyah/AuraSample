//
//  PreFirstAid.swift
//  Aura
//
//  Created by Hubert Daryanto on 25/10/20.
//

import Foundation
import SwiftUI

struct FirstAidSupport: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var description: [NSMutableAttributedString]
}

public class FirstAidSupportData {
    static func getData(language: String, name: String? = "Jonathan") -> [FirstAidSupport]
    {
        let myName = "\(name!)"
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Graphik-Bold", size: 20) ]//font weight: 700 maybe
        
        let myAttribute2 = [ NSAttributedString.Key.font: UIFont(name: "Graphik-Regular", size: 20) ]
        
        let style = NSMutableParagraphStyle()
        
        style.alignment = .center
        let myAttribute3 = [ NSAttributedString.Key.font: UIFont(name: "Graphik-Regular", size: 20), NSAttributedString.Key.paragraphStyle: style]
        if language == "0"
        {
            let havingASeizure = "epilepsi"
            let firstAid = "Pertolongan Pertama"
            let bleeding = "pendarahan"
            let hardBreathe = "kesulitan bernapas"
            
            let resultForPreFirstAidSupport = NSMutableAttributedString()
            resultForPreFirstAidSupport.append(NSAttributedString(string: "Nama saya ", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            resultForPreFirstAidSupport.append(NSAttributedString(string: myName, attributes: myAttribute as [NSAttributedString.Key : Any]))
            resultForPreFirstAidSupport.append(NSAttributedString(string: ", saya sedang kejang karena ", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            resultForPreFirstAidSupport.append(NSAttributedString(string: havingASeizure, attributes: myAttribute as [NSAttributedString.Key : Any]))
            resultForPreFirstAidSupport.append(NSAttributedString(string: ". Tolong bantu saya dengan mengikuti langkah ", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            resultForPreFirstAidSupport.append(NSAttributedString(string: firstAid, attributes: myAttribute as [NSAttributedString.Key : Any]))
            resultForPreFirstAidSupport.append(NSAttributedString(string: ".\n\nJika saya mengalami ", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            resultForPreFirstAidSupport.append(NSAttributedString(string: bleeding, attributes: myAttribute as [NSAttributedString.Key : Any]))
            resultForPreFirstAidSupport.append(NSAttributedString(string: " dan ", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            resultForPreFirstAidSupport.append(NSAttributedString(string: hardBreathe, attributes: myAttribute as [NSAttributedString.Key : Any]))
            resultForPreFirstAidSupport.append(NSAttributedString(string: ", segera hubungi kontak darurat.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultForPostAidSupport1 = NSMutableAttributedString()
            resultForPostAidSupport1.append(NSAttributedString(string: "Kejang dapat menakutkan bagi yang mengalami, maupun yang menyaksikannya. Seseorang mungkin merasa bingung dan malu atas apa yang telah terjadi.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultForPostAidSupport2 = NSMutableAttributedString()
            resultForPostAidSupport2.append(NSAttributedString(string: "Tolong temani saya sampai kejang berakhir dan saya sadarkan diri.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultForPostAidSupport3 = NSMutableAttributedString()
            resultForPostAidSupport3.append(NSAttributedString(string: "Jelaskan secara sederhana atas apa yang telah terjadi, setelah saya dapat berkomunikasi dengan baik.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultForPostAidSupport4 = NSMutableAttributedString()
            resultForPostAidSupport4.append(NSAttributedString(string: "Yakinkan saya bahwa kondisi saya sudah aman.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultForPostAidSupport5 = NSMutableAttributedString()
            resultForPostAidSupport5.append(NSAttributedString(string: "Tanyakan apakah saya butuh ditemani sampai saya bisa kembali beraktivitas.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultForThankYouSupport = NSMutableAttributedString()
            resultForThankYouSupport.append(NSAttributedString(string: "Terima kasih telah membantu saya, pertolongan Anda sangat\nberarti bagi keselamatan saya.", attributes: myAttribute3 as [NSAttributedString.Key : Any]))
            
            return [
                FirstAidSupport(image: "intro.gif", title: "Saya punya epilepsi", description: [resultForPreFirstAidSupport]),
                FirstAidSupport(image: "PostSeizure.gif", title: "Setelah Kejang", description: [resultForPostAidSupport1, resultForPostAidSupport2, resultForPostAidSupport3, resultForPostAidSupport4, resultForPostAidSupport5]),
                FirstAidSupport(image: "Thankyou.png", title: "Terima Kasih", description: [resultForThankYouSupport]),
            ]
        }
        else
        {
            let havingASeizure = "having a seizure"
            let firstAid = "Seizure First Aid"
            let bleeding = "bleeding"
            let hardBreathe = "difficulty breathing"
            
            let resultForPreFirstAidSupport = NSMutableAttributedString()
            resultForPreFirstAidSupport.append(NSAttributedString(string: "My name is ", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            resultForPreFirstAidSupport.append(NSAttributedString(string: myName, attributes: myAttribute as [NSAttributedString.Key : Any]))
            resultForPreFirstAidSupport.append(NSAttributedString(string: ", and I’m ", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            resultForPreFirstAidSupport.append(NSAttributedString(string: havingASeizure, attributes: myAttribute as [NSAttributedString.Key : Any]))
            resultForPreFirstAidSupport.append(NSAttributedString(string: ". Please help me by following the ", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            resultForPreFirstAidSupport.append(NSAttributedString(string: firstAid, attributes: myAttribute as [NSAttributedString.Key : Any]))
            resultForPreFirstAidSupport.append(NSAttributedString(string: " steps.\n\n In case I’m ", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            resultForPreFirstAidSupport.append(NSAttributedString(string: bleeding, attributes: myAttribute as [NSAttributedString.Key : Any]))
            resultForPreFirstAidSupport.append(NSAttributedString(string: " or having ", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            resultForPreFirstAidSupport.append(NSAttributedString(string: hardBreathe, attributes: myAttribute as [NSAttributedString.Key : Any]))
            resultForPreFirstAidSupport.append(NSAttributedString(string: ", please contact emergency services immediately.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultForPostAidSupport1 = NSMutableAttributedString()
            resultForPostAidSupport1.append(NSAttributedString(string: "Seizures can be frightening for the person having one, as well as for others. People may feel embarrassed or confused about what happened.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultForPostAidSupport2 = NSMutableAttributedString()
            resultForPostAidSupport2.append(NSAttributedString(string: "Stay with me until the seizure ends and I’m fully awake.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultForPostAidSupport3 = NSMutableAttributedString()
            resultForPostAidSupport3.append(NSAttributedString(string: "Once I’m alert and able to communicate, tell me what happened in very simple terms.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultForPostAidSupport4 = NSMutableAttributedString()
            resultForPostAidSupport4.append(NSAttributedString(string: "Reassure me that I’m safe.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultForPostAidSupport5 = NSMutableAttributedString()
            resultForPostAidSupport5.append(NSAttributedString(string: "Offer to stay with me until I am ready to go back to normal activity.", attributes: myAttribute2 as [NSAttributedString.Key : Any]))
            
            let resultForThankYouSupport = NSMutableAttributedString()
            resultForThankYouSupport.append(NSAttributedString(string: "Thank you for saving my life, it means a lot to me.", attributes: myAttribute3 as [NSAttributedString.Key : Any]))

            return[
                FirstAidSupport(image: "intro.gif", title: "I have epilepsy", description: [resultForPreFirstAidSupport]),
                FirstAidSupport(image: "PostSeizure.gif", title: "Post Seizure", description: [resultForPostAidSupport1, resultForPostAidSupport2, resultForPostAidSupport3, resultForPostAidSupport4, resultForPostAidSupport5]),
                FirstAidSupport(image: "Thankyou.png", title: "Thank you", description: [resultForThankYouSupport]),
            ]
        }
    }
}
