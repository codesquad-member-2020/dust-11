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
    private let calendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ko_KR")
        return calendar
    }()
    
    init(dustInfo: DustInfo) {
        self.dustInfo = dustInfo
    }
    
    func bind(dustInfoCell: DustInfoCell) {
        dustInfoCell.dustValueLabel.text = dustValueString
        dustInfoCell.dustValueBar.backgroundColor = backgroundColor
        dustInfoCell.setBarWitdhConstraint(multiplier: multiplier())
    }
    
    func bind(statusView: StatusView) {
        statusView.measureLabel.text = String("\(dustValue) 𝜇g/m3")
        statusView.dateLabel.text = measureDateString
        StatusViewModel.bind(statusView, dustGrade: dustGrade)
    }
    
    private func multiplier() -> CGFloat {
        let dustValue = Double(self.dustValue)
        let maxPollutionValue = 200.0
        if dustValue < maxPollutionValue {
            return CGFloat(dustValue / maxPollutionValue)
        } else {
            return 1
        }
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
    
    enum DayDifference: Int, CustomStringConvertible {
        case yesterday = 1
        case today = 0
        
        var description: String {
            switch self {
            case .yesterday:
                return "어제"
            case .today:
                return "오늘"
            }
        }
    }
    
    private var measureDateString: String? {
        let today = calendar.dateComponents([.day], from: Date())
        let components = calendar.dateComponents([.day,.hour,.minute], from: dustInfo.measureDate)
        guard let dayOfToday = today.day else { return nil }
        guard let measureDay = components.day,
            let measureHour = components.hour,
            let measuerMinute = components.minute else { return nil }
        guard let dayDifference = DayDifference(rawValue: dayOfToday - measureDay) else { return nil }
        return "\(dayDifference.description) \(measureHour):\(measuerMinute)"
    }
}
