//
//  BookifySelectLocationTableViewCell.swift
//  Bookify
//
//  Created by Tech Mash on 20/01/24.
//

import UIKit

protocol BookifySelectLocationDelegate: AnyObject{
    func didTapOnLocation(cityName : String)
}

class BookifySelectLocationTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cntView: UIView!
    
    weak var delegate: BookifySelectLocationDelegate?
    
    var cityData: [BookifyCityData]?{
        didSet{
            DispatchQueue.main.async{
                self.collectionView.reloadData()
                if !(self.cityData?.isEmpty ?? false){
                    let indexPathToSelect = IndexPath(item: 0, section: 0)
                    self.collectionView.selectItem(at: indexPathToSelect, animated: true, scrollPosition: .centeredHorizontally)

                }
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
        return cityData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
            let lCell = collectionView.dequeueReusableCell(withReuseIdentifier: BookifyImageWithTitleCollectionViewCell.identifier, for: indexPath) as! BookifyImageWithTitleCollectionViewCell
        lCell.cityData = cityData?[indexPath.row]
        cell = lCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapOnLocation(cityName: cityData?[indexPath.row].cityName ?? "Error Occured")
    }
    
}

//MARK: - Setting collection view delegate flow layout

extension BookifySelectLocationTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: BookifyHeightWidthConstants.BookifyCommon.locationSelectionCollectionViewWidth, height: collectionView.frame.height)
    }
    
    // Distance Between Item Cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
}
