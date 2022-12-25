//
//  File.swift
//  
//
//  Created by wito on 27/11/22.
//

import Foundation
import UIKit
import Combine


class AnimatedBarView: UIView {
    
    private var barColor: UIColor
    @Published private var state: State = .clear
    private var subscribers = Set<AnyCancellable>()
    private var animator: UIViewPropertyAnimator!
    
    enum State {
        case clear
        case animating
        case fill
    }

    
    init(barColor: UIColor) {
        self.barColor = barColor
        super.init(frame: .zero)
        layout()
        observe()
       

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAnimator(){
        animator = UIViewPropertyAnimator(duration: 3.0, curve: .easeInOut, animations: {
            self.foregroundBarView.transform = .identity
        })
    }
    
    
    private func observe(){
        $state.sink { [unowned self] ss in
            switch ss {
            case .clear:
                setupAnimator()
                foregroundBarView.alpha = 0.0
                animator.stopAnimation(false)
            case .animating:
                foregroundBarView.transform = .init(scaleX: 0, y: 1.0)
                foregroundBarView.transform = .init(translationX: frame.size.width, y: 0)
                foregroundBarView.alpha = 1.0
                animator.startAnimation()
            case .fill:
                animator.stopAnimation(true)
                foregroundBarView.transform = .identity
            }
            
        }.store(in: &subscribers)
    }
    
    private lazy var backgoundBarView: UIView = {
        let view = UIView()
        view.backgroundColor = barColor.withAlphaComponent(0.2)
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var foregroundBarView: UIView = {
       let view = UIView()
        view.backgroundColor = barColor
        view.alpha = 0.0
        return view
    }()
    
    private func layout() {
        addSubview(backgoundBarView)
        backgoundBarView.addSubview(foregroundBarView)
        
        backgoundBarView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        foregroundBarView.snp.makeConstraints { make in
            make.edges.equalTo(backgoundBarView)
        }
    }
    
    func starAnimating() {
        state = .animating
    }
    
    func reset() {
        state = .clear
    }
    
    func complete() {
        state = .fill
    }
}
