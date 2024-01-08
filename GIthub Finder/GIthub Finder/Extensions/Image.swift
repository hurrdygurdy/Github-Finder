//
//  Image.swift
//  GIthub Finder
//
//  Created by UserTest on 09/01/24.
//

import SwiftUI

extension Image {
    func setImage(maxWidth: CGFloat, maxHeight: CGFloat) -> some View {
        return self.resizable().frame(maxWidth: maxWidth, maxHeight: maxHeight).aspectRatio(contentMode: .fit)
    }
}
