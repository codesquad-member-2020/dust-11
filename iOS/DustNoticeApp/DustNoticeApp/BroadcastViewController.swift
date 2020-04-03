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
    @IBOutlet weak var broadcastLabel: UILabel!
    @IBOutlet weak var regionsLabel: UILabel!
    
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
        let firstImageCount = 1
        let firstIndex = 0
        if broadcastViewModel.count == firstImageCount {
            DispatchQueue.main.async {
                self.broadcastImageView.image = self.broadcastViewModel.broadcastImages[firstIndex]
            }
        }
    }
    
    private func configureBroadcastInfo() {
        let date = dateProvider()
        let dateString = DateFormatter.broadcastDateFormatter.string(from: date)
        DustInfoDecoder.decodeBroadcast(from: "\(NetworkManager.EndPoints.broadcastURL)\(dateString)",
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
    
    @IBAction func changeRowSlider(_ sender: UISlider) {
        let unit = sender.maximumValue / Float(broadcastViewModel.count)
        let currentValue = sender.value
        let currentIndex = Int(currentValue / unit)
        guard currentIndex < broadcastViewModel.count else { return }
        broadcastImageView.image = broadcastViewModel.broadcastImages[currentIndex]
    }
}
