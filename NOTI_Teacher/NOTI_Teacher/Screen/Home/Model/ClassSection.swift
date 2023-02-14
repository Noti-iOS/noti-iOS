//
//  ClassSection.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/10/08.
//

import UIKit

struct ClassSection {
    let className: String
    let startTime: String
    let endTime: String
    let homeworks: [String]
    var isOpened: Bool
    
    init(className: String, startTime: String, endTime: String, homeworks: [String], isOpened: Bool) {
        self.className = className
        self.startTime = startTime
        self.endTime = endTime
        self.homeworks = homeworks
        self.isOpened = isOpened
    }
}
