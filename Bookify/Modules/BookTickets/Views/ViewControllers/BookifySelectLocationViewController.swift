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
    var topActionBar: BookifyTopActionBarView = .fromNib()
    var bottomSingleButton: BookifyBottomSingleButtonView = .fromNib()
    var selectedLocationText: String?
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
//        fetchAllData()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("fatalError")
    }
    
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
        
        //setting bottom single button
        setupBottomSingleButton()
        addBottomSingleButtonConstraints()
        
        //setting tableView
        setupTableView()
        addTableViewConstraints()
        
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
            make.height.equalTo(BookifyHeightWidthConstants.BookifyCommon.topActionBarHeight)
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -20, right: 0)
        tableView.showsVerticalScrollIndicator = false
        tableView.showLoadingPlaceholder()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.tableView.showDefault()
        }
    }
    
    func addTableViewConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(topActionBar.snp.bottom)
            make.bottom.equalTo(bottomSingleButton.snp.top)
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
    
    // Setting up number of sections
    func numberOfSections(in tableView:UITableView) -> Int {
        return BookifyBookTicketViewsSections.numberOfSections()
    }
    
    // Setting up number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections = BookifyBookTicketViewsSections.getSection(section)
        switch sections{
        case .expandView:
            return 1
        case .collapseView:
            return 0
        }
    }
    
    // Setting up headers for cells
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = UIView()
        let sections = BookifyBookTicketViewsSections.getSection(section)
        switch sections{
        case .expandView:
            let headerCell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: BookifyTitleWithSubtitleHeaderCell.identifier) as! BookifyTitleWithSubtitleHeaderCell
            headerCell.updateUI(titleText: "Location", subtitleText: "Please select location where you want to do booking")
            headerView = headerCell
        case .collapseView:
            let headerCell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: BookifyTitleWithSubtitleHeaderCell.identifier) as! BookifyTitleWithSubtitleHeaderCell
            headerCell.updateUI(titleText: selectedLocationText, subtitleText: "")
            headerView = headerCell
        }
           
       
        return headerView
    }
    
    //Setting height for headers
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sections = BookifyBookTicketViewsSections.getSection(section)
        switch sections{
        case .expandView:
            return UITableView.automaticDimension
        case .collapseView:
            return UITableView.automaticDimension
        }
    }
    
    
    // Setting up cells for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        let sections = BookifyBookTicketViewsSections.getSection(indexPath.section)
        switch sections{
        case .expandView:
            let lCell = tableView.dequeueReusableCell(withIdentifier: BookifySelectLocationTableViewCell.identifier, for: indexPath) as! BookifySelectLocationTableViewCell
            lCell.cityData = viewModel?.cityData
            lCell.delegate = self
            cell = lCell
        case .collapseView:
           print("")
        }
        cell.selectionStyle = .none
        return cell
    }
    
    //setting height of the row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        let sections = BookifyBookTicketViewsSections.getSection(indexPath.section)
        switch sections{
        case .expandView:
            return BookifyHeightWidthConstants.BookifyCommon.locationSelectionCollectionViewHeight
        case .collapseView:
            return 0
        }
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sections = BookifyBookTicketViewsSections.getSection(indexPath.section)
        switch sections{
        case .expandView:
            print("")
        case .collapseView:
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
       
        
    }
    
    private func dismissViewController(){
        self.dismiss(animated: true)
    }

}


extension BookifySelectLocationViewController: BookifySelectLocationDelegate {
    func didTapOnLocation(cityName: String) {
        self.selectedLocationText = cityName
    }
}
