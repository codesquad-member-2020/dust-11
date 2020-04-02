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
        static let good = DustInfo(dataTime: "10", pm10Grade1h: "1", pm10Value: "0")
        static let usual = DustInfo(dataTime: "50", pm10Grade1h: "2", pm10Value: "0")
        static let bad = DustInfo(dataTime: "120", pm10Grade1h: "3", pm10Value: "0")
        static let veryBad = DustInfo(dataTime: "200", pm10Grade1h: "4", pm10Value: "0")
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

