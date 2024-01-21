//
//  BookifyDropdrownButtonBarView.swift
//  Bookify
//
//  Created by Tech Mash on 21/01/24.
//

import UIKit

class BookifyDropdrownButtonBarView: UIView {

    @IBOutlet weak var cntView: UIView!
    @IBOutlet weak var dropdownButton: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        //setting view UI
        setupUI()
    }

}



//MARK: - Setting up UI
extension BookifyDropdrownButtonBarView{
    private func setupUI(){
        //setting view UI
        setupViewUI()
       //setting dropdown button
        setupDropdownButton()
        
    }
}

//MARK: - Setting up UI objects
extension BookifyDropdrownButtonBarView{
    //setting view UI
    private func setupViewUI(){
        self.backgroundColor = .clear
        self.cntView.backgroundColor = .clear
        
    }
    
    //setting action button
    private func setupDropdownButton(){
        dropdownButton.setImage(UIImage(named: "dropdownIcon")?.withTintColor(.bookifySecondary, renderingMode: .alwaysOriginal), for: .normal)
        dropdownButton.imageView?.contentMode = .scaleToFill
        dropdownButton.imageView?.clipsToBounds = true
    }
}

