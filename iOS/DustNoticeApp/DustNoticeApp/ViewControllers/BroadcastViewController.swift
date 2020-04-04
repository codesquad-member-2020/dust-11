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
    @IBOutlet weak var forecastImageView: ForecastImageView!
    @IBOutlet weak var broadcastLabel: BroadcastLabel!
    @IBOutlet weak var regionsLabel: BroadcastLabel!
    @IBOutlet weak var broadcastSlider: BroadcastSlider!
    @IBOutlet weak var toggleButton: ToggleButton!
    
    //MARK:- Internal Property
    private let dateProvider: () -> Date = Date.init
    private var broadcastViewModel: BroadcastViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureToggleButton()
        configureObserver()
        configureBroadcastInfo()
    }
    
    private func configureObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(configureViews),
                                               name: BroadcastViewModel.Notification.broadcastImagesDidChange,
                                               object: broadcastViewModel)
    }
    
    @objc private func configureViews() {
        DispatchQueue.main.async {
            self.configureFirstImage()
            self.configureSlider()
        }
    }
    
    private func configureFirstImage() {
        broadcastViewModel.bindFirstImage(self.forecastImageView)
    }
    
    private func configureSlider() {
        broadcastSlider.maximumValue = Float(broadcastViewModel.imagesCount - 1)
    }
    
    private func configureBroadcastInfo() {
        let date = dateProvider()
        let dateString = DateFormatter.broadcastDateFormatter.string(from: date)
        DustDecoder.decodeBroadcast(from: "\(NetworkManager.EndPoints.broadcastURL)\(dateString)",
        with: NetworkManager()) { broadcast in
            guard let broadcast = broadcast else { return }
            self.configureBroadcastViewModel(broadcast)
            DispatchQueue.main.async {
                self.broadcastViewModel.bindBroadcastLabel(self.broadcastLabel)
                self.broadcastViewModel.bindRegionsLabel(self.regionsLabel)
            }
        }
    }
    
    private func configureBroadcastViewModel(_ broadcast: Broadcast) {
        broadcastViewModel = BroadcastViewModel(broadcast: broadcast)
    }
}

extension BroadcastViewController: ToggleButtonDelegate {
    private func configureToggleButton() {
        toggleButton.delegate = self
    }
    
    func animate(with isPlay: Bool) {
        UIView.transition(with: forecastImageView, duration: 1, options: .transitionCrossDissolve, animations: {
            self.processSlider()
            self.processImage()
        }) { result in
            if result, isPlay {
                self.animate(with: isPlay)
            }
        }
    }
    
    private func processSlider() {
        let mod = broadcastViewModel.imagesCount
        let nextIndex = Int(broadcastSlider.value + 1) % mod
        broadcastSlider.setValue(Float(nextIndex), animated: true)
    }
    
    private func processImage() {
        broadcastViewModel.bind(forecastImageView, at: Int(broadcastSlider.value))
    }
}
