//
//  NotiTabBar.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/09/30.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift

class NotiTabBar: UITabBar {
    lazy var addTabBtn = UIButton()
        .then {
            $0.backgroundColor = .main
            $0.layer.cornerRadius = 35
        }
    
    var didTapButton: (() -> ())?
    
    private let bag = DisposeBag()

    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTabBar()
        bindTab()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureLayout()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        
        return addTabBtn.frame.contains(point)
        ? addTabBtn
        : super.hitTest(point, with: event)
    }
}

// MARK: - Configure

extension NotiTabBar {
    private func configureTabBar() {
        addSubview(addTabBtn)
        layer.masksToBounds = false
        
        // TODO: 탭바 디자인 적용
        tintColor = .main
        unselectedItemTintColor = .gray01
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.3
    }
    
    private func configureLayout() {
        addTabBtn.snp.makeConstraints {
            $0.width.height.equalTo(70)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-17)
        }
    }
    
    private func bindTab() {
        addTabBtn.rx.tap
            .asDriver()
            .drive(onNext: {[weak self] _ in
                guard let self = self else { return }
                self.didTapButton?()
            })
            .disposed(by: bag)
    }
}
