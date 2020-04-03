//
//  NetworkManager.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/04/02.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct NetworkManager {
    enum EndPoints {
        static let dustURL = "http://52.7.82.194:8080/api/dust/"
        static let broadcastURL = "http://52.7.82.194:8080/api/dust/pm10/"
    }
    
    func getResource(from string: String, resultHandler: @escaping (Data?, Error?)->()) {
        guard let url = URL(string: string) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            resultHandler(data, error)
        }.resume()
    }
}
