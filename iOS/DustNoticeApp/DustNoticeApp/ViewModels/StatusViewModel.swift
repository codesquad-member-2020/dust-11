//
//  StatusViewModel.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/03/31.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class StatusViewModel {
    func configure(_ statusView: StatusView, dustInfoViewModel: DustInfoViewModel) {
        switch dustInfoViewModel.dustGrade {
        case .good:
            bind(statusView, status: Status.good)
        case .usual:
            bind(statusView, status: Status.usual)
        case .bad:
            bind(statusView, status: Status.bad)
        case .veryBad:
            bind(statusView, status: Status.veryBad)
        }
        statusView.measureLabel.text = String("\(dustInfoViewModel.dustValue) 𝜇g/m3")
    }
    
    private func bind(_ statusView: StatusView, status: Status) {
        statusView.gradientLayer.colors = status.rawValue.gradientColors
        statusView.emogiView.image = status.rawValue.emojiImage
        statusView.statusLabel.text = status.rawValue.statusLabelText
    }
}

extension StatusViewModel {
    struct StatusData: Equatable {
        let gradientColors: [CGColor]
        let statusLabelText: String
        let emojiImage: UIImage
    }
    
    enum Status: RawRepresentable {
        case good
        case usual
        case bad
        case veryBad
        
        typealias RawValue = StatusData
        
        init?(rawValue: StatusViewModel.StatusData) {
            switch rawValue {
            case .init(gradientColors: CAGradientLayer.gradientBlueColor,
                       statusLabelText: "좋음", emojiImage: UIImage(named: "face-smile-big")!): self = .good
            case .init(gradientColors: CAGradientLayer.gradientGreenColor,
                       statusLabelText: "보통", emojiImage: UIImage(named: "face-tiny-smile")!): self = .usual
            case .init(gradientColors: CAGradientLayer.gradientOrangeColor,
                       statusLabelText: "나쁨", emojiImage: UIImage(named: "face-sad")!): self = .bad
            case .init(gradientColors: CAGradientLayer.gradientRedColor,
                       statusLabelText: "매우나쁨", emojiImage: UIImage(named: "face-crying")!): self = .veryBad
            default:
                return nil
            }
        }
        
        var rawValue: StatusViewModel.StatusData {
            switch self {
            case .good:
                return StatusViewModel.StatusData(
                    gradientColors: CAGradientLayer.gradientBlueColor,
                    statusLabelText: "좋음",
                    emojiImage: UIImage(named: "face-smile-big")!)
            case .usual:
                return StatusViewModel.StatusData(
                    gradientColors: CAGradientLayer.gradientGreenColor,
                    statusLabelText: "보통",
                    emojiImage: UIImage(named: "face-tiny-smile")!)
            case .bad:
                return StatusViewModel.StatusData(
                    gradientColors: CAGradientLayer.gradientOrangeColor,
                    statusLabelText: "나쁨",
                    emojiImage: UIImage(named: "face-sad")!)
            case .veryBad:
                return StatusViewModel.StatusData(
                    gradientColors: CAGradientLayer.gradientRedColor,
                    statusLabelText: "매우나쁨",
                    emojiImage: UIImage(named: "face-crying")!)
            }
        }
    }
}
