import UIKit

final class BookifySlideInPresentationController: UIPresentationController {
    
    fileprivate lazy var dimmingView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: containerView!.bounds.width, height: containerView!.bounds.height))
        return view
    }()
    
    private var direction: PresentationDirection
    private var doTransform: Bool
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView!.bounds.size)
        switch direction {
        case .right:
            frame.origin.x = containerView!.frame.width
        case .bottom:
            frame.origin = .zero
        default:
            frame.origin = .zero
        }
        return frame
    }
    
    // MARK: - Initializers
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, direction: PresentationDirection, doTransform: Bool) {
        self.direction = direction
        self.doTransform = doTransform
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    override func presentationTransitionWillBegin() {
        if let containerView = self.containerView, let coordinator = presentedViewController.transitionCoordinator {
            
            containerView.addSubview(dimmingView)
            dimmingView.clipsToBounds = true
            dimmingView.isUserInteractionEnabled = true
            dimmingView.backgroundColor = .black
            dimmingView.alpha = 0.5
            
            NSLayoutConstraint.activate([
                dimmingView.topAnchor.constraint(equalTo: containerView.topAnchor),
                dimmingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                dimmingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                dimmingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
            ])
            
            dimmingView.addSubview(presentedViewController.view)
            NSLayoutConstraint.activate([
                presentedViewController.view.topAnchor.constraint(equalTo: dimmingView.topAnchor),
                presentedViewController.view.leadingAnchor.constraint(equalTo: dimmingView.leadingAnchor),
                presentedViewController.view.bottomAnchor.constraint(equalTo: dimmingView.bottomAnchor),
                presentedViewController.view.trailingAnchor.constraint(equalTo: dimmingView.trailingAnchor)
            ])
            
            coordinator.animate(alongsideTransition: { _ in
                // Animation code during presentation
            })
        }
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            // Animation code during dismissal
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        switch direction {
        case .left, .right:
            return CGSize(width: parentSize.width, height: parentSize.height)
        case .bottom, .top:
            return CGSize(width: parentSize.width, height: parentSize.height)
        }
    }
}
