//
//  Input.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/28.
//

import Foundation

protocol Input {
    associatedtype Input
    
    var input: Input { get }
    
    func bindInput()
}
