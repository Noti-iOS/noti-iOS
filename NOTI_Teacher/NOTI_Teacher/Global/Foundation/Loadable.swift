//
//  Loadable.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/28.
//

import Foundation
import RxCocoa

protocol Lodable {
    var loading: BehaviorRelay<Bool> { get }
}

extension Lodable {
    var isLoading: Bool {
        loading.value
    }
    
    func beginLoading() {
        loading.accept(true)
    }
    
    func endLoading() {
        loading.accept(false)
    }
}
