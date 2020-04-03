//
//  BroadcastViewModel.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/04/03.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

struct BroadcastViewModel {
    private let broadcast: Broadcast
    private let broadcastImages = [UIImage]()
    
    init(broadcast: Broadcast) {
        self.broadcast = broadcast
    }
}
