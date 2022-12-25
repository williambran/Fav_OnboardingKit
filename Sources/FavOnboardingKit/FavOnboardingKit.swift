
import UIKit

public protocol FavOnboardingKitDelegate: AnyObject {
    func nextButtonDidTap(atIndex index: Int)
    func getStaredButton()
}


public class FavOnboardingKit {
    
    private let slides: [Slide]
    private let tintColor: UIColor
    public weak var delegate: FavOnboardingKitDelegate?
    public var rootVC: UIViewController?
    
    private lazy var onboardingViewController : OnboardingViewController = {
        let controller = OnboardingViewController(slides: slides, tintColor: tintColor)
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        
        controller.nextButtonDidTap = { [weak self] index in
            self?.delegate?.nextButtonDidTap(atIndex: index)
        }
        controller.getStartedButttonDidTap = {[weak self] in
            self?.delegate?.getStaredButton()
        }
        return controller
    }()
    
    public init(slides: [Slide], tintColor: UIColor){
        self.slides = slides
        self.tintColor = tintColor
    }
    
    public func launchOnboarding(rootVC: UIViewController) {
        rootVC.present( onboardingViewController, animated: true, completion: nil)
    }
    
    public func dismissOnboardin() {
        onboardingViewController.stopAnimation()
        if rootVC?.presentedViewController == onboardingViewController {
            onboardingViewController.dismiss(animated: true, completion: nil)
        }
        
    }
}
