//
//  CAGradientLayerExtension.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/03/31.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    static let gradientBlueColor: [CGColor] = [UIColor.BlueGradient.blueColor.cgColor,
                                               UIColor.BlueGradient.skyBlueColor.cgColor,
                                               UIColor.BlueGradient.whiteColor.cgColor]
    
    static let gradientGreenColor: [CGColor] = [UIColor.GreenGradient.greenColor.cgColor,
                                                UIColor.GreenGradient.paleGreenColor.cgColor,
                                                UIColor.GreenGradient.whiteColor.cgColor]
    
    static let gradientOrangeColor: [CGColor] = [UIColor.OrangeGradient.orangeColor.cgColor,
                                                 UIColor.OrangeGradient.paleOrangeColor.cgColor,
                                                 UIColor.OrangeGradient.whiteColor.cgColor]
    
    static let gradientRedColor: [CGColor] = [UIColor.RedGradient.redColor.cgColor,
                                              UIColor.RedGradient.paleRedColor.cgColor,
                                              UIColor.RedGradient.whiteColor.cgColor]
}
