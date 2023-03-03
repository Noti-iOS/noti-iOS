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
    
    private let noLessonView = HomeNoLessonView()
    
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
    
    var homeworkTableViewDataSource: HomeworkTableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getHomeData()
    }
    
    override func configureView() {
        super.configureView()
        addHeaderView()
        configureNaviBar()
    }
    
    override func layoutView() {
        super.layoutView()
        configureHeaderLayout()
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
    private func configureNaviBar() {
        naviBar.configureNaviBar(targetVC: self)
        naviBar.configureRightBarBtn(image: UIImage(named: "alarm")!)
    }
    
    private func addHeaderView() {
        view.addSubview(headerView)
    }
    
    private func configureNoLessonView(_ isJustToday: Bool) {
        view.addSubview(noLessonView)
        noLessonView.configureContentView(title: isJustToday ? "오늘은 수업이 없어요" : "아직 수업이 없어요",
                                          message: "수업을 등록하고 학생들의 숙제 현황을 파악하세요.",
                                          addBtnTitle: "수업 등록하기")
        
        configureNoLessonViewLayout()
    }
    
    private func configureLessonListView() {
        view.addSubviews([headerView,
                          baseScrollView])
        baseScrollView.addSubview(contentView)
        contentView.addSubviews([classProgressCV,
                                 homeworkTV])
        
        configureClassProgressCV()
        configureHomeworkTV()
        configureLessonListLayout()
    }
    
    private func configureClassProgressCV() {
        classProgressCV.register(HomeworkProgressCVC.self, forCellWithReuseIdentifier: HomeworkProgressCVC.className)
        classProgressCV.dataSource = self
        classProgressCV.delegate = self
    }
    
    private func configureHomeworkTV() {
        homeworkTV.register(LessonTVC.self, forCellReuseIdentifier: LessonTVC.className)
        homeworkTV.register(HomeworkTVC.self, forCellReuseIdentifier: HomeworkTVC.className)
        homeworkTV.register(StudentTVC.self, forCellReuseIdentifier: StudentTVC.className)
        
        homeworkTableViewDataSource = HomeworkTableViewDataSource(lessons: viewModel.output.lessons)
        homeworkTV.dataSource = homeworkTableViewDataSource
        
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
    private func configureHeaderLayout() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(184)
        }
    }
    
    private func configureNoLessonViewLayout() {
        noLessonView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(Double(screenHeight - headerView.frame.height) / 3.2)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func configureLessonListLayout() {
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
                self.viewModel.output.lessons[indexPath.section].isOpened?.toggle()
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
        // header message
        viewModel.output.headerMessage
            .asDriver(onErrorJustReturn: nil)
            .drive(onNext: {[weak self] message in
                guard let self = self else { return }
                self.headerView.setHeaderValue(firstClassTime: message)
            })
            .disposed(by: bag)
        
        // 숙제 목록 열려있는 부분 바인딩
        viewModel.output.presentClassIndex
            .asDriver(onErrorJustReturn: -1)
            .drive(onNext: {[weak self] index in
                guard let self = self else { return }
                if index >= self.viewModel.output.lessons.count || index < 0 { return }
                for i in 0..<self.viewModel.output.lessons.count {
                    self.viewModel.output.lessons[i].isOpened = false
                }
                self.viewModel.output.lessons[index].isOpened = true
                
                self.homeworkTV.reloadData()
            })
            .disposed(by: bag)
        
        // 분반 존재 여부에 따른 화면 구성
        viewModel.output.isLessonCreated
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] isLessonCreated in
                guard let self = self else { return }
                if !isLessonCreated || self.viewModel.output.lessons.count == 0 {
                    self.configureNoLessonView(isLessonCreated)
                } else {
                    self.configureLessonListView()
                }
            })
            .disposed(by: bag)
        
    }
}
