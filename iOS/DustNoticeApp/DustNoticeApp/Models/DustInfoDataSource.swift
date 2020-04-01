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
            var models = [DustInfoViewModel]()
            for _ in 0 ..< DustInfoDataSource.Quantity.numberOfRows / 4 {
                models.append(DustInfoViewModel(dustInfo: DummyDust.good))
            }
            return models
        }()
        static let usuals: [DustInfoViewModel] = {
            var models = [DustInfoViewModel]()
            for _ in 0 ..< DustInfoDataSource.Quantity.numberOfRows / 4 {
                models.append(DustInfoViewModel(dustInfo: DummyDust.usual))
            }
            return models
        }()
        static let bads: [DustInfoViewModel] = {
            var models = [DustInfoViewModel]()
            for _ in 0 ..< DustInfoDataSource.Quantity.numberOfRows / 4 {
                models.append(DustInfoViewModel(dustInfo: DummyDust.bad))
            }
            return models
        }()
        static let veryBads: [DustInfoViewModel] = {
            var models = [DustInfoViewModel]()
            for _ in 0 ..< DustInfoDataSource.Quantity.numberOfRows / 4 {
                models.append(DustInfoViewModel(dustInfo: DummyDust.veryBad))
            }
            return models
        }()
    }
}

final class DustInfoDataSource: NSObject, UITableViewDataSource {
    private let dustInfoViewModels: [DustInfoViewModel] = {
        var models = [DustInfoViewModel]()
        models.append(contentsOf: DummyData.DummyDustViewModels.goods)
        models.append(contentsOf: DummyData.DummyDustViewModels.usuals)
        models.append(contentsOf: DummyData.DummyDustViewModels.bads)
        models.append(contentsOf: DummyData.DummyDustViewModels.veryBads)
        return models
    }()
    
    func cellViewModelForRow(at index: Int) -> DustInfoViewModel? {
        guard index < dustInfoViewModels.count else { return nil }
        return dustInfoViewModels[index]
    }
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
        
        dustInfoViewModels[index].configure(dustInfoCell)
        return dustInfoCell
    }
}

