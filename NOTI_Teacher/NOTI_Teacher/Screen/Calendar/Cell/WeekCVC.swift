//
//  WeekCVC.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/11/02.
//

import UIKit
import SnapKit
import Then

class WeekCVC: BaseCollectionViewCell {
    private let weekLabel = UILabel()
        .then {
            $0.font = .notoSansKR_Medium(size: 16)
            $0.textColor = .gray02
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

extension WeekCVC {
    private func configureContentView() {
        contentView.addSubview(weekLabel)
    }
    
    func configureCell(_ day: String) {
        weekLabel.text = day
    }
}

// MARK: - Layout

extension WeekCVC {
    private func configureLayout() {
        weekLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
