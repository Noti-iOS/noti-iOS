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
    
    private let homeworkTV = UITableView(frame: .zero,
                                         style: .grouped)
        .then {
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
    }
    
    override func bindOutput() {
        super.bindOutput()
        bindErrorAlert()
        bindHomeData()
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
        view.addSubview(homeworkTV)
        configureHomeworkTV()
        configureLessonListLayout()
    }
    
    private func configureHomeworkTV() {
        homeworkTV.register(HomeworkTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: HomeworkTableViewHeaderView.className)
        
        homeworkTV.register(LessonTVC.self, forCellReuseIdentifier: LessonTVC.className)
        homeworkTV.register(HomeworkTVC.self, forCellReuseIdentifier: HomeworkTVC.className)
        homeworkTV.register(StudentTVC.self, forCellReuseIdentifier: StudentTVC.className)
        
        homeworkTableViewDataSource = HomeworkTableViewDataSource(viewModel: viewModel)
        homeworkTV.dataSource = homeworkTableViewDataSource
        
        homeworkTV.delegate = self
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
        homeworkTV.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
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
                if index >= self.viewModel.lessons.count || index < 0 { return }
                for i in 0..<self.viewModel.lessons.count {
                    self.viewModel.lessons[i].isOpened = false
                }
                self.viewModel.lessons[index].isOpened = true
                
                self.homeworkTV.reloadData()
            })
            .disposed(by: bag)
        
        // 분반 존재 여부에 따른 화면 구성
        viewModel.output.isLessonCreated
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] isLessonCreated in
                guard let self = self else { return }
                if !isLessonCreated || self.viewModel.lessons.count == 0 {
                    self.configureNoLessonView(isLessonCreated)
                } else {
                    self.configureLessonListView()
                }
            })
            .disposed(by: bag)
        
    }
}

// MARK: - UITableViewDelegate

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
        
        switch indexPath.row {
        case 0:
            return 46
        case totalRows - 1:
            return 93
        default:
            return 52
        }
    }
    
    // tableView HeaderView - 분반별 진도율 CollectionView
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 176 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let lessons = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeworkTableViewHeaderView.className) as? HomeworkTableViewHeaderView
        else { fatalError() }
        
        lessons.lessons = viewModel.lessons
        
        return lessons
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            viewModel.lessons[indexPath.section].isOpened?.toggle()
            homeworkTV.reloadSections([indexPath.section], with: .none)
        } else {
            // TODO: - 숙제 화면 연결
        }
    }
}
