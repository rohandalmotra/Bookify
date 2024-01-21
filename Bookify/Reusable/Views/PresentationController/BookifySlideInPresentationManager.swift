//
//  BookifySlideInPresentationManager.swift
//  Bookify
//
//  Created by Tech Mash on 21/01/24.
//

import UIKit

enum PresentationDirection {
    case left
    case top
    case right
    case bottom
}

protocol BookifySlideInPresentationManagerDelegate: AnyObject {
    func viewControllerForAdaptivePresentationStyle(_ style: UIModalPresentationStyle) -> UIViewController?
}

final class BookifySlideInPresentationManager: NSObject {
    
    // MARK: - Properties
    var direction = PresentationDirection.left
    @objc var disableCompactHeight = false
    var doTransform = true
    
    weak var delegate: BookifySlideInPresentationManagerDelegate?
    
    @objc func setAnimationDirection(_ animationDirection: Int) {
        switch animationDirection {
        case 1:
            // left
            direction = .left
            break
        case 2:
            // left
            direction = .top
            break
        case 3:
            // left
            direction = .right
            break
        case 4:
            // left
            direction = .bottom
            break
        default:
            break
        }
    }
    
}

// MARK: - UIViewControllerTransitioningDelegate
extension BookifySlideInPresentationManager: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = BookifySlideInPresentationController(presentedViewController: presented, presenting: presenting, direction: direction, doTransform: doTransform)
        presentationController.delegate = self
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BookifySlideInPresentationAnimator(direction: direction, isPresentation: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BookifySlideInPresentationAnimator(direction: direction, isPresentation: false)
    }
}

// MARK: - UIAdaptivePresentationControllerDelegate
extension BookifySlideInPresentationManager: UIAdaptivePresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        if traitCollection.verticalSizeClass == .compact && disableCompactHeight {
            return .overFullScreen
        } else {
            return .none
        }
    }
    
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        return self.delegate?.viewControllerForAdaptivePresentationStyle(style)
    }
}

