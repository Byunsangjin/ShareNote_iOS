//
//  UserPageViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2020/12/06.
//

import KakaoSDKUser
import NaverThirdPartyLogin
import RxCocoa
import RxSwift
import UIKit

class UserPageViewController: UIViewController {
//    // MARK: Actions
//    @IBOutlet var titleLabel: UILabel!
//    @IBOutlet var logoutButton: UIButton!
//    
//    // MARK: Variables
//    var disposeBag = DisposeBag()
//    
//    // MARK: Methods
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let loginType = UserDefaults.standard.value(forKey: "loginType") as! String
//        if loginType.elementsEqual("Kakao") {
//            kakaoLogoutBtnInit()
//        } else if loginType.elementsEqual("Naver") {
//            naverLogoutBtnInit()
//        }
//    }
//    
//    func logout() {
//        dismiss(animated: true) {
//            UserDefaults.standard.removeObject(forKey: "loginType")
//        }
//    }
//    
//    func kakaoLogoutBtnInit() {
//        logoutButton.rx.tap.subscribe { _ in
//            UserApi.shared.rx.logout()
//                .subscribe(onCompleted:{
//                    print("logout() success.")
//                    self.logout()
//                }, onError: {error in
//                    print(error)
//                })
//                .disposed(by: self.disposeBag)
//        } onError: { error in
//            print(error)
//        }.disposed(by: self.disposeBag)
//    }
//    
//    func naverLogoutBtnInit() {
//        logoutButton.rx.tap.subscribe { _ in
//            NaverThirdPartyLoginConnection.getSharedInstance()?.requestDeleteToken()
//            self.logout()
//        } onError: { error in
//            print(error)
//        }.disposed(by: self.disposeBag)
//    }
}
