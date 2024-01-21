//
//  BookifyCentreLabelCollectionViewCell.swift
//  Bookify
//
//  Created by Tech Mash on 21/01/24.
//

import UIKit

class BookifyCentreLabelCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cntView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var peopleCanJoin: Int?{
        didSet{
            guard let peopleCanJoinResponse = peopleCanJoin else{return}
            updateTitleLabel(text: "\(peopleCanJoinResponse)")
        }
    }
    
    override var isSelected: Bool {
         didSet {
             // Update UI based on the selection state
             if isSelected {
                 titleLabel.textColor = .bookifyTertiary
                 titleLabel.layer.borderWidth = 1
             } else {
                 titleLabel.textColor = .bookifySecondary
                 titleLabel.layer.borderWidth = 0
             }
         }
     }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //setting up UI
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }

}


//MARK: - Setting up UI

extension BookifyCentreLabelCollectionViewCell{
    private func setupUI(){
        //setting cell's UI
        setupCellUI()
        //setting titleLabel
        setupTitleLabel()
    }
}


// MARK: - Setting UI of the Objects

extension BookifyCentreLabelCollectionViewCell{
    
    //setting cell's UI
    private func setupCellUI(){
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.cntView.layer.cornerRadius = BookifyHeightWidthConstants.BookifyCommon.cornerRadiusOfCells
        self.cntView.layer.cornerCurve = .continuous
        self.cntView.backgroundColor = .bookifyPrimary
    }
    

    //setting title on image label
    private func setupTitleLabel(){
        titleLabel.font = UIFont().BookifyBoldFont(BookifyFontSize.extraLarge.rawValue)
        titleLabel.textColor = .bookifySecondary
        titleLabel.layer.borderColor = UIColor.bookifyTertiary.cgColor
    }
    
    //updating title label
    private func updateTitleLabel(text: String?){
        titleLabel.text = text ?? ""
    }
 
}


