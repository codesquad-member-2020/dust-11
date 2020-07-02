//
//  DustInfoDataSource.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/03/31.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class DustInfoDataSource: NSObject, UITableViewDataSource {
    let dustInfoViewModels: DustInfoViewModels
    
    init(dustInfoViewModels: DustInfoViewModels) {
        self.dustInfoViewModels = dustInfoViewModels
    }
}

extension DustInfoDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dustInfoViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dustInfoCell = tableView.dequeueReusableCell(withIdentifier: DustInfoCell.reuseIdentifier,
                                                               for: indexPath) as? DustInfoCell else { return DustInfoCell() }
        let index = indexPath.row
        guard index < dustInfoViewModels.count else { return dustInfoCell }
        
        dustInfoViewModels.bind(at: index, dustInfoCell: dustInfoCell)
        return dustInfoCell
    }
}

