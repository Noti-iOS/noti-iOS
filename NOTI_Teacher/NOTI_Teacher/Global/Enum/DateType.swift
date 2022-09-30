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
        }
    }
}
