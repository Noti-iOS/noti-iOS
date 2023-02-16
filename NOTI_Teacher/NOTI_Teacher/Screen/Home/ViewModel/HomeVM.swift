//
//  HomeVM.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/10/08.
//

import Foundation
import RxCocoa
import RxSwift

final class HomeVM: BaseViewModel {
    var apiSession: APIService = APISession()
    let apiError = PublishSubject<APIError>()
    var bag = DisposeBag()
    var input = Input()
    var output = Output()
    
    // MARK: - Input
    
    struct Input {}
    
    // MARK: - Output
    
    struct Output {
        var classes = [ClassSection]()
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
                    dump(data)
                case .failure(let error):
                    owner.apiError.onNext(error)
                }
            })
            .disposed(by: bag)
    }
}
