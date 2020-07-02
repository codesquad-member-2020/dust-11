//
//  DateFormatterExtension.swift
//  DustNoticeApp
//
//  Created by kimdo2297 on 2020/04/03.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let dustDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter
}()
    
    static let broadcastDateFormatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter
    }()
}
