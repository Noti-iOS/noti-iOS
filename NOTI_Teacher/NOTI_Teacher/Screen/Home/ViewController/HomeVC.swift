//
//  HomeVC.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/28.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxGesture
import RxSwift

class HomeVC: BaseViewController {
    private let naviBar = NavigationBar()
    
    private let headerView = HomeHeaderView()
        .then {
            $0.backgroundColor = .main
        }
    
    private let baseScrollView = UIScrollView()
        .then {
            $0.showsVerticalScrollIndicator = false
        }
    
    private let contentView = UIView()
    
    private let classProgressCV = UICollectionView(frame: .zero,
                                                   collectionViewLayout: UICollectionViewLayout())
        .then {
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.scrollDirection = .horizontal
            
            $0.collectionViewLayout = layout
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .clear
        }
    
    private let homeworkTV = UITableView()
        .then {
            $0.isScrollEnabled = false
        }
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        configureContentView()
        configureNaviBar()
        configureClassProgressCV()
        configureHomeworkTV()
    }
    
    override func layoutView() {
        super.layoutView()
        configureLayout()
    }
    
    override func bindInput() {
        super.bindInput()
    }
    
    override func bindOutput() {
        super.bindOutput()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setHomeworkTVHeight()
    }
    
}

// MARK: - Configure

extension HomeVC {
    private func configureContentView() {
        view.addSubviews([headerView,
                          baseScrollView])
        baseScrollView.addSubview(contentView)
        contentView.addSubviews([classProgressCV,
                                 homeworkTV])
    }
    
    private func configureNaviBar() {
        naviBar.configureNaviBar(targetVC: self)
        naviBar.configureRightBarBtn(image: UIImage(named: "alarm")!)
    }
    
    private func configureClassProgressCV() {
        classProgressCV.register(ClassProgressCVC.self, forCellWithReuseIdentifier: ClassProgressCVC.className)
        classProgressCV.dataSource = self
        classProgressCV.delegate = self
    }
    
    private func configureHomeworkTV() {
        homeworkTV.register(HomeworkTVC.self, forCellReuseIdentifier: HomeworkTVC.className)
        homeworkTV.dataSource = self
        homeworkTV.delegate = self
    }
    
    private func setHomeworkTVHeight() {
        let height = homeworkTV.contentSize.height
        
        homeworkTV.snp.updateConstraints {
            $0.height.equalTo(height)
        }
        
        view.layoutIfNeeded()
    }
}

// MARK: - Layout

extension HomeVC {
    private func configureLayout() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(184)
        }
        
        baseScrollView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        classProgressCV.snp.makeConstraints {
            $0.top.equalToSuperview().offset(34)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(74)
        }
        
        homeworkTV.snp.makeConstraints {
            $0.top.equalTo(classProgressCV.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-70)
            $0.height.equalTo(0)
        }
    }
}

// MARK: - Input

extension HomeVC {
    
}

// MARK: - Output

extension HomeVC {
    
}

// MARK: - UICollectionViewDataSource

extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassProgressCVC.className,
                                                            for: indexPath) as? ClassProgressCVC
        else { fatalError() }
        cell.setClassProgress()
        return cell
    }
}

// MARK: - UICollectionViewFlowLayout

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 78, height: 74)
    }
}

// MARK: - UITableViewDataSource

extension HomeVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        <#code#>
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeworkTVC.className, for: indexPath) as? HomeworkTVC else { fatalError() }
        cell.configureCell()
        
        return cell
    }
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        52
    }
}
