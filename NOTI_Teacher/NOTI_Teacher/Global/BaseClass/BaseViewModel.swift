//
//  BaseViewModel.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/28.
//

import Foundation
import RxSwift

protocol BaseViewModel: Input, Output {
    var apiSession: APIService { get }
    
    var bag: DisposeBag { get }
}
