//
//  BookifyBottomSingleButtonView.swift
//  Bookify
//
//  Created by Tech Mash on 20/01/24.
//

import UIKit

class BookifyBottomSingleButtonView: UIView {

    @IBOutlet weak var cntView: UIView!
    @IBOutlet weak var actionButton: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        //setting views UI
        setupUI()
    }

}


//MARK: - Setting up UI
extension BookifyBottomSingleButtonView{
    private func setupUI(){
        //setting view UI
        setupViewUI()
       //setting action button
        setupActionButton()
        
    }
}

//MARK: - Setting up UI objects
extension BookifyBottomSingleButtonView{
    //setting view UI
    private func setupViewUI(){
        self.backgroundColor = .clear
        self.cntView.backgroundColor = .bookifyBackground
        self.cntView.roundViewCorners([.layerMaxXMinYCorner, .layerMinXMinYCorner], radius: BookifyHeightWidthConstants.BookifyCommon.cornerRadiusOfCells)
        self.cntView.layer.cornerCurve = .continuous
        
    }
    
    //setting action button
    private func setupActionButton(){
        actionButton.setTitleColor(.bookifySecondary, for: .normal)
        actionButton.titleLabel?.font = UIFont().BookifyMediumFont(BookifyFontSize.medium.rawValue)
        actionButton.imageView?.contentMode = .scaleToFill
    }
}

//MARK: - Updating title label
extension BookifyBottomSingleButtonView{
    //updating action button
    public func updateActionButtonTitle(title: String?){
        actionButton.setTitle(title ?? "Proceed Furthur", for: .normal)
    }
}
