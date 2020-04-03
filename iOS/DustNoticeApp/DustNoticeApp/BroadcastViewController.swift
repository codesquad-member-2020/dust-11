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
    
    //MARK:- Internal Property
    private let dateProvider: () -> Date = Date.init
    private var broadcastViewModel: BroadcastViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBroadcastInfo()
    }
    
    private func configureBroadcastInfo() {
        let date = dateProvider()
        let dateString = DateFormatter.broadcastDateFormatter.string(from: date)
        DustInfoDecoder.decodeBroadcast(from: "\(NetworkManager.EndPoints.broadcastURL)\(dateString)",
        with: NetworkManager()) { broadcast in
            guard let broadcast = broadcast else { return }
            guard let dustInform = broadcast.list.first else { return }
            self.configureBroadcastViewModel(dustInform)
        }
    }
    
    private func configureBroadcastViewModel(_ dustInform: DustInform) {
        broadcastViewModel = BroadcastViewModel(dustInform: dustInform)
    }
}
