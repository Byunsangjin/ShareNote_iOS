//
//  LoginReactor.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/14.
//

import ReactorKit

enum LoginType {
    case none
    case apple
    case kakao
    case naver
    case google
}

class LoginReactor: Reactor {
    enum Action {
        case idTextChanged(String?)
        case passwordTextChaged(String?)
        case login(LoginType)
    }
    
    enum Mutation {
        case setId(String)
        case setPassword(String)
        case setLoginState(Bool)
    }
    
    struct State {
        var id = ""
        var password = ""
        var enableLogin = false
        var isLogin = false
    }
    
    var initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .idTextChanged(let id):
            guard let id = id else { return.empty() }
            return Observable.just(Mutation.setId(id))
            
        case .passwordTextChaged(let password):
            guard let password = password else { return.empty() }
            return Observable.just(Mutation.setPassword(password))
            
        case .login(let loginType):
            let isLogin = login(type: loginType)
            return Observable.just(Mutation.setLoginState(isLogin))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setId(let id):
            newState.id = id
        case .setPassword(let password):
            newState.password = password
        case .setLoginState(let isLogin):
            newState.isLogin = isLogin
        }
        
        newState.enableLogin = !newState.id.isEmpty && !newState.password.isEmpty
        
        return newState
    }
    
    func login(type: LoginType) -> Bool {
        if type == .none {
            let id = self.currentState.id
            let password = self.currentState.password
            
            NetworkHelper.shared.userLogin(userID: id, password: password) { (isSuccess, member) in
                let member = member
                
                if isSuccess {
                    // 로그인 성공
                    logger.info("success = \(member)")
                } else {
                    // 로그인 실패
                    logger.error("false = \(member)")
                }
            }
        } else {
            // snsLogin Logic
        }
        
        return false
    }
}
