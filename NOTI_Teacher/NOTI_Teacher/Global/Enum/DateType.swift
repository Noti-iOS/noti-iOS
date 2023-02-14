//
//  DateType.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/30.
//

import Foundation

enum DateType {
    case hyphen
    case dot
    case dayOnly
    case yearMonth
    case time12
    case time24
}

extension DateType {
    var dateFormatter: String {
        switch self {
        case .hyphen:
            return "yyyy-MM-dd"
        case .dot:
            return "yyyy. MM. dd"
        case .dayOnly:
            return "EEEE"
        case .yearMonth:
            return "yyyy년 MM월"
        case .time12:
            return "h:m"
        case .time24:
            return "HH:mm"
        }
    }
}
