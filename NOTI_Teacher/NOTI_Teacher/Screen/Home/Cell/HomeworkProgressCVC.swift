//
//  HomeworkProgressCVC.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/30.
//

import UIKit
import SnapKit
import Then
import CircleProgressView

class HomeworkProgressCVC: BaseCollectionViewCell {
    private let circleProgressView = CircleProgressView()
        .then {
            $0.trackFillColor = .main
            $0.trackBackgroundColor = .lineGray
            $0.trackWidth = 4
            $0.clockwise = true
            $0.backgroundColor = .clear
        }
    
    private let percentStackView = UIStackView()
        .then {
            $0.axis = .horizontal
            $0.spacing = 0
            $0.distribution = .fill
            $0.alignment = .center
        }
    
    private let percentLabel = UILabel()
        .then {
            $0.font = .notoSansKR_Medium(size: 12)
        }
    
    private let unitLabel = UILabel()
        .then {
            $0.text = "%"
            $0.font = .notoSansKR_Medium(size: 10)
            $0.textColor = .gray02
        }
    
    private let classTitleLabel = UILabel()
        .then {
            $0.font = .notoSansKR_Medium(size: 12)
            $0.textAlignment = .center
        }
    
    override func configureView() {
        super.configureView()
        configureContentView()
    }
    
    override func layoutView() {
        super.layoutView()
        configureLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        circleProgressView.progress = 0
        percentLabel.text = "-"
        classTitleLabel.text = "-"
    }
}

// MARK: - Configure

extension HomeworkProgressCVC {
    private func configureContentView() {
        addSubviews([circleProgressView,
                     percentStackView,
                     classTitleLabel])
        
        [percentLabel, unitLabel].forEach {
            percentStackView.addArrangedSubview($0)
        }
        
        layer.cornerRadius = 5
        backgroundColor = .white
    }
    
    func setClassProgress(_ lesson: Lesson) {
        let lessonName = lesson.lessonName
        
        circleProgressView.progress = Double(lesson.homeworkCompletionRate) / 100
        percentLabel.text = "\(lesson.homeworkCompletionRate)"
        classTitleLabel.text = "\(lessonName)"
    }
}

// MARK: - Layout

extension HomeworkProgressCVC {
    private func configureLayout() {
        circleProgressView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().offset(-14)
            $0.width.height.equalTo(66)
        }
        
        percentStackView.snp.makeConstraints {
            $0.center.equalTo(circleProgressView.snp.center)
        }
        
        classTitleLabel.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(circleProgressView.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
            $0.bottom.equalToSuperview().offset(-14)
        }
    }
}
