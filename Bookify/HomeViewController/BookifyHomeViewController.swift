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
    private func setupUI() {
        //setting controller's UI
        setupViewUI()
        
        //setting start action button
        setupStartActionButton()
        addStartActionButtonConstraints()
    }
}


// MARK: - Setting up controller's UI
extension BookifyHomeViewController{
    private func setupViewUI() {
        view.backgroundColor = .bookifyBackground
    }
}


// MARK: - Setting up start action button
extension BookifyHomeViewController{
    private func setupStartActionButton() {
        self.view.addSubview(startButton)
        startButton.setupRoundButton(withTitle: BookifyStringConstants.startBookingText,
                                     withRadius: BookifyHeightWidthConstants
            .BookifyHomeVCConstants
            .wightOfStartButton/2)
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    private func addStartActionButtonConstraints() {
        startButton.snp.makeConstraints { make in
            make.center.equalTo(self.view.snp.center)
            make.width.equalTo(BookifyHeightWidthConstants.BookifyHomeVCConstants.wightOfStartButton)
            make.height.equalTo(BookifyHeightWidthConstants.BookifyHomeVCConstants.heightOfStartButton)
        }
    }
}

// MARK: - Adding Functionality on clicks or taps
extension BookifyHomeViewController{
    @objc private func startButtonClicked() {
        BookifyHaptic.addHapticTouch(style: .light)
        let viewController = BookifyRouter.ViewController.getSelectLocationViewController()
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
        
    }
}
