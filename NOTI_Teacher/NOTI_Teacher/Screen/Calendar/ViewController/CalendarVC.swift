//
//  CalendarVC.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/10/26.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxGesture
import RxSwift

class CalendarVC: BaseViewController {
    private let naviBar = NavigationBar()
    
    private let calendarHeaderView = CalendarHeaderView()
        .then {
            $0.backgroundColor = .systemBackground
        }
    
    private lazy var calendarCV = UICollectionView(frame: .zero,
                                              collectionViewLayout: UICollectionViewLayout())
        .then {
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 14
            layout.minimumInteritemSpacing = 14
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 19, right: 0)
            
            $0.collectionViewLayout = layout
            $0.showsHorizontalScrollIndicator = false
            $0.isPagingEnabled = true
            $0.backgroundColor = .clear
        }
    
    private let homeworkTV = UIView()
        .then {
            $0.backgroundColor = .blue
        }

    private let viewModel = CalendarVM()
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        configureNaviBar()
        configureContentView()
    }
    
    override func layoutView() {
        super.layoutView()
        configureLayout()
    }
    
    override func bindInput() {
        super.bindInput()
        bindBtn()
        bindDateLabel()
    }
    
    override func bindOutput() {
        super.bindOutput()
        bindMoveMonth()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setCalendarHeight()
    }
}

// MARK: - Configure

extension CalendarVC {
    private func configureNaviBar() {
        naviBar.configureNaviBar(targetVC: self)
        naviBar.configureRightBarBtn(image: .search)
    }
    
    private func configureContentView() {
        view.addSubviews([calendarHeaderView,
                          calendarCV,
                          homeworkTV])
        
        viewModel.getDays()
        
        calendarCV.register(WeekCVC.self, forCellWithReuseIdentifier: WeekCVC.className)
        calendarCV.register(DayCVC.self, forCellWithReuseIdentifier: DayCVC.className)
        calendarCV.dataSource = self
        calendarCV.delegate = self
        
    }
    
    private func setCalendarHeight() {
        let height = calendarCV.collectionViewLayout.collectionViewContentSize.height
        
        calendarCV.snp.updateConstraints {
            $0.height.equalTo(height)
        }
        
        view.layoutIfNeeded()
    }
}

// MARK: - Layout

extension CalendarVC {
    private func configureLayout() {
        calendarHeaderView.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(49)
        }
        
        calendarCV.snp.makeConstraints {
            $0.top.equalTo(calendarHeaderView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(0)
        }
        
        homeworkTV.snp.makeConstraints {
            $0.top.equalTo(calendarCV.snp.bottom).offset(21)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-70)
        }
    }
}

// MARK: - Input

extension CalendarVC {
    private func bindBtn() {
        calendarHeaderView.prevMonthBtn.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.input.moveMonth.accept(-1)
            })
            .disposed(by: bag)
        
        calendarHeaderView.nextMonthBtn.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.input.moveMonth.accept(1)
            })
            .disposed(by: bag)
    }
}

// MARK: - Output

extension CalendarVC {
    private func bindMoveMonth() {
        viewModel.input.moveMonth
            .asDriver(onErrorJustReturn: 0)
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.calendarCV.reloadData()
            })
            .disposed(by: bag)
    }
    
    private func bindDateLabel() {
        viewModel.input.moveMonth
            .asDriver(onErrorJustReturn: 0)
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.calendarHeaderView.dateLabel.text = self.viewModel.input.selectedDay.value.toString(separator: .yearMonth)
            })
            .disposed(by: bag)
    }
}

// MARK: - UICollectionViewDataSource

extension CalendarVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 7
        default:
            return viewModel.days.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let weekCell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekCVC.className, for: indexPath) as? WeekCVC,
              let dayCell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCVC.className, for: indexPath) as? DayCVC
        else { fatalError() }
        
        switch indexPath.section {
        case 0:
            weekCell.configureCell(viewModel.weekTitle[indexPath.row])
            return weekCell
        default:
            let day = viewModel.days[indexPath.row]
            dayCell.configureCell(date: day,
                                  homeworkCnt: 1)
            
            // 이전달, 다음달 일자 색상 변경
            if day.get(.month) != viewModel.input.selectedDay.value.get(.month) {
                dayCell.setOtherMonthDate()
            }
            
            return dayCell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CalendarVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (screenWidth - 40) / 7 - 14
        
        switch indexPath.section {
        case 0:
            return CGSize(width: width, height: 23)
        default:
            return CGSize(width: width, height: 34)
        }
    }
}
