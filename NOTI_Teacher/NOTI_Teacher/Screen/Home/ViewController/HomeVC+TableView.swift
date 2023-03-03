//
//  HomeVC+TableView.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/10/09.
//

import UIKit

// MARK: - UITableViewDelegate

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
        
        switch indexPath.row {
        case 0:
            return 46
        case totalRows - 1:
            return 93
        default:
            return 52
        }
    }
}
