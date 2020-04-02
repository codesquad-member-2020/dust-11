//
//  DustInfoDelegate.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/03/31.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class DustInfoDelegate: NSObject, UITableViewDelegate {
    weak var statusView: StatusView?
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let dustInfoTableView = scrollView as? UITableView else { return }
        guard let indexPathsForVisibleRows = dustInfoTableView.indexPathsForVisibleRows,
            let firstIndexPath = indexPathsForVisibleRows.first else { return }
        guard let statusView = statusView else { return }
        guard let dustInfoDataSource = dustInfoTableView.dataSource as? DustInfoDataSource else { return }
        
        dustInfoDataSource.dustInfoViewModels.bind(at: firstIndexPath.row, statusView: statusView)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let firstRow = 0
        let row = indexPath.row
        guard firstRow == row else { return }
        guard let statusView = statusView else { return }
        guard let dustInfoDataSource = tableView.dataSource as? DustInfoDataSource else { return }
        
        dustInfoDataSource.dustInfoViewModels.bind(at: firstRow, statusView: statusView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt: IndexPath) {
        guard let statusView = statusView else { return }
        guard let dustInfoDataSource = tableView.dataSource as? DustInfoDataSource else { return }
        
        dustInfoDataSource.dustInfoViewModels.bind(at: didSelectRowAt.row, statusView: statusView)
    }
}
