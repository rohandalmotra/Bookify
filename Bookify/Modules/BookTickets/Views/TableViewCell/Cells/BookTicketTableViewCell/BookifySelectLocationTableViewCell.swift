//
//  BookifySelectLocationTableViewCell.swift
//  Bookify
//
//  Created by Tech Mash on 20/01/24.
//

import UIKit

class BookifySelectLocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cntView: UIView!
    
    weak var locationSelectionDelegate: BookifySelectLocationDelegate?
    weak var movieSelectionDelegate: BookifySelectMovieDelegate?
    var cityData: [BookifyCityData]?
    var movieData: [BookifyMovieData]?
    
    var moveToIndex: Int?{
        didSet{
            if !(self.movieData?.isEmpty ?? true){
                let indexPathToSelect = IndexPath(item: moveToIndex ?? 0, section: 0)
                self.collectionView.selectItem(at: indexPathToSelect, animated: true, scrollPosition: .centeredHorizontally)
                self.collectionView.delegate?.collectionView?(self.collectionView, didSelectItemAt: indexPathToSelect)
            }
            if !(self.cityData?.isEmpty ?? true){
                let indexPathToSelect = IndexPath(item: moveToIndex ?? 0, section: 0)
                self.collectionView.selectItem(at: indexPathToSelect, animated: true, scrollPosition: .centeredHorizontally)
                self.collectionView.delegate?.collectionView?(self.collectionView, didSelectItemAt: indexPathToSelect)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cityData = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //setting up UI
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


//MARK: - Setting up UI

extension BookifySelectLocationTableViewCell{
    private func setupUI(){
        //setting cell's UI
        setupCellUI()
        //setting collection view
        setupCollectionView()
        //registering collection view cell
        registerNib()
        
    }
}

//MARK: - Setting up UI objects
extension BookifySelectLocationTableViewCell{
    
    //setting cell's UI
    private func setupCellUI(){
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.cntView.backgroundColor = .clear
    }
    //setting collection view
    private func setupCollectionView(){
        self.collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    //registering collection view cell
    private func registerNib(){
        let nib0 = UINib.init(nibName: BookifyImageWithTitleCollectionViewCell.identifier, bundle: nil)
        self.collectionView.register(nib0, forCellWithReuseIdentifier: BookifyImageWithTitleCollectionViewCell.identifier)
    }
    
}


//MARK: - Setting collection view delegate and data source
extension BookifySelectLocationTableViewCell: UICollectionViewDelegate,
                                              UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !(cityData?.isEmpty ?? true){
            return cityData?.count ?? 0
        }
        if !(movieData?.isEmpty ?? true){
            return movieData?.count ?? 0
        }
        else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        let lCell = collectionView.dequeueReusableCell(withReuseIdentifier: BookifyImageWithTitleCollectionViewCell.identifier, for: indexPath) as! BookifyImageWithTitleCollectionViewCell
        if !(cityData?.isEmpty ?? true){
            lCell.cityData = cityData?[indexPath.row]
        }
        if !(movieData?.isEmpty ?? true){
            lCell.movieData = movieData?[indexPath.row]
        }
        
        
        cell = lCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !(cityData?.isEmpty ?? true){
            if let cityName = cityData?[indexPath.row].cityName, let cityImage = cityData?[indexPath.row].cityImage{
                locationSelectionDelegate?.didTapOnLocation(cityName: cityName, cityImageName: cityImage, selectedIndex: indexPath.row)
            }
        }
        if !(movieData?.isEmpty ?? true){
            if let movieName = movieData?[indexPath.row].movieName, let movieImage = movieData?[indexPath.row].movieImage{
                movieSelectionDelegate?.didTapOnMovie(movieName: movieName, movieImageName: movieImage, selectedIndex: indexPath.row)
            }
        }
    }
    
}

//MARK: - Setting collection view delegate flow layout

extension BookifySelectLocationTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: BookifyHeightWidthConstants.BookifyCommon.locationSelectionCollectionViewWidth, height: BookifyHeightWidthConstants.BookifyCommon.locationSelectionCollectionViewWidth)
    }
    
    // Distance Between Item Cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return BookifyHeightWidthConstants.BookifyCommon.distanceBetweenCVCells
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: BookifyHeightWidthConstants.BookifyCommon.distanceBetweenCVCells, bottom: 0, right: BookifyHeightWidthConstants.BookifyCommon.distanceBetweenCVCells)
    }
    
}
