//
//  DayCVC.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/11/02.
//

import UIKit
import SnapKit
import Then

class DayCVC: BaseCollectionViewCell {
    private let selectedBackground = UIView()
        .then {
            $0.layer.cornerRadius = 13
        }
    
    private let dayLabel = UILabel()
        .then {
            $0.font = .notoSansKR_Medium(size: 16)
            $0.textColor = .black
            $0.textAlignment = .center
        }
    
    private let eventDot = UIImageView()
        .then {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 3
        }
    
    var date: Date?
    
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
        dayLabel.text = nil
        selectedBackground.backgroundColor = .white
        eventDot.backgroundColor = .white
        isUserInteractionEnabled = true
    }
    
    override var isSelected: Bool {
        willSet {
            selectedBackground.backgroundColor = newValue ? .main : .white
            dayLabel.textColor = newValue ? .white : .black
        }
    }
}

// MARK: - Configure

extension DayCVC {
    private func configureContentView() {
        contentView.addSubviews([selectedBackground,
                                 eventDot])
        selectedBackground.addSubview(dayLabel)
    }
    
    func configureCell(date: Date, homeworkCnt: Int) {
        self.date = date
        dayLabel.text = "\(date.get(.day))"
        
        switch homeworkCnt {
        case 0:
            eventDot.backgroundColor = .main
        case 1:
            eventDot.backgroundColor = .main
        default:
            eventDot.backgroundColor = .main
        }
    }
    
    func setOtherMonthDate() {
        dayLabel.text = nil
        eventDot.backgroundColor = nil
        isUserInteractionEnabled = false
    }
}

// MARK: - Layout

extension DayCVC {
    private func configureLayout() {
        selectedBackground.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(26)
        }
        
        dayLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-1)
        }
        
        eventDot.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.height.equalTo(6)
        }
    }
}
