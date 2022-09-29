//
//  TabBarController.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/29.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
}

extension TabBarController {
    private func configureTabBar() {
        // TODO: 탭바 디자인 적용
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
        
        tabBar.tintColor = .main
        tabBar.unselectedItemTintColor = .gray01
        
        tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowOpacity = 0.3
        
        // 탭 구성
        // TODO: - 화면 구현 후 연결 & 탭 아이콘 추가
        let homeTab = makeTabVC(vc: HomeVC(),
                                tabBarTitle: "홈",
                                tabBarImage: "",
                                tabBarSelectedImage: "")
        
        let calendarTab = makeTabVC(vc: HomeVC(),
                                tabBarTitle: "캘린더",
                                tabBarImage: "",
                                tabBarSelectedImage: "")
        
        let addTab = makeTabVC(vc: HomeVC(),
                                tabBarTitle: "숙제 추가",
                                tabBarImage: "",
                                tabBarSelectedImage: "")
        
        let questionTab = makeTabVC(vc: HomeVC(),
                                tabBarTitle: "질문",
                                tabBarImage: "",
                                tabBarSelectedImage: "")
        
        let mypageTab = makeTabVC(vc: HomeVC(),
                                tabBarTitle: "My",
                                tabBarImage: "",
                                tabBarSelectedImage: "")
        
        let tabs =  [homeTab, calendarTab, addTab, questionTab, mypageTab]
        
        // VC에 루트로 설정
        self.setViewControllers(tabs, animated: false)
    }
    
    private func makeTabVC(vc: UIViewController,
                           tabBarTitle: String,
                           tabBarImage: String,
                           tabBarSelectedImage: String) -> UIViewController {
        let tab = vc
        tab.tabBarItem = UITabBarItem(title: tabBarTitle,
                                      image: UIImage(named: tabBarImage),
                                      selectedImage: UIImage(named: tabBarSelectedImage))
        
        return tab
    }
}
