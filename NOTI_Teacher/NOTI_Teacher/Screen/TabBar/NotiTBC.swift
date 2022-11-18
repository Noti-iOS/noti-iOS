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
        tabBar.unselectedItemTintColor = .tag_gray
        tabBar.isTranslucent = false
        
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 2
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.1
        
        // 탭 구성
        // TODO: - 화면 구현 후 연결 & 탭 아이콘 추가
        let homeTab = makeTabVC(vc: HomeVC(),
                                tabBarTitle: "홈",
                                tabBarImage: UIImage(named: "tab_home"))
        
        let calendarTab = makeTabVC(vc: CalendarVC(),
                                    tabBarTitle: "캘린더",
                                    tabBarImage: UIImage(named: "tab_calendar"))
        
        let addTab = makeTabVC(vc: HomeVC(),
                               tabBarTitle: "숙제추가",
                               tabBarImage: UIImage(named: "tab_add"))
        
        let mypageTab = makeTabVC(vc: HomeVC(),
                                  tabBarTitle: "마이페이지",
                                  tabBarImage: UIImage(named: "tab_mypage"))
        
        let tabs =  [homeTab, calendarTab, addTab, mypageTab]
        self.setViewControllers(tabs, animated: false)
    }
    
    private func makeTabVC(vc: UIViewController,
                           tabBarTitle: String?,
                           tabBarImage: UIImage?) -> UIViewController {
        let tab = vc
        tab.tabBarItem = UITabBarItem(title: tabBarTitle,
                                      image: tabBarImage,
                                      selectedImage: tabBarImage)
        
        return tab
    }
}
