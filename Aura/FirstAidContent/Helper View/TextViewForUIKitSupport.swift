//
//  TextViewForUIKitSupport.swift
//  Aura
//
//  Created by Hubert Daryanto on 12/11/20.
//

import Foundation
import SwiftUI

struct TextWithAttributedString: UIViewRepresentable {
    
    var attributedString:NSMutableAttributedString
    @State var width: CGFloat
    
    
    func makeUIView(context: Context) -> UILabel {
        let label = TopAlignedLabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.contentMode = .scaleToFill
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.preferredMaxLayoutWidth = width
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: UIViewRepresentableContext<TextWithAttributedString>) {
        uiView.attributedText = attributedString
    }
    @IBDesignable class TopAlignedLabel: UILabel {
        override func drawText(in rect: CGRect) {
            if let stringText = text {
                let stringTextAsNSString = stringText as NSString
                let labelStringSize = stringTextAsNSString.boundingRect(with: CGSize(width: self.frame.width, height: CGFloat.greatestFiniteMagnitude),
                                                                        options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                                        attributes: [NSAttributedString.Key.font: font!],
                    context: nil).size
                super.drawText(in: CGRect(x: 0, y: 0, width: self.frame.width, height: ceil(labelStringSize.height)))
            } else {
                super.drawText(in: rect)
            }
        }
        override func prepareForInterfaceBuilder() {
            super.prepareForInterfaceBuilder()
            layer.borderWidth = 1
            layer.borderColor = UIColor.black.cgColor
        }
    }

}

