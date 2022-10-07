//
//  ClassProgressCVC.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/30.
//

import UIKit
import SnapKit
import Then
import CircleProgressView

class ClassProgressCVC: BaseCollectionViewCell {
    private let circleProgressView = CircleProgressView()
        .then {
            $0.trackFillColor = .main
            $0.trackBackgroundColor = .line_gray
            $0.trackWidth = 4
            $0.clockwise = true
            $0.backgroundColor = .clear
            $0.transform = $0.transform.rotated(by: .pi * 1.5)
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

extension ClassProgressCVC {
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
    
    func setClassProgress() {
        // TODO: response 모델 생성 후 수정
        let homeworkCnt = 5
        let students = 2
        let className = "중2단어&독해"
        let percent = Double(students) / Double(homeworkCnt)
        
        circleProgressView.progress = percent
        percentLabel.text = "\(Int(percent * 100))"
        classTitleLabel.text = "\(className)"
    }
}

// MARK: - Layout

extension ClassProgressCVC {
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
