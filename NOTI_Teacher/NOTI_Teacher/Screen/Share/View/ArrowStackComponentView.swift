//
//  ArrowStackComponentView.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/11/21.
//

import UIKit
import SnapKit
import Then

class ArrowStackComponentView: BaseView {
    private var baseStackView = UIStackView()
        .then {
            $0.axis = .vertical
            $0.spacing = 4
        }
    
    private var viewTitle = UILabel()
        .then {
            $0.font = .notoSansKR_Bold(size: 14)
            $0.textColor = .black
        }
    
    private var viewMessage = UILabel()
        .then {
            $0.font = .notoSansKR_Light(size: 12)
            $0.textColor = .gray02
        }
    
    private var arrowImageView = UIImageView()
        .then {
            $0.image = .arrowRight
        }
    
    override func configureView() {
        super.configureView()
        addViews()
    }
    
    override func layoutView() {
        super.layoutView()
        configureLayout()
    }
    
}

// MARK: - Configure

extension ArrowStackComponentView {
    private func addViews() {
        addSubviews([baseStackView,
                     arrowImageView])
        [viewTitle, viewMessage].forEach {
            baseStackView.addArrangedSubview($0)
        }
    }
    
    func configureContentView(title: String, message: String = "") {
        viewTitle.text = title
        viewMessage.text = message
    }
    
    func configureMessage(_ message: String) {
        viewMessage.text = message
    }
}

// MARK: - Layout

extension ArrowStackComponentView {
    private func configureLayout() {
        baseStackView.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints {
            $0.leading.equalTo(baseStackView.snp.trailing).offset(8)
            $0.centerY.trailing.equalToSuperview()
            $0.width.height.equalTo(38)
        }
    }
}
