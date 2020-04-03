//
//  Station.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/04/02.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct Station: Codable {
    let stationName: String
    var list: [DustInfo]
    
    enum codingkeys: String, CodingKey {
         case stationName
         case list = "list"
     }
}
