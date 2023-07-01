//
//  String+.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/28.
//

import Foundation

extension String {
    /// Date String을 Date 타입으로 반환하는 메서드
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd"
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            print("toDate() convert error")
            return Date()
        }
    }
    
    /// : 사이에 여백을 추가하는 메서드 (hh:mm -> hh : mm)
    func addSpacingToColon() -> String {
        let hhmm = self.split(separator: ":")
        if hhmm.count == 2 {
            let hh = hhmm[0]
            let mm = hhmm[1]
            return "\(hh) : \(mm)"
        } else {
            return self
        }
    }
    
    /// 인코딩한 string을 반환하는 메서드
    func encodeURL() -> String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
