//
//  BookifyImageWithTitleCollectionViewCell.swift
//  Bookify
//
//  Created by Tech Mash on 20/01/24.
//

import UIKit

class BookifyImageWithTitleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var cntView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recommendedLabel: UILabel!
    
    var cityData: BookifyCityData?{
        didSet{
            guard let cityDataResponse = cityData else{return}
            updateUIForLocationVC(cityData: cityDataResponse)
        }
    }
    
    var movieData: BookifyMovieData?{
        didSet{
            guard let movieDataResponse = movieData else{return}
            updateUIForMovieVC(movieData: movieDataResponse)
        }
    }
    
    override var isSelected: Bool {
         didSet {
             // Update UI based on the selection state
             if isSelected {
                 selectedImageView.image = .checkBoxDone.withTintColor(.bookifyPrimary, renderingMode: .alwaysOriginal)
             } else {
                 selectedImageView.image = .checkBoxEmpty.withTintColor(.bookifyPrimary, renderingMode: .alwaysOriginal)
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
        backgroundImageView.image = nil
        titleLabel.text = nil
    }

}


//MARK: - Setting up UI

extension BookifyImageWithTitleCollectionViewCell{
    private func setupUI(){
        //setting cell's UI
        setupCellUI()
        //setting blurView
        setupBlurView()
        //setting titleLabel
        setupTitleLabel()
        //setting selected image view
        setupSelectedImageView()
        //setting recommended label
        setupRecommendedLabel()
        
    }
}


// MARK: - Setting UI of the Objects

extension BookifyImageWithTitleCollectionViewCell{
    
    //setting cell's UI
    private func setupCellUI(){
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.cntView.layer.cornerRadius = BookifyHeightWidthConstants.BookifyCommon.cornerRadiusOfCells
        self.cntView.layer.cornerCurve = .continuous
        self.cntView.backgroundColor = .bookifyPrimary
    }
    
    //setting blurView
    private func setupBlurView(){
        blurView.roundViewCorners([.layerMaxXMaxYCorner, .layerMaxXMinYCorner], radius: 4)
        blurView.roundViewCorners([.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], radius: BookifyHeightWidthConstants.BookifyCommon.cornerRadiusOfLabels)
    }
    //setting title on image label
    private func setupTitleLabel(){
        titleLabel.font = UIFont().BookifyMediumFont(BookifyFontSize.small.rawValue)
        titleLabel.textColor = .bookifyPrimary
    }
    
    //setting selected image view
    private func setupSelectedImageView(){
        selectedImageView.image = .checkBoxEmpty.withTintColor(.bookifyPrimary, renderingMode: .alwaysOriginal)
    }
    
    //setting recommended label
    private func setupRecommendedLabel(){
        recommendedLabel.font = UIFont().BookifyMediumFont(BookifyFontSize.extraSmall.rawValue)
        recommendedLabel.textColor = .bookifyPrimary
        recommendedLabel.backgroundColor = .bookifySecondary
        recommendedLabel.text = "  Newly Launched  "
        recommendedLabel.isHidden = true
        recommendedLabel.layer.cornerRadius = BookifyHeightWidthConstants.BookifyCommon.cornerRadiusOfLabels
        recommendedLabel.clipsToBounds = true
    }
    
}

// MARK: - Updating UI

extension BookifyImageWithTitleCollectionViewCell{
    
    //updating UI for location VC
    private func updateUIForLocationVC(cityData: BookifyCityData?){
        //updating background Image
        updateBackgroundImage(imageName: cityData?.cityImage)
        //updating title label
        updateTitleLabel(text: cityData?.cityName)
        //updating recommended label
        updateRecommendedLabel(isRecommended: false)
        
    }
    
    //updating UI for movie VC
    private func updateUIForMovieVC(movieData: BookifyMovieData?){
        //updating background Image
        updateBackgroundImage(imageName: movieData?.movieImage)
        //updating title label
        updateTitleLabel(text: movieData?.movieName)
        //updating recommended label
        updateRecommendedLabel(isRecommended: movieData?.isNewlyReleased)
        
    }
    
}

// MARK: - Updating UI Objects

extension BookifyImageWithTitleCollectionViewCell{
    
    //updating background Image
    private func updateBackgroundImage(imageName: String?){
        backgroundImageView.image = UIImage(named: imageName ?? "")
    }
    
    //updating title label
    private func updateTitleLabel(text: String?){
        titleLabel.text = text ?? ""
    }
    
    //updating title label
    private func updateRecommendedLabel(isRecommended: Bool?){
        if isRecommended ?? false{
            recommendedLabel.isHidden = false
        }
        else{
            recommendedLabel.isHidden = true
        }
    }
    
 
}


