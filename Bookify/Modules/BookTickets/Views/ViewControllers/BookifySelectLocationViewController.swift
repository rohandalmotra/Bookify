//
//  BookifySelectLocationViewController.swift
//  Bookify
//
//  Created by Tech Mash on 20/01/24.
//

import UIKit
import HGPlaceholders

class BookifySelectLocationViewController: UIViewController {
    var viewModel: BookifyBookTicketViewModel?
    private let tableView = TableView(frame: CGRect.zero, style: .grouped)
    private let topActionBar: BookifyTopActionBarView = .fromNib()
    private let bottomSingleButton: BookifyBottomSingleButtonView = .fromNib()
    lazy private var selectedLocationText: String? = ""
    let slideInPresentManager = BookifySlideInPresentationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .bookifyBackground
        // Do any additional setup after loading the view.
    }
    
    private init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    convenience init(viewModel: BookifyBookTicketViewModel) {
        self.init()
        self.viewModel = viewModel
        self.viewModel?.collapseLocationVC = false
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatalError")
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        if self.viewModel?.collapseLocationScreen == false{
//            self.viewModel?.collapseLocationScreen = false
//            self.tableView.reloadData()
//        }
//    }
    
    
//    private func clearAllObservables() {
//        viewModel = nil
//        // MARK: - Code Review For Rohan
//        // 1. Make observable nil
//        NotificationCenter.default.removeObserver(self)
//    }

}


// MARK: - Setting Up UI

extension BookifySelectLocationViewController{
    func setupUI() {
        //setting top action bar or navigation bar
        setupTopActionBar()
        addTopActionBarConstraints()
        
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

// MARK: - Setting up top action bar or navigation bar

extension BookifySelectLocationViewController{
    
    private func setupTopActionBar(){
        self.view.addSubview(topActionBar)
        topActionBar.actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
    }
    
    private func addTopActionBarConstraints() {
        topActionBar.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(BookifyHeightWidthConstants.BookifyCommon.topBarHeight)
        }
    }
}

// MARK: - Setting up bottom single button

extension BookifySelectLocationViewController{
    
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

extension BookifySelectLocationViewController{
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .bookifyPrimary
        tableView.separatorStyle = .none
        tableView.roundViewCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: BookifyHeightWidthConstants.BookifyCommon.cornerRadiusOfOuterView)
        tableView.clipsToBounds = true
        tableView.showsVerticalScrollIndicator = false
        tableView.showLoadingPlaceholder()
        tableView.showDefault()
    }
    
    func addTableViewConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(topActionBar.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Registering cells for tableView

extension BookifySelectLocationViewController{
    func registerCell(){
        
        let nib0 = UINib(nibName: BookifySelectLocationTableViewCell.identifier, bundle: nil)
        tableView.register(nib0, forCellReuseIdentifier: BookifySelectLocationTableViewCell.identifier)
        
        let nib1 = UINib(nibName: BookifyTitleWithSubtitleHeaderCell.identifier, bundle: nil)
        tableView.register(nib1, forHeaderFooterViewReuseIdentifier: BookifyTitleWithSubtitleHeaderCell.identifier)
        
    }
    
}


// MARK: - TableView delegates and datasources

extension BookifySelectLocationViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    // Setting up number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let stateType = BookifyScreenState(rawValue: viewModel?.locationVCStateType ?? "collapseView")
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
        let stateType = BookifyScreenState(rawValue: viewModel?.locationVCStateType ?? "collapseView")
        switch stateType{
        case .expandView:
            let headerCell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: BookifyTitleWithSubtitleHeaderCell.identifier) as! BookifyTitleWithSubtitleHeaderCell
            headerCell.updateUI(titleText: "Location", subtitleText: "Please select location where you want to do booking")
            headerView = headerCell
        case .collapseView:
            let headerCell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: BookifyTitleWithSubtitleHeaderCell.identifier) as! BookifyTitleWithSubtitleHeaderCell
            headerCell.updateUI(titleText: selectedLocationText, subtitleText: "")
            headerView = headerCell
        case .none:
            print("")
        }
           
    
        return headerView
    }
    
    //Setting height for headers
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let stateType = BookifyScreenState(rawValue: viewModel?.locationVCStateType ?? "collapseView")
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
        let stateType = BookifyScreenState(rawValue: viewModel?.locationVCStateType ?? "collapseView")
        switch stateType{
        case .expandView:
            let lCell = tableView.dequeueReusableCell(withIdentifier: BookifySelectLocationTableViewCell.identifier, for: indexPath) as! BookifySelectLocationTableViewCell
            lCell.cityData = viewModel?.cityData
            lCell.locationSelectionDelegate = self
            cell = lCell
        case .collapseView, .none:
           print("")
        }
        cell.selectionStyle = .none
        return cell
    }
    
    //setting height of the row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        let stateType = BookifyScreenState(rawValue: viewModel?.locationVCStateType ?? "collapseView")
        switch stateType{
        case .expandView:
            return BookifyHeightWidthConstants.BookifyCommon.locationSelectionCollectionViewHeight
        case .collapseView, .none:
            return 0

        }
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let stateType = BookifyScreenState(rawValue: viewModel?.locationVCStateType ?? "collapseView")
        switch stateType{
        case .expandView, .collapseView, .none:
            print("")
        }
    }
}



// MARK: - Adding Functionality on clicks or taps
extension BookifySelectLocationViewController{
    
    @objc private func actionButtonPressed(){
        dismissViewController()
        
    }
    
    @objc private func bottomActionButtonPressed(){
        
        viewModel?.collapseLocationVC = true
        tableView.showLoadingPlaceholder()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.tableView.reloadData()
            self.tableView.showDefault()
        }
        
        viewModel?.heightOfMovieSelectionVC = self.tableView.frame.height - 100

        if let viewModel = self.viewModel{
            let viewController = BookifyRouter.ViewController.getSelectMovieViewController(viewModel: viewModel)
            presentWithSlideInTransition(viewController: viewController)
        }
        
    }
    
    private func dismissViewController(){
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


extension BookifySelectLocationViewController: BookifySelectLocationDelegate {
    func didTapOnLocation(cityName: String) {
        self.selectedLocationText = cityName
    }
}
