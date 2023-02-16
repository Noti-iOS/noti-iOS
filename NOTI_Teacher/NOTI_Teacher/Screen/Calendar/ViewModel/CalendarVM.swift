//
//  CalendarVM.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/11/09.
//

import Foundation
import RxSwift
import RxCocoa

final class CalendarVM: BaseViewModel{
    var apiSession: APIService = APISession()
    let apiError = PublishSubject<APIError>()
    var bag = DisposeBag()
    var input = Input()
    var output = Output()
    
    // Calendar
    private let cal = Calendar.current
    private var components = DateComponents()
    let weekTitle = ["월", "화", "수", "목", "금", "토", "일"]
    var days = [Date]()
    var weekDays = [Date]()
    var eventDays = [String]()
    
    // MARK: - Input
    
    struct Input {
        var selectedDay = BehaviorRelay<Date>(value: Date.now)
        var moveMonth = PublishRelay<Int>()
    }
    
    // MARK: - Output
    
    struct Output {
        var loading = BehaviorRelay<Bool>(value: false)
    }
    
    // MARK: - Init
    
    init() {
        configureDateComponents()
        bindInput()
        bindOutput()
    }
    
    deinit {
        bag = DisposeBag()
    }
    
}

// MARK: - Custom Methods

extension CalendarVM {
    private func configureDateComponents() {
        components.year = cal.component(.year, from: .now)
        components.month = cal.component(.month, from: .now)
        components.day = 1
    }
    
    func getDays() {
        guard let firstDayOfMonth = firstDayOfMonth(),
              let lastWeekOfMonth = lastWeekOfMonth() else { return }
        
        days.removeAll()
        for i in 0..<lastWeekOfMonth * 7 {
            days.append(cal.date(byAdding: .day,
                                 value: i - firstDayOfMonth.getWeekDay(),
                                 to: firstDayOfMonth)!)
        }
    }
    
    func firstDayOfMonth() -> Date? {
        guard let interval = cal.dateInterval(of: .month, for: input.selectedDay.value) else { return nil }
        return interval.start
    }
    
    func lastWeekOfMonth() -> Int? {
        guard let interval = cal.dateInterval(of: .month, for: input.selectedDay.value) else { return nil }
        let lastDayOfMonth = interval.end - 1
        
        return lastDayOfMonth.get(.weekday) == 1
        ? lastDayOfMonth.get(.weekOfMonth) - 1
        : lastDayOfMonth.get(.weekOfMonth)
    }
}

// MARK: - Input

extension CalendarVM: Input {
    func bindInput() {
        input.moveMonth
            .subscribe(onNext: { [weak self] value in
                guard let self = self,
                      let selectedDate = self.cal.date(byAdding: .month,
                                                       value: value,
                                                       to: self.input.selectedDay.value)
                else { return }
                self.input.selectedDay.accept(selectedDate)
                self.getDays()
            })
            .disposed(by: bag)
    }
}

// MARK: - Output

extension CalendarVM: Output {
    func bindOutput() {}
}

// MARK: - Networking

extension CalendarVM {}
