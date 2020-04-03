//
//  DustInfoDecoder.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/04/02.
//  Copyright © 2020 Jason. All rights reserved.
//
import UIKit
import Foundation

struct DustInfoDecoder {
    static func decodeStation(from string: String, with manager: NetworkManager, completionHandler: @escaping (Station?) -> ()) {
        manager.getResource(from: string) { (data, error) in
            guard error == nil else { return }
            guard let data = data else { return }
            guard let station = try? JSONDecoder().decode(Station.self, from: data) else { return }
            completionHandler(station)
        }
    }
    
    static func decodeBroadcast(from string: String, with manager: NetworkManager, completionHandler: @escaping (Broadcast?) -> ()) {
        manager.getResource(from: string) { (data, error) in
            guard error == nil else { return }
            guard let data = data else { return }
            print(String(bytes: data, encoding: .utf8))
            guard let boradcast = try? JSONDecoder().decode(Broadcast.self, from: data) else { return }
            completionHandler(boradcast)
        }
    }
}
