//
//  HomeworkTableViewDataSource.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2023/03/03.
//

import UIKit

protocol LessonList {
    var lessons: [Lesson] { get set }
}

class HomeworkTableViewDataSource: NSObject, UITableViewDataSource {
    var viewModel: LessonList
    
    init(viewModel: LessonList) {
        self.viewModel = viewModel
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.lessons.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = viewModel.lessons[section]
        return section.isOpened ?? false
        ? section.homeworks.count + 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionCell = tableView.dequeueReusableCell(withIdentifier: LessonTVC.className) as? LessonTVC,
              let homeworkTVC = tableView.dequeueReusableCell(withIdentifier: HomeworkTVC.className) as? HomeworkTVC,
              let studentListTVC = tableView.dequeueReusableCell(withIdentifier: StudentTVC.className) as? StudentTVC
        else { fatalError() }
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
        
        switch indexPath.row {
        case 0:
            sectionCell.configureCell(viewModel.lessons[indexPath.section])
            return sectionCell
        case totalRows - 1:
            studentListTVC.students = viewModel.lessons[indexPath.section].students
            return studentListTVC
        default:
            homeworkTVC.configureCell(viewModel.lessons[indexPath.section].homeworks[indexPath.row - 1])
            return homeworkTVC
        }
    }
    
}
