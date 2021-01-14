//
//  LoginReactor.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/14.
//

import ReactorKit

class LoginReactor: Reactor {
    enum Action {
        case idTextChanged(String?)
        case pwdTextChaged(String?)
        case login
    }
    
    enum Mutation {
        case setId(String)
        case setPassword(String)
    }
    
    struct State {
        var id = ""
        var password = ""
        var enableLogin = false
    }
    
    var initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .idTextChanged(let id):
            guard let id = id else { return.empty() }
            
            return Observable.just(Mutation.setId(id))
            
        case .pwdTextChaged(let password):
            guard let password = password else { return.empty() }
            
            return Observable.just(Mutation.setPassword(password))
            
        case .login:
            return.empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setId(let id):
            newState.id = id
        case .setPassword(let password):
            newState.password = password
        }
        
        newState.enableLogin = !newState.id.isEmpty && !newState.password.isEmpty
        
        return newState
    }
}
