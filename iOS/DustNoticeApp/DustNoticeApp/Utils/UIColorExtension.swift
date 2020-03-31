//
//  UIColorExtension.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/03/31.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init?(red: Int, green: Int, blue: Int) {
        guard red >= 0 && red <= 255,
            green >= 0 && green <= 255,
            blue >= 0 && blue <= 255
            else { return nil }
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: 1.0)
    }
    
    convenience init?(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension UIColor {
    enum BlueGradient {
        static let blueColor = UIColor(rgb: 0x3D85DD)!
        static let skyBlueColor = UIColor(rgb: 0x77A2D5)!
        static let whiteColor = UIColor(rgb: 0xFFFFFF)!
    }
    
    enum GreenGradient {
        static let greenColor = UIColor(rgb: 0x23BA46)!
        static let paleGreenColor = UIColor(rgb: 0x57E6B5)!
        static let whiteColor = UIColor(rgb: 0xFFFFFF)!
    }
    
    enum OrangeGradient {
        static let orangeColor = UIColor(rgb: 0xFF8900)!
        static let paleOrangeColor = UIColor(rgb: 0xEAD89E)!
        static let whiteColor = UIColor(rgb: 0xFFFFFF)!
    }
    
    enum RedGradient {
        static let redColor = UIColor(rgb: 0xC10404)!
        static let paleRedColor = UIColor(rgb: 0xD36565)!
        static let whiteColor = UIColor(rgb: 0xFFFFFF)!
    }
}
