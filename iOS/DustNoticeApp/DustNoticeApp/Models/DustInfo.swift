//
//  DustInfo.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/03/31.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

struct DustInfo: Codable {
    let dustValue: Double
    let dustGrade: UInt
    let measureDate: Date
    
    enum codingkeys: String, CodingKey {
        case dustValue = "pm10Value"
        case dustGrade = "pm10Grade"
        case measureDate = "dataTime"
    }
}
