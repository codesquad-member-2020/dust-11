//
//  DustInfoDecoder.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/04/02.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct DustInfoDecoder {
    static func decode(from string: String, with manager: NetworkManager, completionHandler: @escaping (Station?) -> ()) {
        manager.getResource(from: string) { (data, error) in
            guard error == nil else { return }
            guard let data = data else { return }
            guard let station = try? JSONDecoder().decode(Station.self, from: data) else { return }
            completionHandler(station)
        }
    }
}
