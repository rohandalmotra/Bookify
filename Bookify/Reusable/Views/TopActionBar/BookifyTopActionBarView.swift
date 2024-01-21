//
//  BookifyTopActionBarView.swift
//  Bookify
//
//  Created by Tech Mash on 20/01/24.
//

import UIKit

class BookifyTopActionBarView: UIView {

    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var cntView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //setting view UI
        setupUI()
    }

}


//MARK: - Setting up UI
extension BookifyTopActionBarView{
    private func setupUI(){
        //setting view UI
        setupViewUI()
       //setting action button
        setupActionButton()
        
    }
}

//MARK: - Setting up UI objects
extension BookifyTopActionBarView{
    //setting view UI
    private func setupViewUI(){
        self.backgroundColor = .clear
        self.cntView.backgroundColor = .clear
        
    }
    
    //setting action button
    private func setupActionButton(){
        actionButton.setImage(UIImage(named: "crossIcon")?.withTintColor(.bookifySecondary, renderingMode: .alwaysOriginal), for: .normal)
        actionButton.imageView?.contentMode = .scaleToFill
        actionButton.imageView?.clipsToBounds = true
    }
}

