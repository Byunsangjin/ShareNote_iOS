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
import AuthenticationServices

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
    
    @IBOutlet var appleLoginBtnView: UIView!
    
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
        if #available(iOS 13.0, *) {
            appleLoginBtnInit()
        }
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
    
    @available(iOS 13.0, *)
    func appleLoginBtnInit() {
        let authorizationButton = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .whiteOutline)
        authorizationButton.addTarget(self, action: #selector(appleSignBtnTouched), for: .touchUpInside)
        authorizationButton.frame = appleLoginBtnView.bounds
        appleLoginBtnView.addSubview(authorizationButton)
    }
    
    @available(iOS 13.0, *)
    @objc
    func appleSignBtnTouched() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
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

@available(iOS 13.0, *)
extension ViewController: ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    // Apple ID 연동 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        // Apple ID
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // 계정 정보 가져오기
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
            
        default:
            break
        }
    }
        
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}
