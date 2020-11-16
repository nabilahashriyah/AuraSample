//
//  AnimatingImage.swift
//  Aura
//
//  Created by Hubert Daryanto on 25/10/20.
//

import SwiftUI

struct AnimatingImage: UIViewRepresentable {
    var animatingImage: UIImage
    func makeUIView(context: Context) -> some UIView {
        let animagedImage = animatingImage
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 382, height: 275))
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        image.autoresizesSubviews = true
        image.contentMode = UIView.ContentMode.scaleAspectFill
        image.image = animagedImage
        view.addSubview(image)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

