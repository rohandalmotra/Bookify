//
//  BookifySelectMovieViewController.swift
//  Bookify
//
//  Created by Tech Mash on 20/01/24.
//

import UIKit
import HGPlaceholders

class BookifySelectMovieViewController: UIViewController {

    var viewModel: BookifyBookTicketViewModel?
    private let tableView = TableView(frame: CGRect.zero, style: .grouped)
    private let bottomSingleButton: BookifyBottomSingleButtonView = .fromNib()
    private let dropDownButtonBar: BookifyDropdrownButtonBarView = .fromNib()
    private let containerView = UIView()
    let slideInPresentManager = BookifySlideInPresentationManager()
    lazy private var selectedMovieText: String? = ""
    
    private init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(viewModel: BookifyBookTicketViewModel) {
        self.init()
        self.viewModel = viewModel
        self.viewModel?.collapseMovieSelectionVC = false
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatalError")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}


// MARK: - Setting Up UI

extension BookifySelectMovieViewController{
    func setupUI() {
        
        //setting container view
        setupContainerView()
        addContainerViewConstraints()
        
        //setting drop down button bar
        setupDropdownButtonBar()
        addDropdownButtonBarConstraints()
        
        
        //setting tableView
        setupTableView()
        addTableViewConstraints()
        
        //setting bottom single button
        setupBottomSingleButton()
        addBottomSingleButtonConstraints()
        
        //registering cells for tableView
        registerCell()
        
    }
}

// MARK: - Setting Up container view

extension BookifySelectMovieViewController{
    
    private func setupContainerView() {
        self.view.addSubview(containerView)
        containerView.roundViewCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: BookifyHeightWidthConstants.BookifyCommon.cornerRadiusOfOuterView)
        containerView.backgroundColor = .bookifyPrimary
        containerView.layer.masksToBounds = true
    }
    
    func addContainerViewConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            print("this is from container view", viewModel?.heightOfMovieSelectionVC ?? 0)
            make.height.equalTo(viewModel?.heightOfMovieSelectionVC ?? 0)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Setting Up drop down button

extension BookifySelectMovieViewController{
    
    private func setupDropdownButtonBar() {
        self.view.addSubview(dropDownButtonBar)
        dropDownButtonBar.dropdownButton.addTarget(self, action: #selector(dropdownButtonPressed), for: .touchUpInside)
    }
    
    func addDropdownButtonBarConstraints() {
        dropDownButtonBar.snp.makeConstraints { (make) in
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(BookifyHeightWidthConstants.BookifyCommon.topBarHeight)
            make.bottom.equalTo(containerView.snp.top)
        }
    }
}



// MARK: - Setting up bottom single button

extension BookifySelectMovieViewController{
    
    private func setupBottomSingleButton() {
        self.view.addSubview(bottomSingleButton)
        bottomSingleButton.updateActionButtonTitle(title: "Proceed to Movie Selection")
        bottomSingleButton.actionButton.addTarget(self, action: #selector(bottomActionButtonPressed), for: .touchUpInside)
    }
    
    func addBottomSingleButtonConstraints() {
        bottomSingleButton.snp.makeConstraints { (make) in
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
            make.height.equalTo(BookifyHeightWidthConstants.BookifyCommon.bottomSingleButtonViewHeight)
        }
    }
}

// MARK: - Setting Up TabelView

extension BookifySelectMovieViewController{
    
    private func setupTableView() {
        self.containerView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bookifyPrimary
        tableView.separatorStyle = .none
        tableView.roundViewCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: BookifyHeightWidthConstants.BookifyCommon.cornerRadiusOfOuterView)
        tableView.clipsToBounds = true
        tableView.showsVerticalScrollIndicator = false
        tableView.showLoadingPlaceholder()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.tableView.showDefault()
        }
    }
    
    func addTableViewConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.left.top.bottom.right.equalTo(containerView)
        }
    }
}

// MARK: - Registering cells for tableView

extension BookifySelectMovieViewController{
    func registerCell(){
        
        let nib0 = UINib(nibName: BookifySelectLocationTableViewCell.identifier, bundle: nil)
        tableView.register(nib0, forCellReuseIdentifier: BookifySelectLocationTableViewCell.identifier)
        
        let nib1 = UINib(nibName: BookifyTitleWithSubtitleHeaderCell.identifier, bundle: nil)
        tableView.register(nib1, forHeaderFooterViewReuseIdentifier: BookifyTitleWithSubtitleHeaderCell.identifier)
        
    }
    
}


// MARK: - TableView delegates and datasources

extension BookifySelectMovieViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    // Setting up number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let stateType = BookifyScreenState(rawValue: viewModel?.moviewSelectionVCStateType ?? "collapseView")
        switch stateType{
        case .expandView:
            return 1
        case .collapseView:
            return 0
        case .none:
            return 0
        }
    }
    
    // Setting up headers for cells
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = UIView()
        let stateType = BookifyScreenState(rawValue: viewModel?.moviewSelectionVCStateType ?? "collapseView")
        switch stateType{
        case .expandView:
            let headerCell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: BookifyTitleWithSubtitleHeaderCell.identifier) as! BookifyTitleWithSubtitleHeaderCell
            headerCell.updateUI(titleText: "Location", subtitleText: "Please select location where you want to do booking")
            headerView = headerCell
        case .collapseView:
            let headerCell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: BookifyTitleWithSubtitleHeaderCell.identifier) as! BookifyTitleWithSubtitleHeaderCell
            headerCell.updateUI(titleText: selectedMovieText, subtitleText: "")
            headerView = headerCell
        case .none:
            print("")
        }
           
       
        return headerView
    }
    
    //Setting height for headers
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let stateType = BookifyScreenState(rawValue: viewModel?.moviewSelectionVCStateType ?? "collapseView")
        switch stateType{
        case .expandView:
            return UITableView.automaticDimension
        case .collapseView:
            return UITableView.automaticDimension
        case .none:
            return 0
        }
    }
    
    
    // Setting up cells for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        let stateType = BookifyScreenState(rawValue: viewModel?.moviewSelectionVCStateType ?? "collapseView")
        switch stateType{
        case .expandView:
            let lCell = tableView.dequeueReusableCell(withIdentifier: BookifySelectLocationTableViewCell.identifier, for: indexPath) as! BookifySelectLocationTableViewCell
            lCell.cityData = viewModel?.cityData
//            lCell.delegate = self
            cell = lCell
        case .collapseView, .none:
           print("")
        }
        cell.selectionStyle = .none
        return cell
    }
    
    //setting height of the row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        let stateType = BookifyScreenState(rawValue: viewModel?.moviewSelectionVCStateType ?? "collapseView")
        switch stateType{
        case .expandView:
            return BookifyHeightWidthConstants.BookifyCommon.locationSelectionCollectionViewHeight
        case .collapseView, .none:
            return 0

        }
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let stateType = BookifyScreenState(rawValue: viewModel?.moviewSelectionVCStateType ?? "collapseView")
        switch stateType{
        case .expandView, .collapseView, .none:
            print("")
        }
    }
}


// MARK: - Adding Functionality on clicks or taps
extension BookifySelectMovieViewController{
    
    @objc private func dropdownButtonPressed(){
        dismissViewController()
        
    }
    
    @objc private func bottomActionButtonPressed(){
        tableView.showLoadingPlaceholder()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.tableView.reloadData()
            self.tableView.showDefault()
        }
        
        viewModel?.heightOfPeopleSelectionVC = self.tableView.frame.height - 100

        if let viewModel = self.viewModel{
            let viewController = BookifyRouter.ViewController.getSelectPeopleCountViewController(viewModel: viewModel)
            presentWithSlideInTransition(viewController: viewController)
        }
    }
    
    private func dismissViewController(){
        viewModel?.collapseLocationVC = false
        self.dismiss(animated: true)
    }
    
    //presenting view controller
    func presentWithSlideInTransition(viewController: UIViewController, _ doTransform: Bool = true){
        slideInPresentManager.disableCompactHeight = true
        slideInPresentManager.direction = .bottom
        slideInPresentManager.doTransform = doTransform
        viewController.transitioningDelegate = slideInPresentManager
        viewController.modalPresentationStyle = .custom
        present(viewController, animated: true, completion: nil)
    }

}


extension BookifySelectMovieViewController: BookifySelectLocationDelegate {
    func didTapOnLocation(cityName: String) {
        self.selectedMovieText = cityName
    }
}


