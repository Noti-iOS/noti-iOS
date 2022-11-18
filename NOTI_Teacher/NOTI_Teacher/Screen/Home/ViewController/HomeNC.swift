//
//  HomeNC.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/11/18.
//

import UIKit

class HomeNC: BaseNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([HomeVC()], animated: true)
    }
}
