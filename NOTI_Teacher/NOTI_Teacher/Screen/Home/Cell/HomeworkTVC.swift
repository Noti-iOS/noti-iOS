//
//  HomeworkTVC.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/10/05.
//

import UIKit
import SnapKit
import Then

class HomeworkTVC: BaseTableViewCell {
    private var homeworkTitle = UILabel()
        .then {
            $0.font = .notoSansKR_Medium(size: 14)
        }
    
    private var progress = UIProgressView()
        .then {
            $0.progressTintColor = .main
            $0.trackTintColor = .lineGray
        }
    
    private var studentCount = UILabel()
        .then {
            $0.font = .notoSansKR_Medium(size: 12)
            $0.textColor = .gray01
            $0.textAlignment = .right
        }
    
    override func configureView() {
        super.configureView()
        configureContentView()
    }
    
    override func layoutView() {
        super.layoutView()
        configureLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
    }
}

// MARK: - Configure

extension HomeworkTVC {
    private func configureContentView() {
        selectionStyle = .none
        contentView.addSubviews([homeworkTitle,
                                 progress,
                                 studentCount])
        studentCount.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        homeworkTitle.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    func configureCell(_ homework: Homework) {
        let studentsCnt = homework.numberOfStudents
        let students = homework.numberOfCompletions
        let homework = homework.homeworkName
        let percent = Float(students) / Float(studentsCnt)
        
        homeworkTitle.text = homework
        progress.progress = percent
        studentCount.text = "\(students)/\(studentsCnt)"
    }
}

// MARK: - Layout

extension HomeworkTVC {
    private func configureLayout() {
        homeworkTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalTo(studentCount.snp.leading).offset(-10)
        }
        
        studentCount.snp.makeConstraints {
            $0.centerY.equalTo(homeworkTitle.snp.centerY)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        progress.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(2)
        }
    }
}
