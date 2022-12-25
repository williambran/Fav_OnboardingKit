//
//  File.swift
//  
//
//  Created by wito on 27/11/22.
//

import Foundation
import UIKit


class TittleView: UIView {
    //
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "ArialRoundedMTBold", size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.9
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
     func setTitle(text: String?) {
        titleLabel.text = text
    }
    
    func layout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.bottom.equalTo(snp.bottom).offset(-36)
            make.leading.equalTo(snp.leading).offset(36)
            make.trailing.equalTo(snp.trailing).offset(-36)
        }
    }
    
}
