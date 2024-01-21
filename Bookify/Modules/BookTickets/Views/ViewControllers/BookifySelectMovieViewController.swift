//
//  BookifySelectMovieViewController.swift
//  Bookify
//
//  Created by Tech Mash on 20/01/24.
//

import UIKit

class BookifySelectMovieViewController: UIViewController {
    var viewModel: BookifyBookTicketViewModel?
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    private let bottomSingleButton: BookifyBottomSingleButtonView = .fromNib()
    private let dropDownButtonBar: BookifyDropdrownButtonBarView = .fromNib()
    private let containerView = UIView()
    private let slideInPresentManager = BookifySlideInPresentationManager()
    private lazy var tapButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = view.bounds
        button.isUserInteractionEnabled = true
        button.backgroundColor = .clear
        return button
    }()
    
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
        fatalError(BookifyStringConstants.fatelErrorText)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit{
        viewModel?.selectedMovieImage = nil
        clearAllObservables()
    }
    
    private func clearAllObservables() {
        NotificationCenter.default.removeObserver(self)
    }
    
}


// MARK: - Setting Up UI

extension BookifySelectMovieViewController{
    private func setupUI() {
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
        
        //setting observer for tableView reload
        setupObserver()
        
        //setting tab button for outside tap
        setupTapButton()
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
    
    private func addContainerViewConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(viewModel?.heightOfMovieSelectionVC ?? 0)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Setting Up drop down button

extension BookifySelectMovieViewController{
    private func setupDropdownButtonBar() {
        self.view.addSubview(dropDownButtonBar)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dropdownButtonPressed))
        dropDownButtonBar.addGestureRecognizer(tapGesture)
        dropDownButtonBar.dropdownButton.addTarget(self, action: #selector(dropdownButtonPressed), for: .touchUpInside)
    }
    
    private func addDropdownButtonBarConstraints() {
        dropDownButtonBar.snp.makeConstraints { (make) in
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(BookifyHeightWidthConstants.BookifyCommon.topBarHeight)
            make.bottom.equalTo(containerView.snp.top)
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
        
    }
    
    private func addTableViewConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.left.top.bottom.right.equalTo(containerView)
        }
    }
}

// MARK: - Registering cells for tableView

extension BookifySelectMovieViewController{
    private func registerCell(){
        let nib0 = UINib(nibName: BookifySelectLocationTableViewCell.identifier, bundle: nil)
        tableView.register(nib0, forCellReuseIdentifier: BookifySelectLocationTableViewCell.identifier)
        
        let nib1 = UINib(nibName: BookifyTitleWithSubtitleHeaderCell.identifier, bundle: nil)
        tableView.register(nib1, forHeaderFooterViewReuseIdentifier: BookifyTitleWithSubtitleHeaderCell.identifier)
        
        let nib2 = UINib(nibName: BookifyTitleWithImageHeaderCell.identifier, bundle: nil)
        tableView.register(nib2, forHeaderFooterViewReuseIdentifier: BookifyTitleWithImageHeaderCell.identifier)
    }
}

// MARK: - Setting up bottom single button
extension BookifySelectMovieViewController{
    private func setupBottomSingleButton() {
        self.view.addSubview(bottomSingleButton)
        bottomSingleButton.updateActionButtonTitle(title: BookifyStringConstants.proceedToConfirmSeats)
        bottomSingleButton.actionButton.addTarget(self, action: #selector(bottomActionButtonPressed), for: .touchUpInside)
    }
    
    private func addBottomSingleButtonConstraints() {
        bottomSingleButton.snp.makeConstraints { (make) in
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
            make.height.equalTo(BookifyHeightWidthConstants.BookifyCommon.bottomSingleButtonViewHeight)
        }
    }
}


// MARK: - Setting observer for tableView reload
extension BookifySelectMovieViewController{
    private func setupObserver(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadTableView),
                                               name:BookifyNotificationConstants.updateMovieSelectionTableView,
                                               object: nil)
    }
}


// MARK: - Setting Up tab button for outside tap
extension BookifySelectMovieViewController {
    private func setupTapButton() {
        view.insertSubview(tapButton, at: 0)
        tapButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tapButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
    }
}



// MARK: - TableView delegates and datasources
extension BookifySelectMovieViewController: UITableViewDelegate, UITableViewDataSource{
    
    // Setting up number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let stateType = BookifyScreenState(rawValue: viewModel?.moviewSelectionVCStateType ?? BookifyStringConstants.expandView)
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
        let stateType = BookifyScreenState(rawValue: viewModel?.moviewSelectionVCStateType ?? BookifyStringConstants.expandView)
        switch stateType{
        case .expandView:
            let headerCell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: BookifyTitleWithSubtitleHeaderCell.identifier) as! BookifyTitleWithSubtitleHeaderCell
            headerCell.updateUI(titleText: BookifyStringConstants.selectMovieTilteText, subtitleText: BookifyStringConstants.selectMovieSubilteText)
            headerView = headerCell
        case .collapseView:
            let headerCell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: BookifyTitleWithImageHeaderCell.identifier) as! BookifyTitleWithImageHeaderCell
            headerCell.updateUI(titleText: viewModel?.selectedMovieName, iconImage: viewModel?.selectedMovieImage)
            headerView = headerCell
            headerView = headerCell
        case .none:
            print("")
        }
        
        
        return headerView
    }
    
    //Setting height for headers
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let stateType = BookifyScreenState(rawValue: viewModel?.moviewSelectionVCStateType ?? BookifyStringConstants.expandView)
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
        let stateType = BookifyScreenState(rawValue: viewModel?.moviewSelectionVCStateType ?? BookifyStringConstants.expandView)
        switch stateType{
        case .expandView:
            let lCell = tableView.dequeueReusableCell(withIdentifier: BookifySelectLocationTableViewCell.identifier, for: indexPath) as! BookifySelectLocationTableViewCell
            lCell.movieSelectionDelegate = self
            lCell.movieData = viewModel?.movieData
            lCell.moveToIndex = viewModel?.selectedMovieIndex
            cell = lCell
        case .collapseView, .none:
            print("")
        }
        cell.selectionStyle = .none
        return cell
    }
    
    //setting height of the row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let stateType = BookifyScreenState(rawValue: viewModel?.moviewSelectionVCStateType ?? BookifyStringConstants.expandView)
        switch stateType{
        case .expandView:
            return BookifyHeightWidthConstants.BookifyCommon.locationSelectionCollectionViewHeight
        case .collapseView, .none:
            return 0
            
        }
    }
}


// MARK: - Adding Functionality on clicks or taps
extension BookifySelectMovieViewController{
    
    //functionality for reloading the tableView
    @objc private func reloadTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //functionality on dropdown button pressed
    @objc private func dropdownButtonPressed(){
        dismissViewController()
    }
    
    //functionality on bottom button pressed
    @objc private func bottomActionButtonPressed(){
        viewModel?.collapseMovieSelectionVC = true
        viewModel?.heightOfPeopleSelectionVC = self.tableView.frame.height - BookifyHeightWidthConstants.BookifyCommon.distanceFromPreviousScreen
        if let viewModel = self.viewModel{
            let viewController = BookifyRouter.ViewController.getSelectPeopleCountViewController(viewModel: viewModel)
            presentWithSlideInTransition(viewController: viewController)
        }
    }
    
    //dismissing current ViewController
    @objc private func dismissViewController(){
        viewModel?.collapseLocationVC = false
        BookifyHaptic.addHapticTouch(style: .light)
        self.dismiss(animated: true)
    }
    
    //presenting view controller
    private func presentWithSlideInTransition(viewController: UIViewController, _ doTransform: Bool = true){
        slideInPresentManager.disableCompactHeight = true
        slideInPresentManager.direction = .bottom
        slideInPresentManager.doTransform = doTransform
        viewController.transitioningDelegate = slideInPresentManager
        viewController.modalPresentationStyle = .custom
        present(viewController, animated: true, completion: nil)
    }
    
}

// MARK: - Adding Functionality for delegate methods
extension BookifySelectMovieViewController: BookifySelectMovieDelegate {
    func didTapOnMovie(movieName: String, movieImageName: String, selectedIndex: Int) {
        viewModel?.selectedMovieName = movieName
        viewModel?.selectedMovieImage = movieImageName
        viewModel?.selectedMovieIndex = selectedIndex
    }
}


