//
//  DustInfoViewModel.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/03/31.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

final class DustInfoViewModel {
    private let dustInfo: DustInfo
    private let calendar = Calendar(identifier: .gregorian)
    
    init(dustInfo: DustInfo) {
        self.dustInfo = dustInfo
    }
}
