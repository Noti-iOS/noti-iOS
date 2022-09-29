//
//  NaviType.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/28.
//

import UIKit

enum NaviType {
    case base
    case push
    case present
}

extension NaviType {
    var backBtnImage: UIImage? {
        switch self {
        case .base:
            return nil
        case .push:
            return UIImage(named: "pop") ?? UIImage()
        case .present:
            return UIImage(named: "dismiss") ?? UIImage()
        }
    }
}
