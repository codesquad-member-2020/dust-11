//
//  BroadcastLabel.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/04/04.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

class BroadcastLabel: UILabel {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        configureFont()
        configureLine()
    }
    
    private func configureFont() {
        font = UIFont.systemFont(ofSize: 10)
    }
    
    private func configureLine() {
        lineBreakMode = .byWordWrapping
        numberOfLines = 3
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: -15, left: 0, bottom: 0, right: 0)
        super.drawText(in: rect.inset(by: insets))
    }
}
