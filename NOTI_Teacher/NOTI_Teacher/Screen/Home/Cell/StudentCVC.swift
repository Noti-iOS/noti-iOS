//
//  StudentCVC.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/10/08.
//

import UIKit
import SnapKit
import Then
import Kingfisher

/// 홈화면 과목별 학생의 숙제 완료 상태를 나타내는 CollectionViewCell
class StudentCVC: BaseCollectionViewCell {
    private let markerLabel = UILabel()
        .then {
            $0.text = "*"
            $0.font = .notoSansKR_Medium(size: 15)
            $0.textColor = .red
            $0.isHidden = true
        }
    
    private let checkLayerImageView = UIImageView()
        .then {
            $0.layer.cornerRadius = 24
            $0.backgroundColor = UIColor.main21
            $0.contentMode = .scaleAspectFit
        }
    
    private let profileImageView = UIImageView()
        .then {
            $0.layer.cornerRadius = 24
            $0.image = .defaultProfileImage
            $0.clipsToBounds = true
        }
    
    private let studentNameLabel = UILabel()
        .then {
            $0.textAlignment = .center
            $0.font = .notoSansKR_Medium(size: 12)
            $0.setLineBreakMode()
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
        markerLabel.isHidden = true
        checkLayerImageView.image = nil
        checkLayerImageView.backgroundColor = nil
        profileImageView.image = .defaultProfileImage
        studentNameLabel.text = nil
    }
}

// MARK: - Configure

extension StudentCVC {
    private func configureContentView() {
        addSubviews([profileImageView,
                     markerLabel,
                     studentNameLabel])
        profileImageView.addSubview(checkLayerImageView)
    }
    
    func configureCell(_ student: Student) {
        profileImageView.kf.setImage(with: student.profileImageURL)
        markerLabel.isHidden = !student.focusStatus
        studentNameLabel.text = student.studentNickname
        checkLayerImageView.image = HomeworkProgressStatusType(rawValue: student.homeworkProgressStatus)?.image
        checkLayerImageView.backgroundColor = HomeworkProgressStatusType(rawValue: student.homeworkProgressStatus)?.backgroundColor
    }
}

// MARK: - Layout

extension StudentCVC {
    private func configureLayout() {
        markerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.leading.equalToSuperview().offset(6)
        }
        
        checkLayerImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.leading.trailing.equalToSuperview()
            $0.width.height.equalTo(48)
        }
        
        studentNameLabel.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(profileImageView.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
