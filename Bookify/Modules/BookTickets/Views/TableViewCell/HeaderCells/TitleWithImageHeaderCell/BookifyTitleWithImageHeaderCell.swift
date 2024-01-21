//
//  BookifyTitleWithImageHeaderCell.swift
//  Bookify
//
//  Created by Tech Mash on 21/01/24.
//

import UIKit

class BookifyTitleWithImageHeaderCell: UITableViewHeaderFooterView {

    @IBOutlet weak var cntView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        //setting cell's UI
        setupUI()
    }

}

//MARK: - Setting up UI
extension BookifyTitleWithImageHeaderCell{
    private func setupUI(){
        //setting Cell's UI
        setupCellUI()
        
        //setting title label
        setupTitleLabel()
        
        //setting icon image
        setupIconImage()
    }
}

//MARK: - Setting Cell's UI
extension BookifyTitleWithImageHeaderCell{
    private func setupCellUI(){
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.cntView.backgroundColor = .clear
        self.cntView.roundViewCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: BookifyHeightWidthConstants.BookifyCommon.cornerRadiusOfCells)
    }
}

//MARK: - Setting title label
extension BookifyTitleWithImageHeaderCell{
    private func setupTitleLabel(){
        titleLabel.textColor = .bookifySecondary
        titleLabel.font = UIFont().BookifyMediumFont(BookifyFontSize.medium.rawValue)
    }
}


//MARK: - Setting icon image
extension BookifyTitleWithImageHeaderCell{
    private func setupIconImage(){
        iconImage.layer.cornerRadius = iconImage.frame.width/2
    }
}

//MARK: - Updating UI
extension BookifyTitleWithImageHeaderCell{
    public func updateUI(titleText: String?, iconImage: String?){
        //updating title label
        updateTitleLabel(text: titleText)
        
        //updating icon image
        updateIconImage(imageName: iconImage)
    }
}

//MARK: - Updating UI Objects
extension BookifyTitleWithImageHeaderCell{
    
    //updating title label
    private func updateTitleLabel(text: String?){
        titleLabel.text = text
    }
    
    //updating icon image
    private func updateIconImage(imageName: String?){
        iconImage.image = UIImage(named: imageName ?? "")
    }
    
}

