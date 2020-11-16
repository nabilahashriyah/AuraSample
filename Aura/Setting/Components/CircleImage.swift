//
//  CircleImage.swift
//  Aura
//
//  Created by Allicia Viona Sagi on 13/10/20.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    var body: some View {
        image
            .clipShape(Circle())
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("ProfilePictureExample"))
    }
}
