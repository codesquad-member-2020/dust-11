//
//  DustInfoDelegate.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/03/31.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class DustInfoDelegate: NSObject, UITableViewDelegate {
    var statusView: StatusView?
    private let statusViewModel = StatusViewModel()
    private var willDisplayIndex = 0
    private var endDisplayIndex = 0
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let dustInfoTableView = scrollView as? UITableView else { return }
        guard let indexPathsForVisibleRows = dustInfoTableView.indexPathsForVisibleRows,
            let firstIndexPath = indexPathsForVisibleRows.first else { return }
        guard let statusView = statusView else { return }
        guard let dustInfoDataSource = dustInfoTableView.dataSource as? DustInfoDataSource else { return }
        guard let dustInfoViewModel = dustInfoDataSource.cellViewModelForRow(at: firstIndexPath.row) else { return }
        statusViewModel.configure(statusView, dustInfoViewModel: dustInfoViewModel)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let firstRow = 0
        let row = indexPath.row
        guard firstRow == row else { return }
        guard let statusView = statusView else { return }
        guard let dustInfoDataSource = tableView.dataSource as? DustInfoDataSource else { return }
        guard let dustInfoViewModel = dustInfoDataSource.cellViewModelForRow(at: indexPath.row) else { return }
        statusViewModel.configure(statusView, dustInfoViewModel: dustInfoViewModel)
    }
}
