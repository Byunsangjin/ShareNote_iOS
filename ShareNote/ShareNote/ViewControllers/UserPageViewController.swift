//
//  UserPageViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2020/12/06.
//

import UIKit
import RxSwift
import RxCocoa
import KakaoSDKUser

class UserPageViewController: UIViewController {
    // MARK: Actions
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var logoutButton: UIButton!
    
    // MARK: Variables
    var disposeBag = DisposeBag()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutButton.rx.tap.subscribe { _ in
            UserApi.shared.rx.logout()
                .subscribe(onCompleted:{
                    print("logout() success.")
                    self.dismiss(animated: true, completion: nil)
                }, onError: {error in
                    print(error)
                })
                .disposed(by: self.disposeBag)
        } onError: { error in
            print(error)
        }.disposed(by: self.disposeBag)
    }
}
