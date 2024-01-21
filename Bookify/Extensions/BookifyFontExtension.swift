//
//  BookifyFontExtension.swift
//  Bookify
//
//  Created by Tech Mash on 20/01/24.
//

import Foundation
import UIKit

extension UIFont {
     
    func BookifyBoldFont(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Figtree-Bold", size: size)!
    }
    
    func BookifyMediumFont(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Figtree-Medium", size: size)!
    }
}


enum BookifyFontSize: CGFloat {
    case extraLarge = 29.0
    case large = 24.0
    case medium = 21.0
    case small = 18.0
    case extraSmall = 15.0
}
