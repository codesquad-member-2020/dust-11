//
//  DustInfoViewModels.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/04/02.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

final class DustInfoViewModels {
    private let dustInfoViewModels: [DustInfoViewModel]
    
    init(dustInfoViewModels: [DustInfoViewModel]) {
        self.dustInfoViewModels = dustInfoViewModels
    }
    
    func bind(at index: Int, dustInfoCell: DustInfoCell) {
        guard index < dustInfoViewModels.count else { return }
        dustInfoViewModels[index].bind(dustInfoCell: dustInfoCell)
    }
    
    func bind(at index: Int, statusView: StatusView) {
        guard index < dustInfoViewModels.count else { return }
        dustInfoViewModels[index].bind(statusView: statusView)
    }
    
    var count: Int {
        return dustInfoViewModels.count
    }
}
