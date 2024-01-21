//
//  BookifySelectLocationViewController.swift
//  Bookify
//
//  Created by Tech Mash on 20/01/24.
//

import UIKit

class BookifySelectLocationViewController: UIViewController {
    var viewModel: BookifyBookTicketViewModel?
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    private let topActionBar: BookifyTopActionBarView = .fromNib()
    private let bottomSingleButton: BookifyBottomSingleButtonView = .fromNib()
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
        //        self.viewModel?.collapseLocationVC = false
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatalError")
    }
    
    deinit{
        clearAllObservables()
    }
    
    
    private func clearAllObservables() {
        
        viewModel = nil
        NotificationCenter.default.removeObserver(self)
    }
    
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
        
        //setting observer for tableView reload
        setupObserver()
        
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
        
        let nib2 = UINib(nibName: BookifyTitleWithImageHeaderCell.identifier, bundle: nil)
        tableView.register(nib2, forHeaderFooterViewReuseIdentifier: BookifyTitleWithImageHeaderCell.identifier)
        
        
        
    }
    
}


// MARK: - Setting observer for tableView reload
extension BookifySelectLocationViewController{
    func setupObserver(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadTableView),
                                               name: BookifyNotificationConstants.updateLocationSelectionTableView,
                                               object: nil)
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
            headerCell.updateUI(titleText: "Select Location", subtitleText: 
                                    "Please select the location where you want to make a booking.")
            headerView = headerCell
        case .collapseView:
            let headerCell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: BookifyTitleWithImageHeaderCell.identifier) as! BookifyTitleWithImageHeaderCell
            headerCell.updateUI(titleText: viewModel?.selectedCityName, iconImage: viewModel?.selectedCityImage)
            print("this is from header", viewModel?.selectedCityName, viewModel?.selectedCityImage)
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
            lCell.locationSelectionDelegate = self
            lCell.cityData = viewModel?.cityData
            lCell.moveToIndex = viewModel?.selectedCityIndex
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
    
    
    @objc func reloadTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc private func actionButtonPressed(){
        dismissViewController()
        
    }
    
    @objc private func bottomActionButtonPressed(){
        
        viewModel?.collapseLocationVC = true
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
    func didTapOnLocation(cityName: String, cityImageName: String, selectedIndex: Int) {
        print("this is from didTapOnLocation", viewModel?.selectedCityName, viewModel?.selectedCityImage,cityName,cityImageName)
        viewModel?.selectedCityName = cityName
        viewModel?.selectedCityImage = cityImageName
        viewModel?.selectedCityIndex = selectedIndex
    }
}
