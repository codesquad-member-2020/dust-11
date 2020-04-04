//
//  ToggleButton.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/04/04.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class ToggleButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDelegate()
        configureBorder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureDelegate()
        configureBorder()
    }
    
    private func configureDelegate() {
        addTarget(self, action: #selector(isPlayChanged), for: .touchUpInside)
    }
    
    @objc func isPlayChanged() {
        
    }
    
    private func configureBorder() {
        layer.borderWidth = 0.9
        layer.borderColor = UIColor.black.cgColor
    }
}

