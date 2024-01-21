//
//  BookifyHeightAndWidthConstants.swift
//  Bookify
//
//  Created by Tech Mash on 20/01/24.
//

import Foundation
import UIKit

struct BookifyHeightWidthConstants{
    
    struct BookifyCommon{
        static let cornerRadiusOfRoundButton: CGFloat = 3
        static let topBarHeight: CGFloat = 56
        static let bottomSingleButtonViewHeight: CGFloat = 100
        static let cornerRadiusOfCells: CGFloat = 16
        static let cornerRadiusOfOuterView: CGFloat = 32
        static let cornerRadiusOfLabels: CGFloat = 8
        static let locationSelectionCollectionViewWidth: CGFloat = UIScreen.main.bounds.width/2 - 32
        static let locationSelectionCollectionViewHeight: CGFloat = locationSelectionCollectionViewWidth
        
        static let peopleSelectionCVHeightWidht: CGFloat = 100
        static let distanceBetweenCVCells: CGFloat = 16
        static let distanceFromPreviousScreen: CGFloat = 100
    }
    
    struct BookifyHomeVCConstants{
        static let wightOfStartButton: CGFloat = 200
        static let heightOfStartButton: CGFloat = 200
    }
    
}
