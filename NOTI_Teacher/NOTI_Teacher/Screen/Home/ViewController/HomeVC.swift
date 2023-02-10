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
            layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            layout.minimumLineSpacing = 10
            layout.scrollDirection = .horizontal
            
            $0.collectionViewLayout = layout
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .clear
        }
    
    private let homeworkTV = UITableView(frame: .zero,
                                         style: .grouped)
        .then {
            $0.isScrollEnabled = false
            $0.separatorStyle = .none
            $0.backgroundColor = .systemBackground
        }
    
    let viewModel = HomeVM()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getHomeData()
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
        bindNaviBarRightBtn()
        bindHomeworkTV()
    }
    
    override func bindOutput() {
        super.bindOutput()
        bindErrorAlert()
        bindHomeData()
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
        homeworkTV.register(ClassTVC.self, forCellReuseIdentifier: ClassTVC.className)
        homeworkTV.register(HomeworkTVC.self, forCellReuseIdentifier: HomeworkTVC.className)
        homeworkTV.register(StudentTVC.self, forCellReuseIdentifier: StudentTVC.className)
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
            $0.top.equalToSuperview().offset(18)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        homeworkTV.snp.makeConstraints {
            $0.top.equalTo(classProgressCV.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-30)
            $0.height.equalTo(0)
        }
    }
}

// MARK: - Input

extension HomeVC {
    func bindNaviBarRightBtn() {
        naviBar.rightBtn.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                let notificationListVC = NotificationListVC()
                notificationListVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(notificationListVC,
                                                              animated: true)
                
            })
            .disposed(by: bag)
    }
    
    func bindHomeworkTV() {
        homeworkTV.rx.itemSelected
            .asDriver()
            .drive(onNext: {[weak self] indexPath in
                guard let self = self else { return }
                self.viewModel.output.classes[indexPath.section].isOpened.toggle()
                self.homeworkTV.reloadSections([indexPath.section], with: .none)
                self.setHomeworkTVHeight()
            })
            .disposed(by: bag)
    }
}

// MARK: - Output

extension HomeVC {
    private func bindErrorAlert() {
        viewModel.apiError
            .subscribe(onNext: {[weak self] error in
                guard let self = self else { return }
                self.showErrorAlert(error.message)
            })
            .disposed(by: bag)
    }
    
    func bindHomeData() {
        viewModel.output.isLessonCreated
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] isNone in
                guard let self = self else { return }
            })
            .disposed(by: bag)
    }
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
