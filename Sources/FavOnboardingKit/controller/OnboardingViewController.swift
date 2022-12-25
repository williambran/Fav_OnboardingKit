//
//  File.swift
//  
//
//  Created by wito on 27/11/22.
//

import UIKit
import SnapKit


class OnboardingViewController: UIViewController {
    
    var nextButtonDidTap:((Int) -> Void)?
    var getStartedButttonDidTap: (() -> Void)?
    
    private let slides: [Slide]
    private let tintColor: UIColor
    
    private lazy  var transitionView: TransitionView = {
        let view = TransitionView(slide: slides, tintColor: tintColor)
        return view
    }()
    
    private lazy var buttonContainerView: ButtonConainerView = {
        
        let view = ButtonConainerView(tintColor: tintColor)
        
        view.nextButtonDidTap = { [weak self] in
            guard let this = self else {
                return
            }
            this.nextButtonDidTap?(self!.transitionView.slideIndex)
            this.transitionView.handleTap(direction: .right)
            print("Se toco next button")
        }
        
        view.getStaredButtonDidTap = getStartedButttonDidTap
        return  view
    }()
    
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [transitionView, buttonContainerView])
        view.axis = .vertical
        return view
    }()
    
    public init(slides: [Slide], tintColor: UIColor){
        self.slides = slides
        self.tintColor = tintColor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        transitionView.start()
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        
        buttonContainerView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }

    }
    
    func stopAnimation() {
        transitionView.stop()
    }
    
    func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap(_:)))
        transitionView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func viewDidTap(_ tap: UITapGestureRecognizer)  {
        let point = tap.location(in: view)
        let midPoint = view.frame.size.width / 2
        if point.x > midPoint {
            transitionView.handleTap(direction: .right)
        } else {
            transitionView.handleTap(direction: .left)
        }
        print("holis", point)
    }
}
