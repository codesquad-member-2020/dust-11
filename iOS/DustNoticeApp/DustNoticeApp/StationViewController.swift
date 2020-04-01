//
//  FirstViewController.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/03/30.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class StationViewController: UIViewController {
    //MARK:- IBOutlet
    @IBOutlet weak var dustInfoTableView: UITableView!
    @IBOutlet weak var statusView: StatusView!
    
    //MARK:- Internal Property
    private let dustInfoDataSource = DustInfoDataSource()
    private let dustInfoDelegate = DustInfoDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDustInfoDelegate()
        setupDustInfoTableView()
    }
    
    private func setupDustInfoDelegate() {
        dustInfoDelegate.statusView = statusView
    }
    
    private func setupDustInfoTableView() {
        dustInfoTableView.dataSource = dustInfoDataSource
        dustInfoTableView.delegate = dustInfoDelegate
        dustInfoTableView.register(DustInfoCell.self,
                                   forCellReuseIdentifier: DustInfoCell.reuseIdentifier)
    }
}
