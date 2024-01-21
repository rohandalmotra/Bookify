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
    private let slideInPresentManager = BookifySlideInPresentationManager()
    private lazy var tapButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = view.bounds
        button.isUserInteractionEnabled = true
        button.backgroundColor = .clear
        //UIColor(0, green: 0, blue: 0, alpha: 0.2)
        return button
    }()
    
    private init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(viewModel: BookifyBookTicketViewModel) {
        self.init()
        self.viewModel = viewModel
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(BookifyStringConstants.fatelErrorText)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit{
        viewModel?.selectedNumberOfPeople = nil
        viewModel?.selectedNumberOfPeopleIndex = nil
    }
    
}


// MARK: - Setting Up UI

extension BookifySelectPeopleCountViewController{
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
        
        //setting tab button for outside tap
        setupTapButton()
    }
}

// MARK: - Setting Up tab button for outside tap
extension BookifySelectPeopleCountViewController {
    private func setupTapButton() {
        view.insertSubview(tapButton, at: 0)
        tapButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tapButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
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
    
    private func addContainerViewConstraints() {
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

// MARK: - Setting up bottom single button
extension BookifySelectPeopleCountViewController{
    private func setupBottomSingleButton() {
        self.view.addSubview(bottomSingleButton)
        bottomSingleButton.updateActionButtonTitle(title: BookifyStringConstants.proceedToConfirmBookingText)
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
    
    private func addTableViewConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.left.top.bottom.right.equalTo(containerView)
        }
    }
}

// MARK: - Registering cells for tableView
extension BookifySelectPeopleCountViewController{
    private func registerCell(){
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
        headerCell.updateUI(titleText: BookifyStringConstants.selectSeatTilteText, subtitleText: BookifyStringConstants.selectSeatSubilteText)
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
        lCell.moveToIndex = viewModel?.selectedNumberOfPeopleIndex
        cell = lCell
        cell.selectionStyle = .none
        return cell
    }
    
    //setting height of the row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BookifyHeightWidthConstants.BookifyCommon.peopleSelectionCVHeightWidht
    }
    
}


// MARK: - Adding Functionality on clicks or taps
extension BookifySelectPeopleCountViewController{
    
    //functionality on dropdown button pressed
    @objc private func dropdownButtonPressed(){
        dismissViewController()
    }
    
    //functionality on bottom button pressed
    @objc private func bottomActionButtonPressed(){
        DispatchQueue.main.async { [self] in
            self.showAlert(title: BookifyStringConstants.bookingConfirmText, message: BookifyStringConstants.getAlertTextOnBookingConfirm(numberOfSeats: viewModel?.selectedNumberOfPeople ?? 0, location: viewModel?.selectedCityName ?? "-", movie: viewModel?.selectedMovieName ?? "-"))
        }
    }
    
    //dismissing current ViewController
    @objc private func dismissViewController(){
        viewModel?.collapseMovieSelectionVC = false
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
    
    //presenting an aleart controller on booking confirm
    private func showAlert(title: String, message: String, duration: TimeInterval = 2.0) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        present(alertController, animated: true, completion: nil)
        
        // Schedule the dismissal after the specified duration
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
    
}

// MARK: - Adding Functionality for delegate methods
extension BookifySelectPeopleCountViewController: BookifyPeopleBookingTicketDelegate {
    func didTapOnNumberOfPeople(numberOfPeople: Int, selectedIndex: Int) {
        viewModel?.selectedNumberOfPeople = numberOfPeople
        viewModel?.selectedNumberOfPeopleIndex = selectedIndex
    }
}

