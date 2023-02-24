//
//  HomeVC+CollectionView.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2023/02/24.
//

import UIKit

// MARK: - UICollectionViewDataSource

extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeworkProgressCVC.className,
                                                            for: indexPath) as? HomeworkProgressCVC
        else { fatalError() }
        cell.setClassProgress()
        cell.addShadow()
        return cell
    }
}

// MARK: - UICollectionViewFlowLayout

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 94, height: 118)
    }
}
