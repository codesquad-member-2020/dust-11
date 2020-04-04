//
//  ForecastImageView.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/04/04.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class ForecastImageView: UIImageView {
    
    
}

extension ForecastImageView: ToggleButtonDelegate {
    func animate(with isPlay: Bool) {
        UIView.transition(with: self, duration: 1, options: .transitionCrossDissolve,
                          animations: {
                            
        },
                          completion: { result in
                            if result, isPlay {
                                self.animate(with: isPlay)
                            }
        })
    }
}
