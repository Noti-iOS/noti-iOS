//
//  ClassSection.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/10/08.
//

import UIKit

struct ClassSection {
    let className: String
    let time: String
    let homeworks: [String]
    var isOpened: Bool
    
    init(className: String, time: String, homeworks: [String], isOpened: Bool) {
        self.className = className
        self.time = time
        self.homeworks = homeworks
        self.isOpened = isOpened
    }
}
