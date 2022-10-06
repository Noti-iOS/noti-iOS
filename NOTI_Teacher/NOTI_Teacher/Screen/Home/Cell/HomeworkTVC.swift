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
            $0.trackTintColor = .line_gray
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
}

// MARK: - Configure

extension HomeworkTVC {
    private func configureContentView() {
        selectionStyle = .none
        addSubviews([homeworkTitle,
                     progress,
                     studentCount])
    }
    
    func configureCell() {
        // TODO: response 모델 생성 후 수정
        let studentsCnt = 5
        let students = 2
        let homework = "프린트물로 준 단어장 100개 암기 > 시험있ㅇㅇㅇㅇㅇㅇ"
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
            $0.trailing.greaterThanOrEqualTo(studentCount.snp.leading).offset(-10)
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
