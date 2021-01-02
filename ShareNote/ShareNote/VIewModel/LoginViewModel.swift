//
//  LoginViewModel.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/02.
//

import Foundation
import RxCocoa
import RxSwift

class LoginViewModel {
    struct Input {
        let idText = PublishSubject<String>()
        let pwdText = PublishSubject<String>()
        let buttonTap = PublishSubject<Void>()
    }
    
    struct Output {
        let enableLoginButton = PublishRelay<UIColor>()
        let errorMessage = PublishRelay<String>()
    }
    
    var input = Input()
    var output = Output()
    
    var disposeBag = DisposeBag()
        
    init() {
        Observable.combineLatest(input.idText, input.pwdText)
            .map{ idText, pwdText in
                idText.isEmpty || pwdText.isEmpty ? .red : .green
            }
            .bind(to: output.enableLoginButton)
            .disposed(by: disposeBag)
        
        input.buttonTap.withLatestFrom(Observable.combineLatest(input.idText, input.pwdText)).bind { [weak self] (email, password) in
            guard let self = self else { return }
            if password.count < 6 {
                self.output.errorMessage.accept("아이디 혹은 비밀번호가 잘못 되었습니다.")
            } else {
                // API 태우기
//                self.output.goToMain.accept(())
            }
        }.disposed(by: disposeBag)
    }
}
