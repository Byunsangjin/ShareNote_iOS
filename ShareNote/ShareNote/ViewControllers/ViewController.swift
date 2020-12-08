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
import Firebase
import GoogleSignIn

enum LoginType: String {
    case none = "None"
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
        
        kakaoTalkLoginBtnInit()
        kakaoLoginBtnInit()
        naverLoginBtnInit()
        googleLoginBtnInit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let loginType = UserDefaults.standard.value(forKey: "loginType") as? String else {
            return
        }
        
        if loginType.elementsEqual(LoginType.kakao.rawValue) {
            if TokenManager().getToken() != nil {
                presentUserPage(loginType: LoginType.kakao)
            }
        } else if loginType.elementsEqual(LoginType.naver.rawValue) {
            if naverLoginInstance!.isValidAccessTokenExpireTimeNow() {
                presentUserPage(loginType: LoginType.naver)
            }
        }
    }

    func presentUserPage(loginType: LoginType) {
        UserDefaults.standard.set(loginType.rawValue, forKey: "loginType")
        
        let userPageVC = self.storyboard!.instantiateViewController(withIdentifier: "UserPageViewController")
        present(userPageVC, animated: true, completion: nil)
    }
    
    func kakaoTalkLoginBtnInit() {
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
    
    func kakaoLoginBtnInit() {
        kakaoLoginButton.rx.tap.subscribe { _ in
            AuthApi.shared.rx.loginWithKakaoAccount()
                .subscribe(onNext:{ (oauthToken) in
                    print("loginWithKakaoAccount() success.")
                    
                    //do something
                    _ = oauthToken
                    
                    self.presentUserPage(loginType: LoginType.kakao)
                }, onError: {error in
                    print(error)
                })
                .disposed(by: self.disposeBag)
        } onError: { (error) in
            print(error)
        }.disposed(by: self.disposeBag)
    }
    
    func naverLoginBtnInit() {
        naverLoginButton.rx.tap.subscribe { _ in
            self.naverLoginInstance?.delegate = self
            self.naverLoginInstance?.requestThirdPartyLogin()
        }.disposed(by: self.disposeBag)
    }
    
    func googleLoginBtnInit() {
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
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

extension ViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      // ...
      if let error = error {
        // ...
        return
      }

      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
      // ...
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
}
