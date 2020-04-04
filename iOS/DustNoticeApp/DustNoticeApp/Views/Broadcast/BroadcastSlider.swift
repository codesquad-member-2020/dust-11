//
//  BroadcastSlider.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/04/04.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

protocol BroadcastSliderDelegate {
    func broadcastSliderValueDidChange(at sliderValue: Float)
}

final class BroadcastSlider: UISlider {
    var delegate: BroadcastSliderDelegate?
    
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
        let interval: Float = 0.1
        guard value - Float(Int(value)) <= interval else { return }
        delegate?.broadcastSliderValueDidChange(at: value)
    }
}
