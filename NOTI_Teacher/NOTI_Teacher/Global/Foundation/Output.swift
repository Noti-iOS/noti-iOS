//
//  Output.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/28.
//

import Foundation

protocol Output {
    associatedtype Output
    
    var output: Output { get }
    
    func bindOutput()
}
