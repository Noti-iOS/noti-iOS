//
//  NotiTBC.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/29.
//

import UIKit

class NotiTBC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
}

// MARK: - Configure

extension NotiTBC {
    private func configureTabBar() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .main
        tabBar.isTranslucent = false
        
        // 탭 구성
        // TODO: - 화면 구현 후 연결 & 탭 아이콘 추가
        let homeTab = makeTabVC(vc: HomeVC(),
                                tabBarTitle: "홈",
                                tabBarImage: nil,
                                tabBarSelectedImage: nil)
        
        let calendarTab = makeTabVC(vc: CalendarVC(),
                                tabBarTitle: "캘린더",
                                tabBarImage: nil,
                                tabBarSelectedImage: nil)
        
        let addTab = makeTabVC(vc: HomeVC(),
                                tabBarTitle: "숙제추가",
                                tabBarImage: nil,
                                tabBarSelectedImage: nil)
        
        let mypageTab = makeTabVC(vc: HomeVC(),
                                tabBarTitle: "마이페이지",
                                tabBarImage: nil,
                                tabBarSelectedImage: nil)
        
        let tabs =  [homeTab, calendarTab, addTab, mypageTab]
        self.setViewControllers(tabs, animated: false)
    }
    
    private func makeTabVC(vc: UIViewController,
                           tabBarTitle: String?,
                           tabBarImage: UIImage?,
                           tabBarSelectedImage: UIImage?) -> UIViewController {
        let tab = vc
        tab.tabBarItem = UITabBarItem(title: tabBarTitle,
                                      image: tabBarImage,
                                      selectedImage: tabBarSelectedImage)
        
        return tab
    }
}
