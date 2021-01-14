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
        case setId(String?)
        case setPassword(String?)
    }
    
    struct State {
        var id = ""
        var password = ""
        var enableLogin = false
    }
    
    var initialState: State = State()
}
