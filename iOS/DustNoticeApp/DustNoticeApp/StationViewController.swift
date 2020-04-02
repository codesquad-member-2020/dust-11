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
    private var dustInfoDataSource: DustInfoDataSource!
    private let dustInfoDelegate = DustInfoDelegate()
    private let locationManager = LocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureObserver()
        configureDustInfoDelegate()
        configureDustInfoTableView()
    }
    
    private func configureObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(configureDustInfo),
                                               name: LocationManager.Notification.subLocalityDidChange,
                                               object: locationManager)
    }
    
    @objc private func configureDustInfo() {
        guard let subLocality = locationManager.subLocality else { return }
        DustInfoDecoder.decode(from: "\(NetworkManager.EndPoints.dustURL)\(subLocality)",
        with: NetworkManager()) { station in
            guard let station = station else { return }
            DispatchQueue.main.async {
                self.configureStatusView(station.stationName)
                self.configureDataSource(dustInfos: station.list)
                self.dustInfoTableView.reloadData()
            }
        }
    }
    
    private func configureStatusView(_ stationName: String) {
        statusView.stationLabel.text = "\(stationName) 측정소 기준"
    }
    
    private func configureDataSource(dustInfos: [DustInfo]) {
        let dustInfoViewModels = dustInfos.map{ DustInfoViewModel(dustInfo: $0) }
        dustInfoDataSource = DustInfoDataSource(dustInfoViewModels: DustInfoViewModels(dustInfoViewModels))
        dustInfoTableView.dataSource = dustInfoDataSource
    }
    
    private func configureDustInfoDelegate() {
        dustInfoDelegate.statusView = statusView
    }
    
    private func configureDustInfoTableView() {
        dustInfoTableView.delegate = dustInfoDelegate
        dustInfoTableView.register(DustInfoCell.self,
                                   forCellReuseIdentifier: DustInfoCell.reuseIdentifier)
    }
}
