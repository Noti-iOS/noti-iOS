//
//  HomeworkTableViewHeaderView.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2023/03/04.
//

import UIKit
import SnapKit
import Then

class HomeworkTableViewHeaderView: UITableViewHeaderFooterView {
    let classProgressCV = UICollectionView(frame: .zero,
                                           collectionViewLayout: UICollectionViewLayout())
        .then {
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            layout.minimumLineSpacing = 10
            layout.scrollDirection = .horizontal
            
            $0.collectionViewLayout = layout
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .clear
        }
    
    var lessons: [Lesson]?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureClassProgressCV()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure

extension HomeworkTableViewHeaderView {
    private func configureClassProgressCV() {
        addSubview(classProgressCV)
        classProgressCV.register(HomeworkProgressCVC.self, forCellWithReuseIdentifier: HomeworkProgressCVC.className)
        classProgressCV.dataSource = self
        classProgressCV.delegate = self
    }
}

// MARK: - Layout

extension HomeworkTableViewHeaderView {
    private func configureLayout() {
        classProgressCV.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension HomeworkTableViewHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        lessons?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let lessons = lessons,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeworkProgressCVC.className,
                                                            for: indexPath) as? HomeworkProgressCVC
        else { return UICollectionViewCell() }
        cell.setClassProgress(lessons[indexPath.row])
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.strokeGreen.cgColor
        return cell
    }
}

// MARK: - UICollectionViewFlowLayout

extension HomeworkTableViewHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 94, height: 118)
    }
}
