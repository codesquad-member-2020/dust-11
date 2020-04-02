//
//  DustInfoDecoder.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/04/02.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation



struct DustInfoDecoder {
    static func decode(from: String, with manager: NetworkManager, completionHandler: @escaping (Station?) -> ()) {
        manager.getResource(from: from) { (data, error) in
            guard error == nil else { return }
            guard let data = data else { return }
            guard let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return }
            print(prettyPrintedString)
            do {
               let station = try JSONDecoder().decode(Station.self, from: data)
//                completionHandler(station)
                print(station)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
