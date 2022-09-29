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
        tabBar.isTranslucent = false
        
        delegate = self
        
        // 탭 구성
        // TODO: - 화면 구현 후 연결 & 탭 아이콘 추가
        let homeTab = makeTabVC(vc: HomeVC(),
                                tabBarTitle: "홈",
                                tabBarImage: nil,
                                tabBarSelectedImage: nil)
        
        let calendarTab = makeTabVC(vc: HomeVC(),
                                tabBarTitle: "캘린더",
                                tabBarImage: nil,
                                tabBarSelectedImage: nil)
        
        let addTab = makeTabVC(vc: HomeVC(),
                                tabBarTitle: nil,
                                tabBarImage: nil,
                                tabBarSelectedImage: nil)
        
        let questionTab = makeTabVC(vc: HomeVC(),
                                tabBarTitle: "질문",
                                tabBarImage: nil,
                                tabBarSelectedImage: nil)
        
        let mypageTab = makeTabVC(vc: HomeVC(),
                                tabBarTitle: "My",
                                tabBarImage: nil,
                                tabBarSelectedImage: nil)
        
        let tabs =  [homeTab, calendarTab, addTab, questionTab, mypageTab]
        self.setViewControllers(tabs, animated: false)
        
        guard let tabBar = self.tabBar as? NotiTabBar else { return }
        tabBar.didTapButton = { [unowned self] in
            self.presentAddTab()
        }
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
    
    private func presentAddTab() {
        // TODO: - 숙제 추가 화면 구현 후 연결
        let addNC = HomeVC()
//        addVC.modalPresentationStyle = .fullScreen
        present(addNC, animated: true, completion: nil)
    }
}

// MARK: - UITabBarController Delegate
extension NotiTBC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) else {
            return true
        }
        return selectedIndex != 2
    }
}
