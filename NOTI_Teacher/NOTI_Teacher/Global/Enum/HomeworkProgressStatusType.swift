//
//  HomeworkProgressStatusType.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2023/06/30.
//

import UIKit

enum HomeworkProgressStatusType: String {
    case none = "NONE"
    case inProgress = "IN_PROGRESS"
    case completion = "COMPLETION"
}

extension HomeworkProgressStatusType {
    var image: UIImage? {
        switch self {
        case .none:
            return nil
        case .inProgress:
            return UIImage(named: "homework_inProgress")
        case .completion:
            return UIImage(named: "homework_completion")
        }
    }
    
    var backgroundColor: UIColor? {
        switch self {
        case .none:
            return nil
        case .inProgress:
            return .lightGreen30
        case .completion:
            return .main21
        }
    }
}
