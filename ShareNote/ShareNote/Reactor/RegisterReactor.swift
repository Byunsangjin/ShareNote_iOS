//
//  RegisterReactor.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/17.
//

import Foundation
import ReactorKit

class RegisterReactor: Reactor {
    enum Action {
        case idTextChanged(String?)
        case passwordTextChanged(String?)
        case confirmPasswordTextChanged(String?)
        case emailIDTextChanged(String?)
        case emailAddressTextChanged(String?)
        case regist
    }
    
    enum Mutation {
        case setID(String)
        case setPassword(String)
        case setConfirmPassword(String)
        case setEmailID(String)
        case setEmailAddress(String)
    }
    
    struct State {
        var id = ""
        var password = ""
        var confirmPassword = ""
        var emailID = ""
        var emailAddress = ""
    }
    
    var initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .idTextChanged(let id):
            guard let id = id else { return.empty() }
            return Observable.just(Mutation.setID(id))
            
        case .passwordTextChanged(let password):
            guard let password = password else { return.empty() }
            return Observable.just(Mutation.setPassword(password))
            
        case .confirmPasswordTextChanged(let confirmPassword):
            guard let confirmPassword = confirmPassword else { return.empty() }
            return Observable.just(Mutation.setConfirmPassword(confirmPassword))
            
        case .emailIDTextChanged(let emailID):
            guard let emailID = emailID else { return.empty() }
            return Observable.just(Mutation.setEmailID(emailID))
            
        case .emailAddressTextChanged(let emailAddress):
            guard let emailAddress = emailAddress else { return.empty() }
            return Observable.just(Mutation.setEmailAddress(emailAddress))
            
        case .regist:
            // Regist 로직 구현
            return.empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setID(let id):
            newState.id = id
            
        case .setPassword(let password):
            newState.password = password
            
        case .setConfirmPassword(let confirmPassword):
            newState.confirmPassword = confirmPassword
            
        case .setEmailID(let emailID):
            newState.emailID = emailID
            
        case .setEmailAddress(let emailAddress):
            newState.emailAddress = emailAddress
        }
        
        logger.verbose(newState)
        
        return newState
    }
}
