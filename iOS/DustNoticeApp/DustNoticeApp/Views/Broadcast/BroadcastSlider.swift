//
//  BroadcastSlider.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/04/04.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class BroadcastSlider: UISlider {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDelegate()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureDelegate()
    }
    
    private func configureDelegate() {
        addTarget(self, action: #selector(silderValueChanged), for: .valueChanged)
    }
    
    @objc private func silderValueChanged() {
        
    }
}
