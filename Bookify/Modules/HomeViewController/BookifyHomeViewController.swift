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

// MARK: - Adding Functionality on clicks or taps
extension BookifyHomeViewController{
    @objc func startButtonClicked() {
        
        let viewController = BookifyRouter.ViewController.getSelectLocationViewController()
//        if let sheet = viewController.sheetPresentationController {
//            if #available(iOS 16.0, *) {
//                sheet.detents = [.custom{ _ in
//                    return 400
//                }]
//            } else {
//                sheet.detents = [.medium(), .large()]
//            }
//            
//            sheet.preferredCornerRadius = 40
//            sheet.prefersGrabberVisible = true
//        }
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
        
    }
}
