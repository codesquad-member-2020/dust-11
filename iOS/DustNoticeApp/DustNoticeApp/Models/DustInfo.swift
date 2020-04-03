//
//  DustInfo.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/03/31.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct DustInfo: Codable {
    var dataTime: String
    var pm10Grade1h: String
    var pm10Value: String
    
    enum CodingKeys: String, CodingKey {
        case dataTime = "dataTime"
        case pm10Grade1h = "pm10Grade1h"
        case pm10Value = "pm10Value"
    }
}
