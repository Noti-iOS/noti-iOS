//
//  HomeVM.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/10/08.
//

import Foundation
import RxCocoa
import RxSwift

final class HomeVM: BaseViewModel, LessonList {
    var apiSession: APIService = APISession()
    let apiError = PublishSubject<APIError>()
    var bag = DisposeBag()
    var input = Input()
    var output = Output()
    var lessons = [Lesson]()
    
    // MARK: - Input
    
    struct Input {}
    
    // MARK: - Output
    
    struct Output {
        var isLessonCreated = PublishRelay<Bool>()
        var presentClassIndex = PublishRelay<Int>()
        var headerMessage = PublishRelay<String?>()
    }
    
    // MARK: - Init
    
    init() {
        bindInput()
        bindOutput()
    }
    
    deinit {
        bag = DisposeBag()
    }
}

// MARK: - Custom Methods
extension HomeVM {
    func makeTimeTable() {
        var result:String?
        let now = Date.now.toString(separator: .time24)
        guard let nickname = UserDefaults.standard.string(forKey: UserDefaults.Keys.nickname) else { return }
        
        var idx = 0
        while idx < lessons.count {
            if now > lessons[idx].endTime
                && idx + 1 >= lessons.count {  // 수업 끝
                result = "\(nickname)T, 오늘 수고많았습니다."
                idx = lessons.count + 1
            } else { // 현재 인덱스의 수업 시간
                let time = lessons[idx].startTime.split(separator: ":")
                let hour = "\(time[0])시"
                let minute = time[1] == "00" ? "" : " \(time[1])분"

                result = idx == 0
                ? "\(nickname)T, 오늘의 첫 수업은 \(hour)\(minute)입니다."
                : "\(nickname)T, 다음 수업은 \(hour)\(minute)입니다."
                idx += 1
            }
        }
        output.presentClassIndex.accept(idx-1)
        output.headerMessage.accept(result)
    }
}

// MARK: - Input

extension HomeVM: Input {
    func bindInput() {}
}

// MARK: - Output

extension HomeVM: Output {
    func bindOutput() {}
}

// MARK: - Network

extension HomeVM {
    func getHomeData() {
        let path = "api/teacher/home"
        let resource = URLResource<HomeResponseModel>(path: path)
        
        apiSession.getRequest(with: resource)
            .withUnretained(self)
            .subscribe(onNext: {owner, result in
                switch result {
                case .success(let data):
                    owner.lessons = data.lessons
                    owner.makeTimeTable()
                    owner.output.isLessonCreated.accept(data.isLessonCreated)
                case .failure(let error):
                    owner.apiError.onNext(error)
                }
            })
            .disposed(by: bag)
    }
}
