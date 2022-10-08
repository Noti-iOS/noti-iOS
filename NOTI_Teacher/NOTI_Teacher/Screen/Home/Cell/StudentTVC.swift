//
//  StudentTVC.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/10/08.
//

import UIKit
import SnapKit
import Then

class StudentTVC: BaseTableViewCell {
    private let studentListCV = UICollectionView(frame: .zero,
                                                 collectionViewLayout: UICollectionViewLayout())
        .then {
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 0, left: 34, bottom: 0, right: 34)
            layout.minimumLineSpacing = 16
            layout.scrollDirection = .horizontal
            
            $0.collectionViewLayout = layout
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .clear
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

extension StudentTVC {
    private func configureContentView() {
        selectionStyle = .none
        contentView.addSubview(studentListCV)
        
        studentListCV.register(StudentCVC.self, forCellWithReuseIdentifier: StudentCVC.className)
        studentListCV.dataSource = self
        studentListCV.delegate = self
    }
}

// MARK: - Layout

extension StudentTVC {
    private func configureLayout() {
        studentListCV.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension StudentTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StudentCVC.className, for: indexPath) as? StudentCVC else { fatalError() }
        // TODO: - 데이터 연결
        cell.configureCell()
        return cell
    }
}

// MARK: - UICollectionViewFlowLayout

extension StudentTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 48, height: 73)
    }
}
