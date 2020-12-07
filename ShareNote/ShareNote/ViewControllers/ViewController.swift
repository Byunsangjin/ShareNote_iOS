//
//  ViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2020/12/03.
//

import UIKit
import RxSwift
import RxCocoa
import KakaoSDKAuth
import KakaoSDKUser
import RxKakaoSDKAuth
import RxKakaoSDKUser
import RxKakaoSDKCommon
import NaverThirdPartyLogin

enum LoginType: String {
    case kakao = "Kakao"
    case naver = "Naver"
    case google = "Google"
    case apple = "Apple"
}

class ViewController: UIViewController {
    // MARK: Actions
    @IBOutlet var kakaoTalkLoginButton: UIButton!
    @IBOutlet var kakaoLoginButton: UIButton!
    @IBOutlet var naverLoginButton: UIButton!
    
    // MARK: Constants
    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    // MARK: Variables
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kakaoLoginBtnInit()
        naverLoginBtnInit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tokenManager = TokenManager()
        if (tokenManager.getToken() != nil) {
            presentUserPage(loginType: LoginType.kakao)
        }
    }

    func presentUserPage(loginType: LoginType) {
        UserDefaults.standard.set(loginType.rawValue, forKey: "loginType")
        
        let userPageVC = self.storyboard!.instantiateViewController(withIdentifier: "UserPageViewController")
        present(userPageVC, animated: true, completion: nil)
    }
    
    func kakaoLoginBtnInit() {
        kakaoTalkLoginButton.rx.tap.subscribe { _ in
            if (AuthApi.isKakaoTalkLoginAvailable()) {
                AuthApi.shared.rx.loginWithKakaoTalk()
                    .subscribe(onNext:{ (oauthToken) in
                        print("loginWithKakaoTalk() success.")
                        
                        //do something
                        _ = oauthToken
                        
                        self.presentUserPage(loginType: LoginType.kakao)
                    }, onError: {error in
                        print(error)
                    })
                    .disposed(by: self.disposeBag)
            }
        } onError: { error in
            print(error)
        }.disposed(by: self.disposeBag)
    }
    
    func naverLoginBtnInit() {
        kakaoLoginButton.rx.tap.subscribe { _ in
            AuthApi.shared.rx.loginWithKakaoAccount()
                .subscribe(onNext:{ (oauthToken) in
                    print("loginWithKakaoAccount() success.")
                    
                    //do something
                    _ = oauthToken
                    
                    self.presentUserPage(loginType: LoginType.naver)
                }, onError: {error in
                    print(error)
                })
                .disposed(by: self.disposeBag)
        } onError: { (error) in
            print(error)
        }.disposed(by: self.disposeBag)
        
        naverLoginButton.rx.tap.subscribe { _ in
            self.naverLoginInstance?.delegate = self
            self.naverLoginInstance?.requestThirdPartyLogin()
        }.disposed(by: self.disposeBag)
    }
}

extension ViewController : NaverThirdPartyLoginConnectionDelegate {
    // 로그인 성공했을 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        presentUserPage(loginType: LoginType.naver)
    }
        
    // 접근 토큰 갱신
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        presentUserPage(loginType: LoginType.naver)
    }
    
    // 로그아웃 할 경우 호출 (토큰 삭제)
    func oauth20ConnectionDidFinishDeleteToken() {
        naverLoginInstance?.requestDeleteToken()
    }
    
    // 모든 Error
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        
    }
}
