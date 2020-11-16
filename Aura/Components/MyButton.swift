//
//  MyButton.swift
//  Aura
//
//  Created by Stevhen on 15/10/20.
//

import SwiftUI

struct MyButton: View {
    
    var myText: String
    var myColor: Color
    
    var body: some View {
        Text(myText)
            .foregroundColor(.white)
            .padding()
            .frame(width: 381, height: 50, alignment: .center)
            .background(
                myColor
                .cornerRadius(8))
    }
}

struct MyButton_Previews: PreviewProvider {
    static var previews: some View {
        MyButton(myText: "Selesai", myColor: Color.red)
        
    }
}
