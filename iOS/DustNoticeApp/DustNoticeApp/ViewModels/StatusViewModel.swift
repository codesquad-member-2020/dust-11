//
//  StatusViewModel.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/03/31.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class StatusViewModel {
    var status: Status!
    
    
}

extension StatusViewModel {
    struct StatusData: Equatable {
        let grade: UInt
        let gradientColor: [CGColor]
        let statusLabelText: String
        let emojiView: UIImageView
    }
    
    enum Status: RawRepresentable {
        case good
        case usual
        case bad
        case veryBad
        
        typealias RawValue = StatusData
        
        init?(rawValue: StatusViewModel.StatusData) {
            switch rawValue {
            case .init(grade: 1, gradientColor: CAGradientLayer.gradientBlueColor,
                       statusLabelText: "좋음", emojiView: UIImageView(image: #imageLiteral(resourceName: "face-smile-big"))): self = .good
            case .init(grade: 2, gradientColor: CAGradientLayer.gradientGreenColor,
                       statusLabelText: "보통", emojiView: UIImageView(image: #imageLiteral(resourceName: "face-tiny-smile"))): self = .usual
            case .init(grade: 3, gradientColor: CAGradientLayer.gradientOrangeColor,
                       statusLabelText: "나쁨", emojiView: UIImageView(image: #imageLiteral(resourceName: "face-sad"))): self = .bad
            case .init(grade: 4, gradientColor: CAGradientLayer.gradientRedColor,
                       statusLabelText: "매우나쁨", emojiView: UIImageView(image: #imageLiteral(resourceName: "face-crying"))): self = .veryBad
            default:
                return nil
            }
        }
        
        var rawValue: StatusViewModel.StatusData {
            switch self {
            case .good:
                return StatusViewModel.StatusData(grade: 1,
                                             gradientColor: CAGradientLayer.gradientBlueColor,
                                             statusLabelText: "좋음",
                                             emojiView: UIImageView(image: #imageLiteral(resourceName: "face-smile-big")))
            case .usual:
                return StatusViewModel.StatusData(grade: 2,
                                             gradientColor: CAGradientLayer.gradientGreenColor,
                                             statusLabelText: "보통",
                                             emojiView: UIImageView(image: #imageLiteral(resourceName: "face-tiny-smile")))
            case .bad:
                return StatusViewModel.StatusData(grade: 3,
                                             gradientColor: CAGradientLayer.gradientOrangeColor,
                                             statusLabelText: "나쁨",
                                             emojiView: UIImageView(image: #imageLiteral(resourceName: "face-sad")))
            case .veryBad:
                return StatusViewModel.StatusData(grade: 4,
                                             gradientColor: CAGradientLayer.gradientRedColor,
                                             statusLabelText: "매우나쁨",
                                             emojiView: UIImageView(image: #imageLiteral(resourceName: "face-crying")))
            }
        }
    }
    
}
