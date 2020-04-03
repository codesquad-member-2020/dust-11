//
//  BroadcastViewModel.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/04/03.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class BroadcastViewModel {
    private let dustInform: DustInform
    private var broadcastImages = [UIImage]()
    
    init(dustInform: DustInform) {
        self.dustInform = dustInform
        configureBroadcastImages(networkManager: NetworkManager())
    }
    
    private func configureBroadcastImages(networkManager: NetworkManager) {
        configureBroadcastImage(from: dustInform.imageUrl1, networkManager: networkManager)
        configureBroadcastImage(from: dustInform.imageUrl2, networkManager: networkManager)
        configureBroadcastImage(from: dustInform.imageUrl3, networkManager: networkManager)
        configureBroadcastImage(from: dustInform.imageUrl4, networkManager: networkManager)
        configureBroadcastImage(from: dustInform.imageUrl5, networkManager: networkManager)
        configureBroadcastImage(from: dustInform.imageUrl6, networkManager: networkManager)
    }
    
    private func configureBroadcastImage(from string: String, networkManager: NetworkManager) {
        networkManager.getResource(from: string) { data, error in
            guard error == nil else { return }
            guard let data = data else { return }
            self.insertBroadcastImage(data: data)
        }
    }
    
    private func insertBroadcastImage(data: Data) {
        guard let broadcastImage = UIImage(data: data) else { return }
        broadcastImages.append(broadcastImage)
    }
}
