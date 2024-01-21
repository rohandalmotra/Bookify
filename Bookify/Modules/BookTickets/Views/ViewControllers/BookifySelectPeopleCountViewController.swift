//
//  BookifySelectPeopleCountViewController.swift
//  Bookify
//
//  Created by Tech Mash on 20/01/24.
//

import UIKit

class BookifySelectPeopleCountViewController: UIViewController {
    
    var viewModel: BookifyBookTicketViewModel?
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped)
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

extension BookifySelectPeopleCountViewController{
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

extension BookifySelectPeopleCountViewController{
    
    private func setupContainerView() {
        self.view.addSubview(containerView)
        containerView.roundViewCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: BookifyHeightWidthConstants.BookifyCommon.cornerRadiusOfOuterView)
        containerView.backgroundColor = .bookifyPrimary
        containerView.layer.masksToBounds = true
    }
    
    func addContainerViewConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(viewModel?.heightOfPeopleSelectionVC ?? 0)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Setting Up drop down button

extension BookifySelectPeopleCountViewController{
    
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

extension BookifySelectPeopleCountViewController{
    
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

extension BookifySelectPeopleCountViewController{
    
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
    
    func addTableViewConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.left.top.bottom.right.equalTo(containerView)
        }
    }
}

// MARK: - Registering cells for tableView

extension BookifySelectPeopleCountViewController{
    func registerCell(){
        
        let nib0 = UINib(nibName: BookifyPeopleBookingTicketTableViewCell.identifier, bundle: nil)
        tableView.register(nib0, forCellReuseIdentifier: BookifyPeopleBookingTicketTableViewCell.identifier)
        
        let nib1 = UINib(nibName: BookifyTitleWithSubtitleHeaderCell.identifier, bundle: nil)
        tableView.register(nib1, forHeaderFooterViewReuseIdentifier: BookifyTitleWithSubtitleHeaderCell.identifier)
        
    }
    
}


// MARK: - TableView delegates and datasources

extension BookifySelectPeopleCountViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    // Setting up number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Setting up headers for cells
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = UIView()
        let headerCell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: BookifyTitleWithSubtitleHeaderCell.identifier) as! BookifyTitleWithSubtitleHeaderCell
        headerCell.updateUI(titleText: "How Many Seats?", subtitleText: "Select the number of seats you want to book.")
        headerView = headerCell
        return headerView
    }
    
    //Setting height for headers
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    // Setting up cells for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let lCell = tableView.dequeueReusableCell(withIdentifier: BookifyPeopleBookingTicketTableViewCell.identifier, for: indexPath) as! BookifyPeopleBookingTicketTableViewCell
        lCell.delegate = self
        lCell.numberOfpeopleData = viewModel?.numberOfPeopleAllowedData
        cell = lCell
        cell.selectionStyle = .none
        return cell
    }
    
    //setting height of the row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BookifyHeightWidthConstants.BookifyCommon.peopleSelectionCVHeightWidht
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("")
    }
}


// MARK: - Adding Functionality on clicks or taps
extension BookifySelectPeopleCountViewController{
    
    @objc private func dropdownButtonPressed(){
        dismissViewController()
    }
    
    @objc private func bottomActionButtonPressed(){
        
        
        
    }
    
    private func dismissViewController(){
        viewModel?.collapseMovieSelectionVC = false
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


extension BookifySelectPeopleCountViewController: BookifyPeopleBookingTicketDelegate {
    func didTapOnNumberOfPeople(numberOfPeople: Int, selectedIndex: Int) {
        viewModel?.selectedNumberOfPeople = numberOfPeople
        viewModel?.selectedNumberOfPeopleIndex = selectedIndex
    }
}

