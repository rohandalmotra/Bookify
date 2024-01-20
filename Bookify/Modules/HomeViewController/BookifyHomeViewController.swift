//
//  BookifyHomeViewController.swift
//  Bookify
//
//  Created by Tech Mash on 20/01/24.
//

import UIKit
import SnapKit

class BookifyHomeViewController: UIViewController {
    private var startButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
}


// MARK: - Setting Up UI
extension BookifyHomeViewController{
    func setupUI() {
        //setting controller's UI
        setupViewUI()
        
        
        //setting start action button
        setupStartActionButton()
        addStartActionButtonConstraints()
        
        
    }
}


// MARK: - Setting up controller's UI
extension BookifyHomeViewController{
    func setupViewUI() {
        view.backgroundColor = .bookifyBackground
    }
}


// MARK: - Setting up start action button
extension BookifyHomeViewController{
    func setupStartActionButton() {
        self.view.addSubview(startButton)
        startButton.setupRoundButton(withTitle: "Welcome To Rohan's World",
                                     withRadius: BookifyHeightWidthConstants
            .BookifyHomeVCConstants
            .wightOfStartButton/2)
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    func addStartActionButtonConstraints() {
        startButton.snp.makeConstraints { make in
            make.center.equalTo(self.view.snp.center)
            make.width.equalTo(BookifyHeightWidthConstants.BookifyHomeVCConstants.wightOfStartButton)
            make.height.equalTo(BookifyHeightWidthConstants.BookifyHomeVCConstants.heightOfStartButton)
        }
    }
}

// MARK: - adding Functionality on clicks or taps
extension BookifyHomeViewController{
    @objc func startButtonClicked() {
        
    }
}
