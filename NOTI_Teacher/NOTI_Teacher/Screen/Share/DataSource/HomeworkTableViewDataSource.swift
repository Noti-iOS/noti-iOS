//
//  HomeworkTableViewDataSource.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2023/03/03.
//

import UIKit

class HomeworkTableViewDataSource: NSObject, UITableViewDataSource {
    private var lessons: [Lesson]
    
    init(lessons: [Lesson]) {
        self.lessons = lessons
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return lessons.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = lessons[section]
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
            sectionCell.configureCell(lessons[indexPath.section])
            return sectionCell
        case totalRows - 1:
            return studentListTVC
        default:
            homeworkTVC.configureCell()
            return homeworkTVC
        }
    }
    
}
