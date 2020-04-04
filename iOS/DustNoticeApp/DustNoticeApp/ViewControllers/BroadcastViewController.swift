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
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var button: UIButton!
    
    //MARK:- Internal Property
    private let dateProvider: () -> Date = Date.init
    private var broadcastViewModel: BroadcastViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSlider()
        configureButton()
        configureObserver()
        configureBroadcastInfo()
    }
    
    private func configureSlider() {
        slider.addTarget(self, action: #selector(silderValueChanged), for: .valueChanged)
    }
    
    @objc private func silderValueChanged() {
        guard broadcastViewModel.count != 0 else { return }
        let unit = slider.maximumValue / Float(broadcastViewModel.count)
        let currentValue = slider.value
        let currentIndex = Int(currentValue / unit)
        guard currentIndex < broadcastViewModel.count else { return }
        broadcastImageView.image = broadcastViewModel.broadcastImages[currentIndex]
    }
    
    private func configureButton() {
        button.addTarget(self, action: #selector(buttonTouchupInside), for: .touchUpInside)
    }
    
    private var isPlay = false
    @objc func buttonTouchupInside() {
        isPlay = !isPlay
        if isPlay {
            guard let pauseImage = UIImage(systemName: "pause.fill") else { return }
            button.setImage(pauseImage, for: .normal)
            
            guard broadcastViewModel.count != 0 else { return }
            let unit = self.slider.maximumValue / Float(self.broadcastViewModel.count)
            var curValue: Float = 0
            UIView.animate(withDuration: 1.0,
                           delay: 0,
                           options: [.autoreverse,.repeat],
                           animations: {
                            self.slider.setValue(curValue, animated: true)
                            curValue = curValue + unit / unit
                            let curIndex = Int(curValue) % self.broadcastViewModel.count
                            self.broadcastImageView.image = self.broadcastViewModel.broadcastImages[curIndex]
            }, completion: nil)
        } else {
            guard let playImage = UIImage(systemName: "play.fill") else { return }
            self.button.setImage(playImage, for: .normal)
        }
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
