//
//  BookifyPeopleBookingTicketTableViewCell.swift
//  Bookify
//
//  Created by Tech Mash on 21/01/24.
//

import UIKit


class BookifyPeopleBookingTicketTableViewCell: UITableViewCell {
    @IBOutlet weak var cntView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: BookifyPeopleBookingTicketDelegate?
    var numberOfpeopleData: BookifyNumberOfPeopleData?
    
    var moveToIndex: Int?{
        didSet{
            if !(self.numberOfpeopleData?.peopleCanJoin?.isEmpty ?? true){
                let indexPathToSelect = IndexPath(item: moveToIndex ?? 0, section: 0)
                self.collectionView.selectItem(at: indexPathToSelect, animated: true, scrollPosition: .centeredHorizontally)
                self.collectionView.delegate?.collectionView?(self.collectionView, didSelectItemAt: indexPathToSelect)
            }
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        numberOfpeopleData = nil
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
extension BookifyPeopleBookingTicketTableViewCell{
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
extension BookifyPeopleBookingTicketTableViewCell{
    
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
        let nib0 = UINib.init(nibName: BookifyCentreLabelCollectionViewCell.identifier, bundle: nil)
        self.collectionView.register(nib0, forCellWithReuseIdentifier: BookifyCentreLabelCollectionViewCell.identifier)
    }
    
}


//MARK: - Setting collection view delegate and data source

extension BookifyPeopleBookingTicketTableViewCell: UICollectionViewDelegate,
                                                   UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfpeopleData?.peopleCanJoin?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        let lCell = collectionView.dequeueReusableCell(withReuseIdentifier: BookifyCentreLabelCollectionViewCell.identifier, for: indexPath) as! BookifyCentreLabelCollectionViewCell
        lCell.peopleCanJoin = numberOfpeopleData?.peopleCanJoin?[indexPath.row]
        cell = lCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapOnNumberOfPeople(numberOfPeople: numberOfpeopleData?.peopleCanJoin?[indexPath.row] ?? 0, selectedIndex: indexPath.row)
    }
    
}

//MARK: - Setting collection view delegate flow layout

extension BookifyPeopleBookingTicketTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: BookifyHeightWidthConstants.BookifyCommon.peopleSelectionCVHeightWidht, height: BookifyHeightWidthConstants.BookifyCommon.peopleSelectionCVHeightWidht)
    }
    
    // Distance Between Item Cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return BookifyHeightWidthConstants.BookifyCommon.distanceBetweenCVCells
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: BookifyHeightWidthConstants.BookifyCommon.distanceBetweenCVCells, bottom: 0, right: BookifyHeightWidthConstants.BookifyCommon.distanceBetweenCVCells)
    }
    
}
