//
//  SecondViewController.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/03/30.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class BroadcastViewController: UIViewController {
    //MARK:- IBOutlet
    @IBOutlet weak var broadcastImageView: UIImageView!
    @IBOutlet weak var broadcastLabel: BroadcastLabel!
    @IBOutlet weak var regionsLabel: BroadcastLabel!
    @IBOutlet weak var broadcastSlider: BroadcastSlider!
    @IBOutlet weak var broadcastButton: UIButton!
    
    //MARK:- Internal Property
    private let dateProvider: () -> Date = Date.init
    private var broadcastViewModel: BroadcastViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureObserver()
        configureBroadcastInfo()
    }
    
    private func configureObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(configureFirstBroadcastImage),
                                               name: BroadcastViewModel.Notification.broadcastImagesDidChange,
                                               object: broadcastViewModel)
    }
    
    @objc private func configureFirstBroadcastImage() {
        DispatchQueue.main.async {
            self.broadcastViewModel.bindFirstImage(self.broadcastImageView)
        }
    }
    
    private func configureBroadcastInfo() {
        let date = dateProvider()
        let dateString = DateFormatter.broadcastDateFormatter.string(from: date)
        DustDecoder.decodeBroadcast(from: "\(NetworkManager.EndPoints.broadcastURL)\(dateString)",
        with: NetworkManager()) { broadcast in
            guard let broadcast = broadcast else { return }
            self.configureBroadcastViewModel(broadcast)
            DispatchQueue.main.async {
                self.broadcastLabel.text = self.broadcastViewModel.broadcast.informOverall
                self.regionsLabel.text = self.broadcastViewModel.broadcast.informGrade
            }
        }
    }
    
    private func configureBroadcastViewModel(_ broadcast: Broadcast) {
        broadcastViewModel = BroadcastViewModel(broadcast: broadcast)
    }
}
