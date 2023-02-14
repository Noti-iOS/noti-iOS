//
//  ClassTVC.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/10/08.
//

import UIKit
import SnapKit
import Then

class ClassTVC: BaseTableViewCell {
    private let classTitle = UILabel()
        .then {
            $0.font = .notoSansKR_Bold(size: 14)
            $0.textColor = .main
        }
    
    private let time = UILabel()
        .then {
            $0.font = .notoSansKR_Medium(size: 12)
            $0.textColor = .main
        }
    
    private let openStatusImageView = UIImageView()
    
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

extension ClassTVC {
    private func configureContentView() {
        selectionStyle = .none
        contentView.layer.cornerRadius = 6
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.main.cgColor
        contentView.backgroundColor = .main21
        contentView.addSubviews([classTitle,
                                 time,
                                 openStatusImageView])
        classTitle.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    func configureCell(_ classSection: ClassSection) {
        classTitle.text = classSection.className
        time.text = classSection.startTime
        openStatusImageView.image = classSection.isOpened
        ? UIImage(named: "arrow_down")
        : UIImage(named: "arrow_up")
    }
}

// MARK: - Layout

extension ClassTVC {
    private func configureLayout() {
        classTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.centerY.equalToSuperview()
        }
        
        time.snp.makeConstraints {
            $0.leading.equalTo(classTitle.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
        }
        
        openStatusImageView.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(time.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().offset(-6)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(26)
        }
    }
}
