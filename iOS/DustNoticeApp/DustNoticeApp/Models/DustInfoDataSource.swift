//
//  DustInfoDataSource.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/03/31.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class DustInfoDataSource: NSObject, UITableViewDataSource {
    private let dustInfoViewModels = [DustInfoViewModel]()
    
    enum Quantity {
        static let numberOfSections = 1
    }
}

extension DustInfoDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Quantity.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let dustInfoCell = tableView.dequeueReusableCell(withIdentifier: DustInfoCell.reuseIdentifier,
                                                            for: indexPath) as? DustInfoCell {
            return dustInfoCell
        }
        return DustInfoCell()
    }
}
