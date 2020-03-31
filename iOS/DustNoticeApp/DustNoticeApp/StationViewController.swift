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
    
    //MARK:- Internal Property
    private let dustInfoDataSource = DustInfoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDustInfoTableView()
    }
    
    private func setupDustInfoTableView() {
        dustInfoTableView.dataSource = dustInfoDataSource
    }
}

