//
//  HomeVC+TableView.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/10/09.
//

import UIKit

// MARK: - UITableViewDataSource

extension HomeVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.output.classes.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = viewModel.output.classes[section]
        
        return section.isOpened
        ? section.homeworks.count + 1 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionCell = tableView.dequeueReusableCell(withIdentifier: ClassTVC.className) as? ClassTVC,
              let homeworkTVC = tableView.dequeueReusableCell(withIdentifier: HomeworkTVC.className) as? HomeworkTVC,
              let studentListTVC = tableView.dequeueReusableCell(withIdentifier: StudentTVC.className) as? StudentTVC
        else { fatalError() }
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
        
        switch indexPath.row {
        case 0:
            sectionCell.configureCell(viewModel.output.classes[indexPath.section])
            return sectionCell
        case totalRows - 1:
            return studentListTVC
        default:
            homeworkTVC.configureCell()
            return homeworkTVC
        }
    }
}

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
