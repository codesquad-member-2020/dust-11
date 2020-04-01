//
//  DustInfoDataSource.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/03/31.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

enum DummyData {
    enum DummyDust {
        static let good = DustInfo(dustValue: 10, dustGrade: 1, measureDate: Date())
        static let usual = DustInfo(dustValue: 50, dustGrade: 2, measureDate: Date())
        static let bad = DustInfo(dustValue: 120, dustGrade: 3, measureDate: Date())
        static let veryBad = DustInfo(dustValue: 200, dustGrade: 4, measureDate: Date())
    }
    
    enum DummyDustViewModels {
        static let goods: [DustInfoViewModel] = {
            var viewModels = [DustInfoViewModel]()
            for _ in 0 ..< DustInfoDataSource.Quantity.numberOfRows / 4 {
                viewModels.append(DustInfoViewModel(dustInfo: DummyDust.good))
            }
            return viewModels
        }()
        static let usuals: [DustInfoViewModel] = {
            var viewModels = [DustInfoViewModel]()
            for _ in 0 ..< DustInfoDataSource.Quantity.numberOfRows / 4 {
                viewModels.append(DustInfoViewModel(dustInfo: DummyDust.usual))
            }
            return viewModels
        }()
        static let bads: [DustInfoViewModel] = {
            var viewModels = [DustInfoViewModel]()
            for _ in 0 ..< DustInfoDataSource.Quantity.numberOfRows / 4 {
                viewModels.append(DustInfoViewModel(dustInfo: DummyDust.bad))
            }
            return viewModels
        }()
        static let veryBads: [DustInfoViewModel] = {
            var viewModels = [DustInfoViewModel]()
            for _ in 0 ..< DustInfoDataSource.Quantity.numberOfRows / 4 {
                viewModels.append(DustInfoViewModel(dustInfo: DummyDust.veryBad))
            }
            return viewModels
        }()
        
        static let max: [DustInfoViewModel] = {
            var viewModels = [DustInfoViewModel]()
            viewModels.append(contentsOf: goods)
            viewModels.append(contentsOf: usuals)
            viewModels.append(contentsOf: bads)
            viewModels.append(contentsOf: veryBads)
            return viewModels
        }()
    }
}

final class DustInfoDataSource: NSObject, UITableViewDataSource {
    let dustInfoViewModels = DustInfoViewModels(dustInfoViewModels: DummyData.DummyDustViewModels.max)
}

extension DustInfoDataSource {
    enum Quantity {
        static let numberOfRows = 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Quantity.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dustInfoCell = tableView.dequeueReusableCell(withIdentifier: DustInfoCell.reuseIdentifier,
                                                               for: indexPath) as? DustInfoCell else { return DustInfoCell() }
        let index = indexPath.row
        guard index < dustInfoViewModels.count else { return DustInfoCell() }
        
        dustInfoViewModels.bind(at: index, dustInfoCell: dustInfoCell)
        return dustInfoCell
    }
}

