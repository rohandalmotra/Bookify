//
//  BookifyHaptic.swift
//  Bookify
//
//  Created by Tech Mash on 21/01/24.
//

import Foundation
import UIKit

public class BookifyHaptic{
    static func addHapticTouch(style: UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
