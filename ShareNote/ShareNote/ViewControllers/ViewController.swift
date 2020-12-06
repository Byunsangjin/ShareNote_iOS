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

class ViewController: UIViewController {
    
    // MARK: Actions
    @IBOutlet var kakaoTalkLoginButton: UIButton!
    @IBOutlet var kakaoLoginButton: UIButton!
    
    // MARK: Variables
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kakaoTalkLoginButton.rx.tap.subscribe { _ in
            if (AuthApi.isKakaoTalkLoginAvailable()) {
                AuthApi.shared.rx.loginWithKakaoTalk()
                    .subscribe(onNext:{ (oauthToken) in
                        print("loginWithKakaoTalk() success.")
                        
                        //do something
                        _ = oauthToken
                        
                        self.presentUserPage()
                    }, onError: {error in
                        print(error)
                    })
                    .disposed(by: self.disposeBag)
            }
        } onError: { error in
            print(error)
        }.disposed(by: self.disposeBag)
        
        kakaoLoginButton.rx.tap.subscribe { _ in
            AuthApi.shared.rx.loginWithKakaoAccount()
                .subscribe(onNext:{ (oauthToken) in
                    print("loginWithKakaoAccount() success.")
                    
                    //do something
                    _ = oauthToken
                    
                    self.presentUserPage()
                }, onError: {error in
                    print(error)
                })
                .disposed(by: self.disposeBag)
        } onError: { (error) in
            print(error)
        }.disposed(by: self.disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tokenManager = TokenManager()
        if (tokenManager.getToken() != nil) {
            presentUserPage()
        }
    }

    func presentUserPage() {
        let userPageVC = self.storyboard!.instantiateViewController(withIdentifier: "UserPageViewController")
        present(userPageVC, animated: true, completion: nil)
    }
}

