//
//  DustInfoDataSource.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/03/31.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class DustInfoDataSource: NSObject, UITableViewDataSource {
    static let dummyDust = DustInfo(dustValue: 10, dustGrade: 1, measureDate: Date())
    static let dummyDustViewModel = DustInfoViewModel(dustInfo: DustInfoDataSource.dummyDust)
    private let dustInfoViewModels = [DustInfoViewModel].init(repeating: DustInfoDataSource.dummyDustViewModel, count: Quantity.numberOfRows)
    
    func cellViewModelForRow(at index: Int) -> DustInfoViewModel? {
        guard index < dustInfoViewModels.count else { return nil }
        return dustInfoViewModels[index]
    }
}

extension DustInfoDataSource {
    enum Quantity {
        static let numberOfRows = 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Quantity.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dustInfoCell = tableView.dequeueReusableCell(withIdentifier: DustInfoCell.reuseIdentifier,
                                                               for: indexPath) as? DustInfoCell else { return DustInfoCell() }
        
        let index = indexPath.item
        guard index < dustInfoViewModels.count else { return DustInfoCell() }
        
        dustInfoViewModels[index].configure(dustInfoCell)
        return dustInfoCell
    }
}

