//
//  BroadcastViewModel.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/04/03.
//  Copyright © 2020 Jason. All rights reserved.
//
import Foundation
import UIKit

final class BroadcastViewModel {
    enum Notification {
        static let broadcastImagesDidChange = Foundation.Notification.Name("broadcastImagesDidChange")
    }
    let broadcast: Broadcast
    private var broadcastImages = [UIImage]()
    private static let totalImagesCount = 3
    var imagesCount: Int {
        return broadcastImages.count
    }
    
    init(broadcast: Broadcast) {
        self.broadcast = broadcast
        configureBroadcastImages(networkManager: NetworkManager())
    }
    
    private func configureBroadcastImages(networkManager: NetworkManager) {
        configureBroadcastImage(from: broadcast.imageUrl1, networkManager: networkManager)
        configureBroadcastImage(from: broadcast.imageUrl2, networkManager: networkManager)
        configureBroadcastImage(from: broadcast.imageUrl3, networkManager: networkManager)
    }
    
    private func configureBroadcastImage(from string: String, networkManager: NetworkManager) {
        networkManager.getResource(from: string) { data, error in
            guard error == nil else { return }
            guard let data = data else { return }
            self.insertBroadcastImage(data: data)
            if self.imagesCount == BroadcastViewModel.totalImagesCount {
                NotificationCenter.default.post(name: Notification.broadcastImagesDidChange, object: self)
            }
        }
    }
    
    private func insertBroadcastImage(data: Data) {
        guard let broadcastImage = UIImage(data: data) else { return }
        broadcastImages.append(broadcastImage)
    }
    
    func bindFirstImage(_ broadcastImageView: UIImageView) {
        let firstImageIndex = 0
        broadcastImageView.image = broadcastImages[firstImageIndex]
    }
}
