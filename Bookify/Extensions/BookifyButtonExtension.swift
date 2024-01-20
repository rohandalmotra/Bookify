//
//  BookifyButtonExtension.swift
//  Bookify
//
//  Created by Tech Mash on 20/01/24.
//

import UIKit


extension UIButton {
    
    func setupRoundButton(withTitle: String, withRadius: CGFloat, buttonSize: BookifyFontSize? = .medium){
        titleLabel?.font = UIFont().BookifyBoldFont(buttonSize?.rawValue ?? BookifyFontSize.small.rawValue)
        backgroundColor = .bookifySecondary
        layer.cornerRadius = withRadius
        layer.borderWidth = BookifyHeightWidthConstants.BookifyCommon.cornerRadiusOfRoundButton
        setTitleColor(.bookifyTertiary, for: .normal)
        layer.borderColor = UIColor.bookifyPrimary.cgColor
        setTitle(withTitle, for: .normal)
        titleLabel?.numberOfLines = 0
        titleLabel?.textAlignment = .center
    }

}



