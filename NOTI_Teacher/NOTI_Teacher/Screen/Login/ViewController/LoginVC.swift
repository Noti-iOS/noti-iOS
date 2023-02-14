//
//  LoginVC.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2022/10/12.
//

import UIKit
import RxCocoa
import RxGesture
import RxSwift
import SnapKit
import Then
import AuthenticationServices

class LoginVC: BaseViewController {
    private let logoImageView = UIImageView()
        .then {
            $0.image = UIImage(named: "Logo")
        }
    
    private let sloganLabel = UILabel()
        .then {
            $0.text = "선생님과 학생의 원활한 소통을 위한 서비스"
            $0.font = .notoSansKR_Medium(size: 14)
            $0.textColor = .white
        }
    
    private let kakaoLoginBtn = LoginBtn(image: UIImage(named: "kakaoIcon"),
                                         title: "카카오로 시작하기",
                                         backgroundColor: UIColor(red: 254.0/255.0,
                                                                  green: 229.0/255.0,
                                                                  blue: 0.0/255.0,
                                                                  alpha: 1.0),
                                         textColor: UIColor(red: 25.0/255.0,
                                                            green: 25.0/255.0,
                                                            blue: 25.0/255.0,
                                                            alpha: 1.0))
    
    
    private let appleLoginBtn = LoginBtn(image: UIImage(named: "appleIcon"),
                                         title: "Apple로 계속하기",
                                         backgroundColor: .black,
                                         textColor: .white)
    
    private let viewModel = LoginVM()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        configureContentView()
    }
    
    override func layoutView() {
        super.layoutView()
        configureLayout()
    }
    
    override func bindInput() {
        super.bindInput()
        bindLoginBtn()
    }
    
    override func bindOutput() {
        super.bindOutput()
        bindErrorAlert()
        bindLoginResponse()
    }
    
}

// MARK: - Configure

extension LoginVC {
    private func configureContentView() {
        view.backgroundColor = .main
        view.addSubviews([logoImageView,
                          sloganLabel,
                          appleLoginBtn,
                          kakaoLoginBtn])
    }
}

// MARK: - Layout

extension LoginVC {
    private func configureLayout() {
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-90)
        }
        
        sloganLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(29)
            $0.centerX.equalToSuperview()
        }
        
        appleLoginBtn.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.bottom.equalTo(kakaoLoginBtn.snp.top).offset(-14)
            $0.height.equalTo(48)
        }
        
        kakaoLoginBtn.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-70)
            $0.height.equalTo(48)
        }
    }
}

// MARK: - Input

extension LoginVC {
    private func bindLoginBtn() {
        appleLoginBtn.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.appleLogin()
            })
            .disposed(by: bag)
        
        kakaoLoginBtn.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.kakaoLogin()
            })
            .disposed(by: bag)
    }
    
    func appleLogin() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

// MARK: - Output

extension LoginVC {
    private func bindLoginResponse() {
        viewModel.output.loginResponse
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] status in
                guard let self = self else { return }
                if status { self.setTBCtoRootVC() }
            })
            .disposed(by: bag)
    }
    
    private func bindErrorAlert() {
        viewModel.apiError
            .subscribe(onNext: {[weak self] error in
                guard let self = self else { return }
                self.showErrorAlert(error.message)
            })
            .disposed(by: bag)
    }
}

// MARK: - ASAuthorizationControllerDelegate

extension LoginVC: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            guard let appleToken = String(data: appleIDCredential.identityToken!, encoding: .utf8) else { return }
            UserDefaults.standard.set(appleToken, forKey: UserDefaults.Keys.appleToken)
            
            viewModel.loginRequest(type: .apple)
            
        case let passwordCredential as ASPasswordCredential:
            // TODO: -
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            print(username, password)
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        dump(error)
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding

extension LoginVC: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        guard let currentUserIdentifier = UserDefaults.standard.string(forKey: UserDefaults.Keys.appleToken) else { return false }
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        
        appleIDProvider.getCredentialState(forUserID: currentUserIdentifier) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                break
            case .revoked, .notFound:
                // TODO: - 알람?
                break
            default:
                break
            }
        }
        return true
    }
    
}
