//
//  BookifyTitleWithSubtitleHeaderCell.swift
//  Bookify
//
//  Created by Tech Mash on 20/01/24.
//

import UIKit

class BookifyTitleWithSubtitleHeaderCell: UITableViewHeaderFooterView {

    @IBOutlet weak var cntView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //setting cell's UI
        setupUI()
    }

}

//MARK: - Setting up UI
extension BookifyTitleWithSubtitleHeaderCell{
    private func setupUI(){
        //setting Cell's UI
        setupCellUI()
        
        //setting title label
        setupTitleLabel()
        
        //setting subtitle label
        setupSubtitleLabel()
    }
}

//MARK: - Setting Cell's UI
extension BookifyTitleWithSubtitleHeaderCell{
    private func setupCellUI(){
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.cntView.backgroundColor = .clear
        self.cntView.roundViewCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: BookifyHeightWidthConstants.BookifyCommon.cornerRadiusOfCells)
    }
}

//MARK: - Setting title label
extension BookifyTitleWithSubtitleHeaderCell{
    private func setupTitleLabel(){
        titleLabel.textColor = .bookifySecondary
        titleLabel.font = UIFont().BookifyMediumFont(BookifyFontSize.medium.rawValue)
    }
}


//MARK: - Setting subtitle label
extension BookifyTitleWithSubtitleHeaderCell{
    private func setupSubtitleLabel(){
        subTitleLabel.textColor = .bookifySecondary
        subTitleLabel.font = UIFont().BookifyMediumFont(BookifyFontSize.small.rawValue)
    }
}

//MARK: - Updating UI
extension BookifyTitleWithSubtitleHeaderCell{
    public func updateUI(titleText: String?, subtitleText: String?){
        //updating title label
        updateTitleLabel(text: titleText)
        
        //updating subtitle label
        updateSubtitleLabel(text: subtitleText)
    }
}

//MARK: - Updating UI Objects
extension BookifyTitleWithSubtitleHeaderCell{
    
    //updating title label
    private func updateTitleLabel(text: String?){
        titleLabel.text = text
    }
    
    //updating subtitle label
    private func updateSubtitleLabel(text: String?){
        subTitleLabel.text = text
    }
    
}

