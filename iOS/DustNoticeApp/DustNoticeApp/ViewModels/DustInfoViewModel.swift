//
//  DustInfoViewModel.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/03/31.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class DustInfoViewModel {
    private let dustInfo: DustInfo
    private let calendar = Calendar(identifier: .gregorian)
    
    init(dustInfo: DustInfo) {
        self.dustInfo = dustInfo
    }
    
    func configure(_ dustInfoCell: DustInfoCell) {
        dustInfoCell.dustValueLabel.text = dustValueString
        guard let barSuperview = dustInfoCell.dustValueBar.superview else { return }
        
        let multiplier = Double(dustValue) / 200
        dustInfoCell.dustValueBar.widthAnchor.constraint(equalTo: barSuperview.widthAnchor,
                                                         multiplier: CGFloat(multiplier)).isActive = true
        dustInfoCell.dustValueBar.backgroundColor = backgroundColor
    }
    
    private var dustValue: UInt {
        return dustInfo.dustValue
    }
    
    private var dustValueString: String {
        return String(dustValue)
    }
    
    enum DustGrade: UInt {
        case good = 1
        case usual
        case bad
        case veryBad
    }
    
    private var dustGrade: DustGrade {
        return DustGrade(rawValue: dustInfo.dustGrade) ?? DustGrade.good
    }
    
    private var backgroundColor: UIColor {
        switch dustGrade {
        case .good:
            return UIColor.blueColor
        case .usual:
            return UIColor.greenColor
        case .bad:
            return UIColor.orangeColor
        case .veryBad:
            return UIColor.redColor
        }
    }
}
